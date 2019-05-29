Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D7DC28CC2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 04:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A35821721
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 04:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A35821721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46954 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVqKS-0004Dr-N3
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 00:36:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hVqJB-0003Wy-Ra
	for qemu-devel@nongnu.org; Wed, 29 May 2019 00:35:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hVqJA-0003fT-KR
	for qemu-devel@nongnu.org; Wed, 29 May 2019 00:35:25 -0400
Received: from indium.canonical.com ([91.189.90.7]:58374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hVqJA-0003eA-Db
	for qemu-devel@nongnu.org; Wed, 29 May 2019 00:35:24 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hVqJ8-0004a1-OV
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 04:35:22 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 958BA2E80C7
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 04:35:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 May 2019 04:17:17 -0000
From: Launchpad Bug Tracker <1569053@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bijutalukdar janitor th-huth ztehypervisor
X-Launchpad-Bug-Reporter: biju Talukdar (bijutalukdar)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <20160411213335.1727.82105.malonedeb@wampee.canonical.com>
Message-Id: <155910343778.31442.15182980371567772106.malone@loganberry.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18968";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 1436f6413862463c3eb390757f0c9a829a4d07be
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1569053] Re: Qemu crashes when I start a second
 VM from command line
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1569053 <1569053@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1569053

Title:
  Qemu crashes when I start a second VM from command line

Status in QEMU:
  Expired

Bug description:
  I am using Qemu on 64 bit  x86 platform, operating system ubuntu
  14.04. I cloned the latest version of qemu from github and installed
  on my system.

  I booted the 1st VM with the instruction:

  sudo qemu-system-x86_64 -m 1024 -smp 4 -cpu host -hda
  /var/lib/libvirt/images/vm1p4.img -boot c -enable-kvm -no-reboot -net
  none -chardev socket,id=3Dchar1,path=3D/usr/local/var/run/openvswitch
  /vhost-user1 -netdev type=3Dvhost-
  user,id=3Dmynet1,chardev=3Dchar1,vhostforce -device virtio-net-
  pci,mac=3D00:00:00:00:00:01,netdev=3Dmynet1 -object memory-backend-
  file,id=3Dmem,size=3D1024M,mem-path=3D/dev/hugepages,share=3Don -numa
  node,memdev=3Dmem -mem-prealloc

  It is was launched successfully.
  Then I lanched the second VM with the instruction:

  sudo qemu-system-x86_64 -m 1024 -smp 4 -cpu host -hda
  /var/lib/libvirt/images/vm1p4-2.img -boot c -enable-kvm -no-reboot
  -net none -chardev socket,id=3Dchar2,path=3D/usr/local/var/run/openvswitch
  /vhost-user2 -netdev type=3Dvhost-
  user,id=3Dmynet2,chardev=3Dchar2,vhostforce -device virtio-net-
  pci,mac=3D00:00:00:00:00:02,netdev=3Dmynet2 -object memory-backend-
  file,id=3Dmem,size=3D1024M,mem-path=3D/dev/hugepages,share=3Don -numa
  node,memdev=3Dmem -mem-prealloc

  Qemu crashed right away. Plea see the log below.


  sudo qemu-system-x86_64 -m 1024 -smp 4 -cpu host -hda /var/lib/libvirt/im=
ages/vm1p4-2.img -boot c -enable-kvm -no-reboot -net none -chardev socket,i=
d=3Dchar2,path=3D/usr/local/var/run/openvswitch/vhost-user2 -netdev type=3D=
vhost-user,id=3Dmynet2,chardev=3Dchar2,vhostforce -device virtio-net-pci,ma=
c=3D00:00:00:00:00:02,netdev=3Dmynet2 -object memory-backend-file,id=3Dmem,=
size=3D1024M,mem-path=3D/dev/hugepages,share=3Don -numa node,memdev=3Dmem -=
mem-prealloc
  KVM internal error. Suberror: 1
  emulation failure
  EAX=3D000cc765 EBX=3D00000007 ECX=3D000cc6ac EDX=3D0000df00
  ESI=3D1ff00000 EDI=3D0000d5d7 EBP=3Dffffffff ESP=3D0000f9ce
  EIP=3Dd5d70000 EFL=3D00010012 [----A--] CPL=3D0 II=3D0 A20=3D1 SMM=3D0 HL=
T=3D0
  ES =3Ddf00 000df000 ffffffff 00809300
  CS =3Df000 000f0000 ffffffff 00809b00
  SS =3Ddf00 000df000 ffffffff 00809300
  DS =3Ddf00 000df000 ffffffff 00809300
  FS =3D0000 00000000 ffffffff 00809300
  GS =3D0000 00000000 ffffffff 00809300
  LDT=3D0000 00000000 0000ffff 00008200
  TR =3D0000 00000000 0000ffff 00008b00
  GDT=3D     00000000 00000000
  IDT=3D     00000000 000003ff
  CR0=3D00000010 CR2=3D00000000 CR3=3D00000000 CR4=3D00000000
  DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 DR3=
=3D0000000000000000 =

  DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
  EFER=3D0000000000000000
  Code=3D00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 0=
0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 00

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1569053/+subscriptions

