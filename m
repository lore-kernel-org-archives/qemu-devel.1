Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE745C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 17:11:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 810DD2073B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 17:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810DD2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdd6z-0000ku-Ly
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 13:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jdd6C-0000Jf-CQ
 for qemu-devel@nongnu.org; Tue, 26 May 2020 13:10:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:33924)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jdd6B-0004Rf-3Y
 for qemu-devel@nongnu.org; Tue, 26 May 2020 13:10:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jdd69-0008F9-8Q
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 17:10:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id F393D2E807D
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 17:10:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2020 17:00:57 -0000
From: Ahmed Karaman <1880722@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: linux-user
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ahmedkrmn
X-Launchpad-Bug-Reporter: Ahmed Karaman (ahmedkrmn)
X-Launchpad-Bug-Modifier: Ahmed Karaman (ahmedkrmn)
References: <159050902512.8264.16089666576245848412.malonedeb@gac.canonical.com>
Message-Id: <159051245801.8264.18308114750913433257.launchpad@gac.canonical.com>
Subject: [Bug 1880722] Re: Problems related to checking page crossing in
 use_goto_tb()
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1f7bc749b40714a4cc10f5e4d787118a78037035";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 7022ddd8a44d712e14b9780ce1f2dbecb8adb3ec
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 11:25:40
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
Reply-To: Bug 1880722 <1880722@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Summary changed:

- Changing executable page permissions with mmap causes user-mode failures
+ Problems related to checking page crossing in use_goto_tb()

** Description changed:

- The discussion that led to this bug discovery can be found in this =

+ The discussion that led to this bug discovery can be found in this
  mailing list thread:
  https://lists.nongnu.org/archive/html/qemu-devel/2020-05/msg05426.html
  =

- A workaround for this problem would be to check for page crossings for =

- both the user and system modes in the use_goto_tb() function across =

+ A workaround for this problem would be to check for page crossings for
+ both the user and system modes in the use_goto_tb() function across
  targets. Some targets like "hppa" already implement this fix but others
  don't.
  =

- To solve the root cause of this problem, the linux-user/mmap.c should =

- be fixed to do all the invalidations required. By doing so, up to 6.93% =

- performance improvements will be achieved.
+ To solve the root cause of this problem, the linux-user/mmap.c should
+ be fixed to do all the invalidations required. By doing so, better
+ performance results could be achieved, compared to the case of the
+ workaround described above.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1880722

Title:
  Problems related to checking page crossing in use_goto_tb()

Status in QEMU:
  New

Bug description:
  The discussion that led to this bug discovery can be found in this
  mailing list thread:
  https://lists.nongnu.org/archive/html/qemu-devel/2020-05/msg05426.html

  A workaround for this problem would be to check for page crossings for
  both the user and system modes in the use_goto_tb() function across
  targets. Some targets like "hppa" already implement this fix but others
  don't.

  To solve the root cause of this problem, the linux-user/mmap.c should
  be fixed to do all the invalidations required. By doing so, better
  performance results could be achieved, compared to the case of the
  workaround described above.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1880722/+subscriptions

