Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A902C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 16:59:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8D8420674
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 16:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtpYBgsi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D8420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaMdM-0003oH-0S
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 12:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaMcX-0002yj-F2
 for qemu-devel@nongnu.org; Sun, 17 May 2020 12:58:37 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40599)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaMcV-0007OG-8o
 for qemu-devel@nongnu.org; Sun, 17 May 2020 12:58:37 -0400
Received: by mail-wr1-x441.google.com with SMTP id e16so9038111wra.7
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 09:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=AI6RPPF3wajRWJ+pCdmxWrDDLNxxcpIIePDFKhvZuQA=;
 b=NtpYBgsiGPI4MHPvEMF1H3+Tq2p/qBlql2Pco24fD0L2WSE4mpCDvyWn/lwdpcgY32
 HG2FwntGjE9eBLc5tijiF8V9yeGvRmzki4DCF2QHEZRgHQ+KXdrSK7PjwtICckeRToJl
 rwF2xrWRj/zzAN/nmNE7QrHGLko4VgkNeiNcNWZtXlyYb4UZb+dZdmjCtlTks3N/lAHw
 b60H0J5wyblyKzANB1pFXKD1RuNR7UnJGoJDBBrICZK/iRpwIW6pKIbroyB461QI+9YV
 iSPmrlzk2fIA2xboTiZjhznsN3/Al+nPy4vv1JHQqBu9uOUPP167NS9vfptrESWagzXf
 /V9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=AI6RPPF3wajRWJ+pCdmxWrDDLNxxcpIIePDFKhvZuQA=;
 b=fxQwNzPbtqhGisroATefiKOdRmBy7XK81VAGGnc4i+YS1eaeX80XmDDlef1WW18l8u
 h/6/5im9Li7n5IOStyacympFziybhmRkv1RD3zS5qmFq2koeFckrLFHXGd4gDUbNfHvU
 vwsl1nPX1s/1hM8JVjWBg8ZluNReKHyRqxZqati34JNXPP99EAh2E6BOowl2AcynTp9K
 WapP/QbiVbHL/XAvg05ECpUSHBfUoq+IYYxuoz2F643Y8puM0mWqGK5ArHindZUweQNn
 dmLMay/XxGSAogTL3Ho2NuH9KFrBijfE+poiLGrv1fP3II+0dj1+DP0UswYCfc3zhjBQ
 uVNw==
X-Gm-Message-State: AOAM5329LrrL9kwzE7HGtHzAMdhphKXnaz2itgTUvmLrhUXUFWyoMKi/
 O+WlKOCWfLSNIwrDN+nerbib9c6J5J3x2UuTp8I=
X-Google-Smtp-Source: ABdhPJxoL9J+kCiwjwsoXlnWt1XyLa3OfOo8oX52Oy2nhGqSfFsg4/Du5NJTaBVTr/pJDrOMFcpz0xquOAefSHf1HOM=
X-Received: by 2002:a5d:4e41:: with SMTP id r1mr14922692wrt.420.1589734713618; 
 Sun, 17 May 2020 09:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200517092357.1469-1-aleksandar.qemu.devel@gmail.com>
 <20200517092357.1469-20-aleksandar.qemu.devel@gmail.com>
 <b0b12106-e2f1-36de-c3ac-000a89f87eba@amsat.org>
