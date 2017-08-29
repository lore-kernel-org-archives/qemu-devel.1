Received: from eggs.gnu.org ([2001:4830:134:3::10]:56926)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dmgRk-0001jx-Te
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 09:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dmgRf-0004QJ-Qv
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 09:20:48 -0400
Received: from mout.gmx.net ([212.227.15.19]:54096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dmgRf-0004Ow-Ak
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 09:20:43 -0400
References: <20170828174707.20786-1-famz@redhat.com>
	<20170828174707.20786-4-famz@redhat.com>
	<de606e2a-7f5e-0625-79dd-a828ea3d5fe9@amsat.org>
	<edd3bb01-dcb5-4741-3fe4-a20a5f64af88@amsat.org>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <f2a66875-06e8-9304-b20d-aa10e848a245@gmx.com>
Date: Tue, 29 Aug 2017 15:22:46 +0200
MIME-Version: 1.0
In-Reply-To: <edd3bb01-dcb5-4741-3fe4-a20a5f64af88@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lQ8ftCS1D5gwVs61KSoDfDTI1fsgvPwtH"
Subject: Re: [Qemu-devel] [PATCH v4 03/10] tests: Add vm test lib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lQ8ftCS1D5gwVs61KSoDfDTI1fsgvPwtH
From: Kamil Rytarowski <n54@gmx.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org,
 Kamil Rytarowski <kamil@netbsd.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com,
 Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <f2a66875-06e8-9304-b20d-aa10e848a245@gmx.com>
Subject: Re: [Qemu-devel] [PATCH v4 03/10] tests: Add vm test lib
References: <20170828174707.20786-1-famz@redhat.com>
 <20170828174707.20786-4-famz@redhat.com>
 <de606e2a-7f5e-0625-79dd-a828ea3d5fe9@amsat.org>
 <edd3bb01-dcb5-4741-3fe4-a20a5f64af88@amsat.org>
In-Reply-To: <edd3bb01-dcb5-4741-3fe4-a20a5f64af88@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.08.2017 15:10, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Fam, Kamil,
>=20
>> On 08/28/2017 02:47 PM, Fam Zheng wrote:
> [...]
>>> +        subprocess.check_call([tar_cmd,
>>> +                               "--exclude-vcs",
>>> +                               "--exclude=3Dtests/vm/*.img",
>>> +                               "--exclude=3Dtests/vm/*.img.*",
>>> +                               "--exclude=3D*.d",
>>> +                               "--exclude=3D*.o",
>>> +                               "--exclude=3Ddocker-src.*",
>>> +                               "-cf", tarfile, '.'], cwd=3Ddata_dir,=

>>
>> I'm not happy with this command :/
>> My distrib uses tmpfs for /tmp and suddently the whole X window became=

>> irresponsive until this script failing after filling 8G of /tmp and sw=
ap:
>>
>> ...
>> DEBUG:root:Creating archive /tmp/qemu-vm-F7CY9O/data-3a52c.tar for
>> data dir: .
>> tar: /tmp/qemu-vm-F7CY9O/data-3a52c.tar: Wrote only 4096 of 10240 byte=
s
>> tar: Error is not recoverable: exiting now
>> Failed to prepare guest environment
>>
>> Then I figured out my workdir is full of testing stuff, debug images,
>> firmwares, coredumps, etc.
>>
>> I'll think of another way.
>=20
> Using:
>=20
> (git ls-files; git submodule foreach --recursive "git ls-files | sed
> s_^_\$sm_path/_" | sed /^Entering/d) > files.txt
>=20
> and:
>=20
>         subprocess.check_call([tar_cmd,
>                                "-cf", tarfile,
>                                "-v" if self.debug else "",
>                                "-T", "files.txt"], cwd=3Ddata_dir,
>                               stdin=3Dself._devnull, stdout=3Dself._std=
out)
>=20
> Current /master and submodules generated tarball is ~305MB uncompressed=
=2E
>=20
> Kamil do you mind testing this command on NetBSD?
>=20
> (obviously 'files.txt' goes in tmpdir).
>=20

Result:

http://www.netbsd.org/~kamil/qemu/files.txt

I've tested this command line on a checkout from Jul 17th rev. 77031ee1ce=
4c

> Regards,
>=20
> Phil.
>=20



--lQ8ftCS1D5gwVs61KSoDfDTI1fsgvPwtH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZpWqsAAoJEEuzCOmwLnZsM6gP/1EE1rx/8CymtjLsgdNLLtWa
59GSHCfab4JunFp6TgdjbgjArqQzyrXuEo1NqL+VxLUFAv7PSUKqXQlNXLhifVds
vszG+p7VL0JWHYHc9sm6QBc+gJIM9Cs5akjDc1FThkRUeEIyGoAPJFOrh+3Nu+O8
0zDo5o7QigujfejGgg4m5TlIcp5FqU7aHjUTP+3M4jL7PjF2e48ZhY4ehbLb93fL
zKodjrOAXRmZ1kLoo15JleDp9q6JPNZsIsv6Sf2uSnI+dlUT5Qo9bRFFpHNSShB+
V5XmqBDhjM4DJj5XnBy0iwGC2SHYeMsG/bcLf50H9hmeWx5kU+/KvmPJhsv4OVrE
R2mdarnP6Nfm1klzc9BPflVIgNVUlae3At8FPI5twCYqOCkTRRv48cjQfZj5GIXv
ogc2rhfa47U+1aStn6nwfeM4jTo5cGn607YfInXQ/kBzOhe7MB2YCEYhqx2weeTu
UOVnrll4QfnC8v/oLD9xQaIwnjacLCtWRpYEgPQSfkVrQ29xHc1HdgSgW6C27wMN
Nopg83IxjXn9F+9AJYFzx0TaQrngYneaLG/gmxMyummBYlBdSkxM70uUKwHCBR66
G3PG/VsvflpWQ4F7SRKclDfR8PwPAAAnccUaXsk0Na2g08vocTcW8Mutwo28oCVV
Rm+ZPLYjNP23It9+rv5a
=sbTR
-----END PGP SIGNATURE-----

--lQ8ftCS1D5gwVs61KSoDfDTI1fsgvPwtH--
