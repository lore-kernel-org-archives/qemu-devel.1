Received: from eggs.gnu.org ([2001:4830:134:3::10]:37460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ftJyw-0003h7-0B
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 17:51:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ftJyr-0001tI-VF
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 17:51:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:41440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ftJyr-0001sf-Ml
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 17:50:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ftJyp-0005mO-G2
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 21:50:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3FDB42E81C9
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 21:50:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Aug 2018 21:43:37 -0000
From: Heiko Sieger <1788665@bugs.launchpad.net>
Reply-To: Bug 1788665 <1788665@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153504502595.30588.13203676939349086206.malonedeb@soybean.canonical.com>
Message-Id: <153514701710.26206.10585288626951824416.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1788665] Re: Low 2D graphics performance with
 Windows 10 (1803) VGA passthrough VM using "Spectre" protection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Thanks for your explanations - I thought so too.

The new Intel microcode is applied, as you can see:
dmesg | grep microcode
[ 0.000000] microcode: microcode updated early to revision 0x714, date =3D =
2018-05-08
[ 2.810683] microcode: sig=3D0x206d7, pf=3D0x4, revision=3D0x714
[ 2.813340] microcode: Microcode Update Driver: v2.2.

The host kernel has the features you listed:
cat /proc/cpuinfo | grep flags
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rd=
tscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_=
tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 =
cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes =
xsave avx lahf_lm epb pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority=
 ept vpid xsaveopt dtherm ida arat pln pts flush_l1d

I'm still looking for a way to display the CPU flags under Windows.

Here is my systeminfo (Windows) output:

 systeminfo

Host Name:                 DESKTOP-K3DEAH0
OS Name:                   Microsoft Windows 10 Pro
OS Version:                10.0.17134 N/A Build 17134
OS Manufacturer:           Microsoft Corporation
OS Configuration:          Standalone Workstation
OS Build Type:             Multiprocessor Free
Registered Owner:          win
Registered Organization:
Product ID:                00330-80000-00000-AA554
Original Install Date:     05-Jun-18, 22:58:49
System Boot Time:          25-Aug-18, 00:17:19
System Manufacturer:       QEMU
System Model:              Standard PC (Q35 + ICH9, 2009)
System Type:               x64-based PC
Processor(s):              1 Processor(s) Installed.
                           [01]: Intel64 Family 6 Model 45 Stepping 7 Genui=
neIntel ~3200 Mhz
BIOS Version:              EFI Development Kit II / OVMF 0.0.0, 06-Feb-15
Windows Directory:         C:\WINDOWS
System Directory:          C:\WINDOWS\system32
Boot Device:               \Device\HarddiskVolume2
System Locale:             en-us;English (United States)
Input Locale:              en-us;English (United States)
Time Zone:                 (UTC+02:00) Jerusalem
Total Physical Memory:     16,380 MB
Available Physical Memory: 12,955 MB
Virtual Memory: Max Size:  17,380 MB
Virtual Memory: Available: 13,233 MB
Virtual Memory: In Use:    4,147 MB
Page File Location(s):     C:\pagefile.sys
Domain:                    WORKGROUP
Logon Server:              \\DESKTOP-K3DEAH0
Hotfix(s):                 4 Hotfix(s) Installed.
                           [01]: KB4338832
                           [02]: KB4343669
                           [03]: KB4343902
                           [04]: KB4343909
Network Card(s):           1 NIC(s) Installed.
                           [01]: Red Hat VirtIO Ethernet Adapter
                                 Connection Name: Ethernet 6
                                 DHCP Enabled:    No
                                 IP address(es)
                                 [01]: 192.168.0.200
Hyper-V Requirements:      A hypervisor has been detected. Features require=
d for Hyper-V will not be displayed.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1788665

Title:
  Low 2D graphics performance with Windows 10 (1803) VGA passthrough VM
  using "Spectre" protection

Status in QEMU:
  New

Bug description:
  Windows 10 (1803) VM using VGA passthrough via qemu script.

  After upgrading Windows 10 Pro VM to version 1803, or possibly after
  applying the March/April security updates from Microsoft, the VM would
  show low 2D graphics performance (sluggishness in 2D applications and
  low Passmark results).

  Turning off Spectre vulnerability protection in Windows remedies the
  issue.

  Expected behavior:
  qemu/kvm hypervisor to expose firmware capabilities of host to guest OS -=
 see https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/CVE=
-2017-5715-and-hyper-v-vms

  Background:

  Starting in March or April Microsoft began to push driver updates in
  their updates / security updates. See https://support.microsoft.com
  /en-us/help/4073757/protect-your-windows-devices-against-spectre-
  meltdown

  One update concerns the Intel microcode - see
  https://support.microsoft.com/en-us/help/4100347. It is activated by
  default within Windows.

  Once the updates are applied within the Windows guest, 2D graphics
  performance drops significantly. Other performance benchmarks are not
  affected.

  A bare metal Windows installation does not display a performance loss
  after the update. See https://heiko-sieger.info/low-2d-graphics-
  benchmark-with-windows-10-1803-kvm-vm/

  Similar reports can be found here:
  https://www.reddit.com/r/VFIO/comments/97unx4/passmark_lousy_2d_graphics_=
performance_on_windows/

  Hardware:

  6 core Intel Core i7-3930K (-MT-MCP-)

  Host OS:
  Linux Mint 19/Ubuntu 18.04
  Kernel: 4.15.0-32-generic x86_64
  Qemu: QEMU emulator version 2.11.1
  Intel microcode (host): 0x714
  dmesg | grep microcode
  [    0.000000] microcode: microcode updated early to revision 0x714, date=
 =3D 2018-05-08
  [    2.810683] microcode: sig=3D0x206d7, pf=3D0x4, revision=3D0x714
  [    2.813340] microcode: Microcode Update Driver: v2.2.

  Note: I manually updated the Intel microcode on the host from 0x713 to
  0x714. However, both microcode versions produce the same result in the
  Windows guest.

  Guest OS:
  Windows 10 Pro 64 bit, release 1803

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1788665/+subscriptions
