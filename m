Received: from eggs.gnu.org ([2001:4830:134:3::10]:39183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQbig-0004bw-AR
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 12:55:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQbic-0003wG-5M
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 12:55:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36952 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fQbib-0003vs-P9
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 12:55:30 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed,  6 Jun 2018 17:55:24 +0100
Message-Id: <20180606165527.17365-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] i386: improve output from "-cpu help"
 argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

This short series is a set of improvements to the "-cpu help" output for
the x86 emulator. The patches describe what's change in each step, but
it is best visualized by looking at before/after state.

Before:

   Available CPUs:
   x86              486
   x86   Broadwell-IBRS  Intel Core Processor (Broadwell, IBRS)
   x86 Broadwell-noTSX-IBRS  Intel Core Processor (Broadwell, no TSX, IBR=
S)
   x86  Broadwell-noTSX  Intel Core Processor (Broadwell, no TSX)
   x86        Broadwell  Intel Core Processor (Broadwell)
   x86           Conroe  Intel Celeron_4x0 (Conroe/Merom Class Core 2)
   x86        EPYC-IBPB  AMD EPYC Processor (with IBPB)
   x86             EPYC  AMD EPYC Processor
   x86     Haswell-IBRS  Intel Core Processor (Haswell, IBRS)
   x86 Haswell-noTSX-IBRS  Intel Core Processor (Haswell, no TSX, IBRS)
   x86    Haswell-noTSX  Intel Core Processor (Haswell, no TSX)
   x86          Haswell  Intel Core Processor (Haswell)
   x86   IvyBridge-IBRS  Intel Xeon E3-12xx v2 (Ivy Bridge, IBRS)
   x86        IvyBridge  Intel Xeon E3-12xx v2 (Ivy Bridge)
   x86     Nehalem-IBRS  Intel Core i7 9xx (Nehalem Core i7, IBRS update)
   x86          Nehalem  Intel Core i7 9xx (Nehalem Class Core i7)
   x86       Opteron_G1  AMD Opteron 240 (Gen 1 Class Opteron)
   x86       Opteron_G2  AMD Opteron 22xx (Gen 2 Class Opteron)
   x86       Opteron_G3  AMD Opteron 23xx (Gen 3 Class Opteron)
   x86       Opteron_G4  AMD Opteron 62xx class CPU
   x86       Opteron_G5  AMD Opteron 63xx class CPU
   x86           Penryn  Intel Core 2 Duo P9xxx (Penryn Class Core 2)
   x86 SandyBridge-IBRS  Intel Xeon E312xx (Sandy Bridge, IBRS update)
   x86      SandyBridge  Intel Xeon E312xx (Sandy Bridge)
   x86 Skylake-Client-IBRS  Intel Core Processor (Skylake, IBRS)
   x86   Skylake-Client  Intel Core Processor (Skylake)
   x86 Skylake-Server-IBRS  Intel Xeon Processor (Skylake, IBRS)
   x86   Skylake-Server  Intel Xeon Processor (Skylake)
   x86    Westmere-IBRS  Westmere E56xx/L56xx/X56xx (IBRS update)
   x86         Westmere  Westmere E56xx/L56xx/X56xx (Nehalem-C)
   x86           athlon  QEMU Virtual CPU version 2.5+
   x86         core2duo  Intel(R) Core(TM)2 Duo CPU     T7700  @ 2.40GHz
   x86          coreduo  Genuine Intel(R) CPU           T2600  @ 2.16GHz
   x86            kvm32  Common 32-bit KVM processor
   x86            kvm64  Common KVM processor
   x86             n270  Intel(R) Atom(TM) CPU N270   @ 1.60GHz
   x86          pentium
   x86         pentium2
   x86         pentium3
   x86           phenom  AMD Phenom(tm) 9550 Quad-Core Processor
   x86           qemu32  QEMU Virtual CPU version 2.5+
   x86           qemu64  QEMU Virtual CPU version 2.5+
   x86             base  base CPU model type with no features enabled
   x86             host  KVM processor with all supported host features (=
only available in KVM mode)
   x86              max  Enables all features supported by the accelerato=
