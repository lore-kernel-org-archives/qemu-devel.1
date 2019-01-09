Received: from eggs.gnu.org ([209.51.188.92]:53886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghHDl-0000ns-Ck
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:00:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghHDk-0007yk-Ha
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:00:49 -0500
References: <20190108194552.45453-1-vsementsov@virtuozzo.com>
	<20190109112311.GB4867@localhost.localdomain>
	<5ddd78e0-90ed-a6e5-c454-f1a2e44c1a37@redhat.com>
	<20190109165111.GI4867@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9efd0cd9-1f2e-4f99-4f2a-93919756493f@redhat.com>
Date: Wed, 9 Jan 2019 11:00:31 -0600
MIME-Version: 1.0
In-Reply-To: <20190109165111.GI4867@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="akLu5MXyd3lH6cTkmcLD1tBDwfrh15idx"
Subject: Re: [Qemu-devel] [PATCH] file-posix: add rough-block-status
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com, fam@euphon.net, stefanha@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--akLu5MXyd3lH6cTkmcLD1tBDwfrh15idx
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com,
 mreitz@redhat.com, fam@euphon.net, stefanha@redhat.com, den@openvz.org
Message-ID: <9efd0cd9-1f2e-4f99-4f2a-93919756493f@redhat.com>
Subject: Re: [PATCH] file-posix: add rough-block-status parameter
References: <20190108194552.45453-1-vsementsov@virtuozzo.com>
 <20190109112311.GB4867@localhost.localdomain>
 <5ddd78e0-90ed-a6e5-c454-f1a2e44c1a37@redhat.com>
 <20190109165111.GI4867@localhost.localdomain>
In-Reply-To: <20190109165111.GI4867@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/9/19 10:51 AM, Kevin Wolf wrote:
> Am 09.01.2019 um 17:42 hat Paolo Bonzini geschrieben:
>> On 09/01/19 12:23, Kevin Wolf wrote:
>>> Also note that this is only metadata preallocation; full preallocatio=
n
>>> will still return allocated for the protocol layer and so it will alw=
ays
>>> be slow.
>>
>> Full preallocation these days can create images with preallocated but
>> known-zero blocks, I think?
>=20
> That would defeat one of the main purposes of preallocation because it
> would still require COW and metadata updates on the first write.
>=20
> If there is demand, we could add something like preallocation=3Ddata wh=
ere
> data clusters are preallocated but COW/metadata updates still happen at=

> runtime, but so far nobody has asked for it. Not sure when you would us=
e
> it either.

Except there HAS been talk about it before - such a mode makes it so
that you can guarantee a non-fragmented image, or even guarantee that
the entire guest-visible portion is contiguous and all qcow2 metadata is
at the front or back of the overall qcow2 file, making it very easy to
convert between qcow2 -> raw (strip the qcow2 metadata) or go in reverse
(wrap a raw into a qcow2) without having to shuffle the guest-visible
portions of the file.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--akLu5MXyd3lH6cTkmcLD1tBDwfrh15idx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlw2KK8ACgkQ3g5py3or
ov1n1Af/U+sqluN+vcuwyWraBFe2CuPRnh7noKDZD3hKnveemPVNuunl2NZ/HaDA
Kw/QvuCDcUfYUmFNqye5t4Oo35qsm02/I8C7Dzio2ODY448NTh3MD/lkZ9OJRibs
OUtS/BFxV9Q+qZMtAattD+feRZqJ9HBVbuXeqvFAF6qym5atPwwI9XMf9bgBvroz
ziclkRdipYwpkvxT82odvmFJpdjbO7+CCC0J1vrfOZVYvSS69Ndntv++uQ8vLJQr
b9BUnmOELdVpz/93XrU92L6PaQzG1qYvVbcQMAAW6hDgFST6IMU7HiQU3L2bEA8r
PhiEC3Xqd8AVcmfT319km6UUhDZ9WA==
=nTbP
-----END PGP SIGNATURE-----

--akLu5MXyd3lH6cTkmcLD1tBDwfrh15idx--
