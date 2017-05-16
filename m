Received: from eggs.gnu.org ([2001:4830:134:3::10]:59930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAe2u-0005gv-9q
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAe2t-0000zZ-BG
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:05:56 -0400
References: <20170515203114.9477-1-hpoussin@reactos.org>
	<20170515203114.9477-6-hpoussin@reactos.org>
	<20170516141602.GE4438@noname.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <69fc0b47-4654-c179-f729-bfafc1f68510@redhat.com>
Date: Tue, 16 May 2017 10:05:30 -0500
MIME-Version: 1.0
In-Reply-To: <20170516141602.GE4438@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2wliK5HGGGs73xXdcWD1DWwQSlxTsgRBQ"
Subject: Re: [Qemu-devel] [PATCH 05/13] vvfat: introduce
 offset_to_bootsector, offset_to_fat and offset_to_root_dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2wliK5HGGGs73xXdcWD1DWwQSlxTsgRBQ
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?=
 <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <69fc0b47-4654-c179-f729-bfafc1f68510@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/13] vvfat: introduce offset_to_bootsector,
 offset_to_fat and offset_to_root_dir
References: <20170515203114.9477-1-hpoussin@reactos.org>
 <20170515203114.9477-6-hpoussin@reactos.org>
 <20170516141602.GE4438@noname.redhat.com>
In-Reply-To: <20170516141602.GE4438@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/16/2017 09:16 AM, Kevin Wolf wrote:
> Am 15.05.2017 um 22:31 hat Herv=C3=A9 Poussineau geschrieben:
>> - offset_to_bootsector is the number of sectors up to FAT bootsector
>> - offset_to_fat is the number of sectors up to first File Allocation T=
able
>> - offset_to_root_dir is the number of sectors up to root directory sec=
tor
>=20
> Hm... These names make me think of byte offsets. Not completely opposed=

> to them, but if anyone can think of something better...?

I _want_ us to move towards byte offsets.  Thinking in sector offsets is
madness, especially since I already have patches posted to make
bdrv_get_block_status() converted to a byte-wise interface.

How hard is it to make all of the new variables be byte offsets, then
scale them to sectors as needed?  You can assert() that the byte offsets
are sector-aligned, so that the scaling doesn't have to worry about
rounding effects during the divisions.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2wliK5HGGGs73xXdcWD1DWwQSlxTsgRBQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZGxU6AAoJEKeha0olJ0NqR1UH/iQVfMxBlwP9eRrf5huBKIgQ
2rkaqIrkZ9pr4Dnmrn78UGGkk8TDN5vybgTTaoIbzOY2KDzmftlBvB0x6xWPQ0Ly
30xK5MzXeX+Cssagpw1tzS8/Xazk2PTHW5X+A7jcQ+AbmmuHyGqF+G2n7eskEqYJ
4cd5kyQGBCG31Eku3XuYGUqxYbQGM81FTPs2oCQh9BdbJlylQN/es4OfubUnGmNt
49aW47eBsCESQns3V+pkV4194NkR7A3hOOxVwZaw7nsZLp0Gim0wN1xYtQUQob+A
EjM5VS6vGt1d9SdTkt8z5dF26/EXeSoOy1RamJ41iXM6cLEMxFmj/aY2sSLQ2hA=
=oBv7
-----END PGP SIGNATURE-----

--2wliK5HGGGs73xXdcWD1DWwQSlxTsgRBQ--
