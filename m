Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEB3C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 23:50:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58D2C20717
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 23:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="TfxTbDq/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D2C20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA0GW-0006xa-Hx
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 18:50:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jA0FN-0004Kp-SR
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 18:49:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jA0FL-0008Vv-AW
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 18:49:45 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:45657 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jA0FK-0008Sj-Nu; Thu, 05 Mar 2020 18:49:43 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48YSCP5S8xz9sQt; Fri,  6 Mar 2020 10:49:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1583452177;
 bh=lvDzd5auQYRKOXJXnd+xmVs6q73HUXnx5z3n10EhcmU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TfxTbDq/bDNq62rA1T8XDDJr05xzDcj3MOtjI9efHHRVrYCp07SHwAbT5ojn7tGP7
 gqNp0mfuKiLv6aBNNpm0phHAY4RmMRmoTx5GErIJfkuo5R/6y8XC7DUbGCffeYDs/d
 sadRBl4ZTSxIlKZJy+7FnxKLw2HyfV1RxFn4fqyg=
Date: Fri, 6 Mar 2020 10:03:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 0/7] hw/scsi/spapr_vscsi: Fix time bomb buffer overflow
Message-ID: <20200305230356.GB617846@umbus.fritz.box>
References: <20200305121253.19078-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
In-Reply-To: <20200305121253.19078-1-philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2020 at 01:12:46PM +0100, Philippe Mathieu-Daud=E9 wrote:
> This series fixes a possible buffer overflow.
>=20
> Simples patches first (dissociate the buffer holding DMA
> requests with pointer to SRP Information Unit packets) to
> clean the issue in the penultimate patch.
>

Applied to ppc-for-5.0, thanks.

> v3:
> - Fixed typo reported by Greg Kurz
> - Addressed Paolo Bonzini review comments as an extra patch
> - Added another patch converting a fprintf() call while here
>=20
> v2:
> - Addressed David Gibson review comments
>=20
> Supersedes: <20200305083135.8270-1-philmd@redhat.com>
>=20
> Philippe Mathieu-Daud=E9 (7):
>   hw/scsi/viosrp: Add missing 'hw/scsi/srp.h' include
>   hw/scsi/spapr_vscsi: Use SRP_MAX_IU_LEN instead of sizeof flexible
>     array
>   hw/scsi/spapr_vscsi: Simplify a bit
>   hw/scsi/spapr_vscsi: Introduce req_iu() helper
>   hw/scsi/spapr_vscsi: Do not mix SRP IU size with DMA buffer size
>   hw/scsi/spapr_vscsi: Prevent buffer overflow
>   hw/scsi/spapr_vscsi: Convert debug fprintf() to trace event
>=20
>  hw/scsi/viosrp.h      |  3 +-
>  hw/scsi/spapr_vscsi.c | 72 +++++++++++++++++++++++++------------------
>  hw/scsi/trace-events  |  1 +
>  3 files changed, 45 insertions(+), 31 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5hhVwACgkQbDjKyiDZ
s5K1yw//d+eZqi1vBP+M+cDuCSelwX/sDZzN1t22ZMoj7cpHAKg3dPd7cNX4NmC9
hk3r6aT7oFSz0C/ipNzQsh2/SE6dzIXeZRB3lpS23DxgpX4d3N9be0uW+ZP4pdhq
YlebnEU/AHUUMGC3pHxfvc39k3x5XGksgC1ex3iXl79ERx3HTD/XesPWjhNF2LYm
bDK87UccQpCvccx1N+DIIac5UaEprY81EqI7raeUGedodNhIK/AElr+qfSm+2ZO+
swBRDskyP7wnlFapHgJUrXPvMZeRQeqfm5IGBI0I5u3N/q9MlfHf57Vrcf7aOAiy
2JC3UWHDl1TLdzleThNcblJie+WgctuPzzGnq+Yi/JheS1/fQaC6Xf+6ks5+Y+rD
kDoQ2R3uG5oRLNbA0SfeefhSlwfGBbGx/0pC9E+CNqRRAVn/r4Hno+29Ic2+mRJ5
/WDrzyPq6j6AecEFmUWo4FI9fEdst62eLBtOfPscAqFtXLi6dS//p7AFBl3FYxpS
METMMkAkap7ZMN1I9xK9OvrH8FgsH1pPHC+/V5BInICTsDwC6U3R05CONbCPQmT5
N85/xELlJ+kox8WjXdsg3L7IoQqMdBPrzFWWLwkaqPDvaBfbgzxo6gaD5abqNxE6
6QR6Qd4FFdRRiL+EkeShiSAvUFIN7QBrLQ4mlKV+bGCPoMUPMLM=
=ukf9
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--

