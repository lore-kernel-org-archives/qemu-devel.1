Received: from eggs.gnu.org ([2001:4830:134:3::10]:44620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eGso9-0004WN-DO
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 15:36:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eGso8-0005CN-7M
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 15:36:45 -0500
References: <20171117190422.23626-1-eblake@redhat.com>
	<6f4f6793-c3fc-6711-39af-971964adb37c@redhat.com>
	<367da343-8031-56b4-a6d2-bf7191447bd5@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aa14c192-9b58-ea65-da63-db1d357097cd@redhat.com>
Date: Mon, 20 Nov 2017 14:36:32 -0600
MIME-Version: 1.0
In-Reply-To: <367da343-8031-56b4-a6d2-bf7191447bd5@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LnBg46IsTV4q0aQgdUNCXL30rp5IIk31X"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.11] iotests: Fix 176 on
 32-bit host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LnBg46IsTV4q0aQgdUNCXL30rp5IIk31X
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Message-ID: <aa14c192-9b58-ea65-da63-db1d357097cd@redhat.com>
Subject: Re: [Qemu-block] [Qemu-devel] [PATCH for-2.11] iotests: Fix 176 on
 32-bit host
References: <20171117190422.23626-1-eblake@redhat.com>
 <6f4f6793-c3fc-6711-39af-971964adb37c@redhat.com>
 <367da343-8031-56b4-a6d2-bf7191447bd5@redhat.com>
In-Reply-To: <367da343-8031-56b4-a6d2-bf7191447bd5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/17/2017 04:59 PM, John Snow wrote:
>>> So for this test, the easiest solution is to filter out the
>>> actual hash value.  Broken in commit 4096974e.
>>
>> Of course, if Kevin sends a v2 pull, it's probably better to just squa=
sh
>> this in to my original testsuite change (since a v2 would probably
>> invalidate that commit id).
>>
>=20
> Whichever way you go,

Commit 4096974e has already landed in master, so this commit message is
correct as-is and belongs in the next pull request (whether for -rc2 or
-rc3 depends on timing).

>=20
> Reviewed-by: John Snow <jsnow@redhat.com>
>=20
> I don't know how important it is to nail this down, but the purpose of
> this command is primarily for sanity testing and not necessarily betwee=
n
> architectures, so this might just be a limitation to document.
>=20
> Also, don't use this for anything except testing.

Indeed, the name of x-debug-block-dirty-bitmap-sha256 already implies
its limited portability; but it also gives us free reign to change it's
behavior if we find something we like better for the same ease of bitmap
testing/debugging.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LnBg46IsTV4q0aQgdUNCXL30rp5IIk31X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloTPNAACgkQp6FrSiUn
Q2qA6Qf9Ew30rNKoR1e97zSvHDM01t4eIkVOh/z6xTHmw3zbBoLYZ8lg4nCpv/vl
oVrcOdh+c5SCLHjrW9JWHyvfl96JL6KMWtGgHDuKLF4Yb9kIGiKzoAd2OXWObrs0
PooGL4mZt0gYjbpnc9qVO1KxDpQJ8XKD51U68ICSif24NbdWej/EK4JX/EJMR3kQ
jIQEyjnD47X34hM0MpQKnsjFHAj5sW1wOIJSA+RjLYvc1GXVEqWXfhhtO9c7TlFX
9NXQOuk5V8gUC8BMnBv8NCgaBqXNBhLgQ/LzLTUq6yekiQHAGN8qA5JdLjelQwkd
koqMmOmEKpv0Ok3pIrv8R7lgSsZPxQ==
=al/A
-----END PGP SIGNATURE-----

--LnBg46IsTV4q0aQgdUNCXL30rp5IIk31X--
