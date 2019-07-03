Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD91AC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 13:26:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B9EF2187F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 13:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Ru+rKQHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9EF2187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hifHi-0007tr-LD
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 09:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39638)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hifGP-0006XE-2p
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 09:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hifGN-0002iZ-55
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 09:25:32 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:35087 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1hifGL-0002cT-5n
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 09:25:31 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45f20f0Fh8z9sR1; Wed,  3 Jul 2019 23:25:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562160322;
 bh=T0q8ZMR7HLDPkWR1m5KyuqbBxuDSd6sto9DXGbVjUOQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ru+rKQHq8a9Oaop95+hu+qAQu7dPTl4AuSGE/ivrH3r5AUrc0ww81Q3sFHWZMn8DV
 9MCqIbbnp4QOBP3B+vt+Mzm1hfZ40rrQsgp4gq+QqIsqhp7Bi6Sx2dWFIx0TahSyFM
 wGuNhJuF7v2sgpzzrAzJqG5mLzTyWky8jgeDM+bE=
Date: Wed, 3 Jul 2019 16:15:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190703061505.GL9442@umbus.fritz.box>
References: <878stfzozv.fsf@dusky.pond.sub.org>
 <1c014d01-edef-d418-75a4-96f0811717e8@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZrCu0B0FMx3UnjE2"
Content-Disposition: inline
In-Reply-To: <1c014d01-edef-d418-75a4-96f0811717e8@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] What's IOMMUMemoryRegion's super?
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
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ZrCu0B0FMx3UnjE2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2019 at 07:37:46AM +0200, Paolo Bonzini wrote:
> On 03/07/19 07:05, Markus Armbruster wrote:
> >     static const TypeInfo iommu_memory_region_info =3D {
> >         .parent             =3D TYPE_MEMORY_REGION,
> >         .name               =3D TYPE_IOMMU_MEMORY_REGION,
> >         .class_size         =3D sizeof(IOMMUMemoryRegionClass),
> >         .instance_size      =3D sizeof(IOMMUMemoryRegion),
> >         .instance_init      =3D iommu_memory_region_initfn,
> >         .abstract           =3D true,
> >     };
> >=20
> >     typedef struct IOMMUMemoryRegionClass {
> >         /* private */
> > --->    struct DeviceClass parent_class;
> >         [...]
> >     };
> >=20
> >     struct IOMMUMemoryRegion {
> >         MemoryRegion parent_obj;
> >         [...]
> >     };
> >=20
> > The parent is TYPE_MEMORY_REGION, and the instance struct's first membe=
r is
> > TYPE_MEMORY_REGION's instance struct as I expect, but the class struct's
> > first member is something else entirely.
>=20
> Cut-and-paste error.  MemoryRegion adds no methods so that could be
> either ObjectClass or better
>=20
>     typedef struct MemoryRegionClass {
>         /* private */
>         ObjectClass parent_class;
>     } ObjectClass;

I concur.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZrCu0B0FMx3UnjE2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0cR+kACgkQbDjKyiDZ
s5Jj+BAAjcIeH94jP7+PIdVX4GHm4yxSsLKOYRAnXXFJL8bf1UWQ+WVSymPx9Vjy
ENCklkJL8ZBvROJoMXE5MGGFg4cRwfMQ41D5nF4BccCbJnSjAUy8UcYwGRIxysBQ
YKbn2rjuuZoOJ06XUT2tQA/nQ5X5v6DPxDsHE0od4ciNhO1U5DYfatyI+35JY1Sx
TXqih16pNMb1+5nQ/+tasEYUrU3Y4YvIdbX92rczjpwuJUXlFMH9hHYubY7DTz0E
1bj66cf8XIyn1+ma3f9WcDijrvfwjeVTURttfpznGpGfmtBQ15gPZcTCa0sJCUbD
NAAt1tC9or30ODqK++fs7pC6igAUg+2eoDUyRnVZAYu/u936TMe+F1hc1rtlJtEs
z6vBN2E5Vz6neQ2E4yPAlkVXvoINhicXNeScv6HTiHgJUFIR69JSJgTbV+pfSHDl
xhftKM7Sc8gPSJl1b3iip0TRD49PGxlPNYZDjAb7E3WA4SpkhkVwM/MDufwk2iLk
kg2JpO6crslEp0y9chXmOueQqMCWs29JNQ9Q6YuHt0Xy7T8dwIm4ZnWj59LPid5A
yVUyL5p8MmLAVG4G3ap9XBNNornl4pXKvk6eJhHRBorr2X5GVcZJTeuAdJvBEYkE
cagn+Dh/UraWgIiGQGOVUPsCS2Sem+awh0xOJr5RG1drynUd0tM=
=ARH/
-----END PGP SIGNATURE-----

--ZrCu0B0FMx3UnjE2--

