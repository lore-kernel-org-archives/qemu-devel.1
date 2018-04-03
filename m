Received: from eggs.gnu.org ([2001:4830:134:3::10]:36271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f3BfG-0007jA-6s
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 22:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f3BfD-0005NL-3u
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 22:27:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f3BfC-0005Mq-RO
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 22:27:11 -0400
Date: Mon, 2 Apr 2018 23:27:08 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180403022708.GO5046@localhost.localdomain>
References: <20180320000821.8337-1-boqun.feng@intel.com>
	<20180402051429.GB453@dragonstone>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180402051429.GB453@dragonstone>
Subject: Re: [Qemu-devel] [PATCH v2] i386: add KnightsMill cpu model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Boqun Feng <boqun.feng@intel.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, chao.p.peng@intel.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, Apr 02, 2018 at 01:14:30PM +0800, Boqun Feng wrote:
> Ping ;-)

It missed soft feature freeze (March 13th), so I will queue this
for 2.13.  Thanks!

> 
> Regards,
> Boqun
> 
> On Tue, Mar 20, 2018 at 08:08:15AM +0800, Boqun Feng wrote:
> > A new cpu model called "KnightsMill" is added to model Knights Mill
> > processors.  Compared to "Skylake-Server" cpu model, the following
> > features are added:
> > 
> > 	avx512_4vnniw avx512_4fmaps avx512pf avx512er avx512_vpopcntdq
> > 
> > and the following features are removed:
> > 
> > 	pcid invpcid clflushopt avx512dq avx512bw clwb smap rtm mpx
> > 	xsavec xgetbv1 hle
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@intel.com>
> > ---
> > v1 --> v2:
> > 
> > *	Change the model name to "KnightsMill" as per Daniel's
> > 	suggestion.
> > 
> >  target/i386/cpu.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 2c04645ceac9..c484afdb7023 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -1795,6 +1795,48 @@ static X86CPUDefinition builtin_x86_defs[] = {
> >          .xlevel = 0x80000008,
> >          .model_id = "Intel Xeon Processor (Skylake, IBRS)",
> >      },
> > +    {
> > +        .name = "KnightsMill",
> > +        .level = 0xd,
> > +        .vendor = CPUID_VENDOR_INTEL,
> > +        .family = 6,
> > +        .model = 133,
> > +        .stepping = 0,
> > +        .features[FEAT_1_EDX] =
> > +            CPUID_VME | CPUID_SS | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR |
> > +            CPUID_MMX | CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV |
> > +            CPUID_MCA | CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC |
> > +            CPUID_CX8 | CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC |
> > +            CPUID_PSE | CPUID_DE | CPUID_FP87,
> > +        .features[FEAT_1_ECX] =
> > +            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
> > +            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
> > +            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
> > +            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
> > +            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA | CPUID_EXT_MOVBE |
> > +            CPUID_EXT_F16C | CPUID_EXT_RDRAND,
> > +        .features[FEAT_8000_0001_EDX] =
> > +            CPUID_EXT2_LM | CPUID_EXT2_PDPE1GB | CPUID_EXT2_RDTSCP |
> > +            CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
> > +        .features[FEAT_8000_0001_ECX] =
> > +            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM | CPUID_EXT3_3DNOWPREFETCH,
> > +        .features[FEAT_7_0_EBX] =
> > +            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_AVX2 |
> > +            CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS |
> > +            CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX | CPUID_7_0_EBX_AVX512F |
> > +            CPUID_7_0_EBX_AVX512CD | CPUID_7_0_EBX_AVX512PF |
> > +            CPUID_7_0_EBX_AVX512ER,
> > +        .features[FEAT_7_0_ECX] =
> > +            CPUID_7_0_ECX_AVX512_VPOPCNTDQ,
> > +        .features[FEAT_7_0_EDX] =
> > +            CPUID_7_0_EDX_AVX512_4VNNIW | CPUID_7_0_EDX_AVX512_4FMAPS,
> > +        .features[FEAT_XSAVE] =
> > +            CPUID_XSAVE_XSAVEOPT,
> > +        .features[FEAT_6_EAX] =
> > +            CPUID_6_EAX_ARAT,
> > +        .xlevel = 0x80000008,
> > +        .model_id = "Intel Xeon Phi Processor (Knights Mill)",
> > +    },
> >      {
> >          .name = "Opteron_G1",
> >          .level = 5,
> > -- 
> > 2.16.1
> > 

-- 
Eduardo
