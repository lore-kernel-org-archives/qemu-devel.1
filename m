Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89CDC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 14:16:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 952B320870
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 14:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952B320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrixo-00085g-SS
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 10:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jrix7-0007en-5q
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 10:15:37 -0400
Received: from indium.canonical.com ([91.189.90.7]:60458)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jrix4-00050i-PT
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 10:15:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jrix2-00032q-Ko
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 14:15:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 9BBA02E8025
 for <qemu-devel@nongnu.org>; Sat,  4 Jul 2020 14:15:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2020 14:07:59 -0000
From: Ubuntu QA Website <1881648@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: iso-testing
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: gchristensen ubuntuqa xanclic
X-Launchpad-Bug-Reporter: Graham Christensen (gchristensen)
X-Launchpad-Bug-Modifier: Ubuntu QA Website (ubuntuqa)
References: <159103954472.29684.2828352310168270873.malonedeb@chaenomeles.canonical.com>
Message-Id: <159387167951.15693.14674839871762991733.malone@soybean.canonical.com>
Subject: [Bug 1881648] Re: `qemu-img info` reports an incorrect actual-size
 when the underlying posix filesystem has transparent compression
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1cbd0aa39df153c901321817f9b57cf3f232b507";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 092e7407f728b127cb87b0bf7cda6e195f3cb25a
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 08:20:36
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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

This bug has been reported on the Ubuntu ISO testing tracker.

A list of all reports related to this bug can be found here:
http://iso.qa.ubuntu.com/qatracker/reports/bugs/1881648

** Tags added: iso-testing

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1881648

Title:
  `qemu-img info` reports an incorrect actual-size when the underlying
  posix filesystem has transparent compression

Status in QEMU:
  Invalid

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

