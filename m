Received: from eggs.gnu.org ([2001:4830:134:3::10]:58972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDWQk-0003cH-6n
	for qemu-devel@nongnu.org; Wed, 24 May 2017 09:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDWQj-0000BP-9t
	for qemu-devel@nongnu.org; Wed, 24 May 2017 09:34:26 -0400
References: <20170522211205.14265-1-hpoussin@reactos.org>
	<20170522211205.14265-6-hpoussin@reactos.org>
	<6add2c4b-d8fb-8abb-d2ea-474c8383bbad@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <89f3b705-4a80-e44f-34c0-477df592598e@redhat.com>
Date: Wed, 24 May 2017 08:34:15 -0500
MIME-Version: 1.0
In-Reply-To: <6add2c4b-d8fb-8abb-d2ea-474c8383bbad@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eexRorhvhMUtl3gMWqpRIemgK7CAec46e"
Subject: Re: [Qemu-devel] [PATCH v2 05/13] vvfat: introduce
 offset_to_bootsector, offset_to_fat and offset_to_root_dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eexRorhvhMUtl3gMWqpRIemgK7CAec46e
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <89f3b705-4a80-e44f-34c0-477df592598e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 05/13] vvfat: introduce
 offset_to_bootsector, offset_to_fat and offset_to_root_dir
References: <20170522211205.14265-1-hpoussin@reactos.org>
 <20170522211205.14265-6-hpoussin@reactos.org>
 <6add2c4b-d8fb-8abb-d2ea-474c8383bbad@amsat.org>
In-Reply-To: <6add2c4b-d8fb-8abb-d2ea-474c8383bbad@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/23/2017 11:10 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Herv=C3=A9,
>=20
> On 05/22/2017 06:11 PM, Herv=C3=A9 Poussineau wrote:
>> - offset_to_bootsector is the number of sectors up to FAT bootsector
>> - offset_to_fat is the number of sectors up to first File Allocation
>> Table
>> - offset_to_root_dir is the number of sectors up to root directory sec=
tor
>=20
> Eventually your commit description can end here, adding the 3 following=

> lines below the "---" separator.

No. Stuff after the --- is intended for things that are useful to
reviewers, but not helpful in the long run.  But in this case:

>=20
>> Replace first_sectors_number - 1 by offset_to_bootsector.

Knowing the conversion that was made DOES make it easier to read this
patch, even in the long run.  So this information belongs before the ---.=


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--eexRorhvhMUtl3gMWqpRIemgK7CAec46e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJYvYAAoJEKeha0olJ0NqicUH/2GA6UjjUKBRju75s2BaYeDp
7h4N7xxFqBcK5o/CiCDiM+vzYDV3Fjzog1mnFX6SvNkmRcttuybsSdV6GqU2tgcR
oGDjYCKaGGRqlHSlc+HsJmMM6jUZppf1yQ/20dX0uePInfJy1Q7xzEYrigbVGLFe
tYcMpoE1IwfcqO0rXqQCEHtTE5Se1Iw0YORBOuexzfYCIaPx93fIgWNtfkMOBi13
Ar5kvp0IkihhoOBStw8WyxyKE8QIrz5QRYXKnHQarTz2bBIHrIbeQA9KtWGZf1IW
pyte0qth8UAvaQP1ZMo8yV30JCL4/3Yf6eKecN4vSRe/ndtT5wV/GoKs4p/Tpxk=
=TRn7
-----END PGP SIGNATURE-----

--eexRorhvhMUtl3gMWqpRIemgK7CAec46e--
