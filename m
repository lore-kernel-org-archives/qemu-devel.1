Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D92C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:20:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1089921739
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MSfK5Gd8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1089921739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8k3Z-0004VB-7Y
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 07:20:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42183)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8k2f-00033Y-4Z
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:19:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8k2d-0001j9-5l
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:19:25 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45647)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8k2c-0001j3-U9
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:19:23 -0500
Received: by mail-wr1-x444.google.com with SMTP id v2so12222034wrp.12
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 04:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=RoYS2YHDc+x44MnCwwVgyh19ZPeRbg3AkQPH614Eexo=;
 b=MSfK5Gd8NM7qqI6AC1Kv3Fgk8YMg68f9E+PMzAlUVPgkG80KOK2tk28jgoiU8E1QOA
 v9XhiiGbPp/86/Bj6tKxFlICgnuY0uZC20j1kQO5pYhaFH+RrSaoITArJ48SirNkVgzW
 SxCFniSE/ZVzeWncMIu2T9Kw4Jz8fOtzOFJXhkN+JFf1wBmjIDC8u/ZOT1UF72Y7W8uO
 tTbhAQiGQhMrJdYXkaD+S8yMJrs85g7YrP8mp+Xx2RUBIauZJZ4hFHB0FDpGvmtGfjUF
 MBzAtImXUZ4/+BFfEuEHCadA3q+7lMwjcVtLWMDHDMyi0ibEXHAJNY/3MrbEQoHVyXz/
 PbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=RoYS2YHDc+x44MnCwwVgyh19ZPeRbg3AkQPH614Eexo=;
 b=Y4UJYGeJyPWgXLmFKWLohX2mXb06PfSPaOCYmLccjhJiiU4hAEDA68fJNU10O18F0w
 eoy8WCb62zHSE8qH3VbIkHMoHNX9fy97aNeNPNOkhAfUXC/rBAQaV3qckwSeF5ojYAkC
 vO1pgivzYqx00UuQTRjwRvH+1unHgB6wR//7jS3S/BNsWuEh3sW0klyTY6sdiFPFsk/A
 M+9XHdXddnaD3t+SOCTcp3IurwRnBNQ6x+fVo6DWfb5KFGpPXJlhZk7nO2hZsrstaHKD
 VDy0reK2+0wdrGY/xrRF7qgwdMUc5zgg0uMvBfsW/2PJevnskD66NOxgyWsDzbdQ1plt
 34Zw==
X-Gm-Message-State: APjAAAURuOYfaslIs/tskwwZ/Plmc9e6zZ4cHEnrMzfqyJYWL/RRgE9I
 szCiWdLJgMjoh8f66UdyWls5sw==
X-Google-Smtp-Source: APXvYqwd0bl2Y+yZuN2CxNGwVuvdic8FX+NPY4T4fFyjSn47xgluyop/JaCULIcH5MAXc9qdC9eAXg==
X-Received: by 2002:adf:9071:: with SMTP id
 h104mr19472212wrh.359.1583151561832; 
 Mon, 02 Mar 2020 04:19:21 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s15sm28289682wrp.4.2020.03.02.04.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 04:19:20 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 195291FF87;
 Mon,  2 Mar 2020 12:19:20 +0000 (GMT)
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-25-peter.maydell@linaro.org>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 24/33] docs: Roll -prom-env and -g target-specific
 info into qemu-options.hx
