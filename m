Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EABC2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 21:06:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5764B206CB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 21:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5764B206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijUua-0008Jp-D0
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 16:06:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ijUtj-0007RS-0z
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 16:05:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ijUth-0007IL-GT
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 16:05:50 -0500
Received: from indium.canonical.com ([91.189.90.7]:48656)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ijUth-0007Hc-Ap
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 16:05:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ijUtf-0007WY-GI
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 21:05:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 65E4C2E80C9
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 21:05:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Dec 2019 20:59:46 -0000
From: John Snow <1814420@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: cyent jnsnow
X-Launchpad-Bug-Reporter: Cheng Chen (cyent)
X-Launchpad-Bug-Modifier: John Snow (jnsnow)
References: <154917558063.31331.8037825405478358224.malonedeb@gac.canonical.com>
Message-Id: <157713478616.27216.1629612985053907510.malone@chaenomeles.canonical.com>
Subject: [Bug 1814420] Re: drive-backup with iscsi,
 it will failed "Could not create image: Invalid argument"
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 64f4ea2e2f4b833fd2143567cdec8b107c4e4eae
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.189.90.7
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
Reply-To: Bug 1814420 <1814420@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, qemu version 3.1 is a bit old in terms of upstream support. Can you
confirm that this is still an issue on 4.2 ?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1814420

Title:
  drive-backup with iscsi, it will failed "Could not create image:
  Invalid argument"

Status in QEMU:
  Incomplete

Bug description:
  I use iscsi protocol to drive-backup:

  ---iscsi target---
  yum -y install targetcli python-rtslib
  systemctl start target
  systemctl enable target
  targetcli /iscsi create iqn.2019-01.com.iaas
  targetcli /iscsi/iqn.2019-01.com.iaas/tpg1 set attribute authentication=
=3D0 demo_mode_write_protect=3D0 generate_node_acls=3D1
  targetcli /iscsi/iqn.2019-01.com.iaas/tpg1/portals create 192.168.1.1 3260
  targetcli /backstores/fileio create file1 /opt/file1 2G
  targetcli /iscsi/iqn.2019-01.com.iaas/tpg1/luns create /backstores/fileio=
/file1
  -------------------

  Now, '{ "execute" : "drive-backup" , "arguments" : { "device" :
  "drive-virtio-disk0" , "sync" : "top" , "target" :
  "iscsi://192.168.1.1:3260/iqn.2019-01.com.iaas/0" } }'

  It may failed:
  {"id":"libvirt-1785","error":{"class":"GenericError","desc":"Could not
  create image: Invalid argument"}}

  But, This abnormal will be appear at the first time. Because when I
  retry again, It works very well.

  Then, I re-start the vm, It still be failed 'Could not create image:
  Invalid argument' on the first try, and the second try it will work
  very well.

  ---
  Host: centos 7.5
  qemu version: 2.12 and 3.1.0
  qemu command line: qemu-system-x86_64 -name guest=3Dtest,debug-threads=3D=
on -S -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/q=
emu/domain-190-test./master-key.aes -machine pc-i440fx-3.1,accel=3Dkvm,usb=
=3Doff,dump-guest-core=3Doff,mem-merge=3Doff -m 1024 -mem-prealloc -mem-pat=
h /dev/hugepages1G/libvirt/qemu/190-test -realtime mlock=3Doff -smp 1,socke=
ts=3D1,cores=3D1,threads=3D1 -uuid 1c8611c2-a18a-4b1c-b40b-9d82040eafa4 -sm=
bios type=3D1,manufacturer=3DIaaS -no-user-config -nodefaults -chardev sock=
et,id=3Dcharmonitor,fd=3D31,server,nowait -mon chardev=3Dcharmonitor,id=3Dm=
onitor,mode=3Dcontrol -rtc base=3Dutc -no-shutdown -boot menu=3Don,strict=
=3Don -device piix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -device vi=
rtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x3 -drive file=3D/o=
pt/vol/sas/fb0c7c37-13e7-41fe-b3f8-f0fbaaeec7ce,format=3Dqcow2,if=3Dnone,id=
=3Ddrive-virtio-disk0,cache=3Dwriteback -device virtio-blk-pci,scsi=3Doff,b=
us=3Dpci.0,addr=3D0x5,drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,bootinde=
x=3D1,write-cache=3Don -drive file=3D/opt/vol/sas/bde66671-536d-49cd-8b46-a=
4f1ea7be513,format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio-disk1,cache=3Dwriteb=
ack -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x7,drive=3Ddrive-=
virtio-disk1,id=3Dvirtio-disk1,write-cache=3Don -netdev tap,fd=3D33,id=3Dho=
stnet0,vhost=3Don,vhostfd=3D34 -device virtio-net-pci,netdev=3Dhostnet0,id=
=3Dnet0,mac=3D00:85:45:3e:d4:3a,bus=3Dpci.0,addr=3D0x6 -chardev pty,id=3Dch=
arserial0 -device isa-serial,chardev=3Dcharserial0,id=3Dserial0 -chardev so=
cket,id=3Dcharchannel0,fd=3D35,server,nowait -device virtserialport,bus=3Dv=
irtio-serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dorg.qemu=
.guest_agent.0 -device usb-tablet,id=3Dinput0,bus=3Dusb.0,port=3D1 -vnc 0.0=
.0.0:0,password -device cirrus-vga,id=3Dvideo0,bus=3Dpci.0,addr=3D0x2 -devi=
ce virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x4 -msg timestamp=
=3Don

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1814420/+subscriptions

