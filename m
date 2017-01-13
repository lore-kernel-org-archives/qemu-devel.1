Received: from eggs.gnu.org ([2001:4830:134:3::10]:39348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRwnU-0005V3-Rm
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:01:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRwnQ-00033w-CU
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:01:16 -0500
Received: from indium.canonical.com ([91.189.90.7]:42497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cRwnQ-000324-3p
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:01:12 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cRwnO-0001fr-C6
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 08:01:10 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 574BC2E80C4
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 08:01:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Jan 2017 07:54:51 -0000
From: Thomas Huth <1654271@bugs.launchpad.net>
Reply-To: Bug 1654271 <1654271@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170105132004.20028.66892.malonedeb@wampee.canonical.com>
Message-Id: <20170113075451.20994.22813.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1654271] Re: host machine freezes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Moving this to the Ubuntu-qemu bug tracker since you're apparently using
Ubuntu's QEMU, not the upstream QEMU.

** Project changed: qemu =3D> qemu (Ubuntu)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1654271

Title:
  host machine freezes

Status in qemu package in Ubuntu:
  New

Bug description:
  When trying to install Radeon crimson relive 16.12.1, each host machine f=
reezes at the machine environment check stage.
  Even if you launch the installer in an environment where GPU is not insta=
lled, each host machine freezes in the same way.
  When Gusest's CPU is changed from 4 to 1, the environment check is comple=
ted normally.
  Even if FMA and AVX 2 are invalidated by CPU setting, environment check w=
ill be completed normally.
  Since 1 CPU does not freeze, I thought that it would be better to fix the=
 CPU, but I will still freeze.
  Is it impossible to enable the function of AVX 2 (FMA?) In the virtual ma=
chine on KVM?

  HOST
    Motherboard =EF=BC=9A Asrock Z97 extream6
    CPU          : Core i7-4790
    Memory       : 24GB
    OS           : Ubuntu 16.04(kernel 4.7.2-040702)
    qemu         : 2.5+dfsg-5ubuntu10.6
    libvirt      : 1.3.1-1ubuntu10.5
    ovmf         : 0~20160408.ffea0a2c-2

  Guest
  =E3=80=80BIOS   : UEFI
    OS     : Windows10 Pro Build 14986
    Memory : 8GB
    GPU    : Radeon HD7770

  -----------------------------------------------------------
  <domain type=3D'kvm'>
    <name>WinPC01</name>
    <uuid>4f784d78-4d5e-416a-bb43-82ecd2cad409</uuid>
    <memory unit=3D'KiB'>8388608</memory>
    <currentMemory unit=3D'KiB'>8388608</currentMemory>
    <vcpu placement=3D'static'>4</vcpu>
    <os>
      <type arch=3D'x86_64' machine=3D'pc-i440fx-2.5'>hvm</type>
      <loader readonly=3D'yes' type=3D'pflash'>/usr/share/OVMF/OVMF_CODE.fd=
</loader>
      <nvram>/var/lib/libvirt/qemu/nvram/WinPC01_VARS.fd</nvram>
      <bootmenu enable=3D'yes'/>
    </os>
    <features>
      <acpi/>
      <apic/>
      <pae/>
      <hap/>
      <hyperv>
        <relaxed state=3D'on'/>
        <vapic state=3D'on'/>
        <spinlocks state=3D'on' retries=3D'8191'/>
      </hyperv>
      <kvm>
        <hidden state=3D'on'/>
      </kvm>
    </features>
    <cpu mode=3D'custom' match=3D'exact'>
      <model fallback=3D'allow'>Haswell</model>
      <vendor>Intel</vendor>
      <topology sockets=3D'1' cores=3D'4' threads=3D'1'/>
    </cpu>
    <clock offset=3D'localtime'>
      <timer name=3D'rtc' tickpolicy=3D'catchup'/>
      <timer name=3D'pit' tickpolicy=3D'delay'/>
      <timer name=3D'hpet' present=3D'no'/>
      <timer name=3D'hypervclock' present=3D'yes'/>
    </clock>
    <on_poweroff>destroy</on_poweroff>
    <on_reboot>restart</on_reboot>
    <on_crash>restart</on_crash>
    <pm>
      <suspend-to-mem enabled=3D'no'/>
      <suspend-to-disk enabled=3D'no'/>
    </pm>
    <devices>
      <emulator>/usr/bin/kvm-spice</emulator>
      <disk type=3D'block' device=3D'disk'>
        <driver name=3D'qemu' type=3D'raw' cache=3D'none' io=3D'native' dis=
card=3D'unmap'/>
        <source dev=3D'/dev/mapper/vg_yoshi--kvm01_ssd-lv_WinPC01'/>
        <target dev=3D'sda' bus=3D'scsi'/>
        <boot order=3D'1'/>
        <address type=3D'drive' controller=3D'0' bus=3D'0' target=3D'0' uni=
t=3D'0'/>
      </disk>
      <disk type=3D'block' device=3D'disk'>
        <driver name=3D'qemu' type=3D'raw' cache=3D'none' io=3D'native'/>
        <source dev=3D'/dev/mapper/vg_yoshi--kvm01_hdd-lv_WinPC01_Data'/>
        <target dev=3D'sdb' bus=3D'scsi'/>
        <address type=3D'drive' controller=3D'0' bus=3D'0' target=3D'0' uni=
t=3D'1'/>
      </disk>
      <disk type=3D'file' device=3D'cdrom'>
        <driver name=3D'qemu' type=3D'raw'/>
        <target dev=3D'hdb' bus=3D'ide'/>
        <readonly/>
        <address type=3D'drive' controller=3D'0' bus=3D'0' target=3D'0' uni=
t=3D'1'/>
      </disk>
      <controller type=3D'usb' index=3D'0' model=3D'ich9-ehci1'>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x05' =
function=3D'0x7'/>
      </controller>
      <controller type=3D'usb' index=3D'0' model=3D'ich9-uhci1'>
        <master startport=3D'0'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x05' =
function=3D'0x0' multifunction=3D'on'/>
      </controller>
      <controller type=3D'usb' index=3D'0' model=3D'ich9-uhci2'>
        <master startport=3D'2'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x05' =
function=3D'0x1'/>
      </controller>
      <controller type=3D'usb' index=3D'0' model=3D'ich9-uhci3'>
        <master startport=3D'4'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x05' =
function=3D'0x2'/>
      </controller>
      <controller type=3D'pci' index=3D'0' model=3D'pci-root'/>
      <controller type=3D'ide' index=3D'0'>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x1'/>
      </controller>
      <controller type=3D'virtio-serial' index=3D'0'>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x06' =
function=3D'0x0'/>
      </controller>
      <controller type=3D'sata' index=3D'0'>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x0c' =
function=3D'0x0'/>
      </controller>
      <controller type=3D'scsi' index=3D'0' model=3D'virtio-scsi'>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x0f' =
function=3D'0x0'/>
      </controller>
      <interface type=3D'bridge'>
        <mac address=3D'52:54:00:0e:ca:c5'/>
        <source bridge=3D'br0'/>
        <model type=3D'virtio'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x03' =
function=3D'0x0'/>
      </interface>
      <interface type=3D'bridge'>
        <mac address=3D'52:54:00:7e:4e:dd'/>
        <source bridge=3D'br1'/>
        <model type=3D'virtio'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x04' =
function=3D'0x0'/>
      </interface>
      <channel type=3D'spicevmc'>
        <target type=3D'virtio' name=3D'com.redhat.spice.0'/>
        <address type=3D'virtio-serial' controller=3D'0' bus=3D'0' port=3D'=
1'/>
      </channel>
      <input type=3D'tablet' bus=3D'usb'/>
      <input type=3D'mouse' bus=3D'ps2'/>
      <input type=3D'keyboard' bus=3D'ps2'/>
      <graphics type=3D'spice' port=3D'5900' autoport=3D'no' listen=3D'0.0.=
0.0' keymap=3D'ja'>
        <listen type=3D'address' address=3D'0.0.0.0'/>
      </graphics>
      <video>
        <model type=3D'qxl' ram=3D'65536' vram=3D'65536' vgamem=3D'16384' h=
eads=3D'1'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x0'/>
      </video>
      <hostdev mode=3D'subsystem' type=3D'pci' managed=3D'yes'>
        <source>
          <address domain=3D'0x0000' bus=3D'0x01' slot=3D'0x00' function=3D=
'0x0'/>
        </source>
        <rom bar=3D'off'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x08' =
function=3D'0x0' multifunction=3D'on'/>
      </hostdev>
      <hostdev mode=3D'subsystem' type=3D'pci' managed=3D'yes'>
        <source>
          <address domain=3D'0x0000' bus=3D'0x01' slot=3D'0x00' function=3D=
'0x1'/>
        </source>
        <rom bar=3D'off'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x09' =
function=3D'0x0'/>
      </hostdev>
      <hostdev mode=3D'subsystem' type=3D'pci' managed=3D'yes'>
        <source>
          <address domain=3D'0x0000' bus=3D'0x00' slot=3D'0x14' function=3D=
'0x0'/>
        </source>
        <rom bar=3D'off'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x0a' =
function=3D'0x0'/>
      </hostdev>
      <hostdev mode=3D'subsystem' type=3D'pci' managed=3D'yes'>
        <source>
          <address domain=3D'0x0000' bus=3D'0x00' slot=3D'0x1d' function=3D=
'0x0'/>
        </source>
        <rom bar=3D'off'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x0b' =
function=3D'0x0'/>
      </hostdev>
      <memballoon model=3D'virtio'>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x07' =
function=3D'0x0'/>
      </memballoon>
    </devices>
  </domain>
  -----------------------------------------------------------

  If you put the following designation in the CPU tag, it will not freeze.
  -----------------------------------------------------------
      <feature policy=3D'disable' name=3D'fma'/>
      <feature policy=3D'disable' name=3D'avx2'/>
  -----------------------------------------------------------

To manage notifications about this bug go to:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1654271/+subscriptions
