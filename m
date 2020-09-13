Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7000C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 00:16:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F902087C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 00:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F902087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHFh6-0007N5-65
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 20:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kHFgM-0006vq-4B
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 20:15:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:43404)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kHFgK-0005wg-06
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 20:15:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kHFgI-00047s-59
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 00:15:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 192652E80E9
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 00:15:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2020 00:08:59 -0000
From: Michael Slade <1895363@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: mslade
X-Launchpad-Bug-Reporter: Michael Slade (mslade)
X-Launchpad-Bug-Modifier: Michael Slade (mslade)
References: <159987499082.17652.11658819873688678558.malonedeb@soybean.canonical.com>
Message-Id: <159995573921.13670.13920574467256356759.malone@gac.canonical.com>
Subject: [Bug 1895363] Re: borland IDEs double up cursor key presses (need
 timing on PS2 port input)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="83bdf6c8a3a5f87722c8927e54838522f3e57504"; Instance="production"
X-Launchpad-Hash: f2a931d8b4bdcb91b415b07e27d8eda1c132d576
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 19:55:34
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1895363 <1895363@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just found the complete conversation regarding the abovementioned patch:

https://lists.nongnu.org/archive/html/qemu-devel/2009-08/msg01182.html

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1895363

Title:
  borland IDEs double up cursor key presses (need timing on PS2 port
  input)

Status in QEMU:
  New

Bug description:
  Most DOS-era IDEs from Borland (I have tried Borland C++ 2.0, Borland
  C++ 3.1 and Turbo Pascal 7.1) exhibit strange responses to the
  keyboard.  Cursor keys are registered twice, so each press of a cursor
  key causes the cursor to move twice. Also the other keys occasionally
  are missed or duplicated.

  From an internet search, the problem appears to be this.  These
  programs read the PS2 input register multiple times per incoming byte,
  on the assumption that the byte will remain there for at least a few
  hundred microseconds, before the next byte (if any) appears there.
  qemu treats a read of the register by the guest as an acknowledgement
  of the incoming byte and puts the next byte into the register
  immediately, thus breaking the programs that expect each successive
  byte to stay in place for a while.

  The obvious solution is to use a timer to advance through the queued
  bytes.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1895363/+subscriptions

