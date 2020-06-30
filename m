Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DDEC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 16:56:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0413020759
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 16:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvQdxxbd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0413020759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqJYa-0005Ra-5y
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 12:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqJXr-0004xI-4p
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 12:55:43 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39190)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqJXp-0000Zy-Hm
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 12:55:42 -0400
Received: by mail-wr1-x441.google.com with SMTP id q5so20898089wru.6
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 09:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=v6HuRAhdBD03kcs6LyZxkvpXqxxNfWAhHRXJ7nAAhzA=;
 b=YvQdxxbdzn1QlEV17X3ApgOUas7d5vXzLOZ2q+P8zmHQQ1wZ0+bopEQFrqsFhTveII
 key8mmzAQfzXOm+6vexa+jpJl7IrAWtcY6EL8L77yoryRHvz09weDwRKNbHXxDiMKEic
 sBv7vt/WSe2y44T72RhtNRgfHZVpzIm+icer39t323GuWR2uSB74ov8x88WzHMR1TP9H
 6fPOmsH9WyL0mq4sDfy9gLWQACvmCCFRYzMFM8HXAVSMl3WqPkdmlnxfGwfGD3ZIJ8Vi
 mPl+nPVaOO17mr5EapcFmdU2soLBNDrWMweBoTy5bVOaHvyTRHKhrZhxyRBfLV347I+r
 fPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=v6HuRAhdBD03kcs6LyZxkvpXqxxNfWAhHRXJ7nAAhzA=;
 b=qLEbWq5YxcKl2Ca568iRXrcI9HZxZ02gKBo4mgDvfIO9ECLcZddaeB5EMiDJQP6oXO
 GieDscLLaAn31yu6rjwef9v8t9QcMrkrbuH+V9ao2N2leWXoQ+F82ZD1HZyflFN8+qgu
 IE2oED+GzH06aHIVv9KgD2GKF757QUhiAjQ/hR9JANp2wJQlkKKcUsxfvMtI8szkSk3Y
 5RUmZXH437IGmFvfpC70ZJLT1+lFXi0mlccJswRUhD/dtLshdTpHzL4Ch0hwhzTrrmI9
 ZYdpXj2pkW4AGwgX8wsV45MNn7BMHpE98VauuWZRpa3a61MYwt8YX22QL/RP7o+9YCMi
 PAgQ==
X-Gm-Message-State: AOAM531HgACA9EOumdR0SeIjUvHsj/rFn8rcVbObXYywZQLuwANKnF+e
 GShLPUxV4ifbzTQDRmk5i7iUaB0X8p7rDCfQ3u0=
X-Google-Smtp-Source: ABdhPJxD5AkLVTGH3Zz2C3z4IsFPop3/6sj/i0pI10ty90DDqRiRI7ivQQU2cDE7ez1FO1v0esf93Wi8sxu5JWfaDBI=
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr22082620wrv.162.1593536139946; 
 Tue, 30 Jun 2020 09:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200630145236.27529-1-f4bug@amsat.org>
 <CAHiYmc4=pmzEyhVTHaqxBnCotE8V+vaptMFincyurvAyDHNn6g@mail.gmail.com>
 <5725b99b-b524-ab40-c74d-a615bb28d363@amsat.org>
In-Reply-To: <5725b99b-b524-ab40-c74d-a615bb28d363@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 30 Jun 2020 18:55:24 +0200
Message-ID: <CAHiYmc7AoJd7TMX_Beo3A2f3R1M=yrpe2ZydbsSysREf4Cx3Vw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] hw/mips/malta: Add the 'malta-strict' machine,
 matching Malta hardware
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yunqiang Su <ysu@wavecomp.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=83=D1=82=D0=BE, 30. =D1=98=D1=83=D0=BD 2020. =D1=83 18:46 Philippe Math=
ieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On 6/30/20 5:38 PM, Aleksandar Markovic wrote:
> > =D1=83=D1=82=D0=BE, 30. =D1=98=D1=83=D0=BD 2020. =D1=83 16:52 Philippe =
Mathieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
> > =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >>
> >> Hi,
> >>
> >> This series add a new 'malta-strict' machine, that aims to properly
> >> model the real hardware (which is not what the current 'malta'
> >> machine models).
> >>
> >> As a bonus for Debian builders, a 'malta-unleashed' machine RFC
> >> patch is included. This might start another endless discussion
> >> upstream, but this is not the point of, so I still include it
> >> for people to test. The rest of the series is candidate for merging
> >> in mainstream QEMU.
> >>
> >> Philippe Mathieu-Daud=C3=A9 (6):
> >>   hw/mips/malta: Trivial code movement
> >>   hw/mips/malta: Register the machine as a TypeInfo
> >>   hw/mips/malta: Introduce MaltaMachineClass::max_ramsize
> >>   hw/mips/malta: Introduce the 'malta-strict' machine
> >>   hw/mips/malta: Verify malta-strict machine uses correct DIMM sizes
> >>   hw/mips/malta: Introduce the 'malta-unleashed' 64-bit machine
> >>
> >>  hw/mips/malta.c | 125 ++++++++++++++++++++++++++++++++++++++++++-----=
-
> >>  1 file changed, 111 insertions(+), 14 deletions(-)
> >>
> >> --
> >
> > This whole series is based on idea of emulating physically
> > non-existing feature, and as such violates the fundamental principles
> > of QEMU.
> >
> > As such, not acceptable for upstreaming.
> >
> > I don't see the point of sending again the same series, in just
> > cosmetically different form, if it was said to you that the concept is
> > wrong.
>
> Have you looked at the patches? What "violates the fundamental
> principles of QEMU" is the code currently in mainstream. Should
> we remove it? I can send a patch for it if it pleases you, but
> you will make QEMU unuseful for many distribution users.
>

Past mistakes are past mistakes. We have to live with them. And not
make them in the future.

I see the whole series as a precursor for your change that repeats
past mistakes, a "wolf in sheep clothing".

That's why I reject the series as a whole.

Yours,
Aleksandar

> What this series does is emulate the physically existing feature
> that are not yet emulated in QEMU.
>
> Please refer to the datasheet 'MIPS Document Number: MD00051
> Revision 01.07' before rejecting this series, and find the
> correct arguments.
>
> Thanks.
>
> >
> > Regards,
> > Aleksandar
> >
> >
> >> 2.21.3
> >>
> >

