Received: from eggs.gnu.org ([2001:4830:134:3::10]:59659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7i4t-0001rB-EU
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7i4p-0003Jt-37
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:20:07 -0400
Received: from indium.canonical.com ([91.189.90.7]:43396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e7i4o-0003In-Sw
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:20:03 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e7i4n-00061H-QK
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 13:20:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BB5992E80C8
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 13:20:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Oct 2017 13:09:35 -0000
From: Thomas Huth <1079713@bugs.launchpad.net>
Reply-To: Bug 1079713 <1079713@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121116150919.23777.65675.malonedeb@gac.canonical.com>
Message-Id: <150902337578.17209.2312987569469966021.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1079713] Re: failed to set sndbuf on VMs network
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

** Changed in: qemu-kvm (Ubuntu)
       Status: Confirmed =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1079713

Title:
  failed to set sndbuf on VMs network interface

Status in QEMU:
  Incomplete
Status in qemu-kvm package in Ubuntu:
  Incomplete

Bug description:
  I am trying to set "sndbuf" for a VMs network device to "0".
  I inserted to my XML file:
        <tune>
          <sndbuf>0</sndbuf>
        </tune>
  The XML file validates, but I am not able to start the virtual machine.

  # virsh edit vm3
  <domain type=3D'kvm'>
    <name>vm3</name>
    <uuid><HIDDEN></uuid>
    <memory unit=3D'KiB'>524288</memory>
    <currentMemory unit=3D'KiB'>524288</currentMemory>
    <vcpu placement=3D'static'>1</vcpu>
    <os>
      <type arch=3D'x86_64' machine=3D'pc-1.2'>hvm</type>
      <boot dev=3D'hd'/>
    </os>
    <features>
      <acpi/>
      <apic/>
      <pae/>
    </features>
    <clock offset=3D'utc'/>
    <on_poweroff>destroy</on_poweroff>
    <on_reboot>restart</on_reboot>
    <on_crash>restart</on_crash>
    <devices>
      <emulator>/usr/bin/kvm</emulator>
      <disk type=3D'file' device=3D'disk'>
        <driver name=3D'qemu' type=3D'qcow2'/>
        <source file=3D'<HIDDEN>'/>
        <target dev=3D'vda' bus=3D'virtio'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x05' =
function=3D'0x0'/>
      </disk>
      <controller type=3D'usb' index=3D'0'>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x2'/>
      </controller>
      <interface type=3D'bridge'>
        <mac address=3D'<HIDDEN>'/>
        <source bridge=3D'br2'/>
        <model type=3D'virtio'/>
        <tune>
          <sndbuf>0</sndbuf>
        </tune>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x03' =
function=3D'0x0'/>
      </interface>
      <serial type=3D'pty'>
        <target port=3D'0'/>
      </serial>
      <console type=3D'pty'>
        <target type=3D'serial' port=3D'0'/>
      </console>
      <input type=3D'mouse' bus=3D'ps2'/>
      <graphics type=3D'vnc' port=3D'-1' autoport=3D'yes'/>
      <sound model=3D'ich6'>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x04' =
function=3D'0x0'/>
      </sound>
      <video>
        <model type=3D'cirrus' vram=3D'9216' heads=3D'1'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x0'/>
      </video>
      <memballoon model=3D'virtio'>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x06' =
function=3D'0x0'/>
      </memballoon>
    </devices>
  </domain>

  Domain vm3 XML configuration edited.

  # LANG=3Den_US.utf-8 virsh start vm3
  error: Failed to start domain vm3
  error: internal error Process exited while reading console log output: ch=
ar device redirected to /dev/pts/4

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1079713/+subscriptions
