Received: from eggs.gnu.org ([2001:4830:134:3::10]:46221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fLbLk-00028L-5p
	for qemu-devel@nongnu.org; Wed, 23 May 2018 17:31:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fLbLg-0005a3-6E
	for qemu-devel@nongnu.org; Wed, 23 May 2018 17:31:12 -0400
Received: from indium.canonical.com ([91.189.90.7]:49798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fLbLg-0005Zc-0B
	for qemu-devel@nongnu.org; Wed, 23 May 2018 17:31:08 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fLbLc-0003T3-Mo
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 21:31:05 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D06712E80D2
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 21:31:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 May 2018 21:16:30 -0000
From: Chris <chris.kuethe+launchpad@gmail.com>
Reply-To: Bug 1722074 <1722074@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150746661053.7454.6898170418757179619.malonedeb@wampee.canonical.com>
Message-Id: <152711019088.26992.47431498318287746.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1722074] Re: warning: host doesn't support
 requested feature: CPUID.01H:ECX.vmx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Also reproducible
$ qemu-system-x86_64 --version
QEMU emulator version 2.11.1(Debian 1:2.11+dfsg-1ubuntu7.2)
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
$ uname -a
Linux ryzen 4.16.11-041611-generic #201805221331 SMP Tue May 22 17:34:25 UT=
C 2018 x86_64 x86_64 x86_64 GNU/Linux
$ head -28 /proc/cpuinfo =

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 23
model		: 8
model name	: AMD Ryzen 7 2700X Eight-Core Processor
stepping	: 2
microcode	: 0x8008204
cpu MHz		: 2161.008
cache size	: 512 KB
physical id	: 0
siblings	: 16
core id		: 0
cpu cores	: 8
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtsc=
p lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pn=
i pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx=
 f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignss=
e 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext p=
erfctr_llc mwaitx hw_pstate sme ssbd sev ibpb vmmcall fsgsbase bmi1 avx2 sm=
ep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves cl=
zero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clea=
n flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vg=
if overflow_recov succor smca
bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 7399.25
TLB size	: 2560 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 43 bits physical, 48 bits virtual
power management: ts ttp tm hwpstate eff_freq_ro [13] [14]

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1722074

Title:
  warning: host doesn't support requested feature: CPUID.01H:ECX.vmx

Status in QEMU:
  New

Bug description:
  =

  I encountered the bug today (when using qemu to boot up images - which us=
ed to work on my Intel CPU box):

  warning: host doesn't support requested feature: CPUID.01H:ECX.vmx

  The bug is a show-stopper - I completely cannot load my kernel images
  at all.

  My Ubuntu have this version of QEMU installed:

  qemu-system-x86_64 --version

  QEMU emulator version 2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.16),
  Copyright (c) 2003-2008 Fabrice Bellard

  And PC is a AMD Ryzen7 CPU built, and this is the first time I am
  using it to load QEMU images.   My host information:

  cat /proc/cpuinfo |more

  processor	: 0
  vendor_id	: AuthenticAMD
  cpu family	: 23
  model		: 1
  model name	: AMD Ryzen 7 1700X Eight-Core Processor
  stepping	: 1
  microcode	: 0x800110e
  cpu MHz		: 2200.000
  cache size	: 512 KB
  physical id	: 0
  siblings	: 16
  core id		: 0
  cpu cores	: 8
  apicid		: 0
  initial apicid	: 0
  fpu		: yes
  fpu_exception	: yes
  cpuid level	: 13
  wp		: yes
  flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
  pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb=
 rdtscp
  =C2=A0lm constant_tsc rep_good nopl nonstop_tsc extd_apicid aperfmperf pn=
i pclmulqdq
  monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdra=
nd lahf
  _lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch=
 osvw s
  kinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_l2 mwaitx hw_=
pstate
  vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xs=
aveopt
  xsavec xgetbv1 xsaves clzero irperf arat npt lbrv svm_lock nrip_save tsc_=
scale v
  mcb_clean flushbyasid decodeassists pausefilter pfthreshold avic overflow=
_recov
  succor smca
  bugs		: fxsave_leak sysret_ss_attrs null_seg
  bogomips	: 6787.24
  TLB size	: 2560 4K pages
  clflush size	: 64
  cache_alignment	: 64
  address sizes	: 48 bits physical, 48 bits virtual
  power management: ts ttp tm hwpstate eff_freq_ro [13] [14]

  processor	: 1
  vendor_id	: AuthenticAMD
  cpu family	: 23
  model		: 1
  model name	: AMD Ryzen 7 1700X Eight-Core Processor
  stepping	: 1
  microcode	: 0x800110e
  cpu MHz		: 2200.000
  cache size	: 512 KB

  From other places, it can be seen that this is an AMD CPU issue:

  https://www.virtualmin.com/node/52227

  not sure?

  The bug will also affect the host negatively:  it will completely go
  into a hung mode - the entire host becomes completely unsable.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1722074/+subscriptions
