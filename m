Received: from eggs.gnu.org ([2001:4830:134:3::10]:41176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eKrjQ-0008To-VC
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 15:16:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eKrjQ-0005Ns-3e
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 15:16:20 -0500
References: <20171116173810.16457-1-crosa@redhat.com>
	<20171116173810.16457-2-crosa@redhat.com>
	<a5c42ab2-f384-4768-6e07-30814789ef5c@redhat.com>
	<efb77a22-77c4-9671-744e-5713ae727959@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <422c4428-4807-5132-f8ec-ec5d5ffb5509@redhat.com>
Date: Fri, 1 Dec 2017 21:16:11 +0100
MIME-Version: 1.0
In-Reply-To: <efb77a22-77c4-9671-744e-5713ae727959@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qrbSGhBi80NaP76cMq3lDHa3I0fE7vrs9"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 01/10] qemu-iotests: make
 execution of tests agnostic to test type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qrbSGhBi80NaP76cMq3lDHa3I0fE7vrs9
From: Max Reitz <mreitz@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <422c4428-4807-5132-f8ec-ec5d5ffb5509@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 01/10] qemu-iotests: make
 execution of tests agnostic to test type
References: <20171116173810.16457-1-crosa@redhat.com>
 <20171116173810.16457-2-crosa@redhat.com>
 <a5c42ab2-f384-4768-6e07-30814789ef5c@redhat.com>
 <efb77a22-77c4-9671-744e-5713ae727959@redhat.com>
In-Reply-To: <efb77a22-77c4-9671-744e-5713ae727959@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-17 14:15, Cleber Rosa wrote:
>=20
>=20
> On 11/17/2017 02:25 AM, Paolo Bonzini wrote:
>> On 16/11/2017 18:38, Cleber Rosa wrote:
>>> check makes a distinction on how it runs Python based tests.  The
>>> current approach is inconsistent because:
>>>
>>> 1) a large number of Python tests are already set as executable files=

>>> (eg: 030, 040, 041, 044, 045, 055, 056, 057, 065, 093, 118, 147, 149,=

>>> 155, 165 and 194)
>>>
>>> 2) a smaller number of Python tests are not set as executable files
>>>
>>> 3) the true purpose of a shebang line is to make a file executable,
>>> while it currently is used (inconsistently) as a test type flag
>>>
>>> 4) the same logic could in theory be applied to shell based tests,
>>> that is, if first line contains a shell shebang, run it with
>>> "$SHELL $test_file", but it'd be pointless
>>>
>>> IMO, there's no value in the distinction that check makes.  Dropping
>>> this distinction makes the interface simpler: check requires an
>>> executable file.
>>>
>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>>
>> This is quirky, but I think it makes sense to obey the configure
>> script's chosen Python interpreter.  Unlike /bin/sh or /bin/bash, ther=
e
>> can be many Python interpreters on a system and the user may not want
>> the one in /usr/bin/python (think of old RHEL with software collection=
s,
>> even though our use of Python is generally portable to older versions)=
=2E
>>
>=20
> Yes, that's a valid point.  Looking at it closer, we usually get "pytho=
n
> -B" from configure, so this changes the behavior (can plague the
> developer box with .pyc files).

Not just that, the most important thing is that you get python2 on
systems where /usr/bin/python points to python3 (i.e., Arch).

Max


--qrbSGhBi80NaP76cMq3lDHa3I0fE7vrs9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlohuIsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AW0QIAIcu3tG9DPMWluN04nCkFoMgYJpuSKEl
Fgtmx4d5AlaeZ/BDju1bETuRDoykyz2QRdmRH1bkDIldATIfZxXs3DLWuXUrrhX+
vzwibEk5EAO5WJ1MJcLgzwPh9TTQzuBAwITvXQwSVStfH4W27NBYthEMkdbMX4Lv
xkMzgvbWkE3MopWNKIZstJhs2yO+tmVVLsjrQB3nWGzxM65g+Xfc5+e4f4VOU4PF
DPCf8Ok3MEv3vBywoY1++4nYIVu3RP9qxUNQkenqcYDDok+FMsdiaqbA+r2hhKeZ
XXe24GpdZjzaADWl8sLEBWX1qW5mjAj+2MVyu61yy+TbfbqYTZ+lGco=
=ceB7
-----END PGP SIGNATURE-----

--qrbSGhBi80NaP76cMq3lDHa3I0fE7vrs9--
