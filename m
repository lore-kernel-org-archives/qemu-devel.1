Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949ABC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 21:38:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59E88204EF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 21:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TSsuyBr/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E88204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcyKc-0002O9-HN
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 17:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jcyJv-0001xW-Ev
 for qemu-devel@nongnu.org; Sun, 24 May 2020 17:38:11 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45696)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jcyJu-0003Se-1Y
 for qemu-devel@nongnu.org; Sun, 24 May 2020 17:38:10 -0400
Received: by mail-ot1-x341.google.com with SMTP id c3so12467476otr.12
 for <qemu-devel@nongnu.org>; Sun, 24 May 2020 14:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LIumXQDRNhzPOdNvJsgBxu4+lhHrArNliDGoVr8BF7o=;
 b=TSsuyBr/duVpzV8Bjp9BcskQoyL4e8ZF+MiAlOMYY2QpSIj3gFpLW5ZjJkM6qqNlWj
 nRkp/RfZHlD4/lHkEKcJaliLjxxNF2AA8C3hLpCcss76hQkKTE7WOS3LBPqhWrKXAZHj
 gptA5LGaATMCNHOAs3y19F5g62Gnh6USsrjXD/R/nJXzTz0S308kWd5Duos6IY8AyH/g
 XpEn21uuUIVllWrcVICLOlTwO9twBEs/ebTuFtaqcLa/PIND/aiWx9NTuVk98Ug/wsLt
 he/1n5oH5Nx6z0EvbvaDIw7o5y5I7QwUaa9+GffUAaTJRTfM5pwNyiKVT5ILQQalsYlF
 I5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LIumXQDRNhzPOdNvJsgBxu4+lhHrArNliDGoVr8BF7o=;
 b=uSdcBgzgEjDyK33gcnPZUVWE9ddCBkLpeEtZfz0NQcRiip0rt8OdvWNjMaF0hrRY19
 vZtAejZaGIm0QyCJFobuFc+CgWe9pCUnxA9sobZXE3aOvI3ZYifSB5iIlqW6NPvnh3G1
 LWhC1zVLgFZLSwnL0C9wrEQOh2wFX62Hiq6kIsQvcV3F1xUvM2TosvFC+cTqBOTN5XBg
 nZYDucLfuGOfzWOKhXTDPQtNtDXLUkiln51+0rlL7O9iF5Y26QV+i2axeAdGpABsph+U
 NrYqCa9Gfv0EIeBMNpgc5sfx52fFc/5vMA88woLhnaarl2KGc8bAsx8r1Wv5v96ajeJa
 N1wg==
X-Gm-Message-State: AOAM530WuMSbaQbtl7MDS1kJxYHhJRtd6sfSiNua+fQP3xkYfOb2V4gb
 wEvj/vN4Lo/BOKiw5Qg0IFGhw7eF7A18uGLN3N1lFA==
X-Google-Smtp-Source: ABdhPJwEFLBMXDzT89EL9JNctjdlbWqWp9KOcYxFnhLhHmFmI83JEyrjlZskhjBKVDEq9QnFY5f0nZPFPW+oolY5b1w=
X-Received: by 2002:a9d:3623:: with SMTP id w32mr18549767otb.91.1590356288657; 
 Sun, 24 May 2020 14:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200510152840.13558-1-f4bug@amsat.org>
 <2906ea36-d6c4-f05b-3242-d9380986d48c@redhat.com>
 <CAHiYmc7Jwbvhapj9tXv=2=6ydD9mB=tm6O4SOUameWkRQGE1Qg@mail.gmail.com>
 <78738412-c682-6079-5238-88d96339235c@amsat.org>
In-Reply-To: <78738412-c682-6079-5238-88d96339235c@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 24 May 2020 22:37:57 +0100
Message-ID: <CAFEAcA9OKBb_JeOHsAsZtHnuPD8zDLZN0FTNyL+J49=Jfgfwpg@mail.gmail.com>
Subject: Re: [PATCH 0/7] hw/misc/empty_slot: Spring cleaning
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 24 May 2020 at 21:21, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> On 5/24/20 9:37 PM, Aleksandar Markovic wrote:
> > I agree with all of your patches, they absolutely make sense to me,
> > but I would like to know Peter's opinion on such treatment of empty
> > slots.
> >
> > I am going to give r-bs and integrate mips patches as soon as Peter
> > OKs the general approach. So, Peter, is Philippe's approach to empty
> > slots fine?
>
> Thanks Aleksandar for looking at this series.
>
> I expect a neutral opinion from Peter.

Yes. In particular I cannot be the bottleneck for all design
choices in QEMU: that doesn't scale. Mostly you can assume
that if I have a strong opinion then I'll provide it, and
otherwise I prefer it if the people who care enough to
maintain code and write patches to tidy it up make the choices.

(Empty slots seemed a bit odd to me last time I looked at them,
but if they work for mips and sparc that's fine with me.)

thanks
-- PMM

