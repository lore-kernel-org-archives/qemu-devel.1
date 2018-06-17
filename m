Received: from eggs.gnu.org ([2001:4830:134:3::10]:39373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fURzS-0005gu-NB
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 03:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fURzN-0006UK-Ih
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 03:20:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:60960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fURzN-0006Sv-2q
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 03:20:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fURzK-0006it-MP
	for <qemu-devel@nongnu.org>; Sun, 17 Jun 2018 07:20:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 853B22E80D0
	for <qemu-devel@nongnu.org>; Sun, 17 Jun 2018 07:20:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 Jun 2018 07:15:31 -0000
From: Haldun ALIMLI <1777301@bugs.launchpad.net>
Reply-To: Bug 1777301 <1777301@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152921973161.6894.5433227514724824372.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1777301] [NEW] Boot failed after installing
 Checkpoint Pointsec FDE
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

Boot failed after installing Checkpoint Pointsec FDE


Hi,
I installed Windows 10 64-bit guest on CentOS 7. Everything works great as =
expected.
However after installing CheckPoint AlertSec full disk encryption, the gues=
t failed to boot.

The following error is displayed in qemu log file.
KVM internal error. Suberror: 1
emulation failure


Installed Software
[root@sesamvmh01 qemu]# yum list installed | grep qemu
ipxe-roms-qemu.noarch                   20170123-1.git4e85b27.el7_4.1  @bas=
e    =

libvirt-daemon-driver-qemu.x86_64       3.9.0-14.el7_5.5               @upd=
ates =

qemu-guest-agent.x86_64                 10:2.8.0-2.el7                 @bas=
e    =

qemu-img-ev.x86_64                      10:2.3.0-29.1.el7              @qem=
u-kvm-rhev
qemu-kvm-common-ev.x86_64               10:2.3.0-29.1.el7              @qem=
u-kvm-rhev
qemu-kvm-ev.x86_64                      10:2.3.0-29.1.el7              @qem=
u-kvm-rhev

# uname -r
3.10.0-862.3.2.el7.x86_64

CPU info:
processor	: 0..3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 30
model name	: Intel(R) Xeon(R) CPU           X3430  @ 2.40GHz
stepping	: 5
microcode	: 0x7
cpu MHz		: 1200.000
cache size	: 8192 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 4
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm =
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aper=
fmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm sse4_=
1 sse4_2 popcnt lahf_lm tpr_shadow vnmi flexpriority ept vpid dtherm ida
bogomips	: 4799.98
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

Please also check attached logs. I am new to qemu-kvm so please don't
hesitate to ask missing info.

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "logs.zip"
   https://bugs.launchpad.net/bugs/1777301/+attachment/5153543/+files/logs.=
zip

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1777301

Title:
  Boot failed after installing Checkpoint Pointsec FDE

Status in QEMU:
  New

Bug description:
  Boot failed after installing Checkpoint Pointsec FDE

  =

  Hi,
  I installed Windows 10 64-bit guest on CentOS 7. Everything works great a=
s expected.
  However after installing CheckPoint AlertSec full disk encryption, the gu=
est failed to boot.

  The following error is displayed in qemu log file.
  KVM internal error. Suberror: 1
  emulation failure



  Installed Software
  [root@sesamvmh01 qemu]# yum list installed | grep qemu
  ipxe-roms-qemu.noarch                   20170123-1.git4e85b27.el7_4.1  @b=
ase    =

  libvirt-daemon-driver-qemu.x86_64       3.9.0-14.el7_5.5               @u=
pdates =

  qemu-guest-agent.x86_64                 10:2.8.0-2.el7                 @b=
ase    =

  qemu-img-ev.x86_64                      10:2.3.0-29.1.el7              @q=
emu-kvm-rhev
  qemu-kvm-common-ev.x86_64               10:2.3.0-29.1.el7              @q=
emu-kvm-rhev
  qemu-kvm-ev.x86_64                      10:2.3.0-29.1.el7              @q=
emu-kvm-rhev

  # uname -r
  3.10.0-862.3.2.el7.x86_64

  CPU info:
  processor	: 0..3
  vendor_id	: GenuineIntel
  cpu family	: 6
  model		: 30
  model name	: Intel(R) Xeon(R) CPU           X3430  @ 2.40GHz
  stepping	: 5
  microcode	: 0x7
  cpu MHz		: 1200.000
  cache size	: 8192 KB
  physical id	: 0
  siblings	: 4
  core id		: 0
  cpu cores	: 4
  apicid		: 0
  initial apicid	: 0
  fpu		: yes
  fpu_exception	: yes
  cpuid level	: 11
  wp		: yes
  flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pa=
t pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp l=
m constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc ap=
erfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm sse=
4_1 sse4_2 popcnt lahf_lm tpr_shadow vnmi flexpriority ept vpid dtherm ida
  bogomips	: 4799.98
  clflush size	: 64
  cache_alignment	: 64
  address sizes	: 36 bits physical, 48 bits virtual
  power management:

  Please also check attached logs. I am new to qemu-kvm so please don't
  hesitate to ask missing info.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1777301/+subscriptions
