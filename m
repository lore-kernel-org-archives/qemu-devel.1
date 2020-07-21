Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89103C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 21:57:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B9C4206E3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 21:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhS0k7sl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B9C4206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy0GW-0003dU-Ir
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 17:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jy0Fb-0002wu-IP
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 17:56:39 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229]:34702)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jy0FZ-0002xR-Qr
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 17:56:39 -0400
Received: by mail-lj1-x229.google.com with SMTP id q7so337324ljm.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 14:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9f0+JJmQgbCcZaifNi7c9ecC/zGIPV6FCi+DLH1HDMo=;
 b=HhS0k7slIWU7dqHpA+Ayf+1mEqwVGOy/EZhlqz9ga2gF8lB3wQGnZJjtkHWLNUbt6m
 euAo2TMT5xeL5l4VcHFjSs5Cl9Acb9iu8gBGNhNAcILM6ILDNlhUc6J6FfjCKkkU1WEN
 a+9y9OfL+cuxsxtQkpx53/GsbtdKREiAYkfjb40uHCSfHoUZ57uBUd8Tvzv5M4UuGpzP
 FAMwPLFQt2PMaYPFak7ytKJcWdgqnViL7jjFERntrj/lnk555AkChwol/xA7n27sQ3xL
 b4ixDdxvu0C6jXrxFuyJl4fNnL+IkW2j0BhgcPilc3OpqBVnz5neEdktUkfo51kZrO9O
 8kQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9f0+JJmQgbCcZaifNi7c9ecC/zGIPV6FCi+DLH1HDMo=;
 b=NuF2bsF88W8lJr3yB8gyB2JyqAyPUfuHjG1vfxg6AEcUE3Jbx++y6Whpk8uzU+r3ns
 ztczv8jKHO8uuu3XtIOiREdzK3fPSybyiEWuId1N8rTMILjNiLc0so4t3fmj/CMmJ6iC
 gXeFEa7wSqQ0qYCmqmdH/iLKqQBXvzGah5JfR4i8OkbM+oSZr8qitgQT3FvO+WFsmm6E
 bahpXr8DngSf1BpxeU5Ryrrnc8jvlc2l/90+p1arUSOOD54z2QtImQdtcB6CsW39uBY8
 t8/QAnEjXgDHkQ7TRJvlVkRovO4ZcJEY+xCyqMRcRXuu7jCv0lzfe9GDGVfcOxAexxOz
 tBLg==
X-Gm-Message-State: AOAM533eeGvwgQYpJF1+NY+7eOQKVd4sQ6fRQ2vk0Ulv0TdXz0zGDmCe
 0ciaOlmTIuaqwHAA0SJiriEl2Ax2fMmQZ+3B6hc=
X-Google-Smtp-Source: ABdhPJy0UgaWNuB8VZiMfELpkoJTE9sXDpgXOxL1StDESQNWkGwT1i99SFblJZlUFeWGuzQdiWjX2/jEXGOeiru+kig=
X-Received: by 2002:a2e:9b87:: with SMTP id z7mr14675986lji.80.1595368595192; 
 Tue, 21 Jul 2020 14:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <CALTWKrVvaA7HWxsHNS+tCygLu+x4FCjSZn=+AP0hnEWOCp8vww@mail.gmail.com>
 <87y2ndulq6.fsf@linaro.org>
In-Reply-To: <87y2ndulq6.fsf@linaro.org>
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Tue, 21 Jul 2020 23:55:59 +0200
Message-ID: <CALTWKrU5=nejVRpi5a6Cxs9vba_SqHouJA-5D_yDFU7k--dcMQ@mail.gmail.com>
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#5] Finding
 Commits Affecting QEMU Performance
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lj1-x229.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, luoyonggang@gmail.com,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 21, 2020 at 1:54 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
>
> Ahmed Karaman <ahmedkhaledkaraman@gmail.com> writes:
>
> > Hi,
> >
> > The fifth report of the TCG Continuous Benchmarking project concludes
> > a mini-series of three reports that dealt with the performance
> > comparison and analysis of QEMU 5.0 and 5.1-pre-soft-freeze.
> >
> > The report presents a new Python script that utilizes "git bisect" for
> > running a binary search within a specified range of commits to
> > automatically detect the commit causing a performance improvement or
> > degradation.
>
> Excellent stuff.

Thanks for your continued support!

>
> > The new script is then used to find the commit introducing the PowerPC
> > performance degradation as well as that introducing the performance
> > improvement in MIPS. The results obtained for both commits proves the
> > correctness of the conclusions and analyses presented in the two
> > previous reports.
>
> I can certainly envision a mechanism where 0673ec slows things down. I
> wonder if it would come back if instead of inline function calls we
> ended up making concrete flattend versions, e.g.:
>
> bool QEMU_FLATTEN float64_eq(float64 a, float64 b, float_status *s)
> {
>     return float64_compare(a, b, s) =3D=3D float_relation_equal;
> }
>
> PPC is of course more affected by these changes than others because
> HARDFLOAT never gets a chance to kick in. Looking at the objdump of
> f64_compare there should surely be an opportunity to loose some of the
> branches when looking for a certain test result?

Interesting, I will try to tinker a little bit with the float64
functions and will let you know if I find anything interesting.

>
> >
> > Report link:
> > https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/Finding-Commits=
-Affecting-QEMU-Performance/
> >
> > Previous reports:
> > Report 1 - Measuring Basic Performance Metrics of QEMU:
> > https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.html
> > Report 2 - Dissecting QEMU Into Three Main Parts:
> > https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg09441.html
> > Report 3 - QEMU 5.0 and 5.1-pre-soft-freeze Dissect Comparison:
> > https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg01978.html
> > Report 4 - Listing QEMU Helpers and Function Callees:
> > https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg04227.html
> >
> > Best regards,
> > Ahmed Karaman
>
>
> --
> Alex Benn=C3=A9e

Best regards,
Ahmed Karaman

