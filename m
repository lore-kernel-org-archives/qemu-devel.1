Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5612C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 04:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFC8B20825
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 04:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC8B20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaWu1-00026f-E4
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 23:29:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaWqL-0005WK-Ol
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 23:25:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:38180)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaWqJ-0000D8-PW
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 23:25:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kaWqI-00030m-Kg
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 04:25:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 93DF62E811E
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2020 04:25:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2020 04:17:22 -0000
From: Launchpad Bug Tracker <1708617@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: janitor ke.king th-huth
X-Launchpad-Bug-Reporter: jinke (ke.king)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <150183560010.4317.16234791379107519041.malonedeb@gac.canonical.com>
Message-Id: <160454984261.10129.11286435699064439163.malone@loganberry.canonical.com>
Subject: [Bug 1708617] Re: qemu2.9 meet a question using reconnect about
 ovs+dpdk
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: f139842e61deb4609a50cd3ec30647426b3f4930
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 21:30:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: Bug 1708617 <1708617@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1708617

Title:
  qemu2.9 meet a question using reconnect about ovs+dpdk

Status in QEMU:
  Expired

Bug description:
  env:
  qemu-2.9
  dpdk-16.11
  ovs-2.6.1
  host os:Linux compute 3.10.0-514.el7.x86_64 #1 SMP Tue Nov 22 16:42:41 UT=
C 2016 x86_64 x86_64 x86_64 GNU/Linux
  guest os is same with host

  1. ovs service is normal
  2. start 2 qemu vm, using vhostuser port as server
  taskset 0x3f qemu-system-x86_64 -cpu host -smp 2,cores=3D2 -drive file=3D=
$QCOW2_IMAGE -m 4096M --enable-kvm -name $VM_NAME -nographic -object memory=
-backend-file,id=3Dmem,size=3D$GUEST_MEM,mem-path=3D/dev/hugepages,share=3D=
on -numa node,memdev=3Dmem -mem-prealloc -chardev socket,id=3Dchar1,path=3D=
$VHOST_SOCK_DIR/dpdkvhostuser0,server -netdev type=3Dvhost-user,id=3Dmynet1=
,chardev=3Dchar1,vhostforce,queues=3D2 -device virtio-net-pci,mac=3D00:00:0=
0:00:00:01,netdev=3Dmynet1,mq=3Don,vectors=3D6  -nographic -vnc :0 =

  qemu-system-x86_64: -chardev socket,id=3Dchar1,path=3D/usr/local/var/run/=
openvswitch/dpdkvhostuser0,server: QEMU waiting for connection on: disconne=
cted:unix:/usr/local/var/run/openvswitch/dpdkvhostuser0,server

  taskset 0x3f qemu-system-x86_64 -cpu host -smp 2,cores=3D2 -drive file=3D=
$QCOW2_IMAGE -m 4096M --enable-kvm -name $VM_NAME -nographic -object memory=
-backend-file,id=3Dmem,size=3D$GUEST_MEM,mem-path=3D/dev/hugepages,share=3D=
on -numa node,memdev=3Dmem -mem-prealloc -chardev socket,id=3Dchar1,path=3D=
$VHOST_SOCK_DIR/dpdkvhostuser0,server -netdev type=3Dvhost-user,id=3Dmynet1=
,chardev=3Dchar1,vhostforce,queues=3D2 -device virtio-net-pci,mac=3D00:00:0=
0:00:00:01,netdev=3Dmynet1,mq=3Don,vectors=3D6  -nographic -vnc :0 =

  qemu-system-x86_64: -chardev socket,id=3Dchar1,path=3D/usr/local/var/run/=
openvswitch/dpdkvhostuser0,server: QEMU waiting for connection on: disconne=
cted:unix:/usr/local/var/run/openvswitch/dpdkvhostuser1,server

  3. add br and vhostuser port as client
  ovs-vsctl add-br br1 -- set bridge br1 datapath_type=3Dnetdev
  ovs-vsctl add-port br1 dpdkvhostuser0 -- set Interface dpdkvhostuser0 typ=
e=3Ddpdkvhostuserclient  options:vhost-server-path=3D"/usr/local/var/run/op=
envswitch/dpdkvhostuser0"			=

  ovs-vsctl add-port br1 dpdkvhostuser1 -- set Interface dpdkvhostuser1 typ=
e=3Ddpdkvhostuserclient  options:vhost-server-path=3D"/usr/local/var/run/op=
envswitch/dpdkvhostuser1"			=

  			=

  4. ping between 2 vm is ok
  5. restart ovs process
   systemctl restart openvswitch

  6. there is a question ping between 2 vm error

  7. change qemu from 2.9 to 2.7, everything become ok

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1708617/+subscriptions

