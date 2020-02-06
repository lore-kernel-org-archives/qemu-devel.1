Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF421C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 04:54:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97C7021775
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 04:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Imi6bZmp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C7021775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izZAy-0007Ap-OY
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 23:54:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1izZAO-0006mH-96
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 23:53:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1izZAM-0004Xu-KE
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 23:53:27 -0500
Received: from ozlabs.org ([203.11.71.1]:39497)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1izZAL-0004Ii-GY
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 23:53:26 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48CmKD3nL3z9sP7; Thu,  6 Feb 2020 15:53:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580964800;
 bh=m4y17p3+xgYBQk6ljX39nwMiq9mz8i6qXENxtrea0fg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Imi6bZmp9dlkyVIILNe6XN1wtVM5FwZVjijLe9rZTXyoQW1FxtaoyBXIPA8uZp87b
 9DI2nz0bwCO90+c+yib1AcwPZwI6tqALirWldxCU5529xyg8KU7kf3/yY4OejAGnJy
 EJNymDriM8fKhHkzIIiWKS9I2t6AIREPM3aw4GDk=
Date: Thu, 6 Feb 2020 15:47:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Cornelia Huck <conny@cornelia-huck.de>
Subject: Re: VW ELF loader
Message-ID: <20200206044757.GM60221@umbus.fritz.box>
References: <20200203012842.GD52446@umbus.fritz.box>
 <ec81cca1-d5fb-3f1e-b433-3328d81a117e@redhat.com>
 <de7e4d34-eb63-904c-3475-7feee154c72c@ozlabs.ru>
 <8420784f-b4c7-9864-8534-b94dbc5f74ff@redhat.com>
 <d63ba962-ffbb-9f27-34fb-657188e90194@ozlabs.ru>
 <CABgObfYwtrh_uy8zFmg2qDjK6iynniN6=jJ9_MKfNxXUaOkPKw@mail.gmail.com>
 <71d1cc16-f07d-481d-096b-17ee326157bb@ozlabs.ru>
 <CABgObfa4tUVBbpBtoY3JFSF8-0mRVxgGbzQokc+JrJGPagwPaQ@mail.gmail.com>
 <20200205060634.GI60221@umbus.fritz.box>
 <20200205102830.15cb9706.conny@cornelia-huck.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="eWmFpGZayiNrn4FL"
Content-Disposition: inline
In-Reply-To: <20200205102830.15cb9706.conny@cornelia-huck.de>
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
Cc: Thomas Huth <thuth@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 qemu-devel <qemu-devel@nongnu.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--eWmFpGZayiNrn4FL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 05, 2020 at 10:28:30AM +0100, Cornelia Huck wrote:
> On Wed, 5 Feb 2020 17:06:34 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Tue, Feb 04, 2020 at 12:26:32AM +0100, Paolo Bonzini wrote:
>=20
> > > You can generalize and reuse the s390 code. All you have to write is =
the
> > > PCI scan and virtio-pci setup. =20
> >=20
> > If we assume virtio only.  In any case it sounds like the s390 code is
> > actually based on the SLOF code anyway.
>=20
> Only the netboot part. Device discovery/setup etc. had been written
> from scratch, but I'm not sure how much reusable infrastructure remains
> once you strip all the s390x-specific stuff.

The netboot's the bit we'd be interested in, anyway.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eWmFpGZayiNrn4FL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl47mn0ACgkQbDjKyiDZ
s5IzmxAA1jDGcUUzuV/M3HY8XIe6OTOnwjp/IaNA17+MNHO80QsbPmVhngTMN0z/
lFOsgmXe7cvdCvx5zC/+dvcKYZgHv4uC12kuFvNJe4yCUt+JqjjuVppb5LuxN2sV
f4Hi8SEnr4qeYDtTQepqz/d/MlppzjU78Tf2S5NYx3LTn40Bu/tYT4milQo6tR1g
WuOqeOAMuR+wNX6WBqNGCzEXb9Uj9+M/a13OtS067ZGC2RZuvuGcjgqTviAsJnT8
KnLZj6YW1rrjllGINvTetTn8hj4Toxkgrvf/kX4g7+oIxIpUPvED2FZADikkNVGv
BH4UerRUAcHPdQOjuD6BoM3ur2SsUaKGLDK077XNZM4j0zlWmMJP5xuOHL4ikMwM
xJeIK4ssn+NwkZVGCnvMJBLVrN9QrzHJs6eCo1p150KTvrk1eH3fYGPeRCjhHdoN
cJ9VWkWN7MIIjrIOBZfu2RTOuub06FqjhP5bg602vcrCQW/iCzKYARaG4jAK0tp9
+jovIlgb8fmz7XEjRJIiDnN3SMiQKpcU8Fi0qowqTlBLazFFXZ8gRsXXSWx65hU5
NxNc+WhXpyGEtCIo3MPZMDG6xzbhZ6CsF7AAKEffdllZBYJSYbc9xzwp6zgE2UYl
FdSC0INhYyhwbmtQ/+/1tWcZMGbq5sLT7dPzlj4S9gF1cxFrlIw=
=0xJy
-----END PGP SIGNATURE-----

--eWmFpGZayiNrn4FL--

