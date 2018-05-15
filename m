Received: from eggs.gnu.org ([2001:4830:134:3::10]:40805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fITU0-0000ce-2N
	for qemu-devel@nongnu.org; Tue, 15 May 2018 02:30:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fITTw-0001rA-Pt
	for qemu-devel@nongnu.org; Tue, 15 May 2018 02:30:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:55632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fITTw-0001qW-BC
	for qemu-devel@nongnu.org; Tue, 15 May 2018 02:30:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fITTu-0004Er-8b
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 06:30:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1EE162E8F36
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 06:30:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 May 2018 06:25:18 -0000
From: David Coronel <david.coronel@canonical.com>
Reply-To: Bug 1771238 <1771238@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152634685372.25048.9899905886719153.malonedeb@soybean.canonical.com>
Message-Id: <152636551901.1743.15162457354163699824.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1771238] Re: Not able to passthrough > 32 PCIe
 devices to a KVM Guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu (Ubuntu)
   Importance: Critical =3D> High

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1771238

Title:
  Not able to passthrough > 32 PCIe devices to a KVM Guest

Status in QEMU:
  New
Status in qemu package in Ubuntu:
  New

Bug description:
  Using an Ubuntu Server 16.04-based host with KVM hypervisor installed,
  we are unable to launch a vanilla Ubuntu Server 16.04.4 guest with >=3D
  32 PCIe devices. It is 100% reproducible. Using fewer PCIe devices
  works fine. We are using the vanilla kvm and qemu packages from the
  Canonical repos.

  The ultimate goal is to create a KVM Guest wherein I can passthrough
  44 PCI devices.

  When a KVM Guest launches, it also has some internal PCIe devices
  including host bridge, USB, IDE (for virtual disk), and virtual nic
  etc.

  Script used to launch all devices looks like this:

  #!/bin/bash =

  NAME=3D16gpuvm =


  sudo qemu-img create -f qcow2 /home/lab/kvm/images/${NAME}.img 40G && =

  sudo virt-install \ =

  --name ${NAME} \ =

  --ram 716800 \ =

  --vcpus 88 \ =

  --disk path=3D/home/lab/kvm/images/${NAME}.img,format=3Dqcow2 \ =

  --network bridge=3Dvirbr0 \ =

  --graphics none \ =

  --host-device 34:00.0 \ =

  --host-device 36:00.0 \ =

  --host-device 39:00.0 \ =

  --host-device 3b:00.0 \ =

  --host-device 57:00.0 \ =

  --host-device 59:00.0 \ =

  --host-device 5c:00.0 \ =

  --host-device 5e:00.0 \ =

  --host-device 61:00.0 \ =

  --host-device 62:00.0 \ =

  --host-device 63:00.0 \ =

  --host-device 65:00.0 \ =

  --host-device 66:00.0 \ =

  --host-device 67:00.0 \ =

  --host-device 35:00.0 \ =

  --host-device 3a:00.0 \ =

  --host-device 58:00.0 \ =

  --host-device 5d:00.0 \ =

  --host-device 2e:00.0 \ =

  --host-device 2f:00.0 \ =

  --host-device 51:00.0 \ =

  --host-device 52:00.0 \ =

  --host-device b7:00.0 \ =

  --host-device b9:00.0 \ =

  --host-device bc:00.0 \ =

  --host-device be:00.0 \ =

  --host-device e0:00.0 \ =

  --host-device e2:00.0 \ =

  --host-device e5:00.0 \ =

  --host-device e7:00.0 \ =

  --host-device c1:00.0 \ =

  --host-device c2:00.0 \ =

  --host-device c3:00.0 \ =

  --host-device c5:00.0 \ =

  --host-device c6:00.0 \ =

  --host-device c7:00.0 \ =

  --host-device b8:00.0 \ =

  --host-device bd:00.0 \ =

  --host-device e1:00.0 \ =

  --host-device e6:00.0 \ =

  --host-device b1:00.0 \ =

  --host-device b2:00.0 \ =

  --host-device da:00.0 \ =

  --host-device db:00.0 \ =

  --console pty,target_type=3Dserial \ =

  --location http://ftp.ubuntu.com/ubuntu/dists/xenial/main/installer-amd64=
 \ =

  --initrd-inject=3D/home/lab/kvm/images/preseed.cfg \ =

  --extra-args=3D" =

  console=3DttyS0,115200 =

  locale=3Den_US =

  console-keymaps-at/keymap=3Dus =

  console-setup/ask_detect=3Dfalse =

  console-setup/layoutcode=3Dus =

  keyboard-configuration/layout=3DUSA =

  keyboard-configuration/variant=3DUSA =

  hostname=3D${NAME} =

  file=3Dfile:/preseed.cfg =

  "

  Passing > 32 device causes this issue:  32nd device hits a DPC error
  and the host/HV crashes:

  =

  Apr 25 22:34:35 xpl-evt-16 kernel: [18125.977496] dpc 0000:5b:10.0:pcie21=
