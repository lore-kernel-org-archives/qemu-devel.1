Received: from eggs.gnu.org ([209.51.188.92]:52865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h3NdQ-0008Fb-GU
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h3NdP-0008U7-Jc
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:18:40 -0400
References: <20190305234337.18353-1-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3a8ed35f-e50b-c411-2004-38917d2164c6@redhat.com>
Date: Mon, 11 Mar 2019 11:18:30 -0500
MIME-Version: 1.0
In-Reply-To: <20190305234337.18353-1-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IlhQCBgyQqq6WEAAyjFsu5y93UxfUIwyt"
Subject: Re: [Qemu-devel] [PATCH 0/5] block/qcow2-bitmap: Enable resize with
 persistent bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IlhQCBgyQqq6WEAAyjFsu5y93UxfUIwyt
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <3a8ed35f-e50b-c411-2004-38917d2164c6@redhat.com>
Subject: Re: [PATCH 0/5] block/qcow2-bitmap: Enable resize with persistent
 bitmaps
References: <20190305234337.18353-1-jsnow@redhat.com>
In-Reply-To: <20190305234337.18353-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/5/19 5:43 PM, John Snow wrote:
> This series aims to enable block resizes when persistent bitmaps are
> in use. The basic approach here is to recognize that we now load all
> persistent bitmaps in memory, and so we can rely on in-memory resizes
> and then flush the changed metadata back to disk.
>=20
> One part that is potentially now quite strange is that bitmap resizes
> may happen twice: once during the qcow2 resize event only if persistent=

> bitmaps are found, and then again as part of the generic resize callbac=
k
> event whether or not we have any persistent bitmaps.
>=20
> The second round is required if we are not using qcow2 or we have only
> transient bitmaps. The first round is required as we wish to flush the
> bitmaps back to disk atomically with the qcow2 resize to avoid violatin=
g
> our invariants for the bitmap metadata which is checked in many places.=

>=20
> This is harmless; hbitmap_truncate will recognize the second round as
> a no-op.

FWIW - I have not yet reviewed this series closely, but I think it would
be wise to get this initial cut in before softfreeze (we can make
further tweaks to fix bugs in assumptions during rc1 and rc2, but it's a
lot harder to add the series at all if it misses softfreeze).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--IlhQCBgyQqq6WEAAyjFsu5y93UxfUIwyt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyGilYACgkQp6FrSiUn
Q2qAEAf+InN1DB/AfA7EKySnIImIrrdG9kRECroZMddiAD74l8AVB3I8Y7Rph4+G
it40aPDXu/S+sAivKNcul3nG6VARENxb5NIeHd3usKKwEvjWObpW0w5kWKajK4uV
RyHSj8QEkwqPxuZJoYL+7pxrjZoUzEWsI0Fqj/B3YkWkUtiPVgWzCq5YQ+/Q4rr7
qoOnzo5CKIW5oa31rcAozD58kWkHgFX6MwpxHm3uQwaAI70JWL0r6LcCt5VBxIBG
aMhF+2sTv2Rw7aLLj3C8NVebDAx+DMxsoZs5LK++ZzJ5GsT9tzRspiTZpFPw/tk2
RteIVA5g30qiOIlRFKtDDCAKGN/7BQ==
=YjeL
-----END PGP SIGNATURE-----

--IlhQCBgyQqq6WEAAyjFsu5y93UxfUIwyt--
