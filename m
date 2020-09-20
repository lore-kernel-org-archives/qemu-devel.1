Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E384CC43463
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 20:28:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C50620795
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 20:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u6qlmdU0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C50620795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK5wR-0005x5-AY
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 16:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kK5tB-00047e-9R
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 16:24:49 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:33354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kK5t9-0003i3-PO
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 16:24:49 -0400
Received: by mail-ed1-x544.google.com with SMTP id g4so10947050edk.0
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 13:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rhOiwwkQr0OlZH+2tHyW/N6tD+lw91UfEhEdHsa4xqc=;
 b=u6qlmdU0LQ1K1nlXIN1GuHN47/bOfoDi6VaEGE1UqhYi5asynmr85XFVxYaMhG0H8e
 ZxKjefYcTxqAyizSMBjxCbbH0SOFdn2Mw2yzwSvklP5V9WDnvZXZYEYYoJ4/WBmTUJ/X
 mvmhkn0tx8sAIlLRx6t4iNsFif4jcj2fz0p+R6fVVoJCGLpgEokiRt+TdLqg5SSms/6z
 a3Hqz3Hr6qXp7ZFKMi4x3eyGnM0owbOeUiAIGWoCCrVqKraCjVOeJ0LoQoiivKnlAErf
 wilt8ypy+DIXp2o8e16/P6g3WcKBfh3Sa+/OLY39P9ggGtRj/pntEdAGdwhgEd4798te
 UKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rhOiwwkQr0OlZH+2tHyW/N6tD+lw91UfEhEdHsa4xqc=;
 b=iare9xtDTg8IMsMTTG0+rC0YJIWAdMPKZro/mKq8m+Nw5XSqnYy1HCCNyPzfpVJhGE
 2Pdv1774wKDd/NBpzaSXI4fHqVrSpYMaER8YmsILNNDYri567kKHszWwC2V1STsiFQkw
 qnZ3AxRaqjoR8KCClOybxsjqmYmW7LcLOjOhCnCldNWXhIQEoKUAerfxYi9faj7ovNuE
 /ecNCTgGWfJNUUsPihpHyvxnmAf8ZUkulvpVqmGp4G3jMUKKpAgyllwRtaraIuJLSJYn
 K4oPhbqRwqy7mqBMkOFyilDN/vVKFRbgFVJ4RnS4bHCzOBvdgFdu0ouC7Q4fLKyOLT2A
 Goug==
X-Gm-Message-State: AOAM532Qb/rcfjswUaW+JjG1az7D31O3DbpE7g7L/ao4rPQUT0jlaoBc
 mqniUiEc0QATj/w/cQ3RpDHdEn93i3PidGBdDjsXgQ==
X-Google-Smtp-Source: ABdhPJycmfZe1XTsRcafNb2dy5GkECY6fV8g1AnVtt7tbiluRp+FABYSuF3/oAu7d0H2Th1021+N/QmSs8Rgt4aiKFc=
X-Received: by 2002:aa7:dd4b:: with SMTP id o11mr48142823edw.251.1600633486211; 
 Sun, 20 Sep 2020 13:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200908164157.47108-1-liq3ea@163.com>
 <2ea35f00-3388-22b3-6961-169d2b8a55b7@redhat.com>
In-Reply-To: <2ea35f00-3388-22b3-6961-169d2b8a55b7@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 20 Sep 2020 21:24:35 +0100
Message-ID: <CAFEAcA-sNwcHQyvQx+kH-G4f6oh=8Uew2+NPbWo2Nv4_pVW9EA@mail.gmail.com>
Subject: Re: [RFC 0/4] Add a 'in_mmio' device flag to avoid the DMA to MMIO
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Li Qiang <liq3ea@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Li Qiang <liq3ea@163.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Alexander Bulekov <alxndr@bu.edu>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 20 Sep 2020 at 08:56, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 08/09/20 18:41, Li Qiang wrote:
> > Currently the qemu device fuzzer find some DMA to MMIO issue. If the
> > device handling MMIO currently trigger a DMA which the address is MMIO,
> > this will reenter the device MMIO handler. As some of the device doesn't
> > consider this it will sometimes crash the qemu.

> I don't think this is a good solution.  These are device bugs and they
> need to be fixed.

Do you have an opinion on what the right approach to fixing them is?
It seems like a hard problem to me; my brain has been too full of
cotton wool recently and I haven't felt up to sitting down and
trying to think through whether there's a clean way to handle the
reentrancy-into-device-code problem in the general case...

thanks
-- PMM

