Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE40C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:46:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0EDA23CD1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0EDA23CD1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpsF0-0004Ke-0A
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 07:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jpsEE-0003t8-BF
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 07:45:38 -0400
Received: from indium.canonical.com ([91.189.90.7]:45428)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jpsEB-0005us-Nr
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 07:45:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jpsEA-00037J-Mo
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 11:45:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id A964D2E80E7
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 11:45:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2020 11:37:18 -0000
From: Oksana Voshchana <1885553@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ovoshchana
X-Launchpad-Bug-Reporter: Oksana Voshchana (ovoshchana)
X-Launchpad-Bug-Modifier: Oksana Voshchana (ovoshchana)
Message-Id: <159343063899.16720.10693725380601772129.malonedeb@soybean.canonical.com>
Subject: [Bug 1885553] [NEW] make-check test failed with "Segmentation fault"
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1cbd0aa39df153c901321817f9b57cf3f232b507";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 518ca3bd2bb5491a22edc3bba698fcfdc3e7e9d9
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 06:50:40
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
Reply-To: Bug 1885553 <1885553@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

While running the make-check testing on arm architecture the test failed wi=
th error:
"kill_qemu() detected QEMU death from signal 11 (Segmentation fault) (core =
dumped)". Apart from that make-install test always passes.
The problem doesn't reproduce in 100%
qemu - from the master branch
RHEL-8 kernel 4.18.0-221.el8.aarch64
Logfile with an error you can to find in attachment

Thanks

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "make_check.log"
   https://bugs.launchpad.net/bugs/1885553/+attachment/5388127/+files/make_=
check.log

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1885553

Title:
  make-check test failed with "Segmentation fault"

Status in QEMU:
  New

Bug description:
  While running the make-check testing on arm architecture the test failed =
with error:
  "kill_qemu() detected QEMU death from signal 11 (Segmentation fault) (cor=
e dumped)". Apart from that make-install test always passes.
  The problem doesn't reproduce in 100%
  qemu - from the master branch
  RHEL-8 kernel 4.18.0-221.el8.aarch64
  Logfile with an error you can to find in attachment

  Thanks

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1885553/+subscriptions

