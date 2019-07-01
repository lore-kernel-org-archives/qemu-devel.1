Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B7EC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 05:49:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E79B3208E4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 05:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oc7Vns9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E79B3208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhpC9-0002No-7V
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 01:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37334)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hhpAf-0000ds-JM
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 01:48:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hhpAe-0005pH-E0
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 01:48:09 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57395 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hhpAc-0005mh-Du; Mon, 01 Jul 2019 01:48:08 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45cbxs288Bz9sPD; Mon,  1 Jul 2019 15:48:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1561960081;
 bh=Q2I2WlWbFxLUofXLepO0U9lhPFobX49MRLQJLLky3hA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oc7Vns9XNy21N8HnCE9BDi4JfbaW9A/D7+2Q0YW507olVxXaBMBHXCrR3xGOMgmsF
 2q/qCfrlH2Pd1tVcV/k4IZOdzJlE7rX/CDOPkHMj2dv9uSzTs8MGDF7hHG88a4fI8x
 w16DzjTJ+gzXczoiqCZnu7U/vg4NlFRfPzKdVp38=
Date: Mon, 1 Jul 2019 15:15:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190701051509.GL2138@umbus.fritz.box>
References: <20190614165920.12670-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jtcAeju3WzRmRF+o"
Content-Disposition: inline
In-Reply-To: <20190614165920.12670-1-clg@kaod.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 0/2] spapr/xive: rework the mapping the KVM
 memory regions
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--jtcAeju3WzRmRF+o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2019 at 06:59:18PM +0200, C=E9dric Le Goater wrote:
> Hello,
>=20
> Here is a small series simplifying the initialization sequence of the
> interrupt device by using memory regions specific for KVM. These are
> mapped as overlaps on top of the emulated device.

Applied, thanks.

>=20
> Thanks,
>=20
> C.
>=20
> C=E9dric Le Goater (2):
>   spapr/xive: rework the mapping the KVM memory regions
>   spapr/xive: simplify spapr_irq_init_device() to remove the emulated
>     init
>=20
>  include/hw/ppc/spapr_irq.h  |  1 -
>  include/hw/ppc/spapr_xive.h |  2 +-
>  include/hw/ppc/xive.h       |  1 +
>  hw/intc/spapr_xive.c        | 38 ++++++++++---------------------------
>  hw/intc/spapr_xive_kvm.c    | 21 +++++++++++---------
>  hw/ppc/spapr_irq.c          | 21 +++-----------------
>  6 files changed, 27 insertions(+), 57 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jtcAeju3WzRmRF+o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0Zlt0ACgkQbDjKyiDZ
s5JiVQ/+Ovg+4pGlzKWrsDx7kJ+L0hGPJeM2ptrg8BLg7kqVptnLUA5Lysg/r0Tj
sYWwZ58FuZnbL/KCjJWV9ZJ7l+Hpd/BcZvdRN+xqmhKtrI1JN0tsC8yVYlxKjt8o
8m81CiuegVcbvGcqlLco1qak3m4EVr3f+zqjX8Jy0IgcTH1X8vS52Z4ONnVZsGSr
YYA/IEt9N4Rp8wF+0lIcVZginkLBp/E9QqvabsY1Vjg/85lKtgwTEI0uYqftbFtc
lWJC423l+InXs8UHbZFuVoNbIn6GZ8C+rT2hLdye31meLO5mzxbnRhEN0eSKGn1I
jX0eMm5L+f38swCO/hHbgCs9J9tV5IGVYZKqmPUv2oy+sSSkibT6XUftBaqqwwOt
/Kjujpzw070qIj2sRw18wzTkvqnVpGMDvYGWqfIjZcTWqGbT1Htbekuc4IyU+48z
UiauFvnNuefikKMtao/QgPoZczI6uFOVLRdVwlgTcG3VdIEhaK1Jl8oSUVxfiUHj
tmwCKghmk4pTzUOo1r4OZ6BYWHZF3E5EcN/+2vM36ASgIp1sYGSNrlNUDAM2f373
CfOIglzWSWD8ikiTZ3Dmqxvp97a7ld2rErKohn1AKjvCNFi+AA3y+BbS/J6uitBG
AMxHRjs9lXI3qsbw5xgO4jwThKI0qrnReaGgr5/sZibFfGOo8ws=
=zI7L
-----END PGP SIGNATURE-----

--jtcAeju3WzRmRF+o--

