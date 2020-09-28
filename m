Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E03C4727C
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:37:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0D4621D7F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D4621D7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMtLl-0002Ll-SB
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kMt9y-0008S7-OF
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:25:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:33722)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kMt9w-0003bx-Id
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:25:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kMt9u-0004rl-MV
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 13:25:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id A10802E80E8
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 13:25:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2020 13:17:49 -0000
From: Albert Wik <1897568@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: awik
X-Launchpad-Bug-Reporter: Albert Wik (awik)
X-Launchpad-Bug-Modifier: Albert Wik (awik)
Message-Id: <160129907003.10349.16133652474527618816.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1897568] [NEW] Strange keyboard behaviour in Vim editor
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a314d157ca9be8d00eae0214fc0d7dff1cd406e4"; Instance="production"
X-Launchpad-Hash: fe6e1e9c390e93c564e9874db2f9a0b254907262
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 09:25:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -66
X-Spam_score: -6.7
X-Spam_bar: ------
X-Spam_report: (-6.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.199, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1897568 <1897568@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:


I'm running MS-DOS 7.10 in a QEMU virtual machine, and there is a problem w=
ith the keyboard in the Vim editor.  The arrow keys jump over a line, as if=
 you had typed the key twice.  PgUp and PgDn are likewise affected.  Other =
applications are not affected, unless you shell out from Vim.

The QEMU version is 5.0.0, and I'm using the "-k sv" option, but I've
tried without it and it doesn't make a difference.

I don't get this keyboard behaviour in the exact same VM under VMware
Player or Bochs.

-Albert.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1897568

Title:
  Strange keyboard behaviour in Vim editor

Status in QEMU:
  New

Bug description:
  =

  I'm running MS-DOS 7.10 in a QEMU virtual machine, and there is a problem=
 with the keyboard in the Vim editor.  The arrow keys jump over a line, as =
if you had typed the key twice.  PgUp and PgDn are likewise affected.  Othe=
r applications are not affected, unless you shell out from Vim.

  The QEMU version is 5.0.0, and I'm using the "-k sv" option, but I've
  tried without it and it doesn't make a difference.

  I don't get this keyboard behaviour in the exact same VM under VMware
  Player or Bochs.

  -Albert.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1897568/+subscriptions

