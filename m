Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72466C5517A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 18:12:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA27206A1
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 18:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA27206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcBeM-0003rM-WE
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 13:12:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kcBdD-0002Zp-9v
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 13:11:07 -0500
Received: from indium.canonical.com ([91.189.90.7]:53510)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kcBd8-0002uJ-AC
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 13:11:06 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kcBd6-0003OT-1B
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 18:11:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 07CE32E8134
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 18:11:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2020 18:02:36 -0000
From: Thomas Huth <1701449@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ahasenack james-page jdillaman jonav
 lp-markusschade n6ck
X-Launchpad-Bug-Reporter: Nick (n6ck)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
X-Launchpad-Bug-Duplicate: 1674481
References: <149880297386.6544.11962739093038956076.malonedeb@gac.canonical.com>
Message-Id: <160494495987.12575.13443173775301837285.launchpad@gac.canonical.com>
Subject: [Bug 1701449] Re: high memory usage when using rbd with client caching
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: 8d040ddb6045a55719d3a871c682ee6aadf3d9ae
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 11:16:03
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1701449 <1701449@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

*** This bug is a duplicate of bug 1674481 ***
    https://bugs.launchpad.net/bugs/1674481

** This bug has been marked a duplicate of bug 1674481
   memory overhead of qemu-kvm with ceph rbd and ram-allocation-ratio=3D0.9=
 leads to memory starvation

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1701449

Title:
  high memory usage when using rbd with client caching

Status in QEMU:
  New

Bug description:
  Hi,
  we are experiencing a quite high memory usage of a single qemu (used with=
 KVM) process when using RBD with client caching as a disk backend. We are =
testing with 3GB memory qemu virtual machines and 128MB RBD client cache. W=
hen running 'fio' in the virtual machine you can see that after some time t=
he machine uses a lot more memory (RSS) on the hypervisor than she should. =
We have seen values (in real production machines, no artificially fio tests=
) of 250% memory overhead. I reproduced this with qemu version 2.9 as well.

  Here the contents of our ceph.conf on the hypervisor:
  """
  [client]
  rbd cache writethrough until flush =3D False
  rbd cache max dirty =3D 100663296
  rbd cache size =3D 134217728
  rbd cache target dirty =3D 50331648
  """

  How to reproduce:
  * create a virtual machine with a RBD backed disk (100GB or so)
  * install a linux distribution on it (we are using Ubuntu)
  * install fio (apt-get install fio)
  * run fio multiple times with (e.g.) the following test file:
  """
  # This job file tries to mimic the Intel IOMeter File Server Access Patte=
rn
  [global]
  description=3DEmulation of Intel IOmeter File Server Access Pattern
  randrepeat=3D0
  filename=3D/root/test.dat
  # IOMeter defines the server loads as the following:
  # iodepth=3D1     Linear
  # iodepth=3D4     Very Light
  # iodepth=3D8     Light
  # iodepth=3D64    Moderate
  # iodepth=3D256   Heavy
  iodepth=3D8
  size=3D80g
  direct=3D0
  ioengine=3Dlibaio

  [iometer]
  stonewall
  bs=3D4M
  rw=3Drandrw

  [iometer_just_write]
  stonewall
  bs=3D4M
  rw=3Dwrite

  [iometer_just_read]
  stonewall
  bs=3D4M
  rw=3Dread
  """

  You can measure the virtual machine RSS usage on the hypervisor with:
    virsh dommemstat <machine name> | grep rss
  or if you are not using libvirt:
    grep RSS /proc/<PID of qemu process>/status

  When switching off the RBD client cache, all is ok again, as the
  process does not use so much memory anymore.

  There is already a ticket on the ceph bug tracker for this ([1]).
  However I can reproduce that memory behaviour only when using qemu
  (maybe it is using librbd in a special way?). Running directly 'fio'
  with the rbd engine does not result in that high memory usage.

  [1] http://tracker.ceph.com/issues/20054

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1701449/+subscriptions

