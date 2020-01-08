Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9B4C33C99
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 01:06:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ABA0206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 01:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KnJnO+o2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ABA0206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioznu-00061G-Sv
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 20:06:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iozjV-0000Wb-OJ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 20:02:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iozjU-00017B-J6
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 20:02:01 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:57191)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iozjU-00012I-8W; Tue, 07 Jan 2020 20:02:00 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47srYZ55Fcz9sS3; Wed,  8 Jan 2020 12:01:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578445314;
 bh=g4qssSqHe1T8KMThNOUbaYBAb95zxavJOodYQaKkTjU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KnJnO+o25iUto34k1CGjZCTraOMPYM/751sK3fOmudaQh1/ZAMsFDFA2lvKn6AiSA
 HXGGasuYvMrqKB0RAvZr2dxOkEGWtNDpHv3poeci7L6PWLsiM/SR59XRAMPKTVswKD
 uf7thwzJ7qZokR3d0mC/xAfRE83A8gVYYPZN36Pk=
Date: Wed, 8 Jan 2020 12:01:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 2/2] ppc/pnv: fix check on return value of blk_getlength()
Message-ID: <20200108010146.GF2137@umbus.fritz.box>
References: <20200107171809.15556-1-clg@kaod.org>
 <20200107171809.15556-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vmttodhTwj0NAgWp"
Content-Disposition: inline
In-Reply-To: <20200107171809.15556-3-clg@kaod.org>
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--vmttodhTwj0NAgWp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2020 at 06:18:09PM +0100, C=E9dric Le Goater wrote:
> blk_getlength() returns an int64_t but the result is stored in a
> uint32_t. Errors (negative values) won't be caught by the check in
> pnv_pnor_realize() and blk_blockalign() will allocate a very large
> buffer in such cases.
>=20
> Fixes Coverity issue CID 1412226.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-5.0.

> ---
>  include/hw/ppc/pnv_pnor.h | 2 +-
>  hw/ppc/pnv_pnor.c         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv_pnor.h b/include/hw/ppc/pnv_pnor.h
> index c3dd28643cae..4f96abdfb402 100644
> --- a/include/hw/ppc/pnv_pnor.h
> +++ b/include/hw/ppc/pnv_pnor.h
> @@ -23,7 +23,7 @@ typedef struct PnvPnor {
>      BlockBackend   *blk;
> =20
>      uint8_t        *storage;
> -    uint32_t       size;
> +    int64_t        size;
>      MemoryRegion   mmio;
>  } PnvPnor;
> =20
> diff --git a/hw/ppc/pnv_pnor.c b/hw/ppc/pnv_pnor.c
> index 0e86ae2feae6..b061106d1c0c 100644
> --- a/hw/ppc/pnv_pnor.c
> +++ b/hw/ppc/pnv_pnor.c
> @@ -111,7 +111,7 @@ static void pnv_pnor_realize(DeviceState *dev, Error =
**errp)
>  }
> =20
>  static Property pnv_pnor_properties[] =3D {
> -    DEFINE_PROP_UINT32("size", PnvPnor, size, 128 << 20),
> +    DEFINE_PROP_INT64("size", PnvPnor, size, 128 << 20),
>      DEFINE_PROP_DRIVE("drive", PnvPnor, blk),
>      DEFINE_PROP_END_OF_LIST(),
>  };

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vmttodhTwj0NAgWp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4VKfoACgkQbDjKyiDZ
s5KAMQ/+KyaysGQPBQpSCE3lRkGkev4mTSKNkW2EXN0Tg4V3Q80wdjFUvi/MOTgV
gFIIAQy77tcf/UGaxiXwJqWIUfCy9zIFxFLP4UdZOExsHGKiza/Wgtgcg7UvPdYS
f8AyFZDEYgJATJQl+3jH5fShm83OJ/ajZuIq3ujM+tMN3V5ty9YSK/ebL/VabwTT
2eT9toAqy1QVZMzQiDSR0hyn6a4keYEpmnu/5DJoKvIZ6sHva0Kz+Fm26BOz8ouc
cD1kBK49zmbyxwuDh9cb7CvPAi0Q6UKKe2DHG3eN3Qcpnpq1UlDzkkwgFTEt99OH
J7JnklQOBJEpPN4HWtB22ho7cMnc2eY/NqufdtfpSOHUs/HDQTQN4RFNY5DOCoG3
n7O2SC2CMVGKFhGPA3Z1HzsubqvuHUvCt4TSCO1fOx1Beds69VfOEvshlga7qIqf
jOLx4N37diNrfSOfPbQwn8oVJicnocIx9hQNLhMRJAMi5LHdLLGpOUnzJdTTP7nD
8syabkIkOFZaJtpoNz8AZTnOPaKs82raCG1X7v6HZlT+/htt7QJzVmd3SOOD45am
7efLBCrmAwOxuEOBAKsYcQvmrSdHY11afYYtcMNINRoWzcf/mzfx7nu85m93R8Uh
4qyYTFRVPUF7zQzDogahktrp9Jljj5G9t7D7lQeYTn4D9yQ4+gg=
=5F88
-----END PGP SIGNATURE-----

--vmttodhTwj0NAgWp--

