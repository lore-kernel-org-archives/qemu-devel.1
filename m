Received: from eggs.gnu.org ([2001:4830:134:3::10]:54967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e1B2j-0001rz-Qo
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 08:50:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e1B2e-0006GT-U3
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 08:50:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:50420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e1B2e-0006Fy-NC
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 08:50:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e1B2b-0001Z4-9o
	for <qemu-devel@nongnu.org>; Sun, 08 Oct 2017 12:50:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 435B92E8031
	for <qemu-devel@nongnu.org>; Sun,  8 Oct 2017 12:50:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Oct 2017 12:43:30 -0000
From: "htmldeveloper@gmail.com" <htmldeveloper@gmail.com>
Reply-To: Bug 1722074 <1722074@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150746661053.7454.6898170418757179619.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1722074] [NEW] warning: host doesn't support
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

Public bug reported:

I encountered the bug today:

warning: host doesn't support requested feature: CPUID.01H:ECX.vmx

My Ubuntu have this version of QEMU installed:

qemu-system-x86_64 --version

QEMU emulator version 2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.16), Copyright
(c) 2003-2008 Fabrice Bellard

And PC is a AMD Ryzen7 CPU built, and since it is not Intel CPU:


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
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =

pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb r=
dtscp
 lm constant_tsc rep_good nopl nonstop_tsc extd_apicid aperfmperf pni pclmu=
lqdq =

monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand=
 lahf
_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch o=
svw s
kinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_l2 mwaitx hw_ps=
tate =

vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsav=
eopt =

xsavec xgetbv1 xsaves clzero irperf arat npt lbrv svm_lock nrip_save tsc_sc=
ale v
mcb_clean flushbyasid decodeassists pausefilter pfthreshold avic overflow_r=
ecov =

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

>From other places, it can be seen that this is an AMD CPU issue:

https://www.virtualmin.com/node/52227

not sure?

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1722074

Title:
  warning: host doesn't support requested feature: CPUID.01H:ECX.vmx

Status in QEMU:
  New

Bug description:
  I encountered the bug today:

  warning: host doesn't support requested feature: CPUID.01H:ECX.vmx

  My Ubuntu have this version of QEMU installed:

  qemu-system-x86_64 --version

  QEMU emulator version 2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.16),
  Copyright (c) 2003-2008 Fabrice Bellard

  And PC is a AMD Ryzen7 CPU built, and since it is not Intel CPU:

  =

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
  flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =

  pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb=
 rdtscp
   lm constant_tsc rep_good nopl nonstop_tsc extd_apicid aperfmperf pni pcl=
mulqdq =

  monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdra=
nd lahf
  _lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch=
 osvw s
  kinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_l2 mwaitx hw_=
pstate =

  vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xs=
aveopt =

  xsavec xgetbv1 xsaves clzero irperf arat npt lbrv svm_lock nrip_save tsc_=
scale v
  mcb_clean flushbyasid decodeassists pausefilter pfthreshold avic overflow=
_recov =

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

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1722074/+subscriptions
