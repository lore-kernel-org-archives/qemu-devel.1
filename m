Received: from eggs.gnu.org ([2001:4830:134:3::10]:49027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daUI7-0004mR-KQ
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:56:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daUI3-0007X3-Or
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:56:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1daUI3-0007WN-Fs
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:56:23 -0400
References: <150110567183.114.17390976982809714249@5d477a5b5989>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6ccbdea1-be5e-2dbe-d84a-314fc2d6f666@redhat.com>
Date: Wed, 26 Jul 2017 16:56:18 -0500
MIME-Version: 1.0
In-Reply-To: <150110567183.114.17390976982809714249@5d477a5b5989>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7OsM9CDoclOIUqEPPL21NvVsNfCo1Ss37"
Subject: Re: [Qemu-devel] [PATCH for 2.10 0/4] check dtc submodule is
 outdated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, no-reply@patchew.org, f4bug@amsat.org
Cc: peter.maydell@linaro.org, james.hogan@imgtec.com, famz@redhat.com, quintela@redhat.com, crosthwaite.peter@gmail.com, programmingkidx@gmail.com, yongbok.kim@imgtec.com, pbonzini@redhat.com, aurelien@aurel32.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7OsM9CDoclOIUqEPPL21NvVsNfCo1Ss37
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org, no-reply@patchew.org, f4bug@amsat.org
Cc: peter.maydell@linaro.org, james.hogan@imgtec.com, famz@redhat.com,
 quintela@redhat.com, crosthwaite.peter@gmail.com, programmingkidx@gmail.com,
 yongbok.kim@imgtec.com, pbonzini@redhat.com, aurelien@aurel32.net
Message-ID: <6ccbdea1-be5e-2dbe-d84a-314fc2d6f666@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.10 0/4] check dtc submodule is outdated
References: <150110567183.114.17390976982809714249@5d477a5b5989>
In-Reply-To: <150110567183.114.17390976982809714249@5d477a5b5989>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/26/2017 04:47 PM, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed build test on s390x host. Please find the details be=
low.
>=20
> Type: series
> Subject: [Qemu-devel] [PATCH for 2.10 0/4] check dtc submodule is outda=
ted
> Message-id: 20170726214010.420-1-f4bug@amsat.org
>=20

> =3D=3D=3D TEST BEGIN =3D=3D=3D
> Using CC: /home/fam/bin/cc
>=20
> ERROR: fdt disabled but some requested targets require it.
>        You can turn off fdt only if you also disable all the system emu=
lation
>        targets which need it (by specifying a cut down --target-list).

Well, your new configure check certainly fired!  The question is whether
it was supposed to (meaning patchew needs to tweak what it tries to
configure), or whether there's a logic bug in your patch (meaning it
fails when it shouldn't have).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--7OsM9CDoclOIUqEPPL21NvVsNfCo1Ss37
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll5EAIACgkQp6FrSiUn
Q2oVEwf/ZLjKlWmm21dDIqntrZxPOUYMt6dp4v2gHXMOx5LSZcuekx+SCu+47UGM
XjrLGNEUxux3CWMst6nuhgWUwSByo/UeIO4pnb1NJB1U5zZDRyw2ZaE8TZ6uftxx
UgNNakvp2ZQrLBCeZMrH4dg+jsP69ktpBWijh6hnQB7KUUcadzKsyxas5ryfyYs5
YkJV6cu8xlR0lQlzmSSlsDMfezIE5hiUomJFg2aaGnXhxaDqi0lP4i+GiUt2IPS6
g4lKhA80/almMiQ1jRhb6S+vHJ3u3W87CWZPzubJwfzw2WB+IFldA6RAc/KT2Mdy
LvYmJtEf52FlRcKk8LPaFKtSHwBoLQ==
=CWqF
-----END PGP SIGNATURE-----

--7OsM9CDoclOIUqEPPL21NvVsNfCo1Ss37--