In-Reply-To: <b0b12106-e2f1-36de-c3ac-000a89f87eba@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sun, 17 May 2020 18:58:20 +0200
Message-ID: <CAHiYmc4N0FpRYK1ikZX7mSNBr_1Z7AeeCuE9WTrT6B3YsZ8PdQ@mail.gmail.com>
Subject: Re: [PATCH v4 19/19] hw/mips: Rename malta/mipssim/r4k/jazz files in
 hw/mips
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
Cc: aleksandar.rikalo@syrmia.com, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BD=D0=B5=D0=B4, 17. =D0=BC=D0=B0=D1=98 2020. =D1=83 15:19 Philippe Math=
ieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Hi Aleksandar,
>
> On 5/17/20 11:23 AM, Aleksandar Markovic wrote:
> > Machine file names should not have prefix "mips_".
> >
> > Folong2 machine source file will be handled in a separate patch,
>
> Typo: "Fuloong2e"
>
> > to avoid conflicts. That patch is pending integration into the
> > main tree.
> >
> > Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > CC:  Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >   hw/mips/Makefile.objs                 | 8 ++++----
> >   hw/mips/{mips_jazz.c =3D> jazz.c}       | 0
> >   hw/mips/{mips_malta.c =3D> malta.c}     | 0
> >   hw/mips/{mips_mipssim.c =3D> mipssim.c} | 0
> >   hw/mips/{mips_r4k.c =3D> r4k.c}         | 0
> >   5 files changed, 4 insertions(+), 4 deletions(-)
> >   rename hw/mips/{mips_jazz.c =3D> jazz.c} (100%)
> >   rename hw/mips/{mips_malta.c =3D> malta.c} (100%)
> >   rename hw/mips/{mips_mipssim.c =3D> mipssim.c} (100%)
> >   rename hw/mips/{mips_r4k.c =3D> r4k.c} (100%)
>
> Thanks for cleaning this, appreciated!
>
> You missed MAINTAINERS:
>

Ouch! You are right. Will be fixed..

Thanks,
Aleksandar

> -- >8 --
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1f84e3ae2c..3ad904a73c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1045,3 +1045,3 @@ R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>   S: Maintained
> -F: hw/mips/mips_jazz.c
> +F: hw/mips/jazz.c
>   F: hw/display/jazz_led.c
> @@ -1056,3 +1056,3 @@ F: hw/isa/piix4.c
>   F: hw/acpi/piix4.c
> -F: hw/mips/mips_malta.c
> +F: hw/mips/malta.c
>   F: hw/mips/gt64xxx_pci.c
> @@ -1066,3 +1066,3 @@ R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>   S: Odd Fixes
> -F: hw/mips/mips_mipssim.c
> +F: hw/mips/mipssim.c
>   F: hw/net/mipsnet.c
> @@ -1074,3 +1074,3 @@ R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>   S: Obsolete
> -F: hw/mips/mips_r4k.c
> +F: hw/mips/r4k.c
>
> ---
>
> With this snippet amended:
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> Regards,
>
> Phil.
>
> >
> > diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefile.objs
> > index 525809af07..1d767ed9a8 100644
> > --- a/hw/mips/Makefile.objs
> > +++ b/hw/mips/Makefile.objs
> > @@ -1,8 +1,8 @@
> >   obj-y +=3D addr.o mips_int.o
> > -obj-$(CONFIG_R4K) +=3D mips_r4k.o
> > -obj-$(CONFIG_MALTA) +=3D gt64xxx_pci.o mips_malta.o
> > -obj-$(CONFIG_MIPSSIM) +=3D mips_mipssim.o
> > -obj-$(CONFIG_JAZZ) +=3D mips_jazz.o
> > +obj-$(CONFIG_R4K) +=3D r4k.o
> > +obj-$(CONFIG_MALTA) +=3D gt64xxx_pci.o malta.o
> > +obj-$(CONFIG_MIPSSIM) +=3D mipssim.o
> > +obj-$(CONFIG_JAZZ) +=3D jazz.o
> >   obj-$(CONFIG_FULONG) +=3D mips_fulong2e.o
> >   obj-$(CONFIG_MIPS_CPS) +=3D cps.o
> >   obj-$(CONFIG_MIPS_BOSTON) +=3D boston.o
> > diff --git a/hw/mips/mips_jazz.c b/hw/mips/jazz.c
> > similarity index 100%
> > rename from hw/mips/mips_jazz.c
> > rename to hw/mips/jazz.c
> > diff --git a/hw/mips/mips_malta.c b/hw/mips/malta.c
> > similarity index 100%
> > rename from hw/mips/mips_malta.c
> > rename to hw/mips/malta.c
> > diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mipssim.c
> > similarity index 100%
> > rename from hw/mips/mips_mipssim.c
> > rename to hw/mips/mipssim.c
> > diff --git a/hw/mips/mips_r4k.c b/hw/mips/r4k.c
> > similarity index 100%
> > rename from hw/mips/mips_r4k.c
> > rename to hw/mips/r4k.c
> >

