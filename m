Received: from eggs.gnu.org ([2001:4830:134:3::10]:38189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dYANF-0005j7-Nf
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:16:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dYANE-00007c-1D
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:16:09 -0400
Received: from indium.canonical.com ([91.189.90.7]:41290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dYAND-00007M-Qy
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:16:07 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dYANC-0007S2-RB
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 12:16:06 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CC9332E8079
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 12:16:06 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Jul 2017 12:00:14 -0000
From: Thomas Huth <1192780@bugs.launchpad.net>
Reply-To: Bug 1192780 <1192780@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130620024232.3801.5553.malonedeb@soybean.canonical.com>
Message-Id: <150055201508.24827.16821186853109307811.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1192780] Re: qemu-kvm with snapshot option always
 fails with Permission denied Could not open disk image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

According to Eric's comments, this was a libvirt bug, not a QEMU bug, so
closing this ticket now. If you still encounter this problem, please
report it to the libvirt project instead.

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1192780

Title:
  qemu-kvm with snapshot option always fails with Permission denied
  Could not open disk image

Status in QEMU:
  Invalid

Bug description:
  I'm trying to use the option: -snapshot       write to temporary files
  instead of disk image files

  How to reproduce? See following log:
  2013-06-20 02:13:18.532+0000: starting up
  LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/sbin:/sbin=
:/bin QEMU_AUDIO_DRV=3Dnone /usr/bin/qemu-system-x86_64 -S -M pc-1.0 -no-kv=
m -m 512 -smp 1,sockets=3D1,cores=3D1,threads=3D1 -name instance-0000002b -=
uuid 2d600758-ae56-48b8-bd4d-999744a038e4 -nodefconfig -nodefaults -chardev=
 socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/instance-0000002b.mon=
itor,server,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -=
rtc base=3Dutc -no-shutdown -kernel /opt/stack/data/nova/instances/instance=
-0000002b/kernel -initrd /opt/stack/data/nova/instances/instance-0000002b/r=
amdisk -append root=3D/dev/vda console=3DttyS0 -drive file=3D/opt/stack/dat=
a/nova/instances/instance-0000002b/disk,if=3Dnone,id=3Ddrive-virtio-disk0,f=
ormat=3Dqcow2,cache=3Dnone -device virtio-blk-pci,bus=3Dpci.0,addr=3D0x4,dr=
ive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0 -drive if=3Dnone,media=3Dcdrom,i=
d=3Ddrive-ide0-1-0,readonly=3Don,format=3Draw -device ide-drive,bus=3Dide.1=
,unit=3D0,drive=3Ddrive-ide0-1-0,id=3Dide0-1-0 -netdev tap,fd=3D19,id=3Dhos=
tnet0 -device rtl8139,netdev=3Dhostnet0,id=3Dnet0,mac=3Dfa:16:3e:03:ab:18,b=
us=3Dpci.0,addr=3D0x3 -chardev file,id=3Dcharserial0,path=3D/opt/stack/data=
/nova/instances/instance-0000002b/console.log -device isa-serial,chardev=3D=
charserial0,id=3Dserial0 -chardev pty,id=3Dcharserial1 -device isa-serial,c=
hardev=3Dcharserial1,id=3Dserial1 -usb -device usb-tablet,id=3Dinput0 -vnc =
127.0.0.1:26868 -k en-us -vga cirrus -device virtio-balloon-pci,id=3Dballoo=
n0,bus=3Dpci.0,addr=3D0x5 -snapshot
  Domain id=3D1 is tainted: custom-argv
  char device redirected to /dev/pts/18
  qemu-system-x86_64: -drive file=3D/opt/stack/data/nova/instances/instance=
-0000002b/disk,if=3Dnone,id=3Ddrive-virtio-disk0,format=3Dqcow2,cache=3Dnon=
e: could not open disk image /opt/stack/data/nova/instances/instance-000000=
2b/disk: Permission denied
  2013-06-20 02:13:18.683+0000: shutting down

  Version: QEMU emulator version 1.0 (qemu-kvm-1.0), Copyright (c)
  2003-2008 Fabrice Bellard

  Related info:
  The disk is a qcow2 image with a backing file. Both the backing file and =
the disk are cmodded with 777.

  This is a log from dmesg related to apparmor:
  [  236.531287] type=3D1400 audit(1371694399.156:17): apparmor=3D"STATUS" =
operation=3D"profile_remove" name=3D"libvirt-2d600758-ae56-48b8-bd4d-999744=
a038e4" pid=3D4201 comm=3D"apparmor_parser"

  =

  libvirt.xml that I'm using:
  <domain type=3D"qemu" xmlns:qemu=3D'http://libvirt.org/schemas/domain/qem=
u/1.0'>
    <uuid>2d600758-ae56-48b8-bd4d-999744a038e4</uuid>
    <name>instance-0000002b</name>
    <memory>524288</memory>
    <vcpu>1</vcpu>
    <os>
      <type>hvm</type>
      <kernel>/opt/stack/data/nova/instances/instance-0000002b/kernel</kern=
el>
      <initrd>/opt/stack/data/nova/instances/instance-0000002b/ramdisk</ini=
trd>
      <cmdline>root=3D/dev/vda console=3DttyS0</cmdline>
    </os>
    <features>
      <acpi/>
      <apic/>
    </features>
    <clock offset=3D"utc"/>
    <devices>
      <disk type=3D"file" device=3D"disk">
        <driver name=3D"qemu" type=3D"qcow2" cache=3D"none"/>
        <source file=3D"/opt/stack/data/nova/instances/instance-0000002b/di=
sk"/>
        <target bus=3D"virtio" dev=3D"vda"/>
      </disk>
      <disk type=3D"block" device=3D"cdrom">
        <driver name=3D"qemu" type=3D"raw"/>
        <target tray=3D"open" dev=3D"hdc"/>
        <readonly/>
      </disk>
      <interface type=3D"bridge">
        <mac address=3D"fa:16:3e:03:ab:18"/>
        <source bridge=3D"br100"/>
        <filterref filter=3D"nova-instance-instance-0000002b-fa163e03ab18">
          <parameter name=3D"IP" value=3D"10.0.0.3"/>
          <parameter name=3D"DHCPSERVER" value=3D"10.0.0.1"/>
          <parameter name=3D"PROJNET" value=3D"10.0.0.0"/>
          <parameter name=3D"PROJMASK" value=3D"255.255.255.0"/>
        </filterref>
      </interface>
      <serial type=3D"file">
        <source path=3D"/opt/stack/data/nova/instances/instance-0000002b/co=
nsole.log"/>
      </serial>
      <serial type=3D"pty"/>
      <input type=3D"tablet" bus=3D"usb"/>
      <graphics type=3D"vnc" autoport=3D"no" port=3D"32768" keymap=3D"en-us=
" listen=3D"127.0.0.1"/>
    </devices>
  <qemu:commandline>
     <qemu:arg value=3D'-snapshot'/>
  </qemu:commandline>
  </domain>

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1192780/+subscriptions