r in the current host

   Recognized CPUID flags:
     fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat ps=
e36 pn clflush ds acpi mmx fxsr sse sse2 ss ht tm ia64 pbe
     pni pclmulqdq dtes64 monitor ds-cpl vmx smx est tm2 ssse3 cid fma cx=
16 xtpr pdcm pcid dca sse4.1 sse4.2 x2apic movbe popcnt tsc-deadline aes =
xsave osxsave avx f16c rdrand hypervisor
     fsgsbase tsc-adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm mpx avx=
512f avx512dq rdseed adx smap avx512ifma pcommit clflushopt clwb avx512pf=
 avx512er avx512cd sha-ni avx512bw avx512vl
     avx512vbmi umip pku ospke avx512-vpopcntdq la57 rdpid
     avx512-4vnniw avx512-4fmaps spec-ctrl
     syscall nx mmxext fxsr-opt pdpe1gb rdtscp lm 3dnowext 3dnow
     lahf-lm cmp-legacy svm extapic cr8legacy abm sse4a misalignsse 3dnow=
prefetch osvw ibs xop skinit wdt lwp fma4 tce nodeid-msr tbm topoext perf=
ctr-core perfctr-nb
     invtsc
     ibpb
     xstore xstore-en xcrypt xcrypt-en ace2 ace2-en phe phe-en pmm pmm-en
     kvmclock kvm-nopiodelay kvm-mmu kvmclock kvm-asyncpf kvm-steal-time =
kvm-pv-eoi kvm-pv-unhalt kvm-pv-tlb-flush kvmclock-stable-bit

     npt lbrv svm-lock nrip-save tsc-scale vmcb-clean flushbyasid decodea=
ssists pause-filter pfthreshold
     xsaveopt xsavec xgetbv1 xsaves
     arat

After:

   Available CPUs:
   x86 486
   x86 Broadwell             Intel Core Processor (Broadwell)
   x86 Broadwell-IBRS        Intel Core Processor (Broadwell, IBRS)
   x86 Broadwell-noTSX       Intel Core Processor (Broadwell, no TSX)
   x86 Broadwell-noTSX-IBRS  Intel Core Processor (Broadwell, no TSX, IBR=
S)
   x86 Conroe                Intel Celeron_4x0 (Conroe/Merom Class Core 2=
)
   x86 EPYC                  AMD EPYC Processor
   x86 EPYC-IBPB             AMD EPYC Processor (with IBPB)
   x86 Haswell               Intel Core Processor (Haswell)
   x86 Haswell-IBRS          Intel Core Processor (Haswell, IBRS)
   x86 Haswell-noTSX         Intel Core Processor (Haswell, no TSX)
   x86 Haswell-noTSX-IBRS    Intel Core Processor (Haswell, no TSX, IBRS)
   x86 IvyBridge             Intel Xeon E3-12xx v2 (Ivy Bridge)
   x86 IvyBridge-IBRS        Intel Xeon E3-12xx v2 (Ivy Bridge, IBRS)
   x86 Nehalem               Intel Core i7 9xx (Nehalem Class Core i7)
   x86 Nehalem-IBRS          Intel Core i7 9xx (Nehalem Core i7, IBRS upd=
ate)
   x86 Opteron_G1            AMD Opteron 240 (Gen 1 Class Opteron)
   x86 Opteron_G2            AMD Opteron 22xx (Gen 2 Class Opteron)
   x86 Opteron_G3            AMD Opteron 23xx (Gen 3 Class Opteron)
   x86 Opteron_G4            AMD Opteron 62xx class CPU
   x86 Opteron_G5            AMD Opteron 63xx class CPU
   x86 Penryn                Intel Core 2 Duo P9xxx (Penryn Class Core 2)
   x86 SandyBridge           Intel Xeon E312xx (Sandy Bridge)
   x86 SandyBridge-IBRS      Intel Xeon E312xx (Sandy Bridge, IBRS update=
)
   x86 Skylake-Client        Intel Core Processor (Skylake)
   x86 Skylake-Client-IBRS   Intel Core Processor (Skylake, IBRS)
   x86 Skylake-Server        Intel Xeon Processor (Skylake)
   x86 Skylake-Server-IBRS   Intel Xeon Processor (Skylake, IBRS)
   x86 Westmere              Westmere E56xx/L56xx/X56xx (Nehalem-C)
   x86 Westmere-IBRS         Westmere E56xx/L56xx/X56xx (IBRS update)
   x86 athlon                QEMU Virtual CPU version 2.5+
   x86 core2duo              Intel(R) Core(TM)2 Duo CPU     T7700  @ 2.40=
