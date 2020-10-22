Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AC9C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 04:18:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9839222E9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 04:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="pLJU7JZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9839222E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVS3o-0004m4-Oz
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 00:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kVS2v-0003DH-Gl; Thu, 22 Oct 2020 00:17:50 -0400
Received: from ozlabs.org ([203.11.71.1]:45599)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kVS2s-0000EX-9x; Thu, 22 Oct 2020 00:17:49 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CGvGP142rz9sTc; Thu, 22 Oct 2020 15:17:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1603340253;
 bh=fhySXl1U8HmOPDZAzv6+7BZizPjqUcEc0XL1pS5/XsU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pLJU7JZY9goUfGV2uvPFFjec3XxR5+aAMw2cBNfTainURHisKlHQaeHTXRqYoVudW
 +HYnCB/cWPAFhj8wZnN5SKd1HDvM0wOAL7x/WyUEwXNNbn+oENtYkniwmfU/gkthwN
 PfqgnrINirR10NhxPlbV7bz3wGnlfJ8dhwf8IhNI=
Date: Thu, 22 Oct 2020 15:02:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2 0/5] spapr: Fix and cleanups for sPAPR CPU core
Message-ID: <20201022040236.GC1821515@yekko.fritz.box>
References: <160279669833.1808373.9524145092720289601.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DSayHWYpDlRfCAAQ"
Content-Disposition: inline
In-Reply-To: <160279669833.1808373.9524145092720289601.stgit@bahia.lan>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 00:17:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2020 at 11:18:18PM +0200, Greg Kurz wrote:
> While reading the code _again_ I spotted a memory leak and I realized
> that the realize/unrealize paths are uselessly complex and not really
> symmetrical.
>=20
> This series fixes the leak and re-shuffles the code to make it cleaner.
>=20
> Tested with 'make check', travis-ci and manual hotplug/unplug of CPU
> cores. Also tested error paths by simulating failures when creating
> interrupt presenters or when setting the vCPU id.
>=20
> v2: - enforce symmetry between realize and unrealize
>     - unrealize vCPUs with qdev_unrealize()
>     - one loop to create/realize and to unrealize/delete vCPUs

Applied to ppc-for-5.2.

>=20
> ---
>=20
> Greg Kurz (5):
>       spapr: Fix leak of CPU machine specific data
>       spapr: Unrealize vCPUs with qdev_unrealize()
>       spapr: Drop spapr_delete_vcpu() unused argument
>       spapr: Make spapr_cpu_core_unrealize() idempotent
>       spapr: Simplify spapr_cpu_core_realize() and spapr_cpu_core_unreali=
ze()
>=20
>=20
>  accel/tcg/user-exec-stub.c      |    4 ++
>  hw/ppc/spapr_cpu_core.c         |   69 ++++++++++++++++++---------------=
------
>  target/ppc/translate_init.c.inc |    2 +
>  3 files changed, 37 insertions(+), 38 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+RBFwACgkQbDjKyiDZ
s5JWihAAtlZ1MFw1Bv7jwyuMj2IEjdYG/8VeMZaglUyNVLU55mqgq4gelRCk+AmV
g5Vvgk7k2GJzMuG9WIsAxMje2N7Sb8d91iMj5sZcMIgV5SKNg/bv1lRamY7zEUmX
x+GWQmw+gohtYrP/Y2oHql0Y+etGSIRNjTXRgJpruzBAws20cZF0qgy233EDCMn7
uNhiZGEycv6fT6RfKOpuoppkhEDsaDisso3SQOeUtQe5ZYGMYBNXPZe4CRMjqtYg
kY/Wjr3oXG/43SfKu4DBI+2dLCJGuF8Eqk2jtVAF7H4FrUJu8+8j0P/HR+JA5XM5
BcHrwvi+Og53q3y97+jir8xiBy6xzMr4n8vgqtRAa8Tu/Oe8nZY4O+shOHtH2q7z
FWdbojZ+GAaiErxg7wJ3nnz3pMqL99dSQX5mOTn5ML1zb3+pCl0BFgh5Leb+NsB9
vxrhuQlWDZiosy+9HwUwa+OEmStMnTHxHBMeo07iunfYsjcRMgFdvwdASVXt07KW
sdyPX+EBTSXcXVo+m8A2xhUQrLyLdp12q+B9A54AJmy2eSQX5+JxdQLkxs8lDDJG
9ADBHMEfIC736UnIUrLNo4V0NSqoyEHiDLHRZsJ7g/iHQZJMV9R/Fn6NzIFFegB/
XmmF7eCv+8Y4dFi6HtVkPl0Dh/ywPv/XZr+8J1qv60xPjN9hbak=
=mqAe
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--

