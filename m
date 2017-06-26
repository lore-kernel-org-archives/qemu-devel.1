Received: from eggs.gnu.org ([2001:4830:134:3::10]:38520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <boqun.feng@gmail.com>) id 1dPIiJ-0003op-MG
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 21:21:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <boqun.feng@gmail.com>) id 1dPIiG-00066t-Fs
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 21:21:15 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:33763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <boqun.feng@gmail.com>)
	id 1dPIiG-00066A-7h
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 21:21:12 -0400
Received: by mail-pf0-x243.google.com with SMTP id e199so5358119pfh.0
	for <qemu-devel@nongnu.org>; Sun, 25 Jun 2017 18:21:10 -0700 (PDT)
Date: Mon, 26 Jun 2017 09:23:00 +0800
From: Boqun Feng <boqun.feng@gmail.com>
Message-ID: <20170626012144.3ucwsxfcchyba3wv@tardis>
References: <20170621052935.20715-1-boqun.feng@gmail.com>
	<20170623133814.GE11773@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="imvdfk3gbmm47i6v"
Content-Disposition: inline
In-Reply-To: <20170623133814.GE11773@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH] target-i386: add Skylake-Server cpu model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>


--imvdfk3gbmm47i6v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 23, 2017 at 10:38:14AM -0300, Eduardo Habkost wrote:
> On Wed, Jun 21, 2017 at 01:29:34PM +0800, Boqun Feng (Intel) wrote:
> > Introduce Skylake-Server cpu mode which inherits the features from
> > Skylake-Client and supports some additional features that are: AVX512,
> > CWLB and PGPE1GB.
>=20
> I will fix this to "CLWB" when applying the patch.
>=20

Oops.. thank you for pointing this out.

> >=20
> > Signed-off-by: Boqun Feng (Intel) <boqun.feng@gmail.com>
> > ---
> >  target/i386/cpu.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> >=20
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index b2b1d20cee51..1bed722ac2fd 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -1349,6 +1349,48 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
> >          .model_id =3D "Intel Core Processor (Skylake)",
> >      },
> >      {
> > +        .name =3D "Skylake-Server",
> > +        .level =3D 0xd,
> > +        .vendor =3D CPUID_VENDOR_INTEL,
> > +        .family =3D 6,
> > +        .model =3D 85,
> > +        .stepping =3D 4,
> > +        .features[FEAT_1_EDX] =3D
> > +            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MM=
X |
> > +            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPU=
ID_MCA |
> > +            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX=
8 |
> > +            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
> > +            CPUID_DE | CPUID_FP87,
> > +        .features[FEAT_1_ECX] =3D
> > +            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
> > +            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
> > +            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
> > +            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
> > +            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA | CPUID_EXT_M=
OVBE |
> > +            CPUID_EXT_PCID | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
> > +        .features[FEAT_8000_0001_EDX] =3D
> > +            CPUID_EXT2_LM | CPUID_EXT2_PDPE1GB | CPUID_EXT2_RDTSCP |
> > +            CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
> > +        .features[FEAT_8000_0001_ECX] =3D
> > +            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM | CPUID_EXT3_3DNOWPREF=
ETCH,
> > +        .features[FEAT_7_0_EBX] =3D
> > +            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
> > +            CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SME=
P |
> > +            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_IN=
VPCID |
> > +            CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_A=
DX |
> > +            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_CLW=
B |
> > +            CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
> > +            CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
> > +            CPUID_7_0_EBX_AVX512VL,
>=20
> I believe we should add the same comment about XSAVES from
> Skylake-Cliente here, for consistency:
>=20
>         /* Missing: XSAVES (not supported by some Linux versions,
>          * including v4.1 to v4.6).
>          * KVM doesn't yet expose any XSAVES state save component,
>          * and the only one defined in Skylake (processor tracing)
>          * probably will block migration anyway.
>          */
>=20

Make sense.

> I can add it when applying the patch.
>=20

Please do, thanks! Or you prefer that I send out a V2 with typo fixed
and comment added?

Regards,
Boqun

> > +        .features[FEAT_XSAVE] =3D
> > +            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
> > +            CPUID_XSAVE_XGETBV1,
> > +        .features[FEAT_6_EAX] =3D
> > +            CPUID_6_EAX_ARAT,
> > +        .xlevel =3D 0x80000008,
> > +        .model_id =3D "Intel Xeon Processor (Skylake)",
> > +    },
> > +    {
> >          .name =3D "Opteron_G1",
> >          .level =3D 5,
> >          .vendor =3D CPUID_VENDOR_AMD,
> > --=20
> > 2.13.1
> >=20
>=20
> --=20
> Eduardo

--imvdfk3gbmm47i6v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAllQYfEACgkQSXnow7UH
+rhFJQf/aJT9LVXGPL6XX7Dz4W3q9pNnsSJ0Dd/VMGU2ezFMoOMJvrrVcbta9RFl
KzHPU6fL0HypTE+kokCKJDnZHuBaXUP0eHIRwjg4XdW/ZtkcSv0tvF1p498ZvGSF
BaBMhhpkAv60addrWtAZVfLFZJ9lN9ZZvzvZB+dFjQVc1X0YhyzE9MKyDr1MxRDT
GmdS3KzsSGxZi14LKJxE2mT4gMhM/5ysPCFuXT2JyGZl3LNL9EweKtM4luq5WI3Z
nqAxdnqssLCn3iztlcZjeFarHVpu5tVzqDoRzm2U+my+itNB+8tWAsbcsffTytL8
YKmChJ4P6xPPcwgKJyt7s+8QxN3XQg==
=+8gj
-----END PGP SIGNATURE-----

--imvdfk3gbmm47i6v--
