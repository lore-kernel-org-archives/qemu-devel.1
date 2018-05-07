Received: from eggs.gnu.org ([2001:4830:134:3::10]:44711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jtomko@redhat.com>) id 1fFeqf-00071S-Vn
	for qemu-devel@nongnu.org; Mon, 07 May 2018 08:02:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jtomko@redhat.com>) id 1fFeqb-00085G-3K
	for qemu-devel@nongnu.org; Mon, 07 May 2018 08:02:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38936 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1fFeqa-00083Z-TV
	for qemu-devel@nongnu.org; Mon, 07 May 2018 08:02:29 -0400
Date: Mon, 7 May 2018 14:02:16 +0200
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
Message-ID: <20180507120216.GB25952@dnr>
References: <20180507033214.19219-1-zyimin@linux.ibm.com>
	<df015c61-0dde-da33-86eb-31abbd6ec805@de.ibm.com>
	<20180507103320.GE17261@vader>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Content-Disposition: inline
In-Reply-To: <20180507103320.GE17261@vader>
Subject: Re: [Qemu-devel] [libvirt] [PATCH 0/1] Bug: Sandbox: libvirt
 breakdowns qemu guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, fiuczy@linux.ibm.com, libvir-list@redhat.com, qemu-devel@nongnu.org, Yi Min Zhao <zyimin@linux.ibm.com>


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 07, 2018 at 12:33:20PM +0200, Eduardo Otubo wrote:
>On 07/05/2018 - 11:29:57, Christian Borntraeger wrote:
>> On 05/07/2018 05:32 AM, Yi Min Zhao wrote:
>> > 1. Problem Description
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > If QEMU is built without seccomp support, 'elevatorprivileges' remains=
 compiled.
>> > This option of sandbox is treated as an indication for seccomp blackli=
st support
>> > in libvirt. This behavior is introduced by the libvirt commits 31ca6a5=
 and
>> > 3527f9d. It would make libvirt build wrong QEMU cmdline, and then the =
guest
>> > startup would fail.
>>
>> Adding libvirt list.
>>
>> This would still fail with older QEMUs, so the question is if we should =
also OR instead
>> change something in libvirt.
>
>Perhaps I'm missing something here, but libvirt can differentiate between
>different versions of QEMU, therefore not calling it with wrong or outdated
>arguments.
>

The code introduced in libvirt commit 31ca6a5 specifically looks for
'elevateprivileges' in 'parameters' of the 'sandbox' option through
query-command-line-options.

Outdated QEMUs should not have this option there.

However, libvirtd does add the option by default not knowing whether it
can fail for other reasons, e.g. SECCOMP not being enabled in the
running kernel. I wonder if that is worth addressing.

Jano

>>
>> >
>> > 2. Libvirt Log
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > qemu-system-s390x: -sandbox on,obsolete=3Ddeny,elevateprivileges=3Dden=
y,spawn=3Ddeny,\
>> > resourcecontrol=3Ddeny: seccomp support is disabled
>> >
>> > 3. Fixup
>> > =3D=3D=3D=3D=3D=3D=3D=3D
>> > Wrap the options except 'enable' for qemu_sandbox_opts by CONFIG_SECCO=
MP.
>> >
>> > Yi Min Zhao (1):
>> >   sandbox: avoid to compile options if CONFIG_SECCOMP undefined
>> >
>> >  vl.c | 2 ++
>> >  1 file changed, 2 insertions(+)
>> >
>>
>
>--=20
>Eduardo Otubo
>
>--
>libvir-list mailing list
>libvir-list@redhat.com
>https://www.redhat.com/mailman/listinfo/libvir-list

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEyAry0cRMFDoj9m/ZyvpdPXT/AmkFAlrwQD4ACgkQyvpdPXT/
AmlIRhAAnE4TuT/pt0IHfhx32MLRncrhnsOs9Wb/hDHf25zcVd9zp3pXzskcIxaV
jVLsJuw9WavpYs4rXrw/pW3bXnVzYnur2XDWWGixSLfOIqz959bWjVJNVcR7W+Bt
SJJN88hWUA7Ua1OA9jHlukgYFfOXA+x6ZE9Te2cJ7NBMFzOE+xBziZYz1GTDwdnI
UtOgiLkcwazHB3EKIqqb+TxnTtL9tX/HMA8D0WNPDirJQQhKwHQznjzrutPf0ex8
HJGu73P88o23Syk6pvlHoRhYMxRs7nTMddB0fhu/EmwWSa/jnpEjIvbkIuH023JN
5oFZEzQwLCFII6mAa8dT4job9Y9lJZYhNbOA10aoLyuAwyviSx7n+PmLJ1UILscu
X2OpyHktYsIUTDPXGdIQ+N3WdRI3ok6ngfe56tZ9AUIrqffWBG9xrOv8Xb3iUkTY
JkAQc3NqHhgsDYDypf7UsLO24XJyavIaFkDNXbzBr6/VqeYF6zh/w4RYV/GAucN3
RiiFizTz9WvGDSF4msIiJCh5dsrDwkcrtXt50+rg7HHbix/ME2EYPTn73w6/eLl9
6q7tB1ofK5Fv9NfFyYaD5KUUqeqqrK/WnpBr0ogPiMpDI2IsaD7zJKH+YUF+TSCy
U/B/qyCNcPGLyizcCFtloaO1cc9Wbwvoyw1kATMHFFBgCFHHYQA=
=4jST
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--
