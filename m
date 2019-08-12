Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D318C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 09:15:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 175B62085A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 09:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gzHYtb/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175B62085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx6QE-0006vR-DE
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 05:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41097)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hx6P3-0005xd-NI
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 05:14:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hx6P2-00043y-85
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 05:14:09 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:54069)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hx6P0-0003xs-B7; Mon, 12 Aug 2019 05:14:08 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 466VX80rxjz9sP7; Mon, 12 Aug 2019 19:13:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1565601240;
 bh=Q/gHHoykm0FXADYpl74HthPVck08gWUBDsZmeAL3Zxc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gzHYtb/ViERMfLDo/d8ZHh4XDpqa0bojZi/1M8XECXgU7BPknzrgrRSnqXUhiqtgS
 bwo/RC/PZz573YbJcnSUxin0ADWoir3F+d8aWVBHwMiIfo7G/pGJ6HOSKahxyccq/I
 OnzZxZqULmazUA4f+KjHUfyUfkv6SVdFhbA0eW90=
Date: Mon, 12 Aug 2019 17:58:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20190812075850.GA3947@umbus.fritz.box>
References: <20190812054202.125492-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <20190812054202.125492-1-aik@ozlabs.ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH qemu] spapr_iommu: Fix xlate trace to print
 translated address
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


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2019 at 03:42:02PM +1000, Alexey Kardashevskiy wrote:
> Currently we basically print IO address twice, fix this.
>=20
> Fixes: 7e472264e9e2 ("PPC: spapr: iommu: rework traces")
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to ppc-for-4.2, thanks.

> ---
>  hw/ppc/spapr_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> index bd3d0256a65d..6fe57d799a10 100644
> --- a/hw/ppc/spapr_iommu.c
> +++ b/hw/ppc/spapr_iommu.c
> @@ -137,7 +137,7 @@ static IOMMUTLBEntry spapr_tce_translate_iommu(IOMMUM=
emoryRegion *iommu,
>          ret.addr_mask =3D ~page_mask;
>          ret.perm =3D spapr_tce_iommu_access_flags(tce);
>      }
> -    trace_spapr_iommu_xlate(tcet->liobn, addr, ret.iova, ret.perm,
> +    trace_spapr_iommu_xlate(tcet->liobn, addr, ret.translated_addr, ret.=
perm,
>                              ret.addr_mask);
> =20
>      return ret;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1RHDcACgkQbDjKyiDZ
s5LjzA/+JAyudX8Owx1AanA4Ea5ZRxrKoWJ9rbfV5Bvw0jmWmd+DbI8eMN40cm/k
XZY2UHRI0em1YM75ZvL0j6lEB2QmEBMHgg45DtirBIIkF8aT1eWBKIWz7pvpDY00
Op2jjOJA7XgykrQjwd9fHZf993iDTmzYbPOjoZF2BSJG4k/mo4g9vkURtUdFxlgX
hR9U2Fmxl5eks4s/ok9dzmyacZP+4vSCizxzEjONpIajcg4TRbNUwPPyrO0DAF4V
Ix46NXge/HfY0etXmvhZapABZED7BYZyMmIxN62+FW2Bn7F2MycvN2QpVu+9eAIl
ykwJEmS+PG7ZG59bsVVPK8SoLfi5Ap+HdTquA8YHCK95F62wf3eje2yhAtBahhyZ
CT7LfZphsCydJIoxcOqPz4EMnP3020rbdLf44DTFRwEOrlCNLEUTarScIKfrygBr
BkMZr4JVpduV0XjXNj//mkO+EfedawOokwGExG4P9ii0VnPF/7HHMMBB5zyr+8iN
xCAAUcYQMV7xfn9+JKhXATJmFdlQvyFvqcELLTZqAE+TCQEPiOBBJuNcg8c30O64
dnYQdNbFM8rQ+o2jrwRMgZmz+86lsIhCUL8cCVHiRAIreKsZaE47lwB0c1pQV2Zz
p7jNO6OpUxA0cliY7Bw2el39YYzGcu4cdP4g2lolmrl2SlMqK00=
=vS67
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--