GHz
   x86 coreduo               Genuine Intel(R) CPU           T2600  @ 2.16=
GHz
   x86 kvm32                 Common 32-bit KVM processor
   x86 kvm64                 Common KVM processor
   x86 n270                  Intel(R) Atom(TM) CPU N270   @ 1.60GHz
   x86 pentium
   x86 pentium2
   x86 pentium3
   x86 phenom                AMD Phenom(tm) 9550 Quad-Core Processor
   x86 qemu32                QEMU Virtual CPU version 2.5+
   x86 qemu64                QEMU Virtual CPU version 2.5+
   x86 base                  base CPU model type with no features enabled
   x86 host                  Enables all features supported by the accele=
rator in the current host
   x86 max                   Enables all features supported by the accele=
rator in the current host

   Recognized CPUID flags:
     3dnow 3dnowext 3dnowprefetch abm ace2 ace2-en acpi adx aes apic arat=
 avx
     avx2 avx512-4fmaps avx512-4vnniw avx512-vpopcntdq avx512bitalg avx51=
2bw
     avx512cd avx512dq avx512er avx512f avx512ifma avx512pf avx512vbmi
     avx512vbmi2 avx512vl avx512vnni bmi1 bmi2 cid clflush clflushopt clw=
b
     cmov cmp-legacy cr8legacy cx16 cx8 dca de decodeassists ds ds-cpl dt=
es64
     erms est extapic f16c flushbyasid fma fma4 fpu fsgsbase fxsr fxsr-op=
t
     gfni hle ht hypervisor ia64 ibpb ibs intel-pt invpcid invtsc kvm-asy=
ncpf
     kvm-hint-dedicated kvm-mmu kvm-nopiodelay kvm-pv-eoi kvm-pv-tlb-flus=
h
     kvm-pv-unhalt kvm-steal-time kvmclock kvmclock kvmclock-stable-bit l=
a57
     lahf-lm lbrv lm lwp mca mce misalignsse mmx mmxext monitor movbe mpx=
 msr
     mtrr nodeid-msr npt nrip-save nx ospke osvw osxsave pae pat pause-fi=
lter
     pbe pcid pclmulqdq pcommit pdcm pdpe1gb perfctr-core perfctr-nb
     pfthreshold pge phe phe-en pku pmm pmm-en pn pni popcnt pse pse36 rd=
pid
     rdrand rdseed rdtscp rtm sep sha-ni skinit smap smep smx spec-ctrl s=
s sse
     sse2 sse4.1 sse4.2 sse4a ssse3 svm svm-lock syscall tbm tce tm tm2
     topoext tsc tsc-adjust tsc-deadline tsc-scale umip vaes vmcb-clean v=
me
     vmx vpclmulqdq wdt x2apic xcrypt xcrypt-en xgetbv1 xop xsave xsavec
     xsaveopt xsaves xstore xstore-en xtpr

One possible change, that I didn't include in patch 2, is to sort the
CPU model names case insensitively. That would be a more natural way of
doing alphabetical sorting for human output. The flip side is that it is
quite nice that the "modern" CPU models are all upper case and so appear
"first" in the listing. Except "486" is first no matter what. Ho, Hum.

Daniel P. Berrang=C3=A9 (3):
  i386: improve alignment of CPU model listing
  i386: improve sorting of CPU model names
  i386: display known CPUID features linewrapped, in alphabetical order

 target/i386/cpu.c | 57 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 20 deletions(-)

--=20
2.17.0
