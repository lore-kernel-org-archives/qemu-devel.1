Received: from eggs.gnu.org ([2001:4830:134:3::10]:59988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fTZ3a-0004Ht-Bl
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fTZ3V-0007l8-KN
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:41:22 -0400
Received: from mail-sn1nam01on0068.outbound.protection.outlook.com
	([104.47.32.68]:18784
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fTZ3V-0007jn-3j
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:41:17 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Thu, 14 Jun 2018 20:41:14 +0000
Message-ID: <DM5PR12MB24711B87385BD36335447CC7957D0@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <1528939107-17193-1-git-send-email-babu.moger@amd.com>
	<1528939107-17193-3-git-send-email-babu.moger@amd.com>
	<20180614184019.GV7451@localhost.localdomain>
In-Reply-To: <20180614184019.GV7451@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v14 2/6] i386: Enable TOPOEXT feature on
 AMD EPYC CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kash@tripleback.net" <kash@tripleback.net>, "geoff@hostfission.com" <geoff@hostfission.com>



> -----Original Message-----
> From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> Sent: Thursday, June 14, 2018 1:40 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: mst@redhat.com; marcel.apfelbaum@gmail.com; pbonzini@redhat.com;
> rth@twiddle.net; mtosatti@redhat.com; qemu-devel@nongnu.org;
> kvm@vger.kernel.org; kash@tripleback.net; geoff@hostfission.com
> Subject: Re: [PATCH v14 2/6] i386: Enable TOPOEXT feature on AMD EPYC
> CPU
>=20
> On Wed, Jun 13, 2018 at 09:18:23PM -0400, Babu Moger wrote:
> > Enable TOPOEXT feature on EPYC CPU. This is required to support
> > hyperthreading on VM guests. Also extend xlevel to 0x8000001E.
> >
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> >  target/i386/cpu.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 86fb1a4..2eb26da 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -2554,7 +2554,8 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
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
> > @@ -2599,7 +2600,8 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
> >          .features[FEAT_8000_0001_ECX] =3D
> >              CPUID_EXT3_OSVW | CPUID_EXT3_3DNOWPREFETCH |
> >              CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A |
> CPUID_EXT3_ABM |
> > -            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM,
> > +            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM
> |
> > +            CPUID_EXT3_TOPOEXT,
> >          .features[FEAT_8000_0008_EBX] =3D
> >              CPUID_8000_0008_EBX_IBPB,
> >          .features[FEAT_7_0_EBX] =3D
>=20
> This part is OK, but it requires patch 3/6 to be included in the
> same patch.

Ok. Sure.
>=20
> > @@ -4667,6 +4669,11 @@ static void x86_cpu_expand_features(X86CPU
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
>=20
> This part needs to be done more carefully to avoid breaking
> compatibility.  "-machine pc-q35-2.12 -cpu Opteron_G5,+topoext"
> currently results in xlevel=3D0x8000001A, and this must not change.
Ok.
>=20
> I suggest just changing setting .xlevel=3D0x8000001E on EPYC at
> builtin_x86_defs[1], and worry about automatically increasing
> xlevel later.
Ok.
>=20
> (If you change EPYC.xlevel in builtin_x86_defs, don't forget to
> set EPYC.xlevel=3D0x8000000A on PC_COMPAT_2_12)
Sure.
>=20
> --
> Eduardo
