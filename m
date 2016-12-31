Received: from eggs.gnu.org ([2001:4830:134:3::10]:44958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cNBIs-0002Wd-EK
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 23:30:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cNBIo-0006I8-Fn
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 23:29:58 -0500
Received: from indium.canonical.com ([91.189.90.7]:41519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cNBIo-0006Hv-9e
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 23:29:54 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cNBIl-0008Of-8j
	for <qemu-devel@nongnu.org>; Sat, 31 Dec 2016 04:29:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B506C2E819B
	for <qemu-devel@nongnu.org>; Sat, 31 Dec 2016 04:29:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Dec 2016 04:17:27 -0000
From: Launchpad Bug Tracker <1270397@bugs.launchpad.net>
Reply-To: Bug 1270397 <1270397@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140118101809.30943.54673.malonedeb@soybean.canonical.com>
Message-Id: <20161231041728.5270.1450.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1270397] Re: Systemd segfaults after live
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1270397

Title:
  Systemd segfaults after live migration

Status in QEMU:
  Expired

Bug description:
  After live migrating my virtual machine it panics because of
  segmentation fault in systemd (see attachment).

  Software used (on archlinux):
  qemu 1.7.0-1
  libvirt 1.2.0-1
  linux 3.12.7-1

  This is configuration of this VM:
  <domain type=3D'kvm'>
    <name>vbroker</name>
    <uuid>455c9c62-10a6-11e3-a7f2-441ea153aac8</uuid>
    <description>455c9c62-10a6-11e3-a7f2-441ea153aac8</description>
    <memory unit=3D'KiB'>6291456</memory>
    <currentMemory unit=3D'KiB'>6291456</currentMemory>
    <vcpu placement=3D'static'>4</vcpu>
    <os>
      <type arch=3D'x86_64' machine=3D'pc-i440fx-1.7'>hvm</type>
      <boot dev=3D'cdrom'/>
      <bootmenu enable=3D'no'/>
    </os>
    <features>
      <acpi/>
      <apic/>
    </features>
    <clock offset=3D'utc'/>
    <on_poweroff>destroy</on_poweroff>
    <on_reboot>restart</on_reboot>
    <on_crash>restart</on_crash>
    <devices>
      <emulator>/usr/bin/qemu-kvm</emulator>
      <disk type=3D'file' device=3D'disk'>
        <driver name=3D'qemu' type=3D'qcow2' cache=3D'none'/>
        <source file=3D'/var/lib/libvirt/images/archipel/drives/455c9c62-10=
a6-11e3-a7f2-441ea153aac8/vbroker.qcow2'/>
        <target dev=3D'vda' bus=3D'virtio'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x04' =
function=3D'0x0'/>
      </disk>
      <controller type=3D'usb' index=3D'0'>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x2'/>
      </controller>
      <controller type=3D'pci' index=3D'0' model=3D'pci-root'/>
      <interface type=3D'bridge'>
        <mac address=3D'de:ad:fb:8e:17:c2'/>
        <source bridge=3D'br0'/>
        <model type=3D'virtio'/>
        <filterref filter=3D'clean-traffic'>
          <parameter name=3D'IP' value=3D'10.0.0.2'/>
        </filterref>
        <bandwidth>
        </bandwidth>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x03' =
function=3D'0x0'/>
      </interface>
      <input type=3D'tablet' bus=3D'usb'/>
      <input type=3D'mouse' bus=3D'ps2'/>
      <graphics type=3D'vnc' port=3D'-1' autoport=3D'yes' keymap=3D'en-us'/>
      <video>
        <model type=3D'cirrus' vram=3D'9216' heads=3D'1'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x0'/>
      </video>
      <memballoon model=3D'virtio'>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x05' =
function=3D'0x0'/>
      </memballoon>
    </devices>
  </domain>

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1270397/+subscriptions
