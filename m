Received: from eggs.gnu.org ([2001:4830:134:3::10]:45112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3pcv-0001cM-4n
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 16:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3pcr-0005fP-4N
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 16:02:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d3pcq-0005ej-RV
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 16:02:53 -0400
References: <149332257377.114.5175749327718203613@c05f1edc8ed1>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a5eece39-2718-f5ea-ca7a-34b0d105e3b0@redhat.com>
Date: Thu, 27 Apr 2017 15:02:42 -0500
MIME-Version: 1.0
In-Reply-To: <149332257377.114.5175749327718203613@c05f1edc8ed1>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PB0329QE0O8sQaO9wUX9P4VDS2mChRcJj"
Subject: Re: [Qemu-devel] [PATCH v3 0/4] event: Add source information to
 SHUTDOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, armbru@redhat.com, alistair.francis@xilinx.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PB0329QE0O8sQaO9wUX9P4VDS2mChRcJj
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, armbru@redhat.com, alistair.francis@xilinx.com
Message-ID: <a5eece39-2718-f5ea-ca7a-34b0d105e3b0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/4] event: Add source information to
 SHUTDOWN
References: <149332257377.114.5175749327718203613@c05f1edc8ed1>
In-Reply-To: <149332257377.114.5175749327718203613@c05f1edc8ed1>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/27/2017 02:49 PM, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed automatic build test. Please find the testing comman=
ds and
> their output below. If you have docker installed, you can probably repr=
oduce it
> locally.
>=20

>   CC      util/buffer.o
> In file included from /usr/x86_64-w64-mingw32/sys-root/mingw/include/ob=
jbase.h:66:0,
>                  from /usr/x86_64-w64-mingw32/sys-root/mingw/include/ol=
e2.h:17,
>                  from /usr/x86_64-w64-mingw32/sys-root/mingw/include/wt=
ypesbase.h:12,
>                  from /usr/x86_64-w64-mingw32/sys-root/mingw/include/sh=
lobj.h:9,
>                  from /tmp/qemu-test/src/util/oslib-win32.c:42:
> /usr/x86_64-w64-mingw32/sys-root/mingw/include/objidl.h:14302:3: error:=
 conflicting types for 'ShutdownType'
>  } ShutdownType;
>    ^~~~~~~~~~~~
> In file included from /tmp/qemu-test/src/include/qapi/error.h:118:0,
>                  from /tmp/qemu-test/src/util/oslib-win32.c:34:
> ./qapi-types.h:1591:3: note: previous declaration of 'ShutdownType' was=
 here
>  } ShutdownType;
>    ^~~~~~~~~~~~
> /tmp/qemu-test/src/rules.mak:69: recipe for target 'util/oslib-win32.o'=
 failed

Well, that's a real bug. Guess I get to post v4, once I test via docker
that mingw is happy.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--PB0329QE0O8sQaO9wUX9P4VDS2mChRcJj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZAk5iAAoJEKeha0olJ0Nq/cQH+QH2cCWpUy99fgRDYbkvQKon
+lvWUp/Koxp9f83icR1c48Q1ab6UqjU2uSdf0dC2h3SWlyRmehXiuOY5qNE/uXNI
T9kzCPm05sLOnUcjN1ZQD1HRgD11RZ2ghg0ZtA+Y/7Cx5t+ZEiHUDoRDnIhAlJl/
ZuGD9BT7+3wriFHuy7zmu6GbRlZoUjpYjM0EFRVEP3lXbccUfPAVTAsdAyYpaCqe
wleM8VzPDRR9GTG1RGcQoCVVRdezXeHHEFLWY9VdFTio8tfhYgfxZE/JzJU7yO6e
4OXuXNNQhfMu43B8eK6seZQ0VkK/5+dBA7E5qgOmceuWC0Xbdmlq3QE0BBOZB9U=
=Zbd3
-----END PGP SIGNATURE-----

--PB0329QE0O8sQaO9wUX9P4VDS2mChRcJj--
