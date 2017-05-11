Received: from eggs.gnu.org ([2001:4830:134:3::10]:56953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8ps0-0001yn-Ld
	for qemu-devel@nongnu.org; Thu, 11 May 2017 11:19:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8prz-0000VZ-Jv
	for qemu-devel@nongnu.org; Thu, 11 May 2017 11:19:12 -0400
References: <20170411011718.9152-1-eblake@redhat.com>
	<20170411011718.9152-2-eblake@redhat.com>
	<20170412094909.GC4955@noname.str.redhat.com>
	<161300e8-fefb-f2c6-09cd-afd16d14bca0@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4a52f728-f1c0-8419-da1a-4112df1b0959@redhat.com>
Date: Thu, 11 May 2017 10:18:59 -0500
MIME-Version: 1.0
In-Reply-To: <161300e8-fefb-f2c6-09cd-afd16d14bca0@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="G2N1GROFdkOJa87vrlnKfNWCdJtWWDuJ6"
Subject: Re: [Qemu-devel] [PATCH v9 01/13] qcow2: Unallocate unmapped zero
 clusters if no backing file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G2N1GROFdkOJa87vrlnKfNWCdJtWWDuJ6
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com,
 John Snow <jsnow@redhat.com>
Message-ID: <4a52f728-f1c0-8419-da1a-4112df1b0959@redhat.com>
Subject: Re: [PATCH v9 01/13] qcow2: Unallocate unmapped zero clusters if no
 backing file
References: <20170411011718.9152-1-eblake@redhat.com>
 <20170411011718.9152-2-eblake@redhat.com>
 <20170412094909.GC4955@noname.str.redhat.com>
 <161300e8-fefb-f2c6-09cd-afd16d14bca0@redhat.com>
In-Reply-To: <161300e8-fefb-f2c6-09cd-afd16d14bca0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/11/2017 09:56 AM, Eric Blake wrote:
>=20
> On IRC, John, Kevin, and I were discussing the current situation with
> libvirt NBD storage migration.  When libvirt creates a file on the
> destination (rather than the user pre-creating it), it currently
> defaults to 0.10 [v2] images, even if the source was a 1.1 image [v3]
> (arguably something that could be improved in libvirt, but
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1371749 was closed as not=
 a
> bug).
>=20
> Therefore, the use case of doing a mirror job to a v2 image, and having=

> that image become thick even though the source was thin, is happening
> more than we'd like
> (https://bugzilla.redhat.com/show_bug.cgi?id=3D1371749).  While Kevin h=
ad

Bah, pasted the wrong link.  Correct one is:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1219541

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--G2N1GROFdkOJa87vrlnKfNWCdJtWWDuJ6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZFIDjAAoJEKeha0olJ0Nqp1sH/j1/kfIUriHg/5dMf2PcCCFZ
vjSj85cmgkyY7I4Yk8nuAYeplOfaWZZHa4q1lrGaatKngkgTEFPrYFuNnRZijkk1
hl6Sr/qBWtfqbACTq8rfl/OZR4rYCMkAD8A8v4M53Hq+wg0VzIiHY04bTeK+IZxd
zZMOlTzvzdXDmayHo981HYA96yZ+Ntg8cxAEggzXmtXACfyObj1Uyg/AGtlyio++
LjaMhDSCYkDJ3LV6tCj6S3xpvYLQLGeULAHopxKHrO/TlrdNMjBnQcn8UAouvwY6
iDazKnYaJbmG1zzeLQFa6baj4gGjDodzf8VNsO01oIr6J+G/lSGOfPfoewjfMko=
=NU9e
-----END PGP SIGNATURE-----

--G2N1GROFdkOJa87vrlnKfNWCdJtWWDuJ6--
