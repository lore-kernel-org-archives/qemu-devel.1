Received: from eggs.gnu.org ([2001:4830:134:3::10]:52326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPtlK-0006m9-CD
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:54:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPsvc-00005m-Gm
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:01:27 -0400
References: <20170605203845.24351-1-eblake@redhat.com>
	<20170606122645.GC5448@noname.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fffc2bff-063b-4e0e-c90d-e5a77857ab1c@redhat.com>
Date: Tue, 27 Jun 2017 11:01:15 -0500
MIME-Version: 1.0
In-Reply-To: <20170606122645.GC5448@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1q2x9kxBrjIqNV7dl2Se548nxfsvTgkqx"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4 0/4] more blkdebug tweaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1q2x9kxBrjIqNV7dl2Se548nxfsvTgkqx
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Message-ID: <fffc2bff-063b-4e0e-c90d-e5a77857ab1c@redhat.com>
Subject: Re: [Qemu-block] [PATCH v4 0/4] more blkdebug tweaks
References: <20170605203845.24351-1-eblake@redhat.com>
 <20170606122645.GC5448@noname.redhat.com>
In-Reply-To: <20170606122645.GC5448@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/06/2017 07:26 AM, Kevin Wolf wrote:
> Am 05.06.2017 um 22:38 hat Eric Blake geschrieben:
>> I found a crasher and some odd behavior while rebasing my
>> bdrv_get_block_status series, so I figured I'd get these things
>> fixed first.  This is based on top of Max's block branch.
>>
>> Available as a tag at:
>> git fetch git://repo.or.cz/qemu/ericb.git nbd-blkdebug-status-v4
>>
>> Since v3:
>> - check all qemu-iotests (patch 1)
>=20
> Whoops, somehow I ended up applying and reviewing v4 while looking at
> the v3 thread... Looks like there really aren't any missing test case
> updates any more.
>=20
> Thanks, applied to the block branch.

Did this get lost somehow?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1q2x9kxBrjIqNV7dl2Se548nxfsvTgkqx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZUoFMAAoJEKeha0olJ0Nq4/YH/0ZH143Uc1nA1gsDfj+lQHLf
s+N2+2iszdOpuntdAjjosRNhFm7Xcu4IdS9ddZ7g5lrHJ97qVgFoMxEFrWaModYm
L5YXMK6MXRmI/0M6Ls2d14In6gsbaDR1uBsRwYy+ksFp73c9Nbe+gcGCWQq+ICy+
23lXLSUe4m2OYG53RzgjG4v4isr86vx0Upcgz+W+hEWeMb2QD5Zvw+L30h9g9X+A
a4XGWxrKFYHfRDGWvvFJifZateuPBsiZh1iiu9vkHcSV0/3EK2O1nEMio4/Qf6Gl
7egd1n5uX3irhDHY6181uDlKqEXSbRu4vuliiuTvbEyHU5pWc+hdqCB72vdxdgk=
=Jrs5
-----END PGP SIGNATURE-----

--1q2x9kxBrjIqNV7dl2Se548nxfsvTgkqx--
