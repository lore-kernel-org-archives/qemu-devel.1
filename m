Received: from eggs.gnu.org ([209.51.188.92]:59658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h3K91-0001aj-2a
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 08:35:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h3Jv4-0006If-76
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 08:20:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1h3Jv3-0006IK-RN
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 08:20:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 71513C049E23
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 12:11:37 +0000 (UTC)
References: <20190309004826.9027-1-lersek@redhat.com>
	<20190309004826.9027-2-lersek@redhat.com>
	<ed04ad23-72c9-ce20-dc90-52b540044c13@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <81647c9a-7da7-0b7a-bc9e-46467df6a56d@redhat.com>
Date: Mon, 11 Mar 2019 07:11:28 -0500
MIME-Version: 1.0
In-Reply-To: <ed04ad23-72c9-ce20-dc90-52b540044c13@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KzEPGR4zL9DaXJDmDIcDdUfG3DnFJ2gFV"
Subject: Re: [Qemu-devel] [PATCH 01/10] roms: lift "edk2-funcs.sh" from
 "tests/uefi-test-tools/build.sh"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, berrange@redhat.com, imammedo@redhat.com, kraxel@redhat.com, mst@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KzEPGR4zL9DaXJDmDIcDdUfG3DnFJ2gFV
From: Eric Blake <eblake@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>, berrange@redhat.com,
 imammedo@redhat.com, kraxel@redhat.com, mst@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <81647c9a-7da7-0b7a-bc9e-46467df6a56d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/10] roms: lift "edk2-funcs.sh" from
 "tests/uefi-test-tools/build.sh"
References: <20190309004826.9027-1-lersek@redhat.com>
 <20190309004826.9027-2-lersek@redhat.com>
 <ed04ad23-72c9-ce20-dc90-52b540044c13@redhat.com>
In-Reply-To: <ed04ad23-72c9-ce20-dc90-52b540044c13@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/11/19 7:07 AM, Eric Blake wrote:
> On 3/8/19 6:48 PM, Laszlo Ersek wrote:
>> Extract the dense logic for architecture and toolchain massaging from
>> "tests/uefi-test-tools/build.sh", to a set of small functions. We'll r=
euse
>> these functions for building full platform firmware images.
>>


>> +++ b/tests/uefi-test-tools/build.sh
>> @@ -38,97 +38,12 @@ if [ $ret -ne 0 ]; then
>=20
> build.sh is already marked as a bash script, and...
>=20
>> +# Fetch some option arguments, and set the cross-compilation environm=
ent (if
>> +# any), for the edk2 "build" utility.
>> +source "$edk2_dir/../edk2-funcs.sh"
>=20
> you are only ever sourcing the file, rather than directly executing it
> as a standalone script.

Except that later, you have a patch that sources the file from non-bash.
See my followup on 7/10. :(

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--KzEPGR4zL9DaXJDmDIcDdUfG3DnFJ2gFV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyGUHAACgkQp6FrSiUn
Q2qRrAf/dtErQ/hoEWpBzFPVdzRrjL5IfqU7aqxvSvVgFuwupfPYOtBhVzpixuRr
183Lin74GltAi8/lcrnAxYafT4lhvqiY7OKK6f/RaGQZlWb8shX7Q6ZMebNUzlSa
y4FJLyFgltvV3NlcyclICepnJKh4I/J6VpXusZJZu7tKrD89v6iG43ULZ/nUuMZ5
WbNEAv1h/00G5BRTPxl5I+RK4ZuqYy3E8HvNkJKKWNVO2Ch5UZH4Xb6NZDfcGVjt
+CYulJqcOO0e+TG7v7iLJT1sOL5C0gGta3cxwab5w+cTpCSbDVzTtWp6gSoBLuXw
MydnIoC2tXNqxyyKQlNCPwTTFwLGUA==
=ZHtg
-----END PGP SIGNATURE-----

--KzEPGR4zL9DaXJDmDIcDdUfG3DnFJ2gFV--
