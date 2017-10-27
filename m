Received: from eggs.gnu.org ([2001:4830:134:3::10]:48598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e86E9-0000r4-8q
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 11:07:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e86E3-000483-JZ
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 11:07:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e86E3-000479-An
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 11:07:11 -0400
References: <20171025123056.3165-1-richard.henderson@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b6d296a7-68dc-d1a7-61f1-872d76e770f9@redhat.com>
Date: Fri, 27 Oct 2017 17:07:03 +0200
MIME-Version: 1.0
In-Reply-To: <20171025123056.3165-1-richard.henderson@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3EftfCalgjg2q38p9sD6QusdDSnTu0wro"
Subject: Re: [Qemu-devel] [PULL 00/11] Disassembler patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3EftfCalgjg2q38p9sD6QusdDSnTu0wro
From: Eric Blake <eblake@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Message-ID: <b6d296a7-68dc-d1a7-61f1-872d76e770f9@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/11] Disassembler patches
References: <20171025123056.3165-1-richard.henderson@linaro.org>
In-Reply-To: <20171025123056.3165-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/25/2017 02:30 PM, Richard Henderson wrote:
> Support for Capstone, plus an arm32 fix.
>=20

> ----------------------------------------------------------------
> Capstone disassembler
>=20
> ----------------------------------------------------------------
> Richard Henderson (11):
>       target/i386: Convert to disas_set_info hook
>       target/ppc: Convert to disas_set_info hook
>       target/arm: Move BE32 disassembler fixup
>       target/arm: Don't set INSN_ARM_BE32 for CONFIG_USER_ONLY
>       disas: Remove unused flags arguments
>       disas: Support the Capstone disassembler library
>       i386: Support Capstone in disas_set_info
>       arm: Support Capstone in disas_set_info
>       ppc: Support Capstone in disas_set_info
>       disas: Remove monitor_disas_is_physical
>       disas: Add capstone as submodule

I think (but haven't bisected) that this series is now making 'make' nois=
y:

$ make -j3 qemu-nbd
make[1]: '/home/eblake/qemu-tmp/capstone/libcapstone.a' is up to date.
make: 'qemu-nbd' is up to date.

Can we figure out how to shut up make when libcapstone.a has nothing need=
ed?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3EftfCalgjg2q38p9sD6QusdDSnTu0wro
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnzS5cACgkQp6FrSiUn
Q2r92wgAmDuJt2EB3zx0ifRBkFB1Bcro5mIPMgis7hLtkAdhLFXSB4GPUIIKtdtj
LqSJwSnpaatAshqlJ72YObDL7hn5D9NB49+26zEEd8eUvI6KOZhYmNERYT/+9+5J
22m7kyjyebYU9YaLuUbbk44TH33hkv6SiFCeYzKuNNxxUAIInUz5nsk+4ZilWemu
llzBz+XsZMfD/xDk5hmkgG6pyMoUrhZkM8hAmKbO8x4+zDOWvCDl8uXgRXZJyTKz
d3s6W06Zz0GFcP2SKWYwpQvpvS2giEQ6ozckPU7omU+IZNpLNYe/pRMBeMUOXFin
h1cOhFfbkYCleLXtwWFAEHLt1QYf+A==
=GrdU
-----END PGP SIGNATURE-----

--3EftfCalgjg2q38p9sD6QusdDSnTu0wro--
