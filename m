Received: from eggs.gnu.org ([2001:4830:134:3::10]:56175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fLiba-0004zU-JR
	for qemu-devel@nongnu.org; Thu, 24 May 2018 01:16:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fLibX-0007YV-72
	for qemu-devel@nongnu.org; Thu, 24 May 2018 01:16:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:45176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fLibW-0007Xc-Rv
	for qemu-devel@nongnu.org; Thu, 24 May 2018 01:15:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fLibU-0005oa-MA
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 05:15:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 756A72E80E5
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 05:15:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 May 2018 05:07:40 -0000
From: =?utf-8?b?7oO/IENocmlzdGlhbiBFaHJoYXJkdCDug78=?=
	<1722074@bugs.launchpad.net>
Reply-To: Bug 1722074 <1722074@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150746661053.7454.6898170418757179619.malonedeb@wampee.canonical.com>
Message-Id: <152713846046.25806.13535556256955920237.launchpad@wampee.canonical.com>
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

** Also affects: qemu (Ubuntu)
   Importance: Undecided
       Status: New

** Changed in: qemu
       Status: New =3D> Incomplete

** Changed in: qemu
       Status: Incomplete =3D> Opinion

** Changed in: qemu
       Status: Opinion =3D> Invalid

** Changed in: qemu (Ubuntu)
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1722074

Title:
  warning: host doesn't support requested feature: CPUID.01H:ECX.vmx

Status in QEMU:
  Invalid
Status in qemu package in Ubuntu:
  Confirmed

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
