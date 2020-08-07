Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF73C433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 18:20:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB102221E5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 18:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB102221E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k46zB-0005wh-30
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 14:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k46yC-000501-CC
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 14:19:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:58138)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k46yA-00067S-HQ
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 14:19:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k46y8-0001zO-Lv
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 18:19:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 99FD22E808C
 for <qemu-devel@nongnu.org>; Fri,  7 Aug 2020 18:19:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2020 18:09:59 -0000
From: Thomas Huth <1462949@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: rjones-redhat th-huth
X-Launchpad-Bug-Reporter: Richard Jones (rjones-redhat)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20150608093841.15980.73428.malonedeb@chaenomeles.canonical.com>
Message-Id: <159682379920.27188.2001095451428961471.malone@gac.canonical.com>
Subject: [Bug 1462949] Re: vmdk files cause qemu-img to consume lots of time
 and memory
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="6a138c03da9cc3e2e03f6dd3bbb4a615b0be6ec2";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: ac16932fe707c0ed0c370df1a6613d76c8e758a9
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 01:41:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1462949 <1462949@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Looking through old bug tickets... can you still reproduce this issue
with the latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1462949

Title:
  vmdk files cause qemu-img to consume lots of time and memory

Status in QEMU:
  Incomplete

Bug description:
  The two attached files cause 'qemu-img info' to consume lots of time
  and memory.  Around 10-12 seconds of CPU time, and around 3-4 GB of
  heap.

  $ /usr/bin/time ~/d/qemu/qemu-img info afl10.img =

  qemu-img: Can't get size of device 'image': File too large
  0.40user 11.57system 0:12.03elapsed 99%CPU (0avgtext+0avgdata 4197804maxr=
esident)k
  56inputs+0outputs (0major+1045672minor)pagefaults 0swaps

  $ /usr/bin/time ~/d/qemu/qemu-img info afl11.img =

  image: afl11.img
  file format: vmdk
  virtual size: 12802T (14075741666803712 bytes)
  disk size: 4.0K
  cluster_size: 65536
  Format specific information:
      cid: 4294967295
      parent cid: 4294967295
      create type: monolithicSparse
      extents:
          [0]:
              virtual size: 14075741666803712
              filename: afl11.img
              cluster size: 65536
              format: =

  0.29user 9.10system 0:09.43elapsed 99%CPU (0avgtext+0avgdata 3297360maxre=
sident)k
  8inputs+0outputs (0major+820507minor)pagefaults 0swaps

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1462949/+subscriptions

