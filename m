Received: from eggs.gnu.org ([2001:4830:134:3::10]:55830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddaeg-0005Uc-4M
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 07:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddadY-00072m-QU
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 07:20:33 -0400
References: <20170803150301.10177-1-kwolf@redhat.com>
	<20170803150301.10177-3-kwolf@redhat.com>
	<8dfbc0ca-9a02-3620-d9e5-41aadee69d52@redhat.com>
	<a7a5e25c-fef4-d508-4a9c-ff2d57c1b2ee@redhat.com>
	<20170804102034.GB4108@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a9c3cab3-2b2d-6562-c787-423b9800f4c2@redhat.com>
Date: Fri, 4 Aug 2017 06:17:30 -0500
MIME-Version: 1.0
In-Reply-To: <20170804102034.GB4108@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JbqHLLchv3PCUCj4GHmRSk5iQK8dxH0VQ"
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/5] block: Allow reopen rw
 without BDRV_O_ALLOW_RDWR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JbqHLLchv3PCUCj4GHmRSk5iQK8dxH0VQ
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <a9c3cab3-2b2d-6562-c787-423b9800f4c2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/5] block: Allow reopen rw without
 BDRV_O_ALLOW_RDWR
References: <20170803150301.10177-1-kwolf@redhat.com>
 <20170803150301.10177-3-kwolf@redhat.com>
 <8dfbc0ca-9a02-3620-d9e5-41aadee69d52@redhat.com>
 <a7a5e25c-fef4-d508-4a9c-ff2d57c1b2ee@redhat.com>
 <20170804102034.GB4108@localhost.localdomain>
In-Reply-To: <20170804102034.GB4108@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/04/2017 05:20 AM, Kevin Wolf wrote:
>>>
>>> Hmm, I wonder.  https://bugzilla.redhat.com/show_bug.cgi?id=3D1465320=

>>> details a failure when starting qemu with a read-write NBD disk, then=

>>> taking several snapshots (nbd <- snap1 <- snap2 <- snap3), then where=

>>> intermediate commit (snap2 into nbd) works but live commit (snap3 int=
o
>>> nbd) fails with a message that nbd does not support reopening.  I'm
>>> presuming that your series may help to address that; I'll give it a s=
pin
>>> and see what happens.
>>
>> Nope, even with your patches, I'm still getting:
>>
>> {'execute':'block-commit','arguments':{'device':'drive-image1','top':'=
bar2'}}
>> {"return": {}}
>> {"timestamp": {"seconds": 1501811285, "microseconds": 439748}, "event"=
:
>> "BLOCK_JOB_COMPLETED", "data": {"device": "drive-image1", "len":
>> 2097152, "offset": 2097152, "speed": 0, "type": "commit"}}
>>
>> {'execute':'block-commit','arguments':{'device':'drive-image1','top':'=
bar3'}}
>> {"error": {"class": "GenericError", "desc": "Block format 'nbd' used b=
y
>> node '#block048' does not support reopening files"}}
>=20
> That's simply NBD not implementing .bdrv_reopen_*. In other words, not =
a
> bug, but just a missing feature.

But why does intermediate commit work, while live commit fails?  Both
require that the image being committed into be read-write, and the NBD
image was opened read-write (even if it can be treated as read-only for
the duration of time that it is a backing image).  I understand missing
=2Ebdrv_reopen making it impossible to change read-only to read-write, bu=
t
when missing it means you can never change read-write down to the
tighter read-only originally, then what is making live commit different
from intermediate in not being able to handle it?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--JbqHLLchv3PCUCj4GHmRSk5iQK8dxH0VQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmEV8oACgkQp6FrSiUn
Q2qY/Qf+K4P1wDbNMogGT6gzxodQ85zQ/yOCkUqBF6tceAMST4l9diYuNKg44eMy
WRAFpKy7XeYYyV1l79YCUWg9mqP0635B2Xwr2z+3yafavM2vHfLmrzC8A/rSoMzu
rBMN90qgOhiZmaSBoamoVxDckLDnxzjn/sH5V8dyMORoUbZPuPpX2r1KIVhlv1iw
SYK2HBliG7eWlTuLp0z2xCAmlU3+mz21KYPPgMY/KmfHAnU3lw31ZSWwTfiKQq4K
xrC8pDLyHBVRHXk43kFZrWudri0PKfRg/3iGtwnXT7aVsj6WKjCIRKKsaT+MGLy8
EP6Uk0rhDsZKOGJpm3SwF73Jhlz9mg==
=vgaZ
-----END PGP SIGNATURE-----

--JbqHLLchv3PCUCj4GHmRSk5iQK8dxH0VQ--