In-reply-to: <20200228153619.9906-25-peter.maydell@linaro.org>
Date: Mon, 02 Mar 2020 12:19:20 +0000
Message-ID: <87k1439cfr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> The SPARC and PPC targets currently have a fragment of target-specific
> information about the -g and -prom options which would be better placed
> as part of the general documentation of those options in qemu-options.hx.
> Move the relevant information to those locations.
>
> SPARC also has a bit of text about the -M option which is out of
> date and provides no useful information over the generic documentation
> of that option, so just delete it.
>
> The motivation here is again to avoid having to awkwardly include
> this text into the rST version of the qemu.1 manpage.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  docs/system/target-ppc.rst      | 14 --------------
>  docs/system/target-ppc.texi     | 25 -------------------------
>  docs/system/target-sparc.rst    | 19 -------------------
>  docs/system/target-sparc.texi   | 27 ---------------------------
>  docs/system/target-sparc64.rst  | 12 ------------
>  docs/system/target-sparc64.texi | 22 ----------------------
>  qemu-options.hx                 | 19 +++++++++++++++++++
>  7 files changed, 19 insertions(+), 119 deletions(-)
>
> diff --git a/docs/system/target-ppc.rst b/docs/system/target-ppc.rst
> index 43fadf3c00b..a2f04c533c2 100644
> --- a/docs/system/target-ppc.rst
> +++ b/docs/system/target-ppc.rst
> @@ -43,19 +43,5 @@ the g3beige and mac99 PowerMac and the 40p machines. O=
penBIOS is a free
>  (GPL v2) portable firmware implementation. The goal is to implement a
>  100% IEEE 1275-1994 (referred to as Open Firmware) compliant firmware.
>=20=20
> -The following options are specific to the PowerPC emulation:
> -
> -``-g WxH[xDEPTH]``
> -   Set the initial VGA graphic mode. The default is 800x600x32.
> -
> -``-prom-env string``
> -   Set OpenBIOS variables in NVRAM, for example:
> -
> -   ::
> -
> -      qemu-system-ppc -prom-env 'auto-boot?=3Dfalse' \
> -       -prom-env 'boot-device=3Dhd:2,\yaboot' \
> -       -prom-env 'boot-args=3Dconf=3Dhd:2,\yaboot.conf'
> -
>  More information is available at
>  http://perso.magic.fr/l_indien/qemu-ppc/.
> diff --git a/docs/system/target-ppc.texi b/docs/system/target-ppc.texi
> index 55f98f65b12..5c83d4f68e7 100644
> --- a/docs/system/target-ppc.texi
> +++ b/docs/system/target-ppc.texi
> @@ -47,31 +47,6 @@ for the g3beige and mac99 PowerMac and the 40p machine=
s. OpenBIOS is a free
>  (GPL v2) portable firmware implementation. The goal is to implement a 10=
0%
>  IEEE 1275-1994 (referred to as Open Firmware) compliant firmware.
>=20=20
> -@c man begin OPTIONS
> -
> -The following options are specific to the PowerPC emulation:
> -
> -@table @option
> -
> -@item -g @var{W}x@var{H}[x@var{DEPTH}]
> -
> -Set the initial VGA graphic mode. The default is 800x600x32.
> -
> -@item -prom-env @var{string}
> -
> -Set OpenBIOS variables in NVRAM, for example:
> -
> -@example
> -qemu-system-ppc -prom-env 'auto-boot?=3Dfalse' \
> - -prom-env 'boot-device=3Dhd:2,\yaboot' \
> - -prom-env 'boot-args=3Dconf=3Dhd:2,\yaboot.conf'
> -@end example
> -
> -@end table
> -
> -@c man end
> -
> -
>  More information is available at
>  @url{http://perso.magic.fr/l_indien/qemu-ppc/}.
>=20=20
> diff --git a/docs/system/target-sparc.rst b/docs/system/target-sparc.rst
> index 589c88d1756..b55f8d09e9c 100644
> --- a/docs/system/target-sparc.rst
> +++ b/docs/system/target-sparc.rst
> @@ -60,22 +60,3 @@ QEMU web site. There are still issues with NetBSD and =
OpenBSD, but most
>  kernel versions work. Please note that currently older Solaris kernels
>  don't work probably due to interface issues between OpenBIOS and
>  Solaris.
> -
> -The following options are specific to the Sparc32 emulation:
> -
> -``-g WxHx[xDEPTH]``
> -   Set the initial graphics mode. For TCX, the default is 1024x768x8
> -   with the option of 1024x768x24. For cgthree, the default is
> -   1024x768x8 with the option of 1152x900x8 for people who wish to use
> -   OBP.
> -
> -``-prom-env string``
> -   Set OpenBIOS variables in NVRAM, for example:
> -
> -   ::
> -
> -      qemu-system-sparc -prom-env 'auto-boot?=3Dfalse' \
> -       -prom-env 'boot-device=3Dsd(0,2,0):d' -prom-env 'boot-args=3Dlinu=
x single'
> -
> -``-M [SS-4|SS-5|SS-10|SS-20|SS-600MP|LX|Voyager|SPARCClassic] [|SPARCboo=
k]``
> -   Set the emulated machine type. Default is SS-5.
> diff --git a/docs/system/target-sparc.texi b/docs/system/target-sparc.texi
> index 7748001f734..99fbf820b42 100644
> --- a/docs/system/target-sparc.texi
> +++ b/docs/system/target-sparc.texi
> @@ -64,32 +64,5 @@ most kernel versions work. Please note that currently =
older Solaris kernels
>  don't work probably due to interface issues between OpenBIOS and
>  Solaris.
>=20=20
> -@c man begin OPTIONS
> -
> -The following options are specific to the Sparc32 emulation:
> -
> -@table @option
> -
> -@item -g @var{W}x@var{H}x[x@var{DEPTH}]
> -
> -Set the initial graphics mode. For TCX, the default is 1024x768x8 with t=
he
> -option of 1024x768x24. For cgthree, the default is 1024x768x8 with the o=
ption
> -of 1152x900x8 for people who wish to use OBP.
> -
> -@item -prom-env @var{string}
> -
> -Set OpenBIOS variables in NVRAM, for example:
> -
> -@example
> -qemu-system-sparc -prom-env 'auto-boot?=3Dfalse' \
> - -prom-env 'boot-device=3Dsd(0,2,0):d' -prom-env 'boot-args=3Dlinux sing=
le'
> -@end example
> -
> -@item -M [SS-4|SS-5|SS-10|SS-20|SS-600MP|LX|Voyager|SPARCClassic] [|SPAR=
Cbook]
> -
> -Set the emulated machine type. Default is SS-5.
> -
> -@end table
> -
>  @c man end
>=20=20
> diff --git a/docs/system/target-sparc64.rst b/docs/system/target-sparc64.=
rst
> index ca76ba9c488..97e334b9308 100644
> --- a/docs/system/target-sparc64.rst
> +++ b/docs/system/target-sparc64.rst
> @@ -35,15 +35,3 @@ QEMU emulates the following peripherals:
>  -  2 PCI IDE interfaces with hard disk and CD-ROM support
>=20=20
>  -  Floppy disk
> -
> -The following options are specific to the Sparc64 emulation:
> -
> -``-prom-env string``
> -   Set OpenBIOS variables in NVRAM, for example:
> -
> -   ::
> -
> -      qemu-system-sparc64 -prom-env 'auto-boot?=3Dfalse'
> -
> -``-M [sun4u|sun4v|niagara]``
> -   Set the emulated machine type. The default is sun4u.
> diff --git a/docs/system/target-sparc64.texi b/docs/system/target-sparc64=
.texi
> index 4db4ca3842b..d381d3af719 100644
> --- a/docs/system/target-sparc64.texi
> +++ b/docs/system/target-sparc64.texi
> @@ -36,25 +36,3 @@ PC-compatible serial ports
>  Floppy disk
>  @end itemize
>=20=20
> -@c man begin OPTIONS
> -
> -The following options are specific to the Sparc64 emulation:
> -
> -@table @option
> -
> -@item -prom-env @var{string}
> -
> -Set OpenBIOS variables in NVRAM, for example:
> -
> -@example
> -qemu-system-sparc64 -prom-env 'auto-boot?=3Dfalse'
> -@end example
> -
> -@item -M [sun4u|sun4v|niagara]
> -
> -Set the emulated machine type. The default is sun4u.
> -
> -@end table
> -
> -@c man end
> -
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 4bc8048f60b..3b230a17164 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1962,6 +1962,13 @@ STEXI
>  @item -g @var{width}x@var{height}[x@var{depth}]
>  @findex -g
>  Set the initial graphical resolution and depth (PPC, SPARC only).
> +
> +For PPC the default is 800x600x32.
> +
> +For SPARC with the TCX graphics device, the default is 1024x768x8 with t=
he
> +option of 1024x768x24. For cgthree, the default is 1024x768x8 with the o=
ption
> +of 1152x900x8 for people who wish to use OBP.
> +
>  ETEXI
>=20=20
>  DEF("vnc", HAS_ARG, QEMU_OPTION_vnc ,
> @@ -4107,6 +4114,18 @@ STEXI
>  @item -prom-env @var{variable}=3D@var{value}
>  @findex -prom-env
>  Set OpenBIOS nvram @var{variable} to given @var{value} (PPC, SPARC only).
> +
> +@example
> +qemu-system-sparc -prom-env 'auto-boot?=3Dfalse' \
> + -prom-env 'boot-device=3Dsd(0,2,0):d' -prom-env 'boot-args=3Dlinux sing=
le'
> +@end example
> +
> +@example
> +qemu-system-ppc -prom-env 'auto-boot?=3Dfalse' \
> + -prom-env 'boot-device=3Dhd:2,\yaboot' \
> + -prom-env 'boot-args=3Dconf=3Dhd:2,\yaboot.conf'
> +@end example
> +
>  ETEXI
>  DEF("semihosting", 0, QEMU_OPTION_semihosting,
>      "-semihosting    semihosting mode\n",


--=20
Alex Benn=C3=A9e

