Received: from eggs.gnu.org ([2001:4830:134:3::10]:34318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1gaVi8-0006k6-2Q
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 20:04:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1gaVhq-0000nA-3R
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 20:04:00 -0500
Message-ID: <1545440514.44118.11.camel@linux.intel.com>
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Sat, 22 Dec 2018 09:01:54 +0800
In-Reply-To: <faa89439-18ae-931b-54c7-212b7dea0e48@redhat.com>
References: <20181221063002.7570-1-pbonzini@redhat.com>
	<cb7a9fc9-cded-7ca5-dbb9-8ffde9670fa7@redhat.com>
	<faa89439-18ae-931b-54c7-212b7dea0e48@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] i386: remove the 'INTEL_PT' CPUID bit from
 named CPU models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, qemu-devel@nongnu.org, luwei.kang@intel.com
Cc: robert.hu@intel.com, robert.hu@linux.intel.com, qemu-stable@nongnu.org

On Fri, 2018-12-21 at 16:27 +0100, Paolo Bonzini wrote:
> On 21/12/18 16:22, Philippe Mathieu-Daudé wrote:
> > Hi Paolo,
> > 
> > On 12/21/18 7:30 AM, Paolo Bonzini wrote:
> > > From: Robert Hoo <robert.hu@linux.intel.com>
> > > 
> > > Processor tracing is not yet implemented for KVM and it will be
> > > an
> > > opt in feature requiring a special module parameter.
> > > Disable it, because it is wrong to enable it by default and
> > > it is impossible that no one has ever used it.
> > > 
> > > Cc: qemu-stable@nongnu.org
> > 
> > Does this patch misses Robert S-o-b?
> > Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>

Paolo's right. It didn't come from me.
> 
> No, the author is wrong, it should be me.  "git commit -c" apparently
> copies the author from the original commit.
> 
> Paolo

Hi Paolo, would you hold on INTEL_PT removal for a moment? I think I
need Luwei's double confirm.
(Added him in receiver list.)
> 
> > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > > ---
> > >  target/i386/cpu.c | 8 +++-----
> > >  1 file changed, 3 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > > index dae46f0319..9c54c41e7a 100644
> > > --- a/target/i386/cpu.c
> > > +++ b/target/i386/cpu.c
> > > @@ -2493,8 +2493,7 @@ static X86CPUDefinition builtin_x86_defs[]
> > > = {
> > >              CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLWB |
> > >              CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
> > >              CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
> > > -            CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT |
> > > -            CPUID_7_0_EBX_INTEL_PT,
> > > +            CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT,
> > >          .features[FEAT_7_0_ECX] =
> > >              CPUID_7_0_ECX_PKU | CPUID_7_0_ECX_OSPKE |
> > >              CPUID_7_0_ECX_AVX512VNNI,
> > > @@ -2546,7 +2545,7 @@ static X86CPUDefinition builtin_x86_defs[]
> > > = {
> > >              CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 |
> > > CPUID_7_0_EBX_SMEP |
> > >              CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS |
> > > CPUID_7_0_EBX_INVPCID |
> > >              CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED |
> > > CPUID_7_0_EBX_ADX |
> > > -            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_INTEL_PT,
> > > +            CPUID_7_0_EBX_SMAP,
> > >          .features[FEAT_7_0_ECX] =
> > >              CPUID_7_0_ECX_VBMI | CPUID_7_0_ECX_UMIP |
> > > CPUID_7_0_ECX_PKU |
> > >              CPUID_7_0_ECX_OSPKE | CPUID_7_0_ECX_VBMI2 |
> > > CPUID_7_0_ECX_GFNI |
> > > @@ -2604,8 +2603,7 @@ static X86CPUDefinition builtin_x86_defs[]
> > > = {
> > >              CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLWB |
> > >              CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
> > >              CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
> > > -            CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT |
> > > -            CPUID_7_0_EBX_INTEL_PT,
> > > +            CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT,
> > >          .features[FEAT_7_0_ECX] =
> > >              CPUID_7_0_ECX_VBMI | CPUID_7_0_ECX_UMIP |
> > > CPUID_7_0_ECX_PKU |
> > >              CPUID_7_0_ECX_OSPKE | CPUID_7_0_ECX_VBMI2 |
> > > CPUID_7_0_ECX_GFNI |
> > > 
> 
> 
