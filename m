Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D728C34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 23:23:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3FA522B48
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 23:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="TBraVIiw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3FA522B48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4CDD-0007JY-44
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 18:23:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j4CB8-0004ms-A1
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 18:21:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j4CB6-0006t7-ST
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 18:21:22 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:50329)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j4CB6-0006lh-Gd; Tue, 18 Feb 2020 18:21:20 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48McL36wJ6z9sRY; Wed, 19 Feb 2020 10:21:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582068075;
 bh=PlBsuRlPJXb+VZKiGh+ENvid6UuF8n/xBEGC9RcpX3E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TBraVIiwgnLbeoHs3ofOwdKkJpde+jPpOJzBfNrsGAxk753zPqITjxDH23i0UrJia
 JknK++v8bYSHbDlpruZZqaqlyJ0Pa9lKaP9b9JOKTMOrl2r8Bl2qSYrZ26+IHdabqt
 8/ajG8iRI+Lm7mHeuheBKHxEZ+hC0/Bqd64X0yN8=
Date: Wed, 19 Feb 2020 10:09:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PULL SUBSYSTEM qemu-pseries] pseries: Update SLOF firmware image
Message-ID: <20200218230919.GD1764@umbus.fritz.box>
References: <20200217021217.95766-1-aik@ozlabs.ru>
 <60c5712e-beb7-e536-1252-642dcf88beec@redhat.com>
 <0beab4e0-da3d-48fb-062a-de7a6c244c3f@redhat.com>
 <20200217224647.GA26464@umbus.fritz.box>
 <38cfa5c3-2563-7aaa-b1db-c7dd2f053d3c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Km1U/tdNT/EmXiR1"
Content-Disposition: inline
In-Reply-To: <38cfa5c3-2563-7aaa-b1db-c7dd2f053d3c@redhat.com>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Km1U/tdNT/EmXiR1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2020 at 06:48:43AM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 2/17/20 11:46 PM, David Gibson wrote:
> > On Mon, Feb 17, 2020 at 11:24:11AM +0100, Philippe Mathieu-Daud=E9 wrot=
e:
> > > On 2/17/20 10:26 AM, Philippe Mathieu-Daud=E9 wrote:
> > > > Hi Alexey,
> > > >=20
> > > > On 2/17/20 3:12 AM, Alexey Kardashevskiy wrote:
> > > > > The following changes since commit
> > > > > 05943fb4ca41f626078014c0327781815c6584c5:
> > > > >=20
> > > > >  =A0=A0 ppc: free 'fdt' after reset the machine (2020-02-17 11:27=
:23 +1100)
> > > > >=20
> > > > > are available in the Git repository at:
> > > > >=20
> > > > >  =A0=A0 git@github.com:aik/qemu.git tags/qemu-slof-20200217
> > > > >=20
> > > > > for you to fetch changes up to ea9a03e5aa023c5391bab5259898475d02=
98aac2:
> > > > >=20
> > > > >  =A0=A0 pseries: Update SLOF firmware image (2020-02-17 13:08:59 =
+1100)
> > > > >=20
> > > > > ----------------------------------------------------------------
> > > > > Alexey Kardashevskiy (1):
> > > > >  =A0=A0=A0=A0=A0=A0 pseries: Update SLOF firmware image
> > > > >=20
> > > > >  =A0 pc-bios/README=A0=A0 |=A0=A0 2 +-
> > > > >  =A0 pc-bios/slof.bin | Bin 931032 -> 968560 bytes
> > > > >  =A0 roms/SLOF=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 2 +-
> > > > >  =A0 3 files changed, 2 insertions(+), 2 deletions(-)
> > > >=20
> > > > I only received the cover, not the patch, have you posted it?
> > >=20
> > > OK I see the SLOF binary is almost 1MB. Maybe this got blocked by spam
> > > filter. FYI you can use 'git-format-patch --no-binary' to emit the pa=
tch
> > > with the commit description but without the content.
> >=20
> > Generally Alexey sends SLOF updates to me just as pull requests
> > without patches in full, because a huge slab of base64 encoded
> > firmware isn't particularly illuminating.
>=20
> I understand, this is why I later suggested Alexey to use 'git-format-pat=
ch
> --no-binary', because Laszlo uses it for EDK2 submodule, this allow to
> quickly review the change on the list (without posting the base64), see:

Hm.  What's to review?  The only change apart from the binary blob and
the submodule tag is the version numbers in pc-bios/README.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Km1U/tdNT/EmXiR1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5Mbp8ACgkQbDjKyiDZ
s5IQFBAAo71MDokHGSEXfs3WsberDJJyNCDPh/OeDohRBiN0sNgK0QW3sQIXw/Pe
hj9kumiwxpVpIFtGIVQElh+Pvdrkn6BkFizApXKdTL5Prup0+8l2Jki/p3OgdY+3
HnsX8iINnD19QSCbrVDjfbgjmTit15QvTNToW6Tc1FNKbEe7MdRiXnLViszaOhOp
uIFK6IqfRFKLKFecGSzTJ4ywIN6adA4LWIzp4sM0QBVndGQyKyqo1A8UJWXOSM77
GvHpS2VL5odlH5iRf3rqTVH1t9zmaiVh4RGiOdDyC3m14mZ/0QP+um4ihcaQG5jD
57LuG0Q++8welFKnyyQicSKJtNGVaQgCo7gUfzXbvBA4DMx5bEv2t/c4bmrQ8qPT
kbyKn353p/TkEYMdHTjVLhAkRmpNUFi0ylQnqp50lK1yBj5gDAgC4qLGOgw8y9XS
u5YWjvVgRrku8HexeINq7EAzPXF1VXDOLPXpj6N5Uc+MoVfWz+PkPvigkRCInEF3
Sx8nCk33OwER0bzX1C3J2hzRHqtAji9P+4k9uTILWo3uRFzVZjGQz19gotDQulOX
PeLhO+SgUOp5v+tvDtUv1PXwQ1uHUqvczqNMnZTv1ex8ke4a39zM5YtBtcsa4C1c
e0tGKn6F+uL6yU8Fsb+9i6DK3kqefhlZo6rEpQdo+Pw7WS+Sk9o=
=sPnh
-----END PGP SIGNATURE-----

--Km1U/tdNT/EmXiR1--