0: DPC containment event, status:0x0009 source:0x0000
  Apr 25 22:34:35 xpl-evt-16 kernel: [18125.977500] dpc 0000:5b:10.0:pcie21=
0: DPC unmasked uncorrectable error detected, remove downstream devices
  Apr 25 22:34:35 xpl-evt-16 kernel: [18125.994326] vfio-pci 0000:5e:00.0: =
Refused to change power state, currently in D3
  Apr 25 22:34:35 xpl-evt-16 kernel: [18125.994427] iommu: Removing device =
0000:5e:00.0 from group 92

  =

  From syslog (attached)

  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.194358] dpc 0000:bb:04.0:pcie21=
0: DPC error containment capabilities: Int Msg #3, RPExt- PoisonedTLP+ SwTr=
igger+ RP PIO Log 0, DL_ActiveErr+
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.194387] dpc 0000:bb:10.0:pcie21=
0: DPC error containment capabilities: Int Msg #3, RPExt- PoisonedTLP+ SwTr=
igger+ RP PIO Log 0, DL_ActiveErr+
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.194413] dpc 0000:d9:00.0:pcie21=
0: DPC error containment capabilities: Int Msg #3, RPExt- PoisonedTLP+ SwTr=
igger+ RP PIO Log 0, DL_ActiveErr+
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.194439] dpc 0000:d9:01.0:pcie21=
0: DPC error containment capabilities: Int Msg #3, RPExt- PoisonedTLP+ SwTr=
igger+ RP PIO Log 0, DL_ActiveErr+
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.194472] dpc 0000:d9:02.0:pcie21=
0: DPC error containment capabilities: Int Msg #3, RPExt- PoisonedTLP+ SwTr=
igger+ RP PIO Log 0, DL_ActiveErr+
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.194499] dpc 0000:d9:03.0:pcie21=
0: DPC error containment capabilities: Int Msg #3, RPExt- PoisonedTLP+ SwTr=
igger+ RP PIO Log 0, DL_ActiveErr+
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.194526] dpc 0000:d9:04.0:pcie21=
0: DPC error containment capabilities: Int Msg #3, RPExt- PoisonedTLP+ SwTr=
igger+ RP PIO Log 0, DL_ActiveErr+
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.194553] dpc 0000:d9:0c.0:pcie21=
0: DPC error containment capabilities: Int Msg #3, RPExt- PoisonedTLP+ SwTr=
igger+ RP PIO Log 0, DL_ActiveErr+
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.194583] dpc 0000:df:00.0:pcie21=
0: DPC error containment capabilities: Int Msg #3, RPExt- PoisonedTLP+ SwTr=
igger+ RP PIO Log 0, DL_ActiveErr+
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.194619] dpc 0000:df:04.0:pcie21=
0: DPC error containment capabilities: Int Msg #3, RPExt- PoisonedTLP+ SwTr=
igger+ RP PIO Log 0, DL_ActiveErr+
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.194649] dpc 0000:df:10.0:pcie21=
0: DPC error containment capabilities: Int Msg #3, RPExt- PoisonedTLP+ SwTr=
igger+ RP PIO Log 0, DL_ActiveErr+
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.194679] dpc 0000:e4:00.0:pcie21=
0: DPC error containment capabilities: Int Msg #3, RPExt- PoisonedTLP+ SwTr=
igger+ RP PIO Log 0, DL_ActiveErr+
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.194709] dpc 0000:e4:04.0:pcie21=
0: DPC error containment capabilities: Int Msg #3, RPExt- PoisonedTLP+ SwTr=
igger+ RP PIO Log 0, DL_ActiveErr+
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.194742] dpc 0000:e4:10.0:pcie21=
0: DPC error containment capabilities: Int Msg #3, RPExt- PoisonedTLP+ SwTr=
igger+ RP PIO Log 0, DL_ActiveErr+
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.194763] pciehp 0000:00:1c.0:pci=
e004: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ In=
terlock- NoCompl+ LLActRep+
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.195036] pciehp 0000:60:02.0:pci=
e204: Slot #2 AttnBtn+ PwrCtrl+ MRL+ AttnInd+ PwrInd+ HotPlug+ Surprise- In=
terlock- NoCompl- LLActRep+
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.195278] pciehp 0000:60:0a.0:pci=
e204: Slot #10 AttnBtn+ PwrCtrl+ MRL+ AttnInd+ PwrInd+ HotPlug+ Surprise- I=
nterlock- NoCompl- LLActRep+
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.195513] pciehp 0000:c0:02.0:pci=
e204: Slot #2 AttnBtn+ PwrCtrl+ MRL+ AttnInd+ PwrInd+ HotPlug+ Surprise- In=
terlock- NoCompl- LLActRep+
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.195753] pciehp 0000:c0:0a.0:pci=
e204: Slot #10 AttnBtn+ PwrCtrl+ MRL+ AttnInd+ PwrInd+ HotPlug+ Surprise- I=
nterlock- NoCompl- LLActRep+
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.196196] efifb: probing for efifb
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.196242] efifb: framebuffer at 0=
x9c000000, using 1920k, total 1920k
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.196247] efifb: mode is 800x600x=
32, linelength=3D3200, pages=3D1
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.196250] efifb: scrolling: redraw
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.196254] efifb: Truecolor: size=
=3D8:8:8:8, shift=3D24:16:8:0
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.206652] Console: switching to c=
olour frame buffer device 100x37
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.217034] fb0: EFI VGA frame buff=
er device
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.217173] intel_idle: MWAIT subst=
ates: 0x2020
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.217174] intel_idle: v0.4.1 mode=
l 0x55
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.220874] intel_idle: lapic_timer=
_reliable_states 0xffffffff
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.221219] input: Power Button as =
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.221590] ACPI: Power Button [PWR=
F]
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.231089] ERST: Error Record Seri=
alization Table (ERST) support is initialized.
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.231312] pstore: using zlib comp=
ression
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.231444] pstore: Registered erst=
 as persistent store backend
  Apr 25 22:37:13 xpl-evt-16 kernel: [    2.232503] GHES: APEI firmware fir=
