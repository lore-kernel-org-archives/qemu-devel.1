Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AF1C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 06:01:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52E832173E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 06:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="LuquJNP5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E832173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnzTn-0000n1-K6
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 02:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41760)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hnzSv-0006oz-VB
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 02:00:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hnzSu-0004Gm-RQ
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 02:00:29 -0400
Received: from ozlabs.org ([203.11.71.1]:32799)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hnzSu-0004Dj-G1; Thu, 18 Jul 2019 02:00:28 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45q3QB6qvYz9sNf; Thu, 18 Jul 2019 16:00:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563429618;
 bh=JacP9k4zZK8Q7DRUK2mu0xrWPgKZ4lhc1ATwQnk37kw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LuquJNP5wWWBLhJ/WkmAE1m6lCQx2ndStGcXJW43dEKxtkVDpJDpcSf8GiDLJQYF2
 jo6DXSiMgx0+/AAEBEaN2S0Zem8oEqiTUDtIUo1/OIWDWjonNL8G1Tdu9yjqIBN94b
 bPBmNXN/EgxLCn+2sq2yxCmkYGweQEp6aMnvk6S0=
Date: Thu, 18 Jul 2019 14:21:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Message-ID: <20190718042143.GH8468@umbus.fritz.box>
References: <156335150620.82682.9535735857478533420.stgit@lep8c.aus.stglabs.ibm.com>
 <156335160761.82682.11912058325777251614.stgit@lep8c.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uJrvpPjGB3z5kYrA"
Content-Disposition: inline
In-Reply-To: <156335160761.82682.11912058325777251614.stgit@lep8c.aus.stglabs.ibm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v2 3/4] ppc: fix leak in
 h_client_architecture_support
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


--uJrvpPjGB3z5kYrA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2019 at 03:20:31AM -0500, Shivaprasad G Bhat wrote:
> Free all SpaprOptionVector local pointers after use.
>=20
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>

Applied to ppc-for-4.2, thanks.

> ---
>  hw/ppc/spapr_hcall.c |    2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 6808d4cda8..71cfe7c41d 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1612,6 +1612,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
>      ov5_updates =3D spapr_ovec_new();
>      spapr->cas_reboot =3D spapr_ovec_diff(ov5_updates,
>                                          ov5_cas_old, spapr->ov5_cas);
> +    spapr_ovec_cleanup(ov5_cas_old);
>      /* Now that processing is finished, set the radix/hash bit for the
>       * guest if it requested a valid mode; otherwise terminate the boot.=
 */
>      if (guest_radix) {
> @@ -1629,6 +1630,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
>      }
>      spapr->cas_legacy_guest_workaround =3D !spapr_ovec_test(ov1_guest,
>                                                            OV1_PPC_3_00);
> +    spapr_ovec_cleanup(ov1_guest);
>      if (!spapr->cas_reboot) {
>          /* If spapr_machine_reset() did not set up a HPT but one is nece=
ssary
>           * (because the guest isn't going to use radix) then set it up h=
ere. */
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uJrvpPjGB3z5kYrA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0v89cACgkQbDjKyiDZ
s5LazA/9E/l2jxNzlvSBQt1U1bHQiyc4AH9y/vQfxzo7TZ4qiCaK65AnZxZpooOT
sMP+9v3F93QHhPCTuGxkuyZIHucV1Ucux4K7h4WRUUnICp2F46AJvwCVxQv9YYbK
tOYsWFkjVG3rnwsNlskKgwTECvoABoJCjgcV9dyZ6YCNNJG1sH6cPIG6ZcazO5XT
9zRs83lLq/OatbFoyFx2JjHhpHmH2scE9bA/XgA4eACBPJ59vY6mN4V/YY3M8bRQ
dzj1Noc13Sk+D2toKLy8mV/2HFML3XJPSndqsHULRqLh72jymoLzDk5Y93fRRfj+
DCrCERC6lX+jaiuAsFWDXGUkb06A5RY10VnL7n1Xi7/NgOpAnyOcAZu4RKNHr+nR
5GNbRVwlkAw//s0Aw+FQ2/FuYX+bHvUhbe4sCJeXiP30f64DBKcRVD0QzranILTW
y1yELTnYO3VeKhpw+kSfpAT4hqOpww9yg8Z+kddLBig3Vz5ORBfBw+wAeYOS45Vn
Y0zKWYnIK4rkr44cqBKFBeFg9FRizYnSSAWdz9D6u71aaZOq4kno2TMH2EBmemuI
pDdQbwnAaaIIymARMSCa53vTKMsOsNjJbmD8mmRI9ZOHmgLJ8oH3k3uQ+Q7B+mUT
ck9o35dIKub/VSOffen06whd2hWK2RETK7eyNGJIJwH7hb4v23M=
=TMdW
-----END PGP SIGNATURE-----

--uJrvpPjGB3z5kYrA--

