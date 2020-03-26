Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF60C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 11:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45CE52070A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 11:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="AOcFPBRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45CE52070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHQhj-0005Nc-GB
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 07:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jHQgr-0004ZY-OF
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 07:28:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jHQgq-0004KF-8m
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 07:28:49 -0400
Received: from ozlabs.org ([203.11.71.1]:57441)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jHQgp-0004HF-13; Thu, 26 Mar 2020 07:28:48 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48p2mp4MYyz9sSG; Thu, 26 Mar 2020 22:28:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585222122;
 bh=E/F2wbDXcjmY/A4OA2LKVXlpPkmMLsTBPtZWThjFQRw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AOcFPBRHbEHmnQ3zllP3zbshUR/LA9k7GcH6eiwxDBrV/ElGafG+R5T7kqy/5hezB
 2IW2TpomTZsQ7H/FDe/qT4N/9DuU+eXXVdkP9LlMnqSvA/RdDQQmwMfDTaMTp2jqc+
 d879OiH3zFFNwvtzMdMpkD2RkouVq5qk8qzACQHE=
Date: Thu, 26 Mar 2020 22:28:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH qemu] vfio/spapr: Fix page size calculation
Message-ID: <20200326112829.GA456060@umbus.fritz.box>
References: <20200324063912.25063-1-aik@ozlabs.ru>
 <20200326001106.GJ36889@umbus.fritz.box>
 <CAFEAcA9M1zjbA9Ztsrd+gcgWb8+5ouVw1Nu75MUk2ZZpBNdNEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9M1zjbA9Ztsrd+gcgWb8+5ouVw1Nu75MUk2ZZpBNdNEw@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2020 at 11:21:47AM +0000, Peter Maydell wrote:
> On Thu, 26 Mar 2020 at 00:39, David Gibson <david@gibson.dropbear.id.au> =
wrote:
> >
> > On Tue, Mar 24, 2020 at 05:39:12PM +1100, Alexey Kardashevskiy wrote:
> > > Coverity detected an issue (CID 1421903) with potential call of clz64=
(0)
> > > which returns 64 which make it do "<<" with a negative number.
> > >
> > > This checks the mask and avoids undefined behaviour.
> > >
> > > In practice pgsizes and memory_region_iommu_get_min_page_size() always
> > > have some common page sizes and even if they did not, the resulting p=
age
> > > size would be 0x8000.0000.0000.0000 (gcc 9.2) and
> > > ioctl(VFIO_IOMMU_SPAPR_TCE_CREATE) would fail anyway.
> > >
> > > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >
> > Applied to ppc-for-5.1.
>=20
> As a coverity-issue-fix it would be nice to have this in
> 5.0 unless you think it's particularly risky.

In fact, I realized that shortly after and moved it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl58kd0ACgkQbDjKyiDZ
s5J/WBAAvfeB7/uh5b+Ot9g6bSBwRVMTwcpwPyI/KTWilvbJi50U46UR3Bho54Gm
0NidkKDMkt+kosmQTYt4dRkp6PdmHFTDOfB1BX0OAhGjM9H6I4/CETGsLcRR25ze
aIjBxoodixalOAXvc/9sw6BiXeFpDHnEi60WDFiGqTmpTEY60eyTreP+wx0VO/lW
n6VxMXN9JsG6lKQ8CXwjmEcq7KCs2e8bPsisCPona6UamWPfrTHdM8Y5TC7XBUbl
cDXlOikhHpoNceHjs5tUprNxn6YEsDgDtw0NOvdO0D+IeHaKvO40rRDiBjLWWr59
hhZ9yaQIxjSrQq157pOO+hHZSodSZqzaUmU/cbcy3laMvdCucFF9AW5/nq0r/LEY
NV25ZKr6OeVy9nS5Ser6pb2n9Vxau4OLK7D1RWZeO4Cgccrw0tY0283aI1TRyH8w
j99lmVGjpH030pljODMDdnvgUqKeDILqNnl74NN33oUCNLYCjR/M79nInOd2ZQba
vcpmpRVk9Wqh3CHDZZcSuvhdLOnZDOgnBZQHv/kWEUU3r+BYiMe15N5WQDTh/Kwd
9b9gWnjOhgSuSnWS0uRAgZUL3noHNeWV9eV1YCCR9+/BQvPyNcPAimlyABsJG55K
V2ZAqVAXM2Wky27fXSzww5KJ5GYX6krxpV0Ctn//e0Xae13Z2N8=
=xJKZ
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--

