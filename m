Received: from eggs.gnu.org ([2001:4830:134:3::10]:33569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dR1nr-0007Uv-F1
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 15:42:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dR1nq-0002OT-G7
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 15:42:07 -0400
References: <20170621133023.27627-1-mreitz@redhat.com>
	<20170621133023.27627-2-mreitz@redhat.com>
	<748b90f3-8f89-59ea-4a65-69e938747c0b@redhat.com>
	<6179c9e2-5486-0ff6-927d-da144c178e93@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7fa30bfe-d1b4-0aeb-b90e-ae91f9467749@redhat.com>
Date: Fri, 30 Jun 2017 14:41:48 -0500
MIME-Version: 1.0
In-Reply-To: <6179c9e2-5486-0ff6-927d-da144c178e93@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HmLir0bd64KrquUuG51sggdsTCQBpDTkR"
Subject: Re: [Qemu-devel] [PATCH v4 1/2] iotests: Use absolute paths for
 executables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HmLir0bd64KrquUuG51sggdsTCQBpDTkR
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <7fa30bfe-d1b4-0aeb-b90e-ae91f9467749@redhat.com>
Subject: Re: [PATCH v4 1/2] iotests: Use absolute paths for executables
References: <20170621133023.27627-1-mreitz@redhat.com>
 <20170621133023.27627-2-mreitz@redhat.com>
 <748b90f3-8f89-59ea-4a65-69e938747c0b@redhat.com>
 <6179c9e2-5486-0ff6-927d-da144c178e93@redhat.com>
In-Reply-To: <6179c9e2-5486-0ff6-927d-da144c178e93@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/29/2017 09:46 PM, Max Reitz wrote:

>>> +++ b/tests/qemu-iotests/common.config
>>> @@ -103,6 +103,12 @@ if [ -z "$QEMU_VXHS_PROG" ]; then
>>>      export QEMU_VXHS_PROG=3D"`set_prog_path qnio_server`"
>>>  fi
>>> =20
>>> +export QEMU_PROG=3D$(realpath -- "$(type -p "$QEMU_PROG")")
>>
>> ...now that you updated per my review to favor 'type' over 'which'?
>> Otherwise, the R-b stands.
>=20
> Thanks, will fix and apply then...
>=20
> ...and done, applied to my block branch:
>=20
> https://github.com/XanClic/qemu/commits/block

Sorry for not noticing sooner, but you'll need to replace v4 (commit
0f0fec82 on your branch) with a fix, because now your branch does the
following on all iotests for me:

068 3s ... - output mismatch (see 068.out.bad)
--- /home/eblake/qemu/tests/qemu-iotests/068.out	2017-06-26
22:02:56.057734882 -0500
+++ 068.out.bad	2017-06-30 14:35:28.720241398 -0500
@@ -1,4 +1,5 @@
 QA output created by 068
+realpath: '': No such file or directory

The culprit? $QEMU_VXHS_PROG is empty for me, which means `set_prog_path
qnio_server` found nothing to use.  You'll have to add in a safety valve
that only calls 'type' if operating on a non-empty path in the first plac=
e.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--HmLir0bd64KrquUuG51sggdsTCQBpDTkR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZVql8AAoJEKeha0olJ0Nqfq0H/0Ey9AYQgezbzCPG7e3PKoW/
9No2oQA1j2u594M8lNc9TN5q3FXrjVKsvZgDm05V4mgXTYve9aocHK/A1L2w+9EQ
fae//vkRg61j7HuSe0Ct/CvEWPUEggQsLdwzIzVnlQfuO9eupNqlR12g0YitaKF0
IT7oZ6xZiMCerU3mN1n3K3KmfaDMD+IBJnUK25Jg6ek4QoyELoUzisa8zkNb6eOs
bxaLokP2EzfTM2dc87qBfCR3f/ybl7oAqRWu9UVsCI7/9ZcJZ/RIpgs9gkv7sxtD
x/GsBvuiAkZQonoPAHzQ5Gg97/jHsna7QnLgl2PguKG65JEMLw6JEL9sLntyOcE=
=UtWb
-----END PGP SIGNATURE-----

--HmLir0bd64KrquUuG51sggdsTCQBpDTkR--
