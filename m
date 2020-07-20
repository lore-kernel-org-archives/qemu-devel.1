Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DD3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 00:26:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8841C20B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 00:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8841C20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxJdK-0003pu-EN
	for qemu-devel@archiver.kernel.org; Sun, 19 Jul 2020 20:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jxJck-0003Pr-97
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 20:25:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:58228)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jxJci-0000VL-GX
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 20:25:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jxJcg-0001J5-Kv
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 00:25:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 9B9DA2E80E7
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 00:25:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2020 00:15:49 -0000
From: Jeffrey <1888165@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jmmorlan
X-Launchpad-Bug-Reporter: Jeffrey (jmmorlan)
X-Launchpad-Bug-Modifier: Jeffrey (jmmorlan)
Message-Id: <159520414927.8137.962061150870003047.malonedeb@wampee.canonical.com>
Subject: [Bug 1888165] [NEW] loopz/loopnz clearing previous instruction's
 modified flags on cx -> 0
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="4809fcb62f445aaa3ae919f7f6c3cc7d156ea57a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 6c83e5e750d2746d90e7703bd84059fe71861a3e
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/19 20:25:38
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
Reply-To: Bug 1888165 <1888165@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

If you run QBasic in qemu, printing a double-type single-digit number
will print an extra decimal point (e.g. PRINT CDBL(3) prints "3.") that
does not appear when running on a real CPU (or on qemu with -enable-
kvm). I tracked this down to the state of the status flags after a
loopnz instruction.

After executing a sequence like this in qemu:

	mov bx,1
	mov cx,1
	dec bx    ; sets Z bit in flags
A:	loopnz A  ; should not modify flags

Z is incorrectly clear afterwards. loopz does the same thing (but not
plain loop). Interestingly, inserting pushf+popf after dec results in Z
set, so loopnz/loopz does not always clear Z itself but is rather
interfering with the previous instruction's flag setting.

Version 5.1.0-rc0, x86-64 host.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1888165

Title:
  loopz/loopnz clearing previous instruction's modified flags on cx -> 0

Status in QEMU:
  New

Bug description:
  If you run QBasic in qemu, printing a double-type single-digit number
  will print an extra decimal point (e.g. PRINT CDBL(3) prints "3.")
  that does not appear when running on a real CPU (or on qemu with
  -enable-kvm). I tracked this down to the state of the status flags
  after a loopnz instruction.

  After executing a sequence like this in qemu:

  	mov bx,1
  	mov cx,1
  	dec bx    ; sets Z bit in flags
  A:	loopnz A  ; should not modify flags

  Z is incorrectly clear afterwards. loopz does the same thing (but not
  plain loop). Interestingly, inserting pushf+popf after dec results in
  Z set, so loopnz/loopz does not always clear Z itself but is rather
  interfering with the previous instruction's flag setting.

  Version 5.1.0-rc0, x86-64 host.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1888165/+subscriptions

