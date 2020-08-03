Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9A8C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 12:31:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F1C20775
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 12:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F1C20775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2Zd4-0001gV-SR
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 08:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k2ZcI-0001EG-J5
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 08:30:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:44912)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k2ZcG-0005Py-FE
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 08:30:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k2ZcE-0006gO-4j
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 12:30:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id ED4802E80ED
 for <qemu-devel@nongnu.org>; Mon,  3 Aug 2020 12:30:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2020 12:24:56 -0000
From: Satheesh Rajendran <1821771@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: kvm numa powerpc
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: sathnaga
X-Launchpad-Bug-Reporter: Satheesh Rajendran (sathnaga)
X-Launchpad-Bug-Modifier: Satheesh Rajendran (sathnaga)
References: <155361583469.17984.11681376513113338670.malonedeb@gac.canonical.com>
Message-Id: <159645749610.2330.1047097086201666905.malone@gac.canonical.com>
Subject: [Bug 1821771] Re: KVM guest does not reflect numa distances
 configured through qemu 
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 59786b095ada743d0aafbd64afc1617ac5341562
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 07:00:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1821771 <1821771@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Documentation describing the current qemu behaviour is captured here,
https://www.mail-archive.com/qemu-devel@nongnu.org/msg726442.html

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1821771

Title:
  KVM guest does not reflect numa distances configured through qemu

Status in QEMU:
  New

Bug description:
  KVM guest does not reflect numa distances configured through qemu

  Env:
  Host/Guest Kernel: 5.1.0-rc1-g72999bbdc
  qemu : 3.1.90 (v2.8.0-rc0-18614-g278aebafa0-dirty) [repo: https://github.=
com/dgibson/qemu; branch:ppc-for-4.1 ]
  # git log -1
  commit 278aebafa02f699857ca082d966bcbc05dc9bffb (HEAD -> ppc-for-4.1)
  Author: Jafar Abdi <cafer.abdi@gmail.com>
  Date:   Sat Mar 23 17:26:36 2019 +0300

      tests/libqos: fix usage of bool in pci-spapr.c
      =

      Clean up wrong usage of FALSE and TRUE in places that use "bool" from=
 stdbool.h.
      =

      FALSE and TRUE (with capital letters) are the constants defined by gl=
ib for
      being used with the "gboolean" type of glib. But some parts of the co=
de also use
      TRUE and FALSE for variables that are declared as "bool" (the type fr=
om <stdbool.h>).
      =

      Signed-off-by: Jafar Abdi <cafer.abdi@gmail.com>
      Reviewed-by: Eric Blake <eblake@redhat.com>
      Message-Id: <1553351197-14581-4-git-send-email-cafer.abdi@gmail.com>
      Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

  # libvirtd -V
  libvirtd (libvirt) 5.1.0


  Steps to reproduce:
  1. Boot attached guest xml with predefined numa distance.

  qemu-commandline:
  /usr/share/avocado-plugins-vt/bin/install_root/bin/qemu-system-ppc64 -nam=
e guest=3Dvm2,debug-threads=3Don -S -object secret,id=3DmasterKey0,format=
=3Draw,file=3D/var/lib/libvirt/qemu/domain-15-vm2/master-key.aes -machine p=
series-4.0,accel=3Dkvm,usb=3Doff,dump-guest-core=3Doff -m 4096 -realtime ml=
ock=3Doff -smp 4,sockets=3D1,cores=3D4,threads=3D1 -numa node,nodeid=3D0,cp=
us=3D0-1,mem=3D2048 -numa node,nodeid=3D1,cpus=3D2-3,mem=3D2048 -uuid 1a870=
f1d-269a-4a8c-84bc-2b5bda72823a -display none -no-user-config -nodefaults -=
chardev socket,id=3Dcharmonitor,fd=3D28,server,nowait -mon chardev=3Dcharmo=
nitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc -no-shutdown -boot strict=
=3Don -kernel /home/kvmci/linux/vmlinux -append root=3D/dev/sda2 rw console=
=3Dtty0 console=3DttyS0,115200 init=3D/sbin/init  initcall_debug selinux=3D=
0 -device qemu-xhci,id=3Dusb,bus=3Dpci.0,addr=3D0x3 -device virtio-scsi-pci=
,id=3Dscsi0,bus=3Dpci.0,addr=3D0x2 -drive file=3D/var/lib/avocado/data/avoc=
ado-vt/images/jeos-27-ppc64le.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-scs=
i0-0-0-0 -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,devi=
ce_id=3Ddrive-scsi0-0-0-0,drive=3Ddrive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootin=
dex=3D1 -netdev tap,fd=3D30,id=3Dhostnet0,vhost=3Don,vhostfd=3D31 -device v=
irtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:f4:f5:f6,bus=3Dpci=
.0,addr=3D0x1 -chardev pty,id=3Dcharserial0 -device spapr-vty,chardev=3Dcha=
rserial0,id=3Dserial0,reg=3D0x30000000 -device virtio-balloon-pci,id=3Dball=
oon0,bus=3Dpci.0,addr=3D0x4 -msg timestamp=3Don

  =

  2. Check numa distance and other details inside guest
  # numactl -H
  available: 2 nodes (0-1)
  node 0 cpus: 0 1
  node 0 size: 2025 MB
  node 0 free: 1837 MB
  node 1 cpus: 2 3
  node 1 size: 2045 MB
  node 1 free: 1646 MB
  node distances:
  node   0   1 =

    0:  10  40 -----------------------------------NOK
    1:  40  10 =


  # lsprop /proc/device-tree/cpus/PowerPC\,POWER9\@*/ibm\,associativity =

  /proc/device-tree/cpus/PowerPC,POWER8@0/ibm,associativity
  		 00000005 00000000 00000000 00000000 00000000 00000000
  /proc/device-tree/cpus/PowerPC,POWER8@10/ibm,associativity
  		 00000005 00000000 00000000 00000000 00000001 00000010
  /proc/device-tree/cpus/PowerPC,POWER8@18/ibm,associativity
  		 00000005 00000000 00000000 00000000 00000001 00000018
  /proc/device-tree/cpus/PowerPC,POWER8@8/ibm,associativity
  		 00000005 00000000 00000000 00000000 00000000 00000008

  # lsprop /proc/device-tree/rtas/ibm,associativity-reference-points
  /proc/device-tree/rtas/ibm,associativity-reference-points
  		 00000004 00000004

  Expected numa distances:
  node distances:
  node   0   1 =

    0:  10  20
    1:  20  10

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1821771/+subscriptions

