Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6623FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 11:27:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EFEF206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 11:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STwoOuBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EFEF206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiFwb-00035Z-CL
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 07:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atar4qemu@gmail.com>)
 id 1jiFvt-0002gg-Ac
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 07:27:13 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:33013)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atar4qemu@gmail.com>)
 id 1jiFvs-0001fS-0D
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 07:27:13 -0400
Received: by mail-io1-xd43.google.com with SMTP id i25so3514403iog.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 04:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Ah/8RB6SgcPuiDEw51PCIh9msebiFUAfSfEqHnvQ5+U=;
 b=STwoOuBeTb+MyClhzcSSrgjX3IwS7AtqzV0lLrt8+HSkzk5GDhe259DqEThK6D/ap1
 cZm4IKl6FnJ/gojnYScq8jeK0hFU7MI8EnWE+VsuZLR7f0GKwgWW+FnT2FrcbefzScKp
 Z+UWLYTtxbZCQdAMrX10RMBF1fZTEBZm5Jr1AtMyy7sgN2IdtQxUjOwUFNqTZf+Yt9pk
 mqxsqV/m/adokm0UB/+6kAMajUlidBjNVG16hTymjbt1NrocvNmqWeT5s7zdutaAkkj2
 TyVtHHAoQKAQLGcDSED1x3njPg2jHZmGxJIcY1hheABHRmMPa/LyR4wvIwFp5OwgQxye
 3pbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ah/8RB6SgcPuiDEw51PCIh9msebiFUAfSfEqHnvQ5+U=;
 b=CSgy+b4crSSYb+fTTx7TmPhPVyJLiWbjF/O9zvGsTwyWjuKsjaffx8ep5h4+Y18xVF
 nlV0g5Fk+i4z1dTGfbO4cOI6qJP+fCdoDmbl5n5tX06g8PHP0QwBIJlrlXlEawyPXpqj
 xFovNo8aG+NMOwgMqYu4PAoRf3qHD4EJ4WHwTqxs4pFeh3Ib3dJT5sBqEpgxI1i8VPmw
 oiksxd9wQ+RUhBQDcHxM49mC1qCglCnjes844n0sbTzAjkkLaW1RdKigIeM517xwvIVI
 4VK+C/JXFlH94/Yc2g2l6hZ3n0O15IBYJWhWGEkZ8eMFkpX8E5JWwTVpUDNctJrouuR+
 QXHQ==
X-Gm-Message-State: AOAM531DepFmpIVyyek2IrEspCcytorhDavyh0waJeJSpOO3lUXCvd6r
 33v+PB9U+qeifRW1YrWHh9y8mZE9wWbzcUblnvw=
X-Google-Smtp-Source: ABdhPJxQoAgLRN85X7Tj/QclWsGM2d7yyBaI4Vo/YeWMGKBNvoUuCSwB5jURI0lCvB5T0G+QZGVPxw8MYbAKa/QF11Y=
X-Received: by 2002:a02:ce38:: with SMTP id v24mr21788529jar.137.1591615630430; 
 Mon, 08 Jun 2020 04:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200510152840.13558-1-f4bug@amsat.org>
 <2906ea36-d6c4-f05b-3242-d9380986d48c@redhat.com>
 <CAHiYmc7Jwbvhapj9tXv=2=6ydD9mB=tm6O4SOUameWkRQGE1Qg@mail.gmail.com>
 <78738412-c682-6079-5238-88d96339235c@amsat.org>
In-Reply-To: <78738412-c682-6079-5238-88d96339235c@amsat.org>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Mon, 8 Jun 2020 13:26:59 +0200
Message-ID: <CACXAS8DtVy8uySz3aNoLC5qEY51dih=uHhWM1rSa3Fod3gANfw@mail.gmail.com>
Subject: Re: [PATCH 0/7] hw/misc/empty_slot: Spring cleaning
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=atar4qemu@gmail.com; helo=mail-io1-xd43.google.com
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
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, May 24, 2020 at 10:21 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> On 5/24/20 9:37 PM, Aleksandar Markovic wrote:
> > =D0=BD=D0=B5=D0=B4, 24. =D0=BC=D0=B0=D1=98 2020. =D1=83 18:58 Philippe =
Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >>
> >> ping?
> >>
> >
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
>
> What would be helpful is feedback from Artyom, since it authored this
> device.
>
> Artyom, do you mind Acking the series?

Thanks for asking and sorry for the delay. My mailer played a bad trick on =
me.
The patches definitely make sense:

Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>



> Thanks,
>
> Phil.
>
> >
> > Aleksandar
> >
> >> On 5/10/20 5:28 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> >>> New Spring, new opportunity to clean this device :)
> >>> (v1 was in 2018, v2 in 2019).
> >>>
> >>> - lower device priority
> >>> - follow qdev model and use properties
> >>> - convert to trace events
> >>> - describe with slot name
> >>> - move under hw/misc/ and cover in MAINTAINERS
> >>>
> >>> Peter, I hope you are OK adding it wit UNIMP device,
> >>> as both are very similar, and don't have much activity.
> >>>
> >>> Only MIPS/SPARC32 targets use this device.
> >>>
> >>> v2: https://www.mail-archive.com/qemu-devel@nongnu.org/msg626498.html
> >>> v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg564060.html
> >>>
> >>> Philippe Mathieu-Daud=C3=A9 (7):
> >>>   hw/sparc/sun4m: Use UnimplementedDevice for I/O devices
> >>>   hw/misc/empty_slot: Lower address space priority
> >>>   hw/misc/empty_slot: Convert 'size' field as qdev property
> >>>   hw/misc/empty_slot: Add a 'name' qdev property
> >>>   hw/misc/empty_slot: Convert debug printf() to trace event
> >>>   hw/misc/empty_slot: Move the 'hw/misc' and cover in MAINTAINERS
> >>>   hw/misc/empty_slot: Name the slots when created
> >>>
> >>>  include/hw/empty_slot.h        |  9 -------
> >>>  include/hw/misc/empty_slot.h   | 19 ++++++++++++++
> >>>  hw/mips/mips_malta.c           |  4 +--
> >>>  hw/{core =3D> misc}/empty_slot.c | 47 +++++++++++++++++++-----------=
----
> >>>  hw/sparc/sun4m.c               | 23 +++++++++++------
> >>>  MAINTAINERS                    |  4 ++-
> >>>  hw/core/Makefile.objs          |  1 -
> >>>  hw/misc/Makefile.objs          |  1 +
> >>>  hw/misc/trace-events           |  4 +++
> >>>  9 files changed, 70 insertions(+), 42 deletions(-)
> >>>  delete mode 100644 include/hw/empty_slot.h
> >>>  create mode 100644 include/hw/misc/empty_slot.h
> >>>  rename hw/{core =3D> misc}/empty_slot.c (66%)
> >>>
> >>
> >
>


--
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu

