Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC52C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 06:12:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65F1F2071A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 06:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="WND1wUgw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F1F2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwJbz-0001ul-Me
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 02:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jwJVR-0007jS-S5; Fri, 17 Jul 2020 02:06:01 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:40057)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jwJVN-0005zR-QL; Fri, 17 Jul 2020 02:06:01 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B7LG91d2wz9sSt; Fri, 17 Jul 2020 16:05:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1594965953;
 bh=eAfQ2wgxBsJpI2NUHE8LajdX7GszAGlBYtoIZEr9yho=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WND1wUgwwf/ye4Qe9pRgDbYEll+uC005gI6omAmTVNnqpBn0qlq/IZkmQSIKPbPQx
 zpGqWiNtax1djXPNsv8kAribM5UxhzpFFqSJ3Hh/fWPVMeYnqtgMmDRSzTK+3vlG3U
 BY64LI+R79vZxynDDp2/lHeqAw/J/cvr1/IyBt40=
Date: Fri, 17 Jul 2020 15:47:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PULL SUBSYSTEM qemu-pseries] pseries: Update SLOF firmware image
Message-ID: <20200717054743.GG5607@umbus.fritz.box>
References: <20200717032705.100809-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+sHJum3is6Tsg7/J"
Content-Disposition: inline
In-Reply-To: <20200717032705.100809-1-aik@ozlabs.ru>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--+sHJum3is6Tsg7/J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2020 at 01:27:05PM +1000, Alexey Kardashevskiy wrote:
> The following changes since commit 1038a309ec829f05a3a3e52a9951cfdb24dfd0=
2c:
>=20
>   spapr: Add a new level of NUMA for GPUs (2020-07-17 10:36:28 +1000)
>=20
> are available in the Git repository at:
>=20
>   git@github.com:aik/qemu.git tags/qemu-slof-20200717
>=20
> for you to fetch changes up to 7f5258dd8327d574de455a2271788474fa25548d:
>=20
>   pseries: Update SLOF firmware image (2020-07-17 13:23:00 +1000)

Merged, thanks.

>=20
> ----------------------------------------------------------------
> Alexey Kardashevskiy (1):
>       pseries: Update SLOF firmware image
>=20
>  pc-bios/README   |   2 +-
>  pc-bios/slof.bin | Bin 965112 -> 968368 bytes
>  roms/SLOF        |   2 +-
>  3 files changed, 2 insertions(+), 2 deletions(-)
>=20
>=20
> *** Note: this is not for master, this is for pseries
>=20
> This adds tcgbios (this was posted earlier [1] but got lost)
> and fixes FDT update at ibm,client-architecture-support
> for huge guests.
>=20
> The full list of changes:
>=20
> Alexey Kardashevskiy (4):
>       make: Define default rule for .c when V=3D1 or V=3D2
>       version: update to 20200513
>       fdt: Avoid recursion when traversing tree
>       version: update to 20200717
>=20
> Gustavo Romero (1):
>       board-qemu: Fix comment about SLOF start address
>=20
> Stefan Berger (6):
>       tcgbios: Only write logs for PCRs that are allocated
>       tcgbios: Fix the vendorInfoSize to be of type uint8_t
>       tcgbios: Add support for SHA3 type of algorithms
>       elf: Implement elf_get_file_size to determine size of an ELF image
>       tcgbios: Implement tpm_hash_log_extend_event_buffer
>       tcgbios: Measure the bootloader file read from disk
>=20
> [1] https://patchwork.ozlabs.org/project/qemu-devel/patch/20200513024355.=
121476-1-aik@ozlabs.ru/
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+sHJum3is6Tsg7/J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8RO38ACgkQbDjKyiDZ
s5KGAxAApyiqrhvKBQEr/3SCHzFJ2TXvaMhxvRkHnsHvsP0ge9RsdcMbrSLQsMax
vCd2T6avyHMvvBMZ/0x7BSdemxIFfLyy6KqJpgf3t6eFW8KTl0CEpinVHRqWzxmT
rGozhpU9CyVcvb5fssX08XuKhWb5PL5ULPeTe1jVso94jaAlrvI1lFKLwzSOYRk+
qi7DPTWOdJYEFk0+4PJfqdVzFggkqPwPbERqz4WxeG0HOs5NpG9nJyNTJk7Smk/d
XFoUpZTcFRxlQAWuxUS/B6/JohqpNrULPaBOjtsjw1dzpMiPm/q2F6pevvjkgXpT
X0rDzhGnu3JzmUA4eXckHJC7CRMsX3j9Yj8uDgkMI1etEaM0GT0N5SGKkvAvlRP+
NYtwKKtBA65iEDeLaJGuktr9vaNpYJ4exiRnUTVnKn6qZx7oEe7gppnM1musHtJZ
0S8hXYY0NA0s1Yi6qWoV2NJr2MkkY8JzgCH7qQCfMOTGseCcvEnCO2b4d/4BvMkG
IRaeFXSE5N5xcLNzHnIiqPr+ojkQtdDmx3qVCYZkLSFDlLFGH7NaRd6EtcqRfK0o
+Tif9pqbWzMQbI2iHYSWstgpSELCaF9n+o18YQ+PAOhhqindWXqcYoRdrosweesR
+yv+FILZSadZ+bLDFG42qDunENXia9qvf+WoRsQG1tn5+e8LO9o=
=nxuT
-----END PGP SIGNATURE-----

--+sHJum3is6Tsg7/J--

