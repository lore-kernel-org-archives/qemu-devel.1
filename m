Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC1FC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55B7E207E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B7E207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mps.mpg.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iycqC-00080Q-G2
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 09:36:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iycQD-0002Ad-W1
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:09:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iycQC-0002b2-CB
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:09:53 -0500
Received: from indium.canonical.com ([91.189.90.7]:42312)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iycQC-0002T8-5e
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:09:52 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iycQA-0003mh-Id
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 14:09:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 7928B2E80CC
 for <qemu-devel@nongnu.org>; Mon,  3 Feb 2020 14:09:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Feb 2020 13:56:38 -0000
From: Borut Podlipnik <podlipnik@mps.mpg.de>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Triaged; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: happykvm michal-nowak-b podlipnik sledge-sulaweyo
 th-huth
X-Launchpad-Bug-Reporter: showrun (happykvm)
X-Launchpad-Bug-Modifier: Borut Podlipnik (podlipnik)
References: <20110810053253.11269.76752.malonedeb@gac.canonical.com>
Message-Id: <158073819884.8645.10605539593864941827.malone@chaenomeles.canonical.com>
Subject: [Bug 823733] Re: Soloaris can't be poweroff
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0a62c17273454a1313f81a74a2198ec30b44c7b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: d149054756ccb13ae4e60ff37267f98f18dbff33
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Mon, 03 Feb 2020 09:34:40 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 823733 <823733@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This bug was reported almost 9 years ago and still nobody take care
about it...

# kvm -version
QEMU emulator version 4.1.1 (pve-qemu-kvm_4.1.1)
Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

# more /etc/os-release =

PRETTY_NAME=3D"Debian GNU/Linux 10 (buster)"
NAME=3D"Debian GNU/Linux"
VERSION_ID=3D"10"
VERSION=3D"10 (buster)"
VERSION_CODENAME=3Dbuster
ID=3Ddebian
HOME_URL=3D"https://www.debian.org/"
SUPPORT_URL=3D"https://www.debian.org/support"
BUG_REPORT_URL=3D"https://bugs.debian.org/"

Guest OS: Solaris 11.4

# /usr/sbin/qm shutdown 101
VM quit/powerdown failed - got timeout

# /usr/sbin/qm reboot 101
VM quit/powerdown failed - got timeout

Not able to shutdown/reboot Solaris 11

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/823733

Title:
  Soloaris can't be poweroff

Status in QEMU:
  Triaged

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

