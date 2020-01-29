Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2A8C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:44:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18BDF206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="f4asAL+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18BDF206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwv8o-0001o2-2H
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 16:44:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36605)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1iwv5U-0008QT-Jf
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:41:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1iwv5T-0002g8-Ec
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:41:28 -0500
Received: from mout.gmx.net ([212.227.17.22]:56991)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <deller@gmx.de>)
 id 1iwv5T-0002df-1t; Wed, 29 Jan 2020 16:41:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1580334075;
 bh=NhiP/ciDVFAdLLRGiGXYwebc9iddMWYG9LAYhlbI8fk=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=f4asAL+KqOZB0Jn2FkCKlbXuQQ14I3A2JnaAroKvAfVatYGBWoFjui/Ep0JuKdDjv
 cy8hopgfWC3Io7i/TgBxG5LxhuNCt/afRnuFzE5IDKyqpl1xEN+w/beyvI0JT0aLc1
 NM9Ysi3eTaic6lZMibFknilzfdJ3KbWtuN5maPs4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.131.63]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MzQkK-1jj5mk3ShE-00vOKZ; Wed, 29
 Jan 2020 22:41:14 +0100
Subject: Re: [PATCH] hw/hppa/Kconfig: LASI chipset requires PARALLEL port
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200129192350.27143-1-philmd@redhat.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <ec1fed8a-c099-83bd-d64b-bc29a0b9eb2b@gmx.de>
Date: Wed, 29 Jan 2020 22:41:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200129192350.27143-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H793ZEqi4Rf9raTPRKR9+LxtdyLsWNDfpxzVi0sbZis03T/LY9d
 l6SAqt2TPBaln+Qgox9jqd5FWz2Kzt5m88pFlzvnr5qq4ixQTh7sxAwUSImfMgkjsCnRwt4
 XVU1bqxwYD+L04hcvp+AwAas5IZs4eWeA5/GkrS5hKU9SwXEaYGmBW3OHhSpXV6bTe6Zt3A
 wetdJ0MqnSW3iB7tazEDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4yeS1p2UfOU=:+bQXoUsWtAomyr4rALaUNP
 ZLiYYPE041ZlFSCxVbAQx/yhmGWCEKjNvzxfON1BfGgQQr08vWZg9CzCIxXataSRT9U24NbVZ
 PtHiU8HU7NPavusbbgMGBX9wLf9OtmiQqfNZhqkrg+LJkJxzGDuSxiY+Ozx9cFbdJqq/pD9ds
 r82zJKeqXp8yk1dCbH2ISVCEj+rItRU4735FYMrq4XU/g+F3aYi0piChTIk0HwffuxL9Jerjf
 Eg+6G1il20cyUOyU5zKgvLxLL0bFpWrhAMfleHNTg+oO5hvI961blR/f0uC8O9z0yLNbnTL/S
 JNEHfd0aKAjUZaN3iyTEOdxU1GpXATdyIOv2DkhXaiKkfdCkhzVfrAhHTiaWzvtOmJHywyLy8
 13wBaxNVbAP//pGJvioG45SUwSA9XS/NrglIrBRMjTDvKixfN5E436oiBXQlsJPwEQTmwOH+D
 56ucetZLyjO1z4vnFjyMlmeD09dTq5KSaPH3QyvrrQNlb1kEamwjsP642UUcPcAvx2srlSWxj
 rQ7/VRNt+CsjVhl8h+97s+opoBl3Uqv966QL5qAIcAECt+T8p8rfPuW7Nesh553f5jLPg6pa9
 pPqCy1WMamTZtSC8bRpe32wZf7aVBqDkx5RYWJU5eqIeGco0uPNj/eexqsCn2lTGkV0zCJtz5
 WJlRID/bkLApgoozdZofJ5D7QeFfNKlNFjsDJDendJM3QuNQnciaO+uQCjs0YZIArnqGi8H4P
 IIOKGhe9tYHdionKX8YPeT9AcUzY7NnPL+/LJNx01M2t6+xJaGGCBJe1H0+EOOwBForIP7j2Q
 WifeEaUGfDiCuY9MZv/S4rUvvJs1Vrb+Fg2XJxDfnod0kgTuD0BNNCi3ljC8sjqWjnyOw82tm
 GiFo7PgLNHWBkJBKHbT2mALEFjvwCdK69LsyYx70ABbtd+GaIRRXlbpWPWIf8L688qrBDLXIQ
 J+EY8c1gxVxZzbvNfpTlLvfDrV59mhNcdbZK9PERs8DRkJ6DhQKPeNWlr2cAJW5azjtROIF0V
 okt0abP3EOk8V3AYXWMPpxdmXl/X0LDzoiShzSwMpToRVp7kcbxdD+bH1LrEEeM02oGO41rN4
 gmSdwnuR/Yt6iabcVkY/CyaU9lccrctYN9rFioVXcS/jLuzFijD2F5Je/8bMALezjHO0PruMG
 VjaW2VCMEDJqigm6LphtyGMnA59QDukt2uS8/qyntTSlkndfr91Gt2Rn3n6+CMckRYE4LoIqZ
 OY7QjGmzg6eM4UaqL
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.22
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29.01.20 20:23, Philippe Mathieu-Daud=C3=A9 wrote:
> The PARISC Lasi chipset emulation requires some of the common parallel
> support and fails to build on a --without-default-devices:
>
>     LINK    hppa-softmmu/qemu-system-hppa
>   /usr/bin/ld: hw/hppa/lasi.o: in function `lasi_init':
>   hw/hppa/lasi.c:324: undefined reference to `parallel_mm_init'
>   collect2: error: ld returned 1 exit status
>   make[1]: *** [Makefile:206: qemu-system-hppa] Error 1
>
> Fixes: 376b851909d
> Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Acked-by: Helge Deller <deller@gmx.de>

> ---
>  hw/hppa/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/hppa/Kconfig b/hw/hppa/Kconfig
> index 82178c7dcb..22948db025 100644
> --- a/hw/hppa/Kconfig
> +++ b/hw/hppa/Kconfig
> @@ -12,4 +12,5 @@ config DINO
>      select LSI_SCSI_PCI
>      select LASI_82596
>      select LASIPS2
> +    select PARALLEL
>      select ARTIST
>


