Received: from eggs.gnu.org ([2001:4830:134:3::10]:51098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dLJ7a-0002iY-PL
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 20:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dLJ7W-00031E-QZ
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 20:58:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:38146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dLJ7W-000319-K8
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 20:58:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dLFb0-0007g3-Vp
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 21:12:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BF5522E85AC
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 21:11:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Jun 2017 20:28:58 -0000
From: Thomas Huth <823733@bugs.launchpad.net>
Reply-To: Bug 823733 <823733@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110810053253.11269.76752.malonedeb@gac.canonical.com>
Message-Id: <149747213838.1324.2684709954965181982.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 823733] Re: Soloaris can't be poweroff
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets ... can you still reproduce this problem with
the latest version of QEMU (currently version 2.9.0)?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/823733

Title:
  Soloaris can't be poweroff

Status in QEMU:
  Incomplete

Bug description:
  Thank you forgive my poor English.

  It seems KVM can=E2=80=99t poweroff solairs 10 or sloalrs 11 VM.
  I have created solaris 10 and 11 as usual. Everything in VM is running OK=
, but finally I use shell command =E2=80=98poweroff=E2=80=99 or =E2=80=98in=
it 5=E2=80=99, the solaris VM (both 10 & 11) system could=E2=80=99t be powe=
roff but with promoting me the message: perss any key to reboot =E2=80=A6..=
  ,I pressed any key in vnc client, solaris VM reboot immediately. Endless =
reboot loop above.

  the solaris 10 & 11 from oracle iso file name :
  sol-10-u9-ga-x86-dvd.iso
  sol-11-exp-201011-text-x86.iso

  the solaris 10 & 11 from oracle iso file name :
  sol-10-u9-ga-x86-dvd.iso
  sol-11-exp-201011-text-x86.iso

  1. On my real physical machine,the solaris can be poweroff
  2. On vmware ,the solaris can be poweroff
  3. On my real physical machine,I have try to disbale the ACPI opiton in B=
OIS, then the solaris can't be poweroff,Like the problem I have described a=
bove
  so ,I doubt the KVM has a little problem in ACPI =


  I have try the suggestion as follows, but I can=E2=80=99t solve the probl=
em.
  7.2 Solaris reboot all the time on grub menu
  =E2=80=A2	Run through the installer as usual =

  =E2=80=A2	On completion and reboot, the VM will perpetually reboot. "Stop=
" the VM. =

  =E2=80=A2	Start it up again, and immediately open a vnc console and selec=
t the Safe Boot from the options screen =

  =E2=80=A2	When prompted if you want to try and recover the boot block, sa=
y yes =

  =E2=80=A2	You should now have a Bourne terminal with your existing filesy=
stem mounted on /a =

  =E2=80=A2	Run /a/usr/bin/bash (my preferred shell) =

  =E2=80=A2	export TERM=3Dxterm =

  =E2=80=A2	vi /a/boot/grub/menu.1st (editing the bootloader on your mounte=
d filesystem), to add "kernel/unix" to the kernel options for the non-safe-=
mode boot. Ex : =

  Config File : /a/boot/grub/menu.lst =

  kernel$ /platform/i86pc/multiboot -B $ZFS-BOOTFS kernel/unix

  According to KVM requirements, I collected the following information:
  CPU model name
  model name      : Intel(R) Xeon(R) CPU           X3450  @ 2.67GHz

  kvm -version
  QEMU PC emulator version 0.12.3 (qemu-kvm-0.12.3), Copyright (c) 2003-200=
8 Fabrice Bellard

  Host kernel version
  Ubuntu 10.04.1 LTS   2.6.32-25-server =


  What host kernel arch you are using (i386 or x86_64)
  X86_64

  Guest OS
  Solaris 10 and Solaris 11=EF=BC=8Cboth can not shutdown

  The qemu command line you are using to start the guest

  First, I used the command line as follows:
  kvm -m 1024 -drive file=3Dsolaris10.img,cache=3Dwriteback -net nic -net u=
ser -nographic -vnc :1
  then I try to use -no-kvm-irqchip or -no-kvm ,but the problem also appear=
s!

  Secondly, have created and run solaris 10&11 by using Virsh, still solari=
s can't be poweroff, the XML file content is :
  <domain type=3D'kvm'>
      <name>solairs</name>
      <uuid>85badf15-244d-4719-a2da-8c3de064137d</uuid>
      <memory>1677721</memory>
      <currentMemory>1677721</currentMemory>
      <vcpu>1</vcpu>
      <os>
      <type arch=3D'i686' machine=3D'pc-0.12'>hvm</type>
        <boot dev=3D'hd'/>
     </os>
     <features>
      <acpi/>
      <apic/>
     </features>
    <clock offset=3D'utc'/>
     <on_poweroff>destroy</on_poweroff>
    <on_reboot>restart</on_reboot>
     <on_crash>destroy</on_crash>
     <devices>
       <emulator>/usr/bin/kvm</emulator>
       <disk type=3D'file' device=3D'disk'>
        <driver name=3D'qemu' type=3D'qcow2' cache=3D'writeback'/>
         <source file=3D'/opt/GuestOS/solaris10.img'/>
         <target dev=3D'hda' bus=3D'ide'/>
       </disk>
      <interface type=3D'bridge'>
        <mac address=3D'00:0c:29:d0:36:c3'/>
        <source bridge=3D'br1'/>
        <target dev=3D'vnet0'/>
       </interface>
       <input type=3D'mouse' bus=3D'ps2'/>
       <graphics type=3D'vnc' port=3D'5901' autoport=3D'no' keymap=3D'en-us=
'/>
      <video>
        <model type=3D'vga' vram=3D'65536' heads=3D'1'/>
      </video>
    </devices>
    <seclabel type=3D'dynamic' model=3D'apparmor'>
      <label>libvirt-f36f5289-692e-6f1c-fe71-c6ed19453e2f</label>
      <imagelabel>libvirt-f36f5289-692e-6f1c-fe71-c6ed19453e2f</imagelabel>
    </seclabel>
   </domain>

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/823733/+subscriptions
