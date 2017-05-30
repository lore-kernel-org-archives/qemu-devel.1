Received: from eggs.gnu.org ([2001:4830:134:3::10]:55682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFoLO-0006QR-LO
	for qemu-devel@nongnu.org; Tue, 30 May 2017 17:06:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFoLL-0006hw-HM
	for qemu-devel@nongnu.org; Tue, 30 May 2017 17:06:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dFoLL-0006hk-84
	for qemu-devel@nongnu.org; Tue, 30 May 2017 17:06:19 -0400
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
	<20170530143052.165002-5-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c3f0b03b-33f3-f4b4-8ed9-fbafaf9de3be@redhat.com>
Date: Tue, 30 May 2017 16:06:15 -0500
MIME-Version: 1.0
In-Reply-To: <20170530143052.165002-5-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ra3ov4lPc5Kvf99sq2OfDRBR0wVetsMO4"
Subject: Re: [Qemu-devel] [PATCH 04/19] nbd/server: get rid of EAGAIN dead
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ra3ov4lPc5Kvf99sq2OfDRBR0wVetsMO4
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org
Message-ID: <c3f0b03b-33f3-f4b4-8ed9-fbafaf9de3be@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/19] nbd/server: get rid of EAGAIN dead
 code
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
 <20170530143052.165002-5-vsementsov@virtuozzo.com>
In-Reply-To: <20170530143052.165002-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/30/2017 09:30 AM, Vladimir Sementsov-Ogievskiy wrote:
> For now read_sync never returns EAGAIN. So, don't handle it.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
>=20

I had to go re-read your cover letter, to learn that EAGAIN went away in
your prerequisite series (I see Paolo has a pending PULL request with
your prerequisite in place, but it's not yet on master).

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ra3ov4lPc5Kvf99sq2OfDRBR0wVetsMO4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLd7IAAoJEKeha0olJ0NqPtEH/37QnAr1pmPWc5g1CvBKP9tw
IDDoT/L4UhQEOxMpXFfaMGCaN/bzBkhXXTAqqM20qN1LmyUfaa1R861JHYaEC7Qa
OByOwYokmdaFJrZjveQRWmiN1YIWpVWd0K14Eb3GkER1jeTIYaPtLYyKs9cdbQul
YPg5oZo2eG+/jzItqqDREw9bQmthqsKsYZH4/FXIzA8mnzKdDRjogWC3lDDWtPbD
mPhWWbPP5YybcUOLxULWsX2MFMvhweE5aWDWq67LIb7OPEJBR0croyO0P06rrz7T
vYqvwKDL6SDWnzaPQh9w7rLF6KZmUxXPLUcjA0LTev0DxHQFFDtGmEnNd9crmQg=
=O7J1
-----END PGP SIGNATURE-----

--ra3ov4lPc5Kvf99sq2OfDRBR0wVetsMO4--
