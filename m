Received: from eggs.gnu.org ([2001:4830:134:3::10]:48278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d5Yo6-0003Wo-F5
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:29:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d5Yo5-0005Jy-Jk
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:29:38 -0400
References: <20170502141858.24805-1-berrange@redhat.com>
	<20170502141858.24805-6-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <31bf6b6d-27c4-6519-e3f8-23a537e8f707@redhat.com>
Date: Tue, 2 May 2017 09:29:24 -0500
MIME-Version: 1.0
In-Reply-To: <20170502141858.24805-6-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FoTcvBiqS2xN6hWaWgiTw8MKpg1uOCReL"
Subject: Re: [Qemu-devel] [PATCH v6 5/5] Revert "qemu-img: copy *key-secret
 opts when opening newly created files"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FoTcvBiqS2xN6hWaWgiTw8MKpg1uOCReL
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <31bf6b6d-27c4-6519-e3f8-23a537e8f707@redhat.com>
Subject: Re: [PATCH v6 5/5] Revert "qemu-img: copy *key-secret opts when
 opening newly created files"
References: <20170502141858.24805-1-berrange@redhat.com>
 <20170502141858.24805-6-berrange@redhat.com>
In-Reply-To: <20170502141858.24805-6-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/02/2017 09:18 AM, Daniel P. Berrange wrote:
> This reverts commit 37d7772f6b81613620a333862dc67e34b2fda1a9.
> ---
>  qemu-img.c | 41 ++++++-----------------------------------
>  1 file changed, 6 insertions(+), 35 deletions(-)

Is this intentional, given that 4/5 just installed it?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--FoTcvBiqS2xN6hWaWgiTw8MKpg1uOCReL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZCJfEAAoJEKeha0olJ0NqFCEH/2tec5jSeUnwYMzurcpoebsc
PNn6kd/wWMZ0v3E1Txre9AdXAhoq31/BDvuUU92bO79nI+FkG75DoQBXwbXlKRA4
5ltuiUvtx0md5+gqW+MMnT021jtSOo9e5z8aIJrTICQYUyoSrpXKh8hDk66+AQvq
85aNGSDjAZa9lfMENdujo279ZINU1RNnZCQ2pBGDxKB8rQrU4Giey5N0VU74KRbo
lo8rZmGlX/0MP44YJprBOKrqtsz+9+46BIVfXRY6v0tqz95Vwe8B1RFH0sQYUtl6
6UMUPe4IOfTLNFzy5IRjh/z3wSioh7ja2YYXq6g4WFoBJlVk5W6WLyryN1rFLdE=
=8dof
-----END PGP SIGNATURE-----

--FoTcvBiqS2xN6hWaWgiTw8MKpg1uOCReL--
