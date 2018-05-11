Received: from eggs.gnu.org ([2001:4830:134:3::10]:40360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fHGLQ-0003bm-HE
	for qemu-devel@nongnu.org; Fri, 11 May 2018 18:16:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fHGLM-0002GP-KX
	for qemu-devel@nongnu.org; Fri, 11 May 2018 18:16:56 -0400
Received: from mail-co1nam03on0613.outbound.protection.outlook.com
	([2a01:111:f400:fe48::613]:19168
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fHGLM-0002Ey-6H
	for qemu-devel@nongnu.org; Fri, 11 May 2018 18:16:52 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Fri, 11 May 2018 22:16:46 +0000
Message-ID: <BL0PR12MB2468A53AFC7B1BE849EC2F3F959F0@BL0PR12MB2468.namprd12.prod.outlook.com>
References: <20180510204148.11687-1-babu.moger@amd.com>
	<20180510204148.11687-8-babu.moger@amd.com>
	<20180511204648.GO13350@localhost.localdomain>
In-Reply-To: <20180511204648.GO13350@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v8 7/8] i386: Enable TOPOEXT feature on AMD
 EPYC CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "geoff@hostfission.com" <geoff@hostfission.com>, "kash@tripleback.net" <kash@tripleback.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>



> -----Original Message-----
> From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> Sent: Friday, May 11, 2018 3:47 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: mst@redhat.com; marcel.apfelbaum@gmail.com; pbonzini@redhat.com;
> rth@twiddle.net; mtosatti@redhat.com; geoff@hostfission.com;
> kash@tripleback.net; qemu-devel@nongnu.org; kvm@vger.kernel.org
> Subject: Re: [Qemu-devel] [PATCH v8 7/8] i386: Enable TOPOEXT feature on
> AMD EPYC CPU
>=20
> On Thu, May 10, 2018 at 03:41:47PM -0500, Babu Moger wrote:
> > Enable TOPOEXT feature on EPYC CPU. This is required to support
> > hyperthreading on VM guests. Also extend xlevel to 0x8000001E.
> >
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > Tested-by: Geoffrey McRae <geoff@hostfission.com>
> > Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  target/i386/cpu.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 5cfc7bb0e1..575f2416a1 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -2382,7 +2382,8 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
> >          .features[FEAT_8000_0001_ECX] =3D
> >              CPUID_EXT3_OSVW | CPUID_EXT3_3DNOWPREFETCH |
> >              CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A |
> CPUID_EXT3_ABM |
> > -            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM,
> > +            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM
> |
> > +            CPUID_EXT3_TOPOEXT,
> >          .features[FEAT_7_0_EBX] =3D
> >              CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
> CPUID_7_0_EBX_AVX2 |
> >              CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 |
> CPUID_7_0_EBX_RDSEED |
> > @@ -2427,7 +2428,8 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
> >          .features[FEAT_8000_0001_ECX] =3D
> >              CPUID_EXT3_OSVW | CPUID_EXT3_3DNOWPREFETCH |
> >              CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A |
> CPUID_EXT3_ABM |
> > -            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM,
> > +            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM
> |
> > +            CPUID_EXT3_TOPOEXT,
>=20
> I forgot about one thing: you'll need to add EPYC.topoext=3Doff and
> EPYC-IBPB.topoext=3Doff to PC_COMPAT_2_12.

Ok. Will add it.

>=20
> >          .features[FEAT_8000_0008_EBX] =3D
> >              CPUID_8000_0008_EBX_IBPB,
> >          .features[FEAT_7_0_EBX] =3D
> > @@ -4540,6 +4542,11 @@ static void x86_cpu_expand_features(X86CPU
> *cpu, Error **errp)
> >              x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x800000=
0A);
> >          }
> >
> > +        /* TOPOEXT feature requires 0x8000001E */
> > +        if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) {
> > +            x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x800000=
1E);
> > +        }
> > +
> >          /* SEV requires CPUID[0x8000001F] */
> >          if (sev_enabled()) {
> >              x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x800000=
1F);
> > --
> > 2.17.0
> >
> >
>=20
> --
> Eduardo
