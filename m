Received: from eggs.gnu.org ([2001:4830:134:3::10]:46356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3kc2-0006kD-67
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3kby-00081J-23
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:46:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55480 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f3kbx-000815-Rd
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:46:09 -0400
References: <152276983686.1416.16137563993301721352@71c20359a636>
From: Eric Blake <eblake@redhat.com>
Message-ID: <06bd734b-3b48-ab51-3425-4cbb2dfe3bc0@redhat.com>
Date: Wed, 4 Apr 2018 10:45:57 -0500
MIME-Version: 1.0
In-Reply-To: <152276983686.1416.16137563993301721352@71c20359a636>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QRBrRApp62RIayV1vGsrd324OZiNJKwjm"
Subject: Re: [Qemu-devel] [PATCH 0/2 RFC] Implement Hex file loader and add
 test case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, no-reply@patchew.org, suhang16@mails.ucas.ac.cn
Cc: stefanha@gmail.com, jim@groklearning.com, famz@redhat.com, joel@jms.id.au

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QRBrRApp62RIayV1vGsrd324OZiNJKwjm
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org, no-reply@patchew.org, suhang16@mails.ucas.ac.cn
Cc: stefanha@gmail.com, jim@groklearning.com, famz@redhat.com, joel@jms.id.au
Message-ID: <06bd734b-3b48-ab51-3425-4cbb2dfe3bc0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2 RFC] Implement Hex file loader and add
 test case
References: <152276983686.1416.16137563993301721352@71c20359a636>
In-Reply-To: <152276983686.1416.16137563993301721352@71c20359a636>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/03/2018 10:37 AM, no-reply@patchew.org wrote:
> Hi,
>=20
> This series seems to have some coding style problems. See output below =
for
> more information:
>=20

> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> Checking PATCH 1/2: Implement .hex file loader...
> ERROR: braces {} are necessary for all arms of this statement
> #220: FILE: hw/core/loader.c:1463:
> +    } while (++hex_blob !=3D end);
> [...]

False positive; this is a known bug in checkpatch.pl, and there is even
a patch proposed to resolve it, but no one has incorporated the patch yet=
:

https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg05232.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--QRBrRApp62RIayV1vGsrd324OZiNJKwjm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrE8zUACgkQp6FrSiUn
Q2oLXQf/Q1OheKXEJUzWwPLD1t4WOCWf3A/kVh0HPROXi0Cgvv5lnjpVzGHO1Rmi
mFe6e4IW3H0b54j1ZF0c6adQHCy4/pxxshysInBZQoU/dBA8WH9Hjh7kbc/n/XOk
0VmEjXYQR/rIFX96pLAnDTLJcUSmGhY+WXSSx5Nok89WVmhJWkOZ1YifOwx5MNoP
U+nYHTboMsfvSU9IsJGPTAEHIC3yDR4ISXGw7yBAazQWil2GuJOjer774nkF/4Hf
Qmzptqxvk6nf5Ahlm61e7IciaqKIaf9v+s/ExJtbiOY8GmP1kFT76no08wp2Karb
pNot+vi0Y0kdCN5RYNjXNU/xI590cQ==
=RQaq
-----END PGP SIGNATURE-----

--QRBrRApp62RIayV1vGsrd324OZiNJKwjm--
