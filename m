Received: from eggs.gnu.org ([209.51.188.92]:42933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gi2vu-0004wi-PN
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 14:57:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gi2vq-0006qo-TZ
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 14:57:34 -0500
References: <20190111194720.15671-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2791a830-e853-c2a0-2cba-4ab1f0a4b7a2@redhat.com>
Date: Fri, 11 Jan 2019 13:57:10 -0600
MIME-Version: 1.0
In-Reply-To: <20190111194720.15671-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="YsVDQNaLsjLGyZh3x5S4ceBZePIsSkoEw"
Subject: Re: [Qemu-devel] [PATCH v3 0/8] Promote x-nbd-server-add-bitmap to
 stable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, jsnow@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YsVDQNaLsjLGyZh3x5S4ceBZePIsSkoEw
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, jsnow@redhat.com, qemu-block@nongnu.org
Message-ID: <2791a830-e853-c2a0-2cba-4ab1f0a4b7a2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/8] Promote x-nbd-server-add-bitmap to
 stable
References: <20190111194720.15671-1-eblake@redhat.com>
In-Reply-To: <20190111194720.15671-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/11/19 1:47 PM, Eric Blake wrote:
> Or rather, move its functionality into nbd-server-add.  And as
> a side effect, teach qemu-nbd how to export a persistent bitmap
> without having to go through a qemu process and several QMP
> commands.
>=20
> Based-on: <20181221093529.23855-1-jsnow@redhat.com>
> [jsnow: 0/11 bitmaps: remove x- prefix from QMP api]
> Based-on: <20190111163519.11457-1-philmd@redhat.com>
> [philmd: qemu-nbd: Rename 'exp' variable clashing with math::exp() symb=
ol]
>=20
> Available at: https://repo.or.cz/qemu/ericb.git nbd-bitmap-add-v3
>=20
> Since v2:
> - split old patch 1 into 3 parts
> - add even more tests of expected error messages
> - rebase on top of 'exp' rename
> - improve commit messages
> - add some R-b where it made sense
>=20
> 001/8:[down] 'nbd: Add some error case testing to iotests 223'
> 002/8:[down] 'nbd: Forbid nbd-server-stop when server is not running'
> 003/8:[0011] [FC] 'nbd: Only require disabled bitmap for read-only expo=
rts'
> 004/8:[0020] [FC] 'nbd: Merge nbd_export_set_name into nbd_export_new'
> 005/8:[0008] [FC] 'nbd: Allow bitmap export during QMP nbd-server-add'
> 006/8:[----] [--] 'nbd: Remove x-nbd-server-add-bitmap'
> 007/8:[0009] [FC] 'nbd: Merge nbd_export_bitmap into nbd_export_new'
> 008/8:[0004] [FC] 'qemu-nbd: Add --bitmap=3DNAME option'

Queuing on my NBD tree; I'm planning on sending a pull request Monday
morning that includes these patches, unless a last-minute review finding
changes things.

https://repo.or.cz/qemu/ericb.git nbd

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--YsVDQNaLsjLGyZh3x5S4ceBZePIsSkoEw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw49RcACgkQp6FrSiUn
Q2q6jgf+LMokdJ7PHa3hSpMNF7gPatZloqNFBGL6YTJWh79bBYcC39KyJPPOcPNN
nwgSB2NFxCNvRc/jdfHfsfRLOZxV8P/jrp0S0vOC6JCn5wcexzYkdndZtrodAY+S
l7ecKc1/RBXmEZjjGosuwwO0/sTse8oFvCCdM6bl4f/xl6GFBbc7AGYUfYdBsTDW
pDkbbaMgN1B0XCgyGj/FrsJF8MSjv3ioMUyzcDesjggrd6BTPlGeJAXfWRnH7+wf
/1AIZ/hTwQv6u6O0dY/EcKuUu/EFeAPjd5k3DbJqZjUeKQCMVQmwEwIqsP5ADJcd
eYx0uSwRONMjT5YMkPAFbLQTKzDxfw==
=yRKk
-----END PGP SIGNATURE-----

--YsVDQNaLsjLGyZh3x5S4ceBZePIsSkoEw--
