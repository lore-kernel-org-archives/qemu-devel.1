Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADB7C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 20:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 546C120853
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 20:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="f/LNV2yd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 546C120853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aurel32.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqj8N-0001Hf-AY
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 16:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1jqj5R-0000dm-5V
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 16:12:05 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:41248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1jqj5O-0004cC-7c
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 16:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
 ; s=202004.hall;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Reply-To:
 Subject:Content-ID:Content-Description:X-Debbugs-Cc;
 bh=uw4vr6KNXc+8ZmzWIde82j3SQf80rHhnY30F7CltHHI=; b=f/LNV2ydWYE1nww5MqizQOgkSG
 AAOBXKs24/V4JziY/i49C7sPXS4YdZe3aXMRzFWoN/jtZGmqgpwnrkqiihKzb0keY3kCGXRxB1rFw
 6ZrgUTmbeSNaSPvAtzRPmJhRxIKDLsXcntn69cWnq4ZX/O2a10p/mA6niQcjYkX9HaJ+DkJRIFq+u
 eKFIxP5eUI4WiZXoFQ4i7B79a/UotxOX8+rTOv+kATkVihkH1dI9OBj+HJSJujXoEPQEZwLEZr/AF
 2krhXOctDCeMuuYqbyUJf+3IlUt8N/QcOZPlge6uGwXgtYI7Yi64R6SVyJZXJwo0gBudK98NWWvI2
 I/Y5dH9Q==;
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
 by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <aurelien@aurel32.net>)
 id 1jqj5K-00042t-R7; Wed, 01 Jul 2020 22:11:58 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.94)
 (envelope-from <aurelien@aurel32.net>)
 id 1jqj5J-004bw4-AP; Wed, 01 Jul 2020 22:11:57 +0200
Date: Wed, 1 Jul 2020 22:11:57 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: Re: [PATCH v2 2/2] MAINTAINERS: Adjust MIPS maintainership
Message-ID: <20200701201157.GA1093783@aurel32.net>
References: <20200630164653.24880-1-aleksandar.qemu.devel@gmail.com>
 <20200630164653.24880-3-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200630164653.24880-3-aleksandar.qemu.devel@gmail.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
Received-SPF: none client-ip=2001:bc8:30d7:100::1;
 envelope-from=aurelien@aurel32.net; helo=hall.aurel32.net
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
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
Cc: aleksandar.rikalo@syrmia.com, qemu-devel@nongnu.org,
 Paul Burton <paulburton@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

I know you have sent a v3 of this patch in the meantime, but I would
still like to comment on it.

First of all I confirm, that I do not have time to contribute to QEMU
anymore and that I said I would like to resign from QEMU maintainership.
We discussed that in person in Lyon back in October. I am happy to see
that people are interested to take the maintainership.

It happens that I known Huacai Chen from the time he was upstreaming the
Loongson 3 support to the kernel, I have been testing and reviewing his
patches. I also know Jiaxun Yang from the #debian-mips IRC channel. I
know that they are both very competent and have a good knowledge of the
open source world. I therefore agree that they are good additions to
maintain and/or review the MIPS part of QEMU.

All that said, they have been contributing only relatively recently to
QEMU, and only to some areas. While I do support adding them to those
areas, I wonder for example why adding them to the MIPS TCG target or
to the Jazz board. That's probably something that should be done in a
second step if they have an interest in doing so.

I am fully aware that you posted a v3, that fixes exactly that after you
got pointed out. However, I am still concerned by the way things
happened.

Regards,
Aurelien


On 2020-06-30 18:46, Aleksandar Markovic wrote:
> Paul Burton and Aurelien Jarno removed for not being present.
>=20
> Huacai Chen and Jiaxun Yang step in as new energy.
>=20
> CC: Paul Burton <paulburton@kernel.org>
> CC: Aurelien Jarno <aurelien@aurel32.net>
> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> ---
>  MAINTAINERS | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5d8acf8d31..7fc16e21c9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -213,7 +213,8 @@ F: disas/microblaze.c
> =20
>  MIPS TCG CPUs
>  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> -R: Aurelien Jarno <aurelien@aurel32.net>
> +M: Huacai Chen <chenhc@lemote.com>
> +R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>  S: Maintained
>  F: target/mips/
> @@ -377,6 +378,7 @@ F: target/arm/kvm.c
> =20
>  MIPS KVM CPUs
>  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> +M: Huacai Chen <chenhc@lemote.com>
>  S: Odd Fixes
>  F: target/mips/kvm.c
> =20
> @@ -1052,6 +1054,7 @@ MIPS Machines
>  -------------
>  Jazz
>  M: Herv=E9 Poussineau <hpoussin@reactos.org>
> +M: Huacai Chen <chenhc@lemote.com>
>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>  S: Maintained
>  F: hw/mips/jazz.c
> @@ -1060,8 +1063,8 @@ F: hw/dma/rc4030.c
> =20
>  Malta
>  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> +M: Huacai Chen <chenhc@lemote.com>
>  M: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> -R: Aurelien Jarno <aurelien@aurel32.net>
>  S: Maintained
>  F: hw/isa/piix4.c
>  F: hw/acpi/piix4.c
> @@ -1073,6 +1076,7 @@ F: tests/acceptance/machine_mips_malta.py
> =20
>  Mipssim
>  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> +M: Huacai Chen <chenhc@lemote.com>
>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>  S: Odd Fixes
>  F: hw/mips/mipssim.c
> @@ -1080,7 +1084,6 @@ F: hw/net/mipsnet.c
> =20
>  R4000
>  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> -R: Aurelien Jarno <aurelien@aurel32.net>
>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>  S: Obsolete
>  F: hw/mips/r4k.c
> @@ -1103,7 +1106,8 @@ S: Maintained
>  F: hw/intc/loongson_liointc.c
> =20
>  Boston
> -M: Paul Burton <pburton@wavecomp.com>
> +M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> +M: Huacai Chen <chenhc@lemote.com>
>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>  S: Maintained
>  F: hw/core/loader-fit.c
> @@ -2677,7 +2681,8 @@ F: disas/i386.c
> =20
>  MIPS TCG target
>  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> -R: Aurelien Jarno <aurelien@aurel32.net>
> +M: Huacai Chen <chenhc@lemote.com>
> +R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>  S: Maintained
>  F: tcg/mips/
> --=20
> 2.20.1
>=20
>=20
>=20

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net

