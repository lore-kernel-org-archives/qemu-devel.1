Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE4AC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 19:38:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 464D82076C
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 19:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+HrDS4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 464D82076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcwSU-0003kA-He
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 15:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jcwRg-0003Ig-62
 for qemu-devel@nongnu.org; Sun, 24 May 2020 15:38:04 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34032)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jcwRf-0001Mm-Cz
 for qemu-devel@nongnu.org; Sun, 24 May 2020 15:38:03 -0400
Received: by mail-wr1-x443.google.com with SMTP id g12so14083776wrw.1
 for <qemu-devel@nongnu.org>; Sun, 24 May 2020 12:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ytSls1BEqlw82hOaRQA+tioe5/kqPRuUqOZ65wWdaD4=;
 b=U+HrDS4Bt795IccfdSsm+1cOk+n4N7fdJYCjN79UZRe58wGyxA4DWEeux+9UF3APg1
 Q6AQcp2G7HBx4QmgNtvGxUyi3Cr93crYkt7O2/o/LstAPxq0j3WWMxqGKdLsyCDlzuYh
 7vJC1L4oFBQxput5pb0Wphi2/AoJcjwBqfPloiDgfzADgPU1ss1ciACDlKOrVPAl7Fc7
 piu9UaGqsnBqByowFRWr/zr1G1ExX3wtP5T684N7xQErWKvYp9qMkkkM9TenzPa/Xq8x
 OXnx0EsNh0s05OXXUV7wzSqiwKMY874G9ZjP/9QJ/KjSCM4x/gY4K32plTsyuP86rgdq
 aLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ytSls1BEqlw82hOaRQA+tioe5/kqPRuUqOZ65wWdaD4=;
 b=XsrrbQ8OBC8pAeIKZdPoNzFeQx3GvYgsIMa3VHF5AeGFDyeshMjoL1ZxPJlC50DFLz
 RLnHv05bFyMd2ld4S3ZIgOnn6q7ET2Xqa4pcQK8wEIiLWHl3CIplLPgNpwcWY+tIIn6o
 o+vFiK/m8YCLU92mLb3wVHgFZaIJp7px2svKPvOdHZFhyvw5u+uncHteQ6UlDqHEMCxQ
 bKKnko4R8tVYG+Ge8gYdhSx5ELpJKqm2f+OrMJ8qxCth/PZR6AcAiE5cKCeILxkSeBBH
 dSnCb+8ItLGtrDdqMt/BPuhUyN/w2QM8MX/otR/Ok6+dQvfoFfLwkYXCw39eIlHFptT0
 Tiqw==
X-Gm-Message-State: AOAM531saqzIcoCLKsJFQPGD0U5kbDcF8A6cvvfcajPYH/Azj0KQMKWV
 +zWN/et9uuukAQkUxkGtWWPrvEgG322AkjJ4rOI=
X-Google-Smtp-Source: ABdhPJxbSTWbOQZghfaMD8FrU5LjGOwLXU271cVPWXaj2+VkFYiTWbdwNgMy+IQwQ6LR0IY+Xf70z44gnf72XTLSfXY=
X-Received: by 2002:adf:dc50:: with SMTP id m16mr12153068wrj.329.1590349081391; 
 Sun, 24 May 2020 12:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200510152840.13558-1-f4bug@amsat.org>
 <2906ea36-d6c4-f05b-3242-d9380986d48c@redhat.com>
In-Reply-To: <2906ea36-d6c4-f05b-3242-d9380986d48c@redhat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sun, 24 May 2020 21:37:48 +0200
Message-ID: <CAHiYmc7Jwbvhapj9tXv=2=6ydD9mB=tm6O4SOUameWkRQGE1Qg@mail.gmail.com>
Subject: Re: [PATCH 0/7] hw/misc/empty_slot: Spring cleaning
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BD=D0=B5=D0=B4, 24. =D0=BC=D0=B0=D1=98 2020. =D1=83 18:58 Philippe Math=
ieu-Daud=C3=A9 <philmd@redhat.com>
=D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> ping?
>

I agree with all of your patches, they absolutely make sense to me,
but I would like to know Peter's opinion on such treatment of empty
slots.

I am going to give r-bs and integrate mips patches as soon as Peter
OKs the general approach. So, Peter, is Philippe's approach to empty
slots fine?

Aleksandar

> On 5/10/20 5:28 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > New Spring, new opportunity to clean this device :)
> > (v1 was in 2018, v2 in 2019).
> >
> > - lower device priority
> > - follow qdev model and use properties
> > - convert to trace events
> > - describe with slot name
> > - move under hw/misc/ and cover in MAINTAINERS
> >
> > Peter, I hope you are OK adding it wit UNIMP device,
> > as both are very similar, and don't have much activity.
> >
> > Only MIPS/SPARC32 targets use this device.
> >
> > v2: https://www.mail-archive.com/qemu-devel@nongnu.org/msg626498.html
> > v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg564060.html
> >
> > Philippe Mathieu-Daud=C3=A9 (7):
> >   hw/sparc/sun4m: Use UnimplementedDevice for I/O devices
> >   hw/misc/empty_slot: Lower address space priority
> >   hw/misc/empty_slot: Convert 'size' field as qdev property
> >   hw/misc/empty_slot: Add a 'name' qdev property
> >   hw/misc/empty_slot: Convert debug printf() to trace event
> >   hw/misc/empty_slot: Move the 'hw/misc' and cover in MAINTAINERS
> >   hw/misc/empty_slot: Name the slots when created
> >
> >  include/hw/empty_slot.h        |  9 -------
> >  include/hw/misc/empty_slot.h   | 19 ++++++++++++++
> >  hw/mips/mips_malta.c           |  4 +--
> >  hw/{core =3D> misc}/empty_slot.c | 47 +++++++++++++++++++-------------=
--
> >  hw/sparc/sun4m.c               | 23 +++++++++++------
> >  MAINTAINERS                    |  4 ++-
> >  hw/core/Makefile.objs          |  1 -
> >  hw/misc/Makefile.objs          |  1 +
> >  hw/misc/trace-events           |  4 +++
> >  9 files changed, 70 insertions(+), 42 deletions(-)
> >  delete mode 100644 include/hw/empty_slot.h
> >  create mode 100644 include/hw/misc/empty_slot.h
> >  rename hw/{core =3D> misc}/empty_slot.c (66%)
> >
>

