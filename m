Received: from eggs.gnu.org ([2001:4830:134:3::10]:54015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ce1ds-0000j5-BM
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:37:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ce1dr-0003El-J2
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:37:16 -0500
References: <5fd09f2c-4201-1099-6d1b-a130e688e6eb@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5022d0be-7086-a743-23f0-5888b7ceefc3@redhat.com>
Date: Wed, 15 Feb 2017 09:37:07 -0600
MIME-Version: 1.0
In-Reply-To: <5fd09f2c-4201-1099-6d1b-a130e688e6eb@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BxlVvKU4tTFSj3wVRWxEltOksNsP9Vpf1"
Subject: Re: [Qemu-devel] blockdev-add/del status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BxlVvKU4tTFSj3wVRWxEltOksNsP9Vpf1
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>,
 Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>
Message-ID: <5022d0be-7086-a743-23f0-5888b7ceefc3@redhat.com>
Subject: Re: [Qemu-devel] blockdev-add/del status
References: <5fd09f2c-4201-1099-6d1b-a130e688e6eb@virtuozzo.com>
In-Reply-To: <5fd09f2c-4201-1099-6d1b-a130e688e6eb@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/15/2017 09:26 AM, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
>=20
> What is the status of qmp commands blockdev-add and x-blockdev-del? Is
> blockdev-add stable (it never had x- prefix)? What should be done to ge=
t
> rid of "x-" for x-blockdev-del?

We are still working on 'BlockdevOptions' for iscsi, rbd, and sheepdog.
When those are done (target of 2.9), then x-blockdev-del will be renamed
to drop the x- prefix, and blockdev-add will be considered stable.
Meanwhile, we are also working on adding a -blockdev command line option
that maps to the QMP command, again targetted for 2.9.

>=20
> I see a lot of work on blockdev-add in the list, but x-blockdev-del
> seems untouched about 8 moths..

Right now, x-blockdev-del is unlikely to change much, if at all; rather,
it keeps the name to remind us that blockdev-add is still changing, so
that we'll have a nice witness during introspection that both interfaces
are stable based on the loss of the x- prefix.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--BxlVvKU4tTFSj3wVRWxEltOksNsP9Vpf1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYpHWjAAoJEKeha0olJ0Nq/OUH/jvuUcZzEFKcpbJygeNNJCFq
et/gHVFhDgll3o2Gxr/4O95EYsao16tGLbp6M+Mbj+LXU9ALvBPb2u1ezvG11IT0
5FoRQ6Bkw/N/rHlyK352u2Ru1F7KeZVxxuGE6RTVy1WmUOCP93DLB4v+NyVG6MsZ
D4xnA+q4Aab5IWNzC0JrzbdrfhAB4jYbSXJUl3fPyXi4bp+qc9O433KuekFcKLUv
htWJPZV5aAb8jbE4bXjjqorZpbZXq07N13IoRvPF/tXd+IvJLNfFA/r5cwG/yCRI
n1kx4RozeIt9z/PHZTCH6CdSH9kzTefL0mQBiQX4RlgmUoBECmSuiUKagAkEpmk=
=NNhF
-----END PGP SIGNATURE-----

--BxlVvKU4tTFSj3wVRWxEltOksNsP9Vpf1--
