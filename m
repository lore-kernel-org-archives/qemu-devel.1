Received: from eggs.gnu.org ([2001:4830:134:3::10]:43929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cJNUg-0001s9-0p
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 11:42:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cJNUf-0004MK-0t
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 11:42:26 -0500
References: <20161202192223.15153-1-eblake@redhat.com>
	<20161202192223.15153-6-eblake@redhat.com>
	<20161207161659.GG4773@noname.str.redhat.com>
	<6e1d4ce3-da78-2766-6670-9cfda8d61d33@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <36f5499a-3310-e5c6-fc27-80a8db6c9660@redhat.com>
Date: Tue, 20 Dec 2016 10:42:12 -0600
MIME-Version: 1.0
In-Reply-To: <6e1d4ce3-da78-2766-6670-9cfda8d61d33@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8cL7PK8RskTBFrd0kCc3CQTVW5LaMcTOW"
Subject: Re: [Qemu-devel] [PATCH v3 5/5] tests: Add coverage for recent
 block geometry fixes
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
--8cL7PK8RskTBFrd0kCc3CQTVW5LaMcTOW
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Message-ID: <36f5499a-3310-e5c6-fc27-80a8db6c9660@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/5] tests: Add coverage for recent block
 geometry fixes
References: <20161202192223.15153-1-eblake@redhat.com>
 <20161202192223.15153-6-eblake@redhat.com>
 <20161207161659.GG4773@noname.str.redhat.com>
 <6e1d4ce3-da78-2766-6670-9cfda8d61d33@redhat.com>
In-Reply-To: <6e1d4ce3-da78-2766-6670-9cfda8d61d33@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/07/2016 10:34 AM, Eric Blake wrote:
> On 12/07/2016 10:16 AM, Kevin Wolf wrote:
>> Am 02.12.2016 um 20:22 hat Eric Blake geschrieben:
>>> Use blkdebug's new geometry constraints to emulate setups that
>>> have caused recent regression fixes: write zeroes asserting
>>> when running through a loopback block device with max-transfer
>>> smaller than cluster size, and discard rounding away portions
>>> of requests not aligned to preferred boundaries.  Also, add
>>> coverage that the block layer is honoring max transfer limits.
>>>

>>> +
>>> +_supported_fmt qcow2
>>> +_supported_proto file
>>> +
>>> +CLUSTER_SIZE=3D1M
>>> +size=3D128M
>>> +options=3Ddriver=3Dblkdebug,image.driver=3Dqcow2
>>> +
>>> +echo
>>> +echo "=3D=3D setting up files =3D=3D"
>>> +
>>> +_make_test_img $size
>>> +$QEMU_IO -c "write -P 11 0 $size" "$TEST_IMG" | _filter_qemu_io
>>> +mv "$TEST_IMG" "$TEST_IMG.base"
>>
>> I know that you declared "_supported_proto file", but if you don't use=

>> mv after creating the image, it might actually work with other
>> protocols.
>>
>> Most other tests use something like this:
>>
>>     TEST_IMG=3D"$TEST_IMG.base" _make_test_img $size
>>
>> And for the qemu-io invocation you can just use the right filename.
>=20
> Thanks.  I obviously copied-and-pasted from an earlier test, rather tha=
n
> a later one, so I'll make the tweaks in v4.

Even with the tweaks, I still wasn't able to get things like:

=2E/check -qcow2 -nfs 173

to work.  I'm probably missing something trivial, but if someone wants
to improve the test as a follow-up, they can be my guest.  I'll go ahead
and post v4 with the cleaner creation of the backing file, but leave the
_supported_proto file line for now.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--8cL7PK8RskTBFrd0kCc3CQTVW5LaMcTOW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYWV9lAAoJEKeha0olJ0NquMoH/inupO9TV7INDkbSG63KSc19
Kk661x7+RUISNJlOyb4uwD7QyQU0VuVSMu9UyaGyz+s+vL3fw9PdoCbZLCGaoS7S
wUHJdM8h5H2XWq2VHZZBmwv/JWqEVNXdF6gmolmgBhDPe1jD3aqLjH28RbgVkThw
f89sJsZvW8SAmkLkb4N0GQqlFMfcrRf48770uPmg4N7cLsutlnxcc9DOx454c0pP
iMaDD+xWuULI/sCAXYZmpqUjndOGt/ho4sX3UBqjVva/1+FME8z6OyXts+pu5VdC
fImx+BwsxzsvUqkaCtZVVKYfrvpS52Lzr3eeom8IGV/eX6I4V4mV60HWH55QJ/8=
=bL2h
-----END PGP SIGNATURE-----

--8cL7PK8RskTBFrd0kCc3CQTVW5LaMcTOW--
