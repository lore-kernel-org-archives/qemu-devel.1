Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EA1C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 10:31:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C9212083E
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 10:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9212083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCh61-0007NQ-DD
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 06:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kCh5P-0006u8-8o
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 06:30:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:46662)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kCh5N-0004Hf-5r
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 06:30:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kCh5H-0003eW-Jn
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 10:30:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 9091E2E8025
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 10:30:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2020 10:24:49 -0000
From: Tom Yan <1893634@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: tom-ty89
X-Launchpad-Bug-Reporter: Tom Yan (tom-ty89)
X-Launchpad-Bug-Modifier: Tom Yan (tom-ty89)
Message-Id: <159886949002.28151.4021199873744523881.malonedeb@soybean.canonical.com>
Subject: [Bug 1893634] [NEW] blk_get_max_transfer() works only with sg
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="195cbfa84cb75815472f69dd83d46f006869050b"; Instance="production"
X-Launchpad-Hash: 879f296fbfa2f1063942581bcb2f63b31a39b0bb
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 04:40:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Reply-To: Bug 1893634 <1893634@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

blk_get_max_transfer() is supposed to be able to get the max_sectors
queue limit of the scsi device on the host side and is used in both
scsi-generic.c (for scsi-generic and scsi-block) and scsi-disk.c (for
scsi-hd) to set/change the max_xfer_len (and opt_xfer_len in the case of
scsi-generic).

However, it only works with the sg driver in doing so. It cannot get the
queue limit with the sd driver and simply returns MAX_INT.

qemu version 5.1.0
kernel version 5.8.5

Btw, is there a particular reason that it doesn't MIN_NON_ZERO against
the original max_xfer_len:
https://github.com/qemu/qemu/blob/v5.1.0/hw/scsi/scsi-generic.c#L172?

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1893634

Title:
  blk_get_max_transfer() works only with sg

Status in QEMU:
  New

Bug description:
  blk_get_max_transfer() is supposed to be able to get the max_sectors
  queue limit of the scsi device on the host side and is used in both
  scsi-generic.c (for scsi-generic and scsi-block) and scsi-disk.c (for
  scsi-hd) to set/change the max_xfer_len (and opt_xfer_len in the case
  of scsi-generic).

  However, it only works with the sg driver in doing so. It cannot get
  the queue limit with the sd driver and simply returns MAX_INT.

  qemu version 5.1.0
  kernel version 5.8.5

  Btw, is there a particular reason that it doesn't MIN_NON_ZERO against
  the original max_xfer_len:
  https://github.com/qemu/qemu/blob/v5.1.0/hw/scsi/scsi-generic.c#L172?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1893634/+subscriptions

