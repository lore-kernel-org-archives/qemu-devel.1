Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A95CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 11:13:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 612B9206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 11:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wr2x4d3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 612B9206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZYHo-0003vT-Gf
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 07:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZYH0-0002ut-NL
 for qemu-devel@nongnu.org; Fri, 15 May 2020 07:13:02 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33391)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZYGy-0008Nw-HO
 for qemu-devel@nongnu.org; Fri, 15 May 2020 07:13:01 -0400
Received: by mail-ot1-x341.google.com with SMTP id v17so1614761ote.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 04:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CDJM7KgiCVism3OxTRKw4oxYwiN9Lu0WrNShMLWRS4I=;
 b=wr2x4d3PAH+CfGmtEgIbmkmDqm1hZeiNP7tM9JFuVfZHwSSLNZGWYZ2/ioq8TH1cwy
 vVVxckPd9oJbOEo5yJXvgcNxV9FmfHdgCS8gSDnaxkO77FLzQDy5RHDsSjIfZYtvcRKH
 hqqgCAD1j3qX4wB0LmJgmnHOWm0qgavC8gKbQziF7b33xJu2HlmA6NdHn/y14fCrzwe+
 21ydgBrReMSXOTedO+FwC3/Qjb00aEv9GcUrVQ8XRhD+vnVxtIcFZX8DLFT+c4ipFPzr
 4paGMVVhq/LgrAK+cmF3nk6O+EetR01dhL8g4nhdjeUQgXsHycTBvb6Be/U37Te6Ev46
 DMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CDJM7KgiCVism3OxTRKw4oxYwiN9Lu0WrNShMLWRS4I=;
 b=RJAob7VRfetgv95UiqPFjNOwHQyruhteM1vo6BQJgBIUnnWdCcvlmQ2Cr89r2+ObpL
 IOu7buVv6LYf5+D/+S+LAJbsXp96QsokNapJ1/ghF7ARGQtJ+75xou+7L07IQ6ExDAoQ
 jCQ9VamCOmV2hEJ+JKrmOyzKEYD2SLRoqt2gXf7G1of+Pb4Vk/cChneWmgVYCJ+80jql
 FpGxYz5+dcdT6HLMJpDbV+pYAKEQdQrLnbUR+SHOUrKcv1RLrfdN8Qk+lh9Ia7TOHwij
 hO/PHRgdc/FkgSpFbpA9D4oKZ2VwJMCWZXVXpPIkEbZ9XYrFb5PIX+1AOutBICleYP7s
 1yiA==
X-Gm-Message-State: AOAM530aBPZt6ZnutN6qOPCuIv0VlU+cszTWBdAQyjMEmQaN3QLfdpC6
 RbaFq+UzY9Hr82NELlslL+XUNH9JkfbTXPg5n7uwgA==
X-Google-Smtp-Source: ABdhPJycV1yJD1wbqFhWWsPaddNjI50+lM8hSeRF2c6woCtuPFdElwm6ViAUnztH4KihUBoE67NwDZUDBkARVyEgmaI=
X-Received: by 2002:a9d:398b:: with SMTP id y11mr1019815otb.135.1589541178920; 
 Fri, 15 May 2020 04:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200514192047.5297-1-aleksandar.qemu.devel@gmail.com>
 <20200514192047.5297-18-aleksandar.qemu.devel@gmail.com>
 <87lfltr5vk.fsf@dusky.pond.sub.org>
 <CAHiYmc6qZQz8c3mmuvdDWP0uPtBi5K5ie06JOTEo-sy7tbJojg@mail.gmail.com>
In-Reply-To: <CAHiYmc6qZQz8c3mmuvdDWP0uPtBi5K5ie06JOTEo-sy7tbJojg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 May 2020 12:12:47 +0100
Message-ID: <CAFEAcA9J6-qoyqJyH9mxhfX6oNhq+DkeFmGbsPbVgi0jX+qMMw@mail.gmail.com>
Subject: Re: [PATCH v2 17/17] hw/mips: Convert Malta "ifdef 0"-ed code to
 comments
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 May 2020 at 12:07, Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
> I understood your points. They make sense to me. In hindsight, in
> general, we shouldn't try just to silence checkpatch warnings (or, for
> that matter, compiler warnings as well), but try to resolve the root
> cause, the underlying issue, of the warning. In this case, creating
> tracepoints seems to be the right thing to do.

For this sort of "default case, guest accessed a bad register offset"
case, what I usually do is something like
   qemu_log_mask(LOG_GUEST_ERROR, "malta_fpga_write: Bad register offset 0x"
                 TARGET_FMT_lx "\n", addr);

That's a simpler change than adding tracepoints and matches how
we report this kind of guest-did-the-wrong-thing behaviour elsewhere.

thanks
-- PMM

