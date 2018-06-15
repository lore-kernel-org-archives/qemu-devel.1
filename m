Received: from eggs.gnu.org ([2001:4830:134:3::10]:60625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fTsra-0004UU-7l
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:50:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fTsrX-0000Mk-1e
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:50:18 -0400
Received: from indium.canonical.com ([91.189.90.7]:46984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fTsrW-0000MJ-Nu
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:50:14 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fTsrV-0007zJ-BA
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 17:50:13 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4DDAA2E80C7
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 17:50:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Jun 2018 17:37:58 -0000
From: Thomas Huth <1516446@bugs.launchpad.net>
Reply-To: Bug 1516446 <1516446@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20151115213157.12208.66685.malonedeb@chaenomeles.canonical.com>
Message-Id: <152908427885.26799.16427679405308743928.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1516446] Re: Migration always causes guest freeze
 in one direction.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Bug watch removed: Red Hat Bugzilla #1401767
   https://bugzilla.redhat.com/show_bug.cgi?id=3D1401767

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1516446

Title:
  Migration always causes guest freeze in one direction.

Status in QEMU:
  Incomplete

Bug description:
  Hello,

  I have three debian jessie machines standard installations except for
  homebuild qemu-2.4.0 package using the source package from testing. I
  had the same problem with the standard debian jessie qemu 2.1 too.

  I have host A, B and C.

  Migrations work between all combinations of these except A -> B. B ->
  A works.

  I use libvirt but as per your written request I have run qemu directly
  and verified the same problem.

  Host A:
  qemu-system-x86_64 --enable-kvm -name ashole -cpu kvm64 -m 1024 -drive fi=
le=3D/mnt/synctest/ashole.raw,if=3Dnone,id=3Ddrive-virtio-disk0,format=3Dra=
w,cache=3Dnone -vnc 0.0.0.0:600 -k sv -vga std -device virtio-blk-pci,scsi=
=3Doff,bus=3Dpci.0,addr=3D0x9,drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,=
bootindex=3D1

  Host B:
  qemu-system-x86_64 --enable-kvm -name ashole -cpu kvm64 -m 1024 -drive fi=
le=3D/mnt/synctest/ashole.raw,if=3Dnone,id=3Ddrive-virtio-disk0,format=3Dra=
w,cache=3Dnone -vnc 0.0.0.0:600 -k sv -vga std -device virtio-blk-pci,scsi=
=3Doff,bus=3Dpci.0,addr=3D0x9,drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,=
bootindex=3D1 -incoming tcp:0:4444

  Then in qemu monitor I run migrate -d tcp:B:4444 and the guest freeze.

  I have tried with these guest os:es, freebsd 9.1, debian wheezy and
  debian jessie (Standard 3.16 kernel and backported 4.2 kernel), same
  problem with all of them. when running the migration through libvirt
  virt-manager says the guest is using 100% cpu.

  I had a similar problem
  (https://bugzilla.kernel.org/show_bug.cgi?id=3D61971) 2 years ago which
  was solved in kernel 3.13 if I remember correctly.

  Best Regards
  Magnus

  CPU info:
  Host A
  processor	: 0
  vendor_id	: AuthenticAMD
  cpu family	: 21
  model		: 2
  model name	: AMD FX(tm)-8320 Eight-Core Processor
  stepping	: 0
  microcode	: 0x600081f
  cpu MHz		: 1400.000
  cache size	: 2048 KB
  physical id	: 0
  siblings	: 8
  core id		: 0
  cpu cores	: 4
  apicid		: 16
  initial apicid	: 0
  fpu		: yes
  fpu_exception	: yes
  cpuid level	: 13
  wp		: yes
  flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pa=
t pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdt=
scp lm constant_tsc rep_good nopl nonstop_tsc extd_apicid aperfmperf pni pc=
lmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 popcnt aes xsave avx f16c lahf=
_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch o=
svw ibs xop skinit wdt lwp fma4 tce nodeid_msr tbm topoext perfctr_core per=
fctr_nb arat cpb hw_pstate npt lbrv svm_lock nrip_save tsc_scale vmcb_clean=
 flushbyasid decodeassists pausefilter pfthreshold vmmcall bmi1
  bugs		: fxsave_leak sysret_ss_attrs
  bogomips	: 7023.54
  TLB size	: 1536 4K pages
  clflush size	: 64
  cache_alignment	: 64
  address sizes	: 48 bits physical, 48 bits virtual
  power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro

  processor	: 1
  vendor_id	: AuthenticAMD
  cpu family	: 21
  model		: 2
  model name	: AMD FX(tm)-8320 Eight-Core Processor
  stepping	: 0
  microcode	: 0x600081f
  cpu MHz		: 1400.000
  cache size	: 2048 KB
  physical id	: 0
  siblings	: 8
  core id		: 1
  cpu cores	: 4
  apicid		: 17
  initial apicid	: 1
  fpu		: yes
  fpu_exception	: yes
  cpuid level	: 13
  wp		: yes
  flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pa=
t pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdt=
scp lm constant_tsc rep_good nopl nonstop_tsc extd_apicid aperfmperf pni pc=
lmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 popcnt aes xsave avx f16c lahf=
_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch o=
svw ibs xop skinit wdt lwp fma4 tce nodeid_msr tbm topoext perfctr_core per=
fctr_nb arat cpb hw_pstate npt lbrv svm_lock nrip_save tsc_scale vmcb_clean=
 flushbyasid decodeassists pausefilter pfthreshold vmmcall bmi1
  bugs		: fxsave_leak sysret_ss_attrs
  bogomips	: 7023.54
  TLB size	: 1536 4K pages
  clflush size	: 64
  cache_alignment	: 64
  address sizes	: 48 bits physical, 48 bits virtual
  power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro

  processor	: 2
  vendor_id	: AuthenticAMD
  cpu family	: 21
  model		: 2
  model name	: AMD FX(tm)-8320 Eight-Core Processor
  stepping	: 0
  microcode	: 0x600081f
  cpu MHz		: 1700.000
  cache size	: 2048 KB
  physical id	: 0
  siblings	: 8
  core id		: 2
  cpu cores	: 4
  apicid		: 18
  initial apicid	: 2
  fpu		: yes
  fpu_exception	: yes
  cpuid level	: 13
  wp		: yes
  flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pa=
t pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdt=
scp lm constant_tsc rep_good nopl nonstop_tsc extd_apicid aperfmperf pni pc=
lmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 popcnt aes xsave avx f16c lahf=
_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch o=
svw ibs xop skinit wdt lwp fma4 tce nodeid_msr tbm topoext perfctr_core per=
fctr_nb arat cpb hw_pstate npt lbrv svm_lock nrip_save tsc_scale vmcb_clean=
 flushbyasid decodeassists pausefilter pfthreshold vmmcall bmi1
  bugs		: fxsave_leak sysret_ss_attrs
  bogomips	: 7023.54
  TLB size	: 1536 4K pages
  clflush size	: 64
  cache_alignment	: 64
  address sizes	: 48 bits physical, 48 bits virtual
  power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro

  processor	: 3
  vendor_id	: AuthenticAMD
  cpu family	: 21
  model		: 2
  model name	: AMD FX(tm)-8320 Eight-Core Processor
  stepping	: 0
  microcode	: 0x600081f
  cpu MHz		: 1400.000
  cache size	: 2048 KB
  physical id	: 0
  siblings	: 8
  core id		: 3
  cpu cores	: 4
  apicid		: 19
  initial apicid	: 3
  fpu		: yes
  fpu_exception	: yes
  cpuid level	: 13
  wp		: yes
  flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pa=
t pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdt=
scp lm constant_tsc rep_good nopl nonstop_tsc extd_apicid aperfmperf pni pc=
lmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 popcnt aes xsave avx f16c lahf=
_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch o=
svw ibs xop skinit wdt lwp fma4 tce nodeid_msr tbm topoext perfctr_core per=
fctr_nb arat cpb hw_pstate npt lbrv svm_lock nrip_save tsc_scale vmcb_clean=
 flushbyasid decodeassists pausefilter pfthreshold vmmcall bmi1
  bugs		: fxsave_leak sysret_ss_attrs
  bogomips	: 7023.54
  TLB size	: 1536 4K pages
  clflush size	: 64
  cache_alignment	: 64
  address sizes	: 48 bits physical, 48 bits virtual
  power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro

  processor	: 4
  vendor_id	: AuthenticAMD
  cpu family	: 21
  model		: 2
  model name	: AMD FX(tm)-8320 Eight-Core Processor
  stepping	: 0
  microcode	: 0x600081f
  cpu MHz		: 1400.000
  cache size	: 2048 KB
  physical id	: 0
  siblings	: 8
  core id		: 4
  cpu cores	: 4
  apicid		: 20
  initial apicid	: 4
  fpu		: yes
  fpu_exception	: yes
  cpuid level	: 13
  wp		: yes
  flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pa=
t pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdt=
scp lm constant_tsc rep_good nopl nonstop_tsc extd_apicid aperfmperf pni pc=
lmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 popcnt aes xsave avx f16c lahf=
_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch o=
svw ibs xop skinit wdt lwp fma4 tce nodeid_msr tbm topoext perfctr_core per=
fctr_nb arat cpb hw_pstate npt lbrv svm_lock nrip_save tsc_scale vmcb_clean=
 flushbyasid decodeassists pausefilter pfthreshold vmmcall bmi1
  bugs		: fxsave_leak sysret_ss_attrs
  bogomips	: 7023.54
  TLB size	: 1536 4K pages
  clflush size	: 64
  cache_alignment	: 64
  address sizes	: 48 bits physical, 48 bits virtual
  power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro

  processor	: 5
  vendor_id	: AuthenticAMD
  cpu family	: 21
  model		: 2
  model name	: AMD FX(tm)-8320 Eight-Core Processor
  stepping	: 0
  microcode	: 0x600081f
  cpu MHz		: 1400.000
  cache size	: 2048 KB
  physical id	: 0
  siblings	: 8
  core id		: 5
  cpu cores	: 4
  apicid		: 21
  initial apicid	: 5
  fpu		: yes
  fpu_exception	: yes
  cpuid level	: 13
  wp		: yes
  flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pa=
t pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdt=
scp lm constant_tsc rep_good nopl nonstop_tsc extd_apicid aperfmperf pni pc=
lmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 popcnt aes xsave avx f16c lahf=
_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch o=
svw ibs xop skinit wdt lwp fma4 tce nodeid_msr tbm topoext perfctr_core per=
fctr_nb arat cpb hw_pstate npt lbrv svm_lock nrip_save tsc_scale vmcb_clean=
 flushbyasid decodeassists pausefilter pfthreshold vmmcall bmi1
  bugs		: fxsave_leak sysret_ss_attrs
  bogomips	: 7023.54
  TLB size	: 1536 4K pages
  clflush size	: 64
  cache_alignment	: 64
  address sizes	: 48 bits physical, 48 bits virtual
  power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro

  processor	: 6
  vendor_id	: AuthenticAMD
  cpu family	: 21
  model		: 2
  model name	: AMD FX(tm)-8320 Eight-Core Processor
  stepping	: 0
  microcode	: 0x600081f
  cpu MHz		: 1400.000
  cache size	: 2048 KB
  physical id	: 0
  siblings	: 8
  core id		: 6
  cpu cores	: 4
  apicid		: 22
  initial apicid	: 6
  fpu		: yes
  fpu_exception	: yes
  cpuid level	: 13
  wp		: yes
  flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pa=
t pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdt=
scp lm constant_tsc rep_good nopl nonstop_tsc extd_apicid aperfmperf pni pc=
lmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 popcnt aes xsave avx f16c lahf=
_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch o=
svw ibs xop skinit wdt lwp fma4 tce nodeid_msr tbm topoext perfctr_core per=
fctr_nb arat cpb hw_pstate npt lbrv svm_lock nrip_save tsc_scale vmcb_clean=
 flushbyasid decodeassists pausefilter pfthreshold vmmcall bmi1
  bugs		: fxsave_leak sysret_ss_attrs
  bogomips	: 7023.54
  TLB size	: 1536 4K pages
  clflush size	: 64
  cache_alignment	: 64
  address sizes	: 48 bits physical, 48 bits virtual
  power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro

  processor	: 7
  vendor_id	: AuthenticAMD
  cpu family	: 21
  model		: 2
  model name	: AMD FX(tm)-8320 Eight-Core Processor
  stepping	: 0
  microcode	: 0x600081f
  cpu MHz		: 1400.000
  cache size	: 2048 KB
  physical id	: 0
  siblings	: 8
  core id		: 7
  cpu cores	: 4
  apicid		: 23
  initial apicid	: 7
  fpu		: yes
  fpu_exception	: yes
  cpuid level	: 13
  wp		: yes
  flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pa=
t pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdt=
scp lm constant_tsc rep_good nopl nonstop_tsc extd_apicid aperfmperf pni pc=
lmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 popcnt aes xsave avx f16c lahf=
_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch o=
svw ibs xop skinit wdt lwp fma4 tce nodeid_msr tbm topoext perfctr_core per=
fctr_nb arat cpb hw_pstate npt lbrv svm_lock nrip_save tsc_scale vmcb_clean=
 flushbyasid decodeassists pausefilter pfthreshold vmmcall bmi1
  bugs		: fxsave_leak sysret_ss_attrs
  bogomips	: 7023.54
  TLB size	: 1536 4K pages
  clflush size	: 64
  cache_alignment	: 64
  address sizes	: 48 bits physical, 48 bits virtual
  power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro

  Host B:
  processor	: 0
  vendor_id	: AuthenticAMD
  cpu family	: 16
  model		: 10
  model name	: AMD Phenom(tm) II X6 1055T Processor
  stepping	: 0
  microcode	: 0x10000bf
  cpu MHz		: 800.000
  cache size	: 512 KB
  physical id	: 0
  siblings	: 6
  core id		: 0
  cpu cores	: 6
  apicid		: 0
  initial apicid	: 0
  fpu		: yes
  fpu_exception	: yes
  cpuid level	: 6
  wp		: yes
  flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pa=
t pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdt=
scp lm 3dnowext 3dnow constant_tsc rep_good nopl nonstop_tsc extd_apicid ap=
erfmperf pni monitor cx16 popcnt lahf_lm cmp_legacy svm extapic cr8_legacy =
abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt cpb hw_pstate npt l=
brv svm_lock nrip_save pausefilter vmmcall
  bugs		: tlb_mmatch apic_c1e fxsave_leak sysret_ss_attrs
  bogomips	: 5624.68
  TLB size	: 1024 4K pages
  clflush size	: 64
  cache_alignment	: 64
  address sizes	: 48 bits physical, 48 bits virtual
  power management: ts ttp tm stc 100mhzsteps hwpstate cpb

  processor	: 1
  vendor_id	: AuthenticAMD
  cpu family	: 16
  model		: 10
  model name	: AMD Phenom(tm) II X6 1055T Processor
  stepping	: 0
  microcode	: 0x10000bf
  cpu MHz		: 800.000
  cache size	: 512 KB
  physical id	: 0
  siblings	: 6
  core id		: 1
  cpu cores	: 6
  apicid		: 1
  initial apicid	: 1
  fpu		: yes
  fpu_exception	: yes
  cpuid level	: 6
  wp		: yes
  flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pa=
t pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdt=
scp lm 3dnowext 3dnow constant_tsc rep_good nopl nonstop_tsc extd_apicid ap=
erfmperf pni monitor cx16 popcnt lahf_lm cmp_legacy svm extapic cr8_legacy =
abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt cpb hw_pstate npt l=
brv svm_lock nrip_save pausefilter vmmcall
  bugs		: tlb_mmatch apic_c1e fxsave_leak sysret_ss_attrs
  bogomips	: 5624.68
  TLB size	: 1024 4K pages
  clflush size	: 64
  cache_alignment	: 64
  address sizes	: 48 bits physical, 48 bits virtual
  power management: ts ttp tm stc 100mhzsteps hwpstate cpb

  processor	: 2
  vendor_id	: AuthenticAMD
  cpu family	: 16
  model		: 10
  model name	: AMD Phenom(tm) II X6 1055T Processor
  stepping	: 0
  microcode	: 0x10000bf
  cpu MHz		: 800.000
  cache size	: 512 KB
  physical id	: 0
  siblings	: 6
  core id		: 2
  cpu cores	: 6
  apicid		: 2
  initial apicid	: 2
  fpu		: yes
  fpu_exception	: yes
  cpuid level	: 6
  wp		: yes
  flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pa=
t pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdt=
scp lm 3dnowext 3dnow constant_tsc rep_good nopl nonstop_tsc extd_apicid ap=
erfmperf pni monitor cx16 popcnt lahf_lm cmp_legacy svm extapic cr8_legacy =
abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt cpb hw_pstate npt l=
brv svm_lock nrip_save pausefilter vmmcall
  bugs		: tlb_mmatch apic_c1e fxsave_leak sysret_ss_attrs
  bogomips	: 5624.68
  TLB size	: 1024 4K pages
  clflush size	: 64
  cache_alignment	: 64
  address sizes	: 48 bits physical, 48 bits virtual
  power management: ts ttp tm stc 100mhzsteps hwpstate cpb

  processor	: 3
  vendor_id	: AuthenticAMD
  cpu family	: 16
  model		: 10
  model name	: AMD Phenom(tm) II X6 1055T Processor
  stepping	: 0
  microcode	: 0x10000bf
  cpu MHz		: 800.000
  cache size	: 512 KB
  physical id	: 0
  siblings	: 6
  core id		: 3
  cpu cores	: 6
  apicid		: 3
  initial apicid	: 3
  fpu		: yes
  fpu_exception	: yes
  cpuid level	: 6
  wp		: yes
  flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pa=
t pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdt=
scp lm 3dnowext 3dnow constant_tsc rep_good nopl nonstop_tsc extd_apicid ap=
erfmperf pni monitor cx16 popcnt lahf_lm cmp_legacy svm extapic cr8_legacy =
abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt cpb hw_pstate npt l=
brv svm_lock nrip_save pausefilter vmmcall
  bugs		: tlb_mmatch apic_c1e fxsave_leak sysret_ss_attrs
  bogomips	: 5624.68
  TLB size	: 1024 4K pages
  clflush size	: 64
  cache_alignment	: 64
  address sizes	: 48 bits physical, 48 bits virtual
  power management: ts ttp tm stc 100mhzsteps hwpstate cpb

  processor	: 4
  vendor_id	: AuthenticAMD
  cpu family	: 16
  model		: 10
  model name	: AMD Phenom(tm) II X6 1055T Processor
  stepping	: 0
  microcode	: 0x10000bf
  cpu MHz		: 800.000
  cache size	: 512 KB
  physical id	: 0
  siblings	: 6
  core id		: 4
  cpu cores	: 6
  apicid		: 4
  initial apicid	: 4
  fpu		: yes
  fpu_exception	: yes
  cpuid level	: 6
  wp		: yes
  flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pa=
t pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdt=
scp lm 3dnowext 3dnow constant_tsc rep_good nopl nonstop_tsc extd_apicid ap=
erfmperf pni monitor cx16 popcnt lahf_lm cmp_legacy svm extapic cr8_legacy =
abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt cpb hw_pstate npt l=
brv svm_lock nrip_save pausefilter vmmcall
  bugs		: tlb_mmatch apic_c1e fxsave_leak sysret_ss_attrs
  bogomips	: 5624.68
  TLB size	: 1024 4K pages
  clflush size	: 64
  cache_alignment	: 64
  address sizes	: 48 bits physical, 48 bits virtual
  power management: ts ttp tm stc 100mhzsteps hwpstate cpb

  processor	: 5
  vendor_id	: AuthenticAMD
  cpu family	: 16
  model		: 10
  model name	: AMD Phenom(tm) II X6 1055T Processor
  stepping	: 0
  microcode	: 0x10000bf
  cpu MHz		: 800.000
  cache size	: 512 KB
  physical id	: 0
  siblings	: 6
  core id		: 5
  cpu cores	: 6
  apicid		: 5
  initial apicid	: 5
  fpu		: yes
  fpu_exception	: yes
  cpuid level	: 6
  wp		: yes
  flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pa=
t pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdt=
scp lm 3dnowext 3dnow constant_tsc rep_good nopl nonstop_tsc extd_apicid ap=
erfmperf pni monitor cx16 popcnt lahf_lm cmp_legacy svm extapic cr8_legacy =
abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt cpb hw_pstate npt l=
brv svm_lock nrip_save pausefilter vmmcall
  bugs		: tlb_mmatch apic_c1e fxsave_leak sysret_ss_attrs
  bogomips	: 5624.68
  TLB size	: 1024 4K pages
  clflush size	: 64
  cache_alignment	: 64
  address sizes	: 48 bits physical, 48 bits virtual
  power management: ts ttp tm stc 100mhzsteps hwpstate cpb

  Host C:
  processor	: 0
  vendor_id	: GenuineIntel
  cpu family	: 6
  model		: 58
  model name	: Intel(R) Core(TM) i5-3450 CPU @ 3.10GHz
  stepping	: 9
  microcode	: 0x12
  cpu MHz		: 1607.156
  cache size	: 6144 KB
  physical id	: 0
  siblings	: 4
  core id		: 0
  cpu cores	: 4
  apicid		: 0
  initial apicid	: 0
  fpu		: yes
  fpu_exception	: yes
  cpuid level	: 13
  wp		: yes
  flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pa=
t pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp l=
m constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc ap=
erfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx1=
6 xtpr pdcm pcid sse4_1 sse4_2 popcnt tsc_deadline_timer xsave avx f16c rdr=
and lahf_lm ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vp=
id fsgsbase smep erms xsaveopt
  bugs		:
  bogomips	: 6186.23
  clflush size	: 64
  cache_alignment	: 64
  address sizes	: 36 bits physical, 48 bits virtual
  power management:

  processor	: 1
  vendor_id	: GenuineIntel
  cpu family	: 6
  model		: 58
  model name	: Intel(R) Core(TM) i5-3450 CPU @ 3.10GHz
  stepping	: 9
  microcode	: 0x12
  cpu MHz		: 1730.066
  cache size	: 6144 KB
  physical id	: 0
  siblings	: 4
  core id		: 1
  cpu cores	: 4
  apicid		: 2
  initial apicid	: 2
  fpu		: yes
  fpu_exception	: yes
  cpuid level	: 13
  wp		: yes
  flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pa=
t pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp l=
m constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc ap=
erfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx1=
6 xtpr pdcm pcid sse4_1 sse4_2 popcnt tsc_deadline_timer xsave avx f16c rdr=
and lahf_lm ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vp=
id fsgsbase smep erms xsaveopt
  bugs		:
  bogomips	: 6186.23
  clflush size	: 64
  cache_alignment	: 64
  address sizes	: 36 bits physical, 48 bits virtual
  power management:

  processor	: 2
  vendor_id	: GenuineIntel
  cpu family	: 6
  model		: 58
  model name	: Intel(R) Core(TM) i5-3450 CPU @ 3.10GHz
  stepping	: 9
  microcode	: 0x12
  cpu MHz		: 1654.382
  cache size	: 6144 KB
  physical id	: 0
  siblings	: 4
  core id		: 2
  cpu cores	: 4
  apicid		: 4
  initial apicid	: 4
  fpu		: yes
  fpu_exception	: yes
  cpuid level	: 13
  wp		: yes
  flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pa=
t pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp l=
m constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc ap=
erfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx1=
6 xtpr pdcm pcid sse4_1 sse4_2 popcnt tsc_deadline_timer xsave avx f16c rdr=
and lahf_lm ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vp=
id fsgsbase smep erms xsaveopt
  bugs		:
  bogomips	: 6186.23
  clflush size	: 64
  cache_alignment	: 64
  address sizes	: 36 bits physical, 48 bits virtual
  power management:

  processor	: 3
  vendor_id	: GenuineIntel
  cpu family	: 6
  model		: 58
  model name	: Intel(R) Core(TM) i5-3450 CPU @ 3.10GHz
  stepping	: 9
  microcode	: 0x12
  cpu MHz		: 1610.304
  cache size	: 6144 KB
  physical id	: 0
  siblings	: 4
  core id		: 3
  cpu cores	: 4
  apicid		: 6
  initial apicid	: 6
  fpu		: yes
  fpu_exception	: yes
  cpuid level	: 13
  wp		: yes
  flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pa=
t pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp l=
m constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc ap=
erfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx1=
6 xtpr pdcm pcid sse4_1 sse4_2 popcnt tsc_deadline_timer xsave avx f16c rdr=
and lahf_lm ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vp=
id fsgsbase smep erms xsaveopt
  bugs		:
  bogomips	: 6186.23
  clflush size	: 64
  cache_alignment	: 64
  address sizes	: 36 bits physical, 48 bits virtual
  power management:

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1516446/+subscriptions
