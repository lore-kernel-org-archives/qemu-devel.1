Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0ACFC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 03:31:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DB26205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 03:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB26205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7Vrl-0006U5-OB
	for qemu-devel@archiver.kernel.org; Sun, 16 Aug 2020 23:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k7VrA-00064e-Sy
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 23:30:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:35992)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k7Vr8-0003Ff-Ri
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 23:30:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k7Vr6-0000Yg-Se
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 03:30:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id D60E52E8076
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 03:30:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2020 03:23:04 -0000
From: Michael Slade <1891829@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: serial
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: mslade
X-Launchpad-Bug-Reporter: Michael Slade (mslade)
X-Launchpad-Bug-Modifier: Michael Slade (mslade)
References: <159762208982.14812.18418944831865683616.malonedeb@gac.canonical.com>
Message-Id: <159763458462.27115.4486723274417610800.launchpad@soybean.canonical.com>
Subject: [Bug 1891829] Re: High bit(s) sometimes set high on rcvd serial bytes
 when char size < 8 bits
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="d6d0b96812d8def2ca0ffcc25cb4d200f2f30aeb";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 4ee6d7e60a5041bfe1826e51d8886f3f523f8465
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/16 20:00:57
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
Reply-To: Bug 1891829 <1891829@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Summary changed:

- High bits(s) sometimes set high on rcvd serial bytes when char size < 8 b=
its
+ High bit(s) sometimes set high on rcvd serial bytes when char size < 8 bi=
ts

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1891829

Title:
  High bit(s) sometimes set high on rcvd serial bytes when char size < 8
  bits

Status in QEMU:
  New

Bug description:
  I *believe* (not confirmed) that the old standard PC serial ports,
  when configured with a character size of 7 bits or less, should set
  non-data bits to 0 when the CPU reads received chars from the read
  register.  qemu doesn't do this.

  Windows 1.01 will not make use of a serial mouse when bit 7 is 1.  The
  ID byte that the mouse sends on reset is ignored.  I added a temporary
  hack to set bit 7 to 0 on all incoming bytes, and this convinced
  windows 1.01 to use the mouse.

  note 1:  This was using a real serial mouse through a passed-through
  serial port.  The emulated msmouse doesn't work for other reasons.

  note 2:  The USB serial port I am passing through to the guest sets
  non-data bits to 1.  Not sure if this is the USB hardware or linux.

  note 3:  I also needed to add an -icount line to slow down the guest
  CPU, so that certain cpu-sensitive timing code in the guest didn't
  give up too quickly.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1891829/+subscriptions

