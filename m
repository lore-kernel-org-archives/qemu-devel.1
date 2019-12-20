Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F62C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 20:02:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C69B92072B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 20:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C69B92072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiOTf-0004jG-02
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 15:02:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iiOSG-0004Ht-Pw
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 15:00:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iiOSF-0003z6-83
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 15:00:56 -0500
Received: from indium.canonical.com ([91.189.90.7]:41116)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iiOSF-0003vs-02
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 15:00:55 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iiOS9-0006Vu-UA
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 20:00:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C85B82E802B
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 20:00:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Dec 2019 19:49:58 -0000
From: Toolybird <1857143@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: gschafer noctavian
X-Launchpad-Bug-Reporter: =?utf-8?q?N=C4=83stasie_Ion_Octavian_=28noctavian?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: Toolybird (gschafer)
References: <157685586097.27697.14145668174002417681.malonedeb@chaenomeles.canonical.com>
Message-Id: <157687139856.2533.12222522317606333309.malone@soybean.canonical.com>
Subject: [Bug 1857143] Re: VMs won't boot from external snapshots on qemu 4.2
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: ef867758d7088007ebc0624f9026a77dd92d7640
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
Reply-To: Bug 1857143 <1857143@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is due to the new way of configuring block devices in 4.2.

You'll need to create your snapshots correctly by using the '-F'
parameter of qemu-img create.

Full details here:

https://www.redhat.com/archives/libvirt-
users/2019-December/msg00016.html

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1857143

Title:
  VMs won't boot from external snapshots on qemu 4.2

Status in QEMU:
  New

Bug description:
  After upgrading from qemu 4.1.1-1 to 4.2.0-1, VMs that were set to use
  an external snapshot as their disk failed to boot.

  Depending on the guest OS and other VM settings the boot fails and you
  get either the "Boot failed: not a bootable drive" message or the grub
  rescue shell or the EFI shell. Downgrading back to qemu 4.1 allows the
  VMs to boot from the external snapshots without any problem and the
  disk images doesn't appear to be corrupted afterwards.

  From my testing this bug is easily reproducible. Create a VM, install
  a guest os, confirm that the VM boots the guest os without problems,
  shutdown the VM, create an external snapshot of the VM disk, set the
  VM to boot from the snapshot, try to boot the VM with qemu 4.2 and see
  it fail, try to boot it with qemu 4.1 and see it succeed.

  In my case, to test that this bug is reproducible, I used virt-manager
  to install Xubuntu 19.10 on a qcow2 disk image, and then used qemu-img
  create -f qcow2 -b base_image.qcow2 snapshot_image.qcow2 to create the
  external snapshot and edited the xml in virt-manager to point the VM's
  disk to snapshot_image.qcow2. It failed to boot with qemu 4.2, but it
  was working fine with 4.1.

  I booted this test VM off a live distro using the virtual CDROM and
  fdisk can't seem to find a partition table on the VM disk when qemu
  4.2 is used, with 4.1 it can see the partition table just fine.

  Internal snapshots don't seem to have this problem.

  I'm using Archlinux, virt-manager 2.2.1-2, libvirt 5.10.0-1, qemu
  4.2.0-1.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1857143/+subscriptions

