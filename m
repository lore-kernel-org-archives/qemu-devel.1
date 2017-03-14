Received: from eggs.gnu.org ([2001:4830:134:3::10]:60985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnmdu-0000Fv-Jz
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 09:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnmdr-0000wK-CM
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 09:37:38 -0400
References: <20170314101925.16792-1-andreas@grapentin.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cb635189-1c52-8b30-d33d-e593febc2a2e@redhat.com>
Date: Tue, 14 Mar 2017 08:37:31 -0500
MIME-Version: 1.0
In-Reply-To: <20170314101925.16792-1-andreas@grapentin.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LcqFluUf1l1xxq7eNlK2rsqRe2XXiSaIE"
Subject: Re: [Qemu-devel] [PATCH 0/1] major / minor macros are to be
 included from <sys/sysmacros.h>
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andreas Grapentin <andreas@grapentin.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LcqFluUf1l1xxq7eNlK2rsqRe2XXiSaIE
From: Eric Blake <eblake@redhat.com>
To: Andreas Grapentin <andreas@grapentin.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Message-ID: <cb635189-1c52-8b30-d33d-e593febc2a2e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/1] major / minor macros are to be included
 from <sys/sysmacros.h>
References: <20170314101925.16792-1-andreas@grapentin.org>
In-Reply-To: <20170314101925.16792-1-andreas@grapentin.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/14/2017 05:19 AM, Andreas Grapentin wrote:
> Building qemu fails with glibc-2.25 and gcc-6.3.1:
>=20
>> qemu/qga/commands-posix.c:656:13: error: In the GNU C Library, "major"=
 is defined
>>  by <sys/sysmacros.h>. For historical compatibility, it is
>>  currently defined by <sys/types.h> as well, but we plan to
>>  remove this soon. To use "major", include <sys/sysmacros.h>
>>  directly. If you did not intend to use a system-defined macro
>>  "major", you should undefine it after including <sys/types.h>. [-Werr=
or]
>>          *devmajor =3D major(st.st_rdev);
>>              ^~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> A trivial fix is to #include <sys/sysmacros.h> in the respective files.=

>=20
>=20
> Andreas Grapentin (1):
>   major / minor macros are to be included from <sys/sysmacros.h>

NACK. <sys/sysmacros.h> is not a universal file, so you can't blindly
include it without first checking that it exists. We already fixed the
problem correctly in commit 4d04351, which just landed today.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--LcqFluUf1l1xxq7eNlK2rsqRe2XXiSaIE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYx/IbAAoJEKeha0olJ0NqIM0IAKQWOvZ6oXfnY2eF2rOJiodF
qF1mnHliRNZNcrT4EH8vSSGAh9KzsQrB9FxfJEMk4a/DCvkr0+379FnvMR3JuwW4
jgs4cSjEbqIhBZRde1VukJXw5w7UdT3i35PEJ2jNFQvowTiMoj8fScdhsUSe7KoN
J0pRttEN1If3+YHVLSojFX1sJuVC74eUP3YRQfqFKeAv6ud89YTLcOGgMnVHcUO8
Qat1mfuAU7QXz85pOYPUvbc3SMi0mLY7+I2wO+iY+5uZK0EzTsqoGJXUGFP2jGr7
sH104Zw8Znw0Y2IVjpUa9e+pepERVURta4jlPm3SrRa6gO3TM//iXcPWxGjH8kY=
=gUMB
-----END PGP SIGNATURE-----

--LcqFluUf1l1xxq7eNlK2rsqRe2XXiSaIE--
