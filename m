Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78CAC33CA9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 01:48:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A246D2080D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 01:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="EYFpc68h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A246D2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irBJR-0003sR-Ky
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 20:48:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1irBIM-00031e-TE
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 20:47:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1irBIL-0001bL-FB
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 20:47:02 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:47473)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1irBIK-0001WU-RT; Mon, 13 Jan 2020 20:47:01 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47xYGl6KZ9z9sPn; Tue, 14 Jan 2020 12:46:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578966415;
 bh=bZ3ZjexFCfrKEORUsWBWtLyhJaXY3XwTe4TiiLXRj6Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EYFpc68hjpol0bL9GMksyjXY+HR5s4VhA3NwqEVOAICnZ8wb++lT/zPkLcD0pgrOQ
 qOkgDANTXmtR7dBW3KTh1ySrXen0VG/LGE4y8R0baLGbYgWCpjKbAgfMit9L9FTd0l
 ILZJNCHDw+jAX15c6tFYVpDyMvd+KoFe2lNIHKbE=
Date: Tue, 14 Jan 2020 10:48:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrea Bolognani <abologna@redhat.com>
Subject: Re: [RFC PATCH qemu] spapr: Kill SLOF
Message-ID: <20200114004800.GI19995@umbus>
References: <20200103074404.30853-1-aik@ozlabs.ru>
 <3cf3e733-199a-61ba-7aaa-05e9546cd4d9@ozlabs.ru>
 <dd98618f-01c6-850f-ac00-454a2f798508@gmail.com>
 <81f1f752-3ada-2c8d-38b7-1344c7633e14@ozlabs.ru>
 <e3299f0688127627de96eb2db1f127bf94df9085.camel@redhat.com>
 <5ed92e2a-4b9f-8092-cb67-8d94c3891e20@ozlabs.ru>
 <1a8f9121a3cb85d415ff1c67a5379a717ad2b8e0.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZPDwMsyfds7q4mrK"
Content-Disposition: inline
In-Reply-To: <1a8f9121a3cb85d415ff1c67a5379a717ad2b8e0.camel@redhat.com>
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
Cc: Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Fabiano Rosas <farosas@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@ozlabs.org>, Sam Bobroff <sbobroff@linux.ibm.com>,
 qemu-ppc@nongnu.org,
 Leonardo Augusto =?iso-8859-1?Q?Guimar=E3es?= Garcia <lagarcia@br.ibm.com>,
 Leonardo Bras <leonardo@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ZPDwMsyfds7q4mrK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2020 at 10:13:27AM +0100, Andrea Bolognani wrote:
> On Wed, 2020-01-08 at 13:34 +1100, Alexey Kardashevskiy wrote:
> > On 07/01/2020 20:39, Andrea Bolognani wrote:
> > > On Tue, 2020-01-07 at 12:55 +1100, Alexey Kardashevskiy wrote:
> > > > Petitboot kernel+initramdisk almost replaces SLOF + GRUB.
> > >=20
> > > Is this necessarily a good thing?
> >=20
> > The bare metal host and the powernv machine in QEMU do not use grub,
> > they use petitboot which parses all grub configs and supports quite a l=
ot.
>=20
> How well does the distro integration work? Eg. if I change something
> in /etc/default/grub and then run grub2-mkconfig, can I expect my
> changes to be picked up?

Yes, in the most trivial possible way.  AIUI, grub needs to process
some of the config file information into a form that the early boot
stages can read before they can read a filesystem.  Petitboot has a
full Linux kernel beneath it so it parses everything from the grub
file at boot time, so if it's in the file it will pick it up.

> In which scenarios will that *not* work?

If you use some grub feature that petitboot doesn't understand /
support.  I don't know off hand of such a feature, but there might be
some.

> > Using Linux for a boot loader is not powerpc-only thing really, some
> > folks do this too (forgot who, just heard this at the KVM forum).
>=20
> While other options are available and some architectures use
> something else entirely, GRUB is the de-facto standard across most
> of the non-obscure architectures.
>=20
> I guess the question is whether it's more important to be consistent
> within the architecture or across them. I think the latter might be
> preferable, especially when we consider what I think is the most
> common scenario, that is, someone who's used to having GRUB on their
> x86 machine running a ppc64 guest on the cloud. The more skills they
> can automatically transfer over, the better.

Note that killing SLOF isn't necessarily incompatible with running
(true) grub.  It is harder though, because we'd have to fake
significantly more of the OF client interface in qemu to let grub load
the kernel.

> > > Personally I quite like the fact
> > > that I can use the same bootloader across x86, ppc64 and aarch64.
> >=20
> > I am not suggesting removing SLOF soon
>=20
> Perhaps the patch subject shouldn't be "kill SLOF" then? ;)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZPDwMsyfds7q4mrK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4dD74ACgkQbDjKyiDZ
s5JuoBAAmxIfx3Sz1RRnijxtgKfHrNjnX6ieOO7gbmSkp2r9hJ3AR7Qo+uHMtoEs
sH1oMJxhBXJVn7hiMPJZWu4lsY8SJdi6rq/Mrazf54rB0YzYDr7a9RJSBvNKbIcb
ipmXqKQYJWnIAbE5A1izslFoNCwmyDqS6fHDKHLBQKoKmp9RkWz9H8dMxDZPMhK8
wSBNCggUe7h4rzH+MbW+oBwW92errdJfqixB6fjcwAO7/7EQzW0AI6wmINmg2K5D
uzTGAqgiW3IZXs4nhJT6Imd6L2k7wRHRFqyNL5YWISs7eOzuM8Xzrs+N3k7N7T76
AbuHrdmEQY1MJ5SlC+L0uthLXIrlD6hVS+8+WONYF4z/fPW5amUCCIX7GZaiTKnf
67aej58PPZXkdVblGqmxBF1futyBScttv4HI5QANAOI/sZh9WcNYRtcMR1wx7I2N
enpx5gGCu9c9RZtKjWPdfSPT3nhvJqwIA9lvORVyXGLUsMsmA1oq1iXsbc+uKFWu
ecQfrWjWf31ksTpXi1Qkj1PFDOkKOCLaTlS4UOg10oE+cAI2srpwXEuIerKSBrde
JDn5viHX+geePsIYILySc1Yi40yXXFMGDv8WyOiz4c0SDBkkWcmQAxze5AY0UObv
yNMeNl+bQUhgZjVHQOG5aYeR4jA/4QGAxGJgS2OT3LYpl8Moclw=
=Hc2w
-----END PGP SIGNATURE-----

--ZPDwMsyfds7q4mrK--