st mode is enabled by APEI bit and WHEA _OSC.


  All PCI devices go offline include NVMe.

  OS Drives go away, RAID-1 is remounted as RO, and eventually system
  crashes.

  =

  Apr 25 22:37:13 xpl-evt-16 rsyslogd-2007: action 'action 9' suspended, ne=
xt retry is Wed Apr 25 22:37:43 2018 [v8.16.0 try http://www.rsyslog.com/e/=
2007 ]
  Apr 25 22:37:13 xpl-evt-16 systemd-udevd[1383]: Process '/sbin/mdadm --in=
cremental /dev/nvme1n1p2 --offroot' failed with exit code 1.
  Apr 25 22:37:13 xpl-evt-16 systemd-udevd[1371]: Process '/sbin/mdadm --in=
cremental /dev/nvme0n1p2 --offroot' failed with exit code 1.
  Apr 25 22:37:13 xpl-evt-16 systemd[1]: Starting Apply Kernel Variables...
  Apr 25 22:37:13 xpl-evt-16 systemd[1]: Mounted Configuration File System.
  Apr 25 22:37:13 xpl-evt-16 systemd[1]: Mounted FUSE Control File System.
  Apr 25 22:37:13 xpl-evt-16 systemd[1]: Started Apply Kernel Variables.
  Apr 25 22:37:13 xpl-evt-16 systemd[1]: Found device /dev/disk/by-uuid/269=
E-631A.
  Apr 25 22:37:13 xpl-evt-16 systemd[1]: Starting File System Check on /dev=
/disk/by-uuid/269E-631A...
  Apr 25 22:37:13 xpl-evt-16 systemd[1]: Started File System Check Daemon t=
o report status.
  Apr 25 22:37:13 xpl-evt-16 systemd-fsck[1576]: fsck.fat 3.0.28 (2015-05-1=
6)
  Apr 25 22:37:13 xpl-evt-16 systemd-fsck[1576]: /dev/nvme0n1p1: 10 files, =
1168/130812 clusters
  Apr 25 22:37:13 xpl-evt-16 systemd[1]: Started File System Check on /dev/=
disk/by-uuid/269E-631A.
  Apr 25 22:37:13 xpl-evt-16 systemd[1]: Mounting /boot/efi...
  Apr 25 22:37:13 xpl-evt-16 systemd[1]: Listening on Load/Save RF Kill Swi=
tch Status /dev/rfkill Watch.
  Apr 25 22:37:13 xpl-evt-16 systemd[1]: Mounted /boot/efi.
  Apr 25 22:37:13 xpl-evt-16 systemd[1]: Reached target Local File Systems.
  Apr 25 22:37:13 xpl-evt-16 systemd[1]: Starting Preprocess NFS configurat=
ion...
  Apr 25 22:37:13 xpl-evt-16 systemd[1]: Starting Create Volatile Files and=
 Directories...
  Apr 25 22:37:13 xpl-evt-16 systemd-tmpfiles[1714]: [/usr/lib/tmpfiles.d/v=
ar.conf:14] Duplicate line for path "/var/log", ignoring.
  Apr 25 22:37:13 xpl-evt-16 systemd[1]: Starting openibd - configure Mella=
nox devices...
  Apr 25 22:37:13 xpl-evt-16 kernel: [    0.000000] random: get_random_byte=
s called from start_kernel+0x42/0x50d with crng_init=3D0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1771238/+subscriptions
