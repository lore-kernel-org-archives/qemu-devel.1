Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223E2C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 19:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA4AE206E2
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 19:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4AE206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfqEK-0000Xz-8S
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 15:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jfqDd-0008OP-JH
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 15:35:33 -0400
Received: from indium.canonical.com ([91.189.90.7]:60698)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jfqDc-0002LU-21
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 15:35:33 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jfqDZ-0000Tz-Ab
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 19:35:29 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 4CADF2E8109
 for <qemu-devel@nongnu.org>; Mon,  1 Jun 2020 19:35:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2020 19:25:44 -0000
From: Graham Christensen <1881648@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: gchristensen
X-Launchpad-Bug-Reporter: Graham Christensen (gchristensen)
X-Launchpad-Bug-Modifier: Graham Christensen (gchristensen)
Message-Id: <159103954472.29684.2828352310168270873.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1881648] [NEW] `qemu-img info` reports an incorrect actual-size
 when the underlying posix filesystem has transparent compression
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="275d46a24253e557e4403d52832837e4bfa425b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 025dfd57274ef4b660638ae1a78792fe005a4c56
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 13:41:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
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
Reply-To: Bug 1881648 <1881648@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

qemu-img info reports the same thing as `du`*1024:

$ qemu-img info --output json ./my.qcow2  | jq '."actual-size"'
558619648

$ du ./my.qcow2
545527	./my.qcow2

$ echo $((558619648 / 545527))
1024

and this is correct in terms of bytes on disk, but due to transparent
compression implemented by the filesystem, it is not the actual byte
count:

$ du -h --apparent-size ./my.qcow2
1346568192	my.qcow2

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1881648

Title:
  `qemu-img info` reports an incorrect actual-size when the underlying
  posix filesystem has transparent compression

Status in QEMU:
  New

Bug description:
  qemu-img info reports the same thing as `du`*1024:

  $ qemu-img info --output json ./my.qcow2  | jq '."actual-size"'
  558619648

  $ du ./my.qcow2
  545527	./my.qcow2

  $ echo $((558619648 / 545527))
  1024

  and this is correct in terms of bytes on disk, but due to transparent
  compression implemented by the filesystem, it is not the actual byte
  count:

  $ du -h --apparent-size ./my.qcow2
  1346568192	my.qcow2

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1881648/+subscriptions

