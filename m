Received: from eggs.gnu.org ([2001:4830:134:3::10]:44485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB6UT-0005NC-Gp
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 18:32:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB6UN-0007IF-P5
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 18:32:49 -0400
References: <20180424214550.32549-1-lersek@redhat.com>
	<20180424214550.32549-3-lersek@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a1cd9e50-9379-1523-c5c8-9b6a29e01491@redhat.com>
Date: Tue, 24 Apr 2018 17:32:41 -0500
MIME-Version: 1.0
In-Reply-To: <20180424214550.32549-3-lersek@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WEiVG4RDKG3Sy7a5AdkgKltg2FrbKA8Nu"
Subject: Re: [Qemu-devel] [PATCH 2/6] qapi: handle the riscv CpuInfoArch in
 query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>, Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WEiVG4RDKG3Sy7a5AdkgKltg2FrbKA8Nu
From: Eric Blake <eblake@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>,
 Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-stable@nongnu.org
Message-ID: <a1cd9e50-9379-1523-c5c8-9b6a29e01491@redhat.com>
Subject: Re: [PATCH 2/6] qapi: handle the riscv CpuInfoArch in query-cpus-fast
References: <20180424214550.32549-1-lersek@redhat.com>
 <20180424214550.32549-3-lersek@redhat.com>
In-Reply-To: <20180424214550.32549-3-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/24/2018 04:45 PM, Laszlo Ersek wrote:
> Commit 25fa194b7b11 added the @riscv enum constant to @CpuInfoArch (use=
d
> in both @CpuInfo and @CpuInfoFast -- the return types of the @query-cpu=
s
> and @query-cpus-fast commands, respectively), and assigned, in both ret=
urn
> structures, the @CpuInfoRISCV sub-structure to the new enum value.
>=20
> However, qmp_query_cpus_fast() would not populate either the @arch fiel=
d
> or the @CpuInfoRISCV sub-structure, when TARGET_RISCV was defined; only=

> qmp_query_cpus() would.
>=20
> In theory, there are two ways to fix this:
>=20
> (a) Fill in both the @arch field and the @CpuInfoRISCV sub-structure in=

>     qmp_query_cpus_fast(), by copying the logic from qmp_query_cpus().
>=20
> (b) Assign @CpuInfoOther to the @riscv enum constant in @CpuInfoFast, a=
nd
>     populate only the @arch field in qmp_query_cpus_fast().
>=20
> Approach (b) seems more robust, because:
>=20
> - clearly there has never been an attempt to get actual RISV CPU state
>   from qmp_query_cpus_fast(), so its lack of RISCV support is not actua=
lly
>   a problem,
>=20
> - getting CPU state without interrupting KVM looks like an exceptional
>   thing to do (only S390X does it currently).
>=20
=2E..
> Cc: qemu-stable@nongnu.org
> Fixes: 25fa194b7b11901561532e435beb83d046899f7a
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--WEiVG4RDKG3Sy7a5AdkgKltg2FrbKA8Nu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrfsIkACgkQp6FrSiUn
Q2pWQwgAnBq/A+s5T+nxPh1u0B9IKAow9LqdMOVIJCgQsxzNSbBBhXS8/ewPBKgf
dTwunBULOWH6ANmsWIXDr8jkXyuA0iRQv0UmOnIy0nNyJHn1fyB8NcpOBR0gk3Rb
+J/kjf6mwjC8TZBgxb1Wo8XfGFHieXUzc7P/lLjZ1aybdVDC30SG/FgkB6m/+9BZ
q0wkztbXhciINYpJy5WDvipIl4Fvm0z9EI2E6yqzQXvTjLrIsxn9tI/tAje0ZwTB
SBo6P/nKNHHPqtrNphzjSMSEonnkhlF+1ngZo0kvo/wiooQw6WoO0xd0ImjnAnwU
DKZs1bhOz4sp9pA5Ny0ivy+s8RfmLg==
=sI72
-----END PGP SIGNATURE-----

--WEiVG4RDKG3Sy7a5AdkgKltg2FrbKA8Nu--
