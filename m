Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D07FC3A5A9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 01:22:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A29E206D7
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 01:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A29E206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVmHg-0003ZT-GE
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 21:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jVmGZ-00035M-Rq
 for qemu-devel@nongnu.org; Mon, 04 May 2020 21:20:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:38322)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jVmGN-0002Uw-Ky
 for qemu-devel@nongnu.org; Mon, 04 May 2020 21:20:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jVmGL-0003Eo-3c
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 01:20:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1815C2E804A
 for <qemu-devel@nongnu.org>; Tue,  5 May 2020 01:20:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2020 01:11:18 -0000
From: Alan Murtagh <1875762@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: stefanha vorteil-alan
X-Launchpad-Bug-Reporter: Alan Murtagh (vorteil-alan)
X-Launchpad-Bug-Modifier: Alan Murtagh (vorteil-alan)
References: <158811390770.10067.14727390581808721252.malonedeb@soybean.canonical.com>
Message-Id: <158864107890.12970.7430180682201405680.malone@gac.canonical.com>
Subject: [Bug 1875762] Re: Poor disk performance on sparse VMDKs
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="fbdff7602bd10fb883bf7e2ddcc7fd5a16f60398";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 65db3c2f1eaf5ca53ad55f3d1ab3975e6fc966bc
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 21:00:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1875762 <1875762@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks Stefan.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1875762

Title:
  Poor disk performance on sparse VMDKs

Status in QEMU:
  New

Bug description:
  Found in QEMU 4.1, and reproduced on master.

  QEMU appears to suffer from remarkably poor disk performance when
  writing to sparse-extent VMDKs. Of course it's to be expected that
  allocation takes time and sparse VMDKs peform worse than allocated
  VMDKs, but surely not on the orders of magnitude I'm observing. On my
  system, the fully allocated write speeds are approximately 1.5GB/s,
  while the fully sparse write speeds can be as low as 10MB/s. I've
  noticed that adding "cache unsafe" reduces the issue dramatically,
  bringing speeds up to around 750MB/s. I don't know if this is still
  slow or if this perhaps reveals a problem with the default caching
  method.

  To reproduce the issue I've attached two 4GiB VMDKs. Both are
  completely empty and both are technically sparse-extent VMDKs, but one
  is 100% pre-allocated and the other is 100% unallocated. If you attach
  these VMDKs as second and third disks to an Ubuntu VM running on QEMU
  (with KVM) and measure their write performance (using dd to write to
  /dev/sdb and /dev/sdc for example) the difference in write speeds is
  clear.

  For what it's worth, the flags I'm using that relate to the VMDK are
  as follows:

  `-drive if=3Dnone,file=3Dsparse.vmdk,id=3Dhd0,format=3Dvmdk -device virti=
o-
  scsi-pci,id=3Dscsi -device scsi-hd,drive=3Dhd0`

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1875762/+subscriptions

