Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01166C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 14:53:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84DE821BE5
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 14:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84DE821BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDr7S-00009Q-9u
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 10:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jDaXE-00076D-6q
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 17:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jDaXC-0007dQ-SY
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 17:11:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:57242)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jDaXC-0007ah-Mr
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 17:10:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jDaXB-0000Qk-0Y
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 21:10:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E9E7F2E807B
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 21:10:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Mar 2020 21:02:31 -0000
From: Jon Hood <squinky86@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: albrt brogers-q dgilbert-h himbeere lersek
 squinky86 tstrike34 vkuznets
X-Launchpad-Bug-Reporter: Thomas (himbeere)
X-Launchpad-Bug-Modifier: Jon Hood (squinky86)
References: <154833838504.19548.14915901097039330455.malonedeb@gac.canonical.com>
Message-Id: <158430615177.19236.13540584613040007755.malone@chaenomeles.canonical.com>
Subject: [Bug 1813165] Re: KVM internal error. Suberror: 1 emulation failure
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="3a6db24bbe7280ec09bae73384238390fcc98ad3";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: d6311a97c426daf284f47c2c4b3da3619cf0cdd8
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Mon, 16 Mar 2020 10:26:18 -0400
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
Reply-To: Bug 1813165 <1813165@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I created a new bug request to track the Ubuntu 20.04 package (bug
#1867545)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1813165

Title:
  KVM internal error. Suberror: 1 emulation failure

Status in QEMU:
  New

Bug description:
  Hello Devs.

  Having problems getting VM to run with qemu 3.1.0. I should mention
  it's a nested configuration.

  2019-01-24 13:46:08.648+0000: starting up libvirt version: 4.10.0, qemu v=
ersion: 3.1.0, kernel: 4.14.94, hostname: one....
  LC_ALL=3DC PATH=3D/bin:/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/bin:/usr/=
sbin:/usr/local/bin:/usr/local/sbin:/opt/bin HOME=3D/root USER=3Droot QEMU_=
AUDIO_DRV=3Dnone /usr/bin/kvm -name guest=3Done-266,debug-threads=3Don -S -=
object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/dom=
ain-1-one-266/master-key.aes -machine pc-i440fx-2.9,accel=3Dkvm,usb=3Doff,d=
ump-guest-core=3Doff -cpu Skylake-Client-IBRS,ss=3Don,hypervisor=3Don,tsc_a=
djust=3Don,clflushopt=3Don,ssbd=3Don,xsaves=3Don,pdpe1gb=3Don -m 1024 -real=
time mlock=3Doff -smp 2,sockets=3D2,cores=3D1,threads=3D1 -uuid b219b45d-a2=
f0-4128-a948-8673a7abf968 -no-user-config -nodefaults -chardev socket,id=3D=
charmonitor,fd=3D21,server,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,m=
ode=3Dcontrol -rtc base=3Dutc -no-shutdown -boot strict=3Don -device piix3-=
usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -drive file=3D/var/lib/one//da=
tastores/0/266/disk.0,format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio-disk0,cach=
e=3Dnone -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x4,drive=3Dd=
rive-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1,write-cache=3Don -drive f=
ile=3D/var/lib/one//datastores/0/266/disk.1,format=3Draw,if=3Dnone,id=3Ddri=
ve-ide0-0-0,readonly=3Don -device ide-cd,bus=3Dide.0,unit=3D0,drive=3Ddrive=
-ide0-0-0,id=3Dide0-0-0 -netdev tap,fd=3D23,id=3Dhostnet0 -device rtl8139,n=
etdev=3Dhostnet0,id=3Dnet0,mac=3D02:00:00:76:69:85,bus=3Dpci.0,addr=3D0x3 -=
chardev pty,id=3Dcharserial0 -device isa-serial,chardev=3Dcharserial0,id=3D=
serial0 -vnc 0.0.0.0:266 -device cirrus-vga,id=3Dvideo0,bus=3Dpci.0,addr=3D=
0x2 -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x5 -sandbo=
x on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourcecontrol=
=3Ddeny -msg timestamp=3Don
  char device redirected to /dev/pts/1 (label charserial0)
  KVM internal error. Suberror: 1
  emulation failure
  EAX=3D00000001 EBX=3D000f7c2c ECX=3D00000001 EDX=3D00000001
  ESI=3D00006a26 EDI=3D3ffbdc48 EBP=3D000069e6 ESP=3D000a8000
  EIP=3D000fd057 EFL=3D00010016 [----AP-] CPL=3D0 II=3D0 A20=3D1 SMM=3D1 HL=
T=3D0
  ES =3D0010 00000000 ffffffff 00c09300
  CS =3D0000 00000000 00000fff 00809b00
  SS =3D0010 00000000 ffffffff 00c09300
  DS =3D0010 00000000 ffffffff 00c09300
  FS =3D0010 00000000 ffffffff 00c09300
  GS =3D0010 00000000 ffffffff 00c09300
  LDT=3D0000 00000000 0000ffff 00008200
  TR =3D0000 00000000 0000ffff 00008b00
  GDT=3D     10387cfe 0000fe6c
  IDT=3D     0010387c 00003810
  CR0=3D00000010 CR2=3D00000000 CR3=3D00000000 CR4=3D00000000
  DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 DR3=
=3D0000000000000000
  DR6=3D00000000fffecffc DR7=3D000000000e1e0400
  EFER=3D0000000000000000
  Code=3Dcb 66 ba 4d d0 0f 00 e9 c8 fe bc 00 80 0a 00 e8 31 3a ff ff <0f> a=
a fa fc 66 ba 66 d0 0f 00 e9 b1 fe f3 90 f0 0f ba 2d ac 3b 0f 00 00 72 f3 8=
b 25 a8 3b
  2019-01-24T13:47:39.383366Z kvm: terminating on signal 15 from pid 2708 (=
/usr/sbin/libvirtd)

  Someone has an idea whats going wrong here?

  thanks and cheers
  t.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1813165/+subscriptions

