Received: from eggs.gnu.org ([2001:4830:134:3::10]:41837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZdTm-0004wg-Ms
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:05:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZdTi-0002zQ-Lk
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:05:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eZdTi-0002yE-C7
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:05:10 -0500
References: <1515637324-96034-1-git-send-email-mjc@sifive.com>
	<1515637324-96034-22-git-send-email-mjc@sifive.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e78a8a10-b46b-a9da-8c81-7dd48eb47b10@redhat.com>
Date: Thu, 11 Jan 2018 08:05:05 -0600
MIME-Version: 1.0
In-Reply-To: <1515637324-96034-22-git-send-email-mjc@sifive.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GS4KJOcNwlP5swg1WHAl94Vf7GSWW19il"
Subject: Re: [Qemu-devel] [PATCH v3 21/21] RISC-V Build Infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GS4KJOcNwlP5swg1WHAl94Vf7GSWW19il
From: Eric Blake <eblake@redhat.com>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 RISC-V Patches <patches@groups.riscv.org>
Message-ID: <e78a8a10-b46b-a9da-8c81-7dd48eb47b10@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 21/21] RISC-V Build Infrastructure
References: <1515637324-96034-1-git-send-email-mjc@sifive.com>
 <1515637324-96034-22-git-send-email-mjc@sifive.com>
In-Reply-To: <1515637324-96034-22-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/10/2018 08:22 PM, Michael Clark wrote:
> This adds RISC-V into the build system enabling the following targets:
>=20
> - riscv32-softmmu
> - riscv64-softmmu
> - riscv32-linux-user
> - riscv64-linux-user
>=20
> This adds defaults configs for RISC-V, enables the build for the RISC-V=

> CPU core, hardware, and Linux User Emulation. The 'qemu-binfmt-conf.sh'=

> script is updated to add the RISC-V ELF magic.
>=20
> +++ b/qapi-schema.json
> @@ -413,7 +413,7 @@
>  # Since: 2.6
>  ##
>  { 'enum': 'CpuInfoArch',
> -  'data': ['x86', 'sparc', 'ppc', 'mips', 'tricore', 'other' ] }
> +  'data': ['x86', 'sparc', 'ppc', 'mips', 'tricore', 'riscv', 'other' =
] }

Still missing documentation that riscv was added in 2.12 (see my
comments on v1).


> --- /dev/null
> +++ b/target/riscv/trace-events
> @@ -0,0 +1 @@
> +# See docs/devel/tracing.txt for syntax documentation.
>=20

Do we really need this file if you don't have any traces yet?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--GS4KJOcNwlP5swg1WHAl94Vf7GSWW19il
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpXbxEACgkQp6FrSiUn
Q2r1aQf/Rr21KcgJDVFl20FAt4qZ5Gc/9wvUJHo0eY75cjEt3nfmfWmeyp2NUFAu
MlL79/IDBtWrIYjpHXXWodKXJtf8UwW7OlHSZ96jjqSTGZgx3EDpgCUvqUHyptCS
CkrPpw3FdEjUGRvwfeWCOzQ/kGQFmLc9h9j+sZG0nSWqBEhHA0loFwVajDqpjGaq
/x9Fq5NsU42Q/SYXe3NRTDRLHgYK7WQ3O//Ur+XceVlAr3+dzksNnnF1KetGn6z8
ovo3i6ExkQAeoXaNjhze8uN5Pz+G+53Gq8UTneUCzOgxQmCDKy09bPIRwJEiG8yu
Hi1PEypD9eolxgTD5URqAdjaEFm+7g==
=O9tr
-----END PGP SIGNATURE-----

--GS4KJOcNwlP5swg1WHAl94Vf7GSWW19il--
