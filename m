Received: from eggs.gnu.org ([2001:4830:134:3::10]:40351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8RjW-0001xI-Qw
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 10:05:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8RjV-00040h-MC
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 10:05:06 -0400
Received: from indium.canonical.com ([91.189.90.7]:57048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e8RjV-0003zm-GE
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 10:05:05 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e8RjU-0007jO-6a
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 14:05:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 279242E80C3
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 14:05:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Oct 2017 13:52:30 -0000
From: Thomas Huth <921208@bugs.launchpad.net>
Reply-To: Bug 921208 <921208@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120124212047.2129.40489.malonedeb@wampee.canonical.com>
Message-Id: <150919875098.4488.16099907508768578926.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 921208] Re: win7/x64 installer hangs on startup
 with 0x0000005d.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Since there hasn't been a reply within the last 5 months, I assume this
has been fixed and thus close now this ticket accordingly.

** Changed in: qemu
       Status: Incomplete =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/921208

Title:
  win7/x64 installer hangs on startup with 0x0000005d.

Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Triaged

Bug description:
  hi,

  during booting win7/x64 installer i'm observing a bsod with 0x0000005d
  ( msdn: unsupported_processor ).

  used command line: qemu-system-x86_64 -m 2048 -hda w7-system.img
  -cdrom win7_x64.iso -boot d

  adding '-machine accel=3Dkvm' instead of default tcg accel helps to
  boot.

  =

  installed software:

  qemu-1.0
  linux-3.2.1
  glibc-2.14.1
  gcc-4.6.2

  hw cpu:

  processor       : 0..7
  vendor_id       : GenuineIntel
  cpu family      : 6
  model           : 42
  model name      : Intel(R) Core(TM) i7-2630QM CPU @ 2.00GHz
  stepping        : 7
  microcode       : 0x14
  cpu MHz         : 1995.739
  cache size      : 6144 KB
  physical id     : 0
  siblings        : 8
  core id         : 3
  cpu cores       : 4
  apicid          : 7
  initial apicid  : 7
  fpu             : yes
  fpu_exception   : yes
  cpuid level     : 13
  wp              : yes
  flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mc=
a cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx=
 rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonst=
op_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx1=
6 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer xsave avx l=
ahf_lm ida arat epb xsaveopt pln pts dts tpr_shadow vnmi flexpriority ept v=
pid
  bogomips        : 3992.23
  clflush size    : 64
  cache_alignment : 64
  address sizes   : 36 bits physical, 48 bits virtual

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/921208/+subscriptions
