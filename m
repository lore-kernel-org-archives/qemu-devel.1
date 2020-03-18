Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC40C5ACD7
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 06:47:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C82520724
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 06:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Yo0Ev3R0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C82520724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jESUG-0007Jj-N3
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 02:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36750)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jESTF-0006pR-Gv
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 02:46:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jESTE-00071c-3P
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 02:46:29 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35633 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jESTD-0006GB-3T; Wed, 18 Mar 2020 02:46:28 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48j0tc3h5wz9sPk; Wed, 18 Mar 2020 17:46:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584513976;
 bh=vWp+EtJMhTVOzgQShgzk7GeNE5zG/RZ2mTWG9WBuVaI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Yo0Ev3R0oq1pkKw5RNbTrJu82xu9HHHhnpcrr1Y2ktX+tiTUpbvMc5YbriDriii3O
 qKvxHcvz2aOww4iJaYVMiugQCRE6VyO8grodoo6OaJ/n1p/yM0hHFc1pPLViNmwucD
 n+0Gmgftmafz7+Gm9P0Qmq2XIGNKvenA9gV++lL8=
Date: Wed, 18 Mar 2020 16:46:54 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PULL 00/45] ppc-for-5.0 queue 20200317
Message-ID: <20200318054654.GA628315@umbus.fritz.box>
References: <20200317100423.622643-1-david@gibson.dropbear.id.au>
 <bc2dc429-0c54-2a36-b901-97b14d4c9ce7@redhat.com>
 <20200317223305.GN20264@umbus.fritz.box>
 <eb78a310-fa30-cf50-7fe0-c2f7b7d63d9e@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <eb78a310-fa30-cf50-7fe0-c2f7b7d63d9e@ozlabs.ru>
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org, mdroth@linux.vnet.ibm.com,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2020 at 10:58:46AM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 18/03/2020 09:33, David Gibson wrote:
> > On Tue, Mar 17, 2020 at 11:30:31AM +0100, Paolo Bonzini wrote:
> >> On 17/03/20 11:03, David Gibson wrote:
> >>>       pseries: Update SLOF firmware image
> >>>       ppc/spapr: Move GPRs setup to one place
> >>>       pseries: Update SLOF firmware image
> >>>       spapr/rtas: Reserve space for RTAS blob and log
> >>>       pseries: Update SLOF firmware image
> >>
> >> Oh, no fake-OF patches?
> >=20
> > Apart from some prelims that make sense on their own, no.
> >=20
> > Not quite ready to go ahead with that, I'm afraid.
>=20
> You reviewed and found problems or you did not have time for that?
> Either is fine, just curious.

Mostly the second.  It's not just the time to actually review the
patches, either.  Paolo made some good points about what it's safe to
move into qemu proper.  That means I need to thoroughly rethink where
I really want to go with these SLOF removal ideas, and I haven't had
time to do that.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5xtcwACgkQbDjKyiDZ
s5I9jg/+LlyQfH/3M1RDDhmTSkoeKnhxchYPNTFKD2qJzczCOfKuq9Kol75FRvGl
A4u/1GKHqoVCleQhdwkrjL/mKewnYXVMkXQ5T9Jv5bgbdEBxVaQrFEVb+TU0GMpF
9Xosf1vJ7hKqgXPo1jR8lB+TKNVsPZLqPBt9jLu85LdAQDFIxyLLgnYhgGPD8Uv7
ZrhbQMUIyg9gpjE7LLeYqxV1ugsDNifUISvIe/knGMuweSKgmQX3furW+0znLqHk
0njb0oeg15u0rFOjcya1sZ2YCuAcuFhZlp5ONaS8C7AATXL0ANNcQmTZX7MnpPEs
tnuhrD0jOpNa0f84R4O2m8TYbNVjNqokFX57CND25xX2HL8a8qS2JKrYjRM2fOlh
TjHVdcNEHwjz3FtLfOXvG+yGxN800Gx2ELqEOnAie9056UmdjEhdI7NG6uvca3Km
+vyXgcVXG10YyHvF3SoCFHeMKiAchmoh3c2JWkaxD51WdPFyHP9SfqNsHZaBQ7p3
eOemvkIth3qLKyU+OCPBMhLfMTZwOX3dQKQ4PTH70OSr5SrVxtoS97yX2jVXw/Pe
CsrpzUZXDbXxl0fil8nncaH1w0OLCy4sF3b0BzdfAeHCqeFV0Hwglz7PrSRFKRmZ
16uiTa26R4SozipJB90pKZWnHJ6lKJRX1oO97Vzr3D0XzbIPN6g=
=IjTS
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--

