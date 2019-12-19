Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED903C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 05:18:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B30342146E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 05:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="c71gdxJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30342146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihoD0-0002zs-Pk
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 00:18:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ihoCM-0002JQ-3L
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 00:18:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ihoCK-0005QU-VV
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 00:18:06 -0500
Received: from ozlabs.org ([203.11.71.1]:51909)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ihoCK-0005CJ-Hd; Thu, 19 Dec 2019 00:18:04 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47dgBJ60mcz9sPn; Thu, 19 Dec 2019 16:17:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576732680;
 bh=NQiSztyPAbPgulkIn1a2Wkf8nWAKJwxdUxEUoj2JqM0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=c71gdxJIO2ZIkVGT+4TFUuYhTmRxhjZsdaHAEewpfjjnxlEmqVN0KfS1SwpxkEVkK
 +p+DL8fiL5S/WU2amHM3DUyFMne/Y6L2NMRqFz6dZuDhncpslRRSVlrkvVIQpF9naN
 VdFv4zhln0IOzo65jHH1GXEZ3Bs9NqPiT9TOlcVA=
Date: Thu, 19 Dec 2019 16:15:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Bharata B Rao <bharata@linux.ibm.com>
Subject: Re: [PATCH v4 ppc-for-5.0 0/2] ppc/spapr: Support reboot of secure
 pseries guest
Message-ID: <20191219051557.GI2321@umbus.fritz.box>
References: <20191219031445.8949-1-bharata@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="X0cz4bGbQuRbxrVl"
Content-Disposition: inline
In-Reply-To: <20191219031445.8949-1-bharata@linux.ibm.com>
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
Cc: paulus@ozlabs.org, linuxram@us.ibm.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--X0cz4bGbQuRbxrVl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 08:44:43AM +0530, Bharata B Rao wrote:
> This patchset adds KVM_PPC_SVM_OFF ioctl which is required to support
> reset of secure guest. This includes linux-headers update so that we get
> the newly introduced ioctl.
>=20
> v3:
> https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg03685.html

Applied to ppc-for-5.0, thanks.

>=20
> Changes in v4:
> -------------
> - s/error_setg/error_setg_errno (Greg Kurz)
>=20
> Bharata B Rao (2):
>   linux-headers: Update
>   ppc/spapr: Support reboot of secure pseries guest
>=20
>  hw/ppc/spapr.c                                |  1 +
>  include/standard-headers/asm-x86/bootparam.h  |  7 +-
>  .../infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h | 15 +++-
>  include/standard-headers/drm/drm_fourcc.h     | 28 ++++++-
>  .../linux/input-event-codes.h                 | 77 +++++++++++++++++++
>  include/standard-headers/linux/pci_regs.h     |  3 +
>  .../standard-headers/rdma/vmw_pvrdma-abi.h    |  5 ++
>  linux-headers/linux/kvm.h                     |  1 +
>  target/ppc/kvm.c                              | 15 ++++
>  target/ppc/kvm_ppc.h                          |  6 ++
>  10 files changed, 154 insertions(+), 4 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--X0cz4bGbQuRbxrVl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl37B40ACgkQbDjKyiDZ
s5KWnA//edH8hqUlSLT9TaATQlqSx7OBOookvCHD4e7FPem1CrDmTACq74MxGG2c
+UBUrD+N0WXEz65sUNp8evCv+k1yTD30TlWY+HtNlsieau4whesQpZwhiMywNIbv
WW93hRnj+53GW0ldm673h8TmtM0EBAyh7KZY6PRQXmFBfwIbd9Bt/T3o6KPk6aMR
Ky51NhZyvqwPMX1WIUjqgcYDOnyZDEvUHbEA8IZQe4wpr5c871qR+LZ7Yn8vna+3
0SFIw2NLkAC7PPqWItrUOlx6+Dpaw0pJm3FAMKR/M2fY3VNAsNG5wC8PKtZVtZus
aIINmGCZxAvpW5Dvhhv7/9JlQ1bBvHdAJETFX9fquLhIbaEENb+DOCWHB+WGqGHb
vVL+f94h5Z41LniTWBtGn6NlD7TD4tP8MVZdryEucCqTj+2xD2siAzZ9OM+OxNno
lA+JRg3gZupj78mbVtm+eb8v2m2FET4wc/wSgjoKy/Nvkuj4r2fWeeXZSISXtao3
MaGVkHsXIaD1Wj+GxZgF0s+xSNhGfNbFp07I4d7urS5pZ/M9iQRqJSqt1uUIaq1b
sqNekhZlFNggcSmcYaG5KxdJ7EeYiqmMr2RzzAZ7+NVsYLuFODHojT3CfWZwPa50
qisQtVzHNkedD7x6ViHd1t2qDNg9JtSBJlhAK68+fTR80Pg7zH0=
=AlLs
-----END PGP SIGNATURE-----

--X0cz4bGbQuRbxrVl--

