Received: from eggs.gnu.org ([2001:4830:134:3::10]:38976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1gAPk5-0003qA-Mx
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 21:26:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1gAPk2-00066I-As
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 21:26:21 -0400
Received: from mga14.intel.com ([192.55.52.115]:27481)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
	id 1gAPk0-00064l-98
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 21:26:17 -0400
From: "Liu, Jingqi" <jingqi.liu@intel.com>
Date: Thu, 11 Oct 2018 01:22:41 +0000
Message-ID: <09D68D4CF52CAF489B702DEBDD12D3D3527FF817@SHSMSX103.ccr.corp.intel.com>
References: <20180919031122.28487-1-tao3.xu@intel.com>
	<20180919031122.28487-2-tao3.xu@intel.com>
	<09D68D4CF52CAF489B702DEBDD12D3D3527FD330@SHSMSX103.ccr.corp.intel.com>
	<20181010203511.GJ5738@habkost.net>
In-Reply-To: <20181010203511.GJ5738@habkost.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/1] i386: Add new model of
 Cascadelake-Server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Xu, Tao3" <tao3.xu@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Robert Hoo <robert.hu@linux.intel.com>

> -----Original Message-----
> From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> Sent: Thursday, October 11, 2018 4:35 AM
> To: Liu, Jingqi <jingqi.liu@intel.com>
> Cc: Xu, Tao3 <tao3.xu@intel.com>; pbonzini@redhat.com; rth@twiddle.net;
> qemu-devel@nongnu.org; Robert Hoo <robert.hu@linux.intel.com>
> Subject: Re: [PATCH 1/1] i386: Add new model of Cascadelake-Server
>=20
> On Wed, Oct 10, 2018 at 01:49:56AM +0000, Liu, Jingqi wrote:
> > Hi Eduardo/Paolo,
> >
> > Do you have any comments about this patch ?
>=20
> Thanks for the reminder and sorry for the delay.  I was waiting for MSR f=
eatures
> to be merged before including this CPU model.
>=20
> But considering that it's taking a while until we sort out the details, I=
'll review
> this so it can be merged first if necessary.

Hi Eduardo,

Thanks for your feedback.
No problem.  It's fine on your schedule.

Thanks
Jingqi
>=20
> >
> > Thanks
> > Jingqi
> >
> > > -----Original Message-----
> > > From: Xu, Tao3
> > > Sent: Wednesday, September 19, 2018 11:11 AM
> > > To: pbonzini@redhat.com; rth@twiddle.net; ehabkost@redhat.com
> > > Cc: qemu-devel@nongnu.org; Liu, Jingqi <jingqi.liu@intel.com>; Xu,
> > > Tao3 <tao3.xu@intel.com>
> > > Subject: [PATCH 1/1] i386: Add new model of Cascadelake-Server
> > >
> > > New CPU models mostly inherit features from ancestor Skylake-Server,
> > > while addin new features: AVX512_VNNI, Intel PT.
> > > SSBD support for speculative execution side channel mitigations.
> > >
> > > Note:
> > >
> > > On Cascadelake, some capabilities (RDCL_NO, IBRS_ALL, RSBA,
> > > SKIP_L1DFL_VMENTRY and SSB_NO) are enumerated by MSR.
> > > These features rely on MSR based feature support patch.
> > > Will be added later after that patch's in.
> > > http://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg00074.htm
> > > l
> > >
> > > Signed-off-by: Tao Xu <tao3.xu@intel.com>
> > > ---
> > >  target/i386/cpu.c | 54
> > > +++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 54 insertions(+)
> > >
> > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c index
> > > f24295e6e4..670898f32d 100644
> > > --- a/target/i386/cpu.c
> > > +++ b/target/i386/cpu.c
> > > @@ -2386,6 +2386,60 @@ static X86CPUDefinition builtin_x86_defs[] =3D=
 {
> > >          .xlevel =3D 0x80000008,
> > >          .model_id =3D "Intel Xeon Processor (Skylake, IBRS)",
> > >      },
> > > +    {
> > > +        .name =3D "Cascadelake-Server",
> > > +        .level =3D 0xd,
> > > +        .vendor =3D CPUID_VENDOR_INTEL,
> > > +        .family =3D 6,
> > > +        .model =3D 85,
> > > +        .stepping =3D 5,
> > > +        .features[FEAT_1_EDX] =3D
> > > +            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR |
> CPUID_MMX |
> > > +            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV |
> > > CPUID_MCA |
> > > +            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_=
CX8
> |
> > > +            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PS=
E |
> > > +            CPUID_DE | CPUID_FP87,
> > > +        .features[FEAT_1_ECX] =3D
> > > +            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
> > > +            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
> > > +            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
> > > +            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
> > > +            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA |
> > > CPUID_EXT_MOVBE |
> > > +            CPUID_EXT_PCID | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
> > > +        .features[FEAT_8000_0001_EDX] =3D
> > > +            CPUID_EXT2_LM | CPUID_EXT2_PDPE1GB | CPUID_EXT2_RDTSCP |
> > > +            CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
> > > +        .features[FEAT_8000_0001_ECX] =3D
> > > +            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM |
> > > CPUID_EXT3_3DNOWPREFETCH,
> > > +        .features[FEAT_7_0_EBX] =3D
> > > +            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
> > > +            CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 |
> > > + CPUID_7_0_EBX_SMEP
> > > |
> > > +            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS |
> > > CPUID_7_0_EBX_INVPCID |
> > > +            CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED |
> > > CPUID_7_0_EBX_ADX |
> > > +            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_MPX |
> > > CPUID_7_0_EBX_CLWB |
> > > +            CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
> > > +            CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
> > > +            CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT |
> > > +            CPUID_7_0_EBX_INTEL_PT,
> > > +        .features[FEAT_7_0_ECX] =3D
> > > +            CPUID_7_0_ECX_PKU | CPUID_7_0_ECX_OSPKE |
> > > +            CPUID_7_0_ECX_AVX512VNNI,
> > > +        .features[FEAT_7_0_EDX] =3D
> > > +            CPUID_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_SPEC_CTRL_SSBD,
> > > +        /* Missing: XSAVES (not supported by some Linux versions,
> > > +                * including v4.1 to v4.12).
> > > +                * KVM doesn't yet expose any XSAVES state save compo=
nent,
> > > +                * and the only one defined in Skylake (processor tra=
cing)
> > > +                * probably will block migration anyway.
> > > +                */
> > > +        .features[FEAT_XSAVE] =3D
> > > +            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
> > > +            CPUID_XSAVE_XGETBV1,
> > > +        .features[FEAT_6_EAX] =3D
> > > +            CPUID_6_EAX_ARAT,
> > > +        .xlevel =3D 0x80000008,
> > > +        .model_id =3D "Intel Xeon Processor (Cascadelake)",
> > > +    },
> > >      {
> > >          .name =3D "Icelake-Client",
> > >          .level =3D 0xd,
> > > --
> > > 2.17.1
> >
>=20
> --
> Eduardo
