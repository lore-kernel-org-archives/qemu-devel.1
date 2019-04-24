Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A38C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 05:29:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 160BE2089F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 05:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 160BE2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36018 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJASr-0007uG-22
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 01:29:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJAPj-0005Qd-G3
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJAPg-00053W-9e
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:25:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:35676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJAPd-0004u2-IQ
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:25:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJAPb-0002H7-M0
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 05:25:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A082D2E80D1
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 05:25:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 05:19:38 -0000
From: Thomas Huth <1812091@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Tags: arm
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: nezza pmaydell
X-Launchpad-Bug-Reporter: Thomas Roth (nezza)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <154766268387.1937.11188043264522807203.malonedeb@wampee.canonical.com>
Message-Id:
 <155608317901.14262.7771879457612853928.launchpad@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 228b60706dbb41eb56330053afd526769bd72613
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1812091] Re: gdbstub memory accesses performed
 with wrong attributes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1812091 <1812091@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424051938.Bz7YFGFrJBMLfxrgq5iYm91_svDMIn9axVbga616q4Y@z>

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1812091

Title:
  gdbstub memory accesses performed with wrong attributes

Status in QEMU:
  Fix Released

Bug description:
  Qemu-commit: b2f7c27f56bf1116ebb7848c75914aa7c5d6a040

  =

  The ARMv8-M architecture (with security extensions) contains a SAU, the S=
ecurity Attribution Unit. After booting the mps2-an505 and immediately halt=
ing (`-S`), I attempt to read the SAU_TYPE register, located at 0xE000EDD4,=
 using gdb (x 0xE000EDD4). The returned value is 0, while the expected valu=
e is 8 (number of regions).

  On further investigation, it seems that `attrs.secure` is set to false
  (armv7m_nvic.c - nvic_readl, line 1167). Commenting out the check will
  return the correct value.

  As the CPU should be in 'secure' mode after reset, I think this
  behavior is wrong.

  Steps to reproduce:
  Example code that loads an endless loop into the beginning of secure memo=
ry: https://github.com/ajblane/armv8m-hello

  Commandline: qemu-system-arm -machine mps2-an505 -cpu cortex-m33 \
  	                    -m 4096 \
  			    -nographic -serial mon:stdio \
  	                    -kernel $(IMAGE) -s -S

  Attach with arm-none-eabi-gdb, and run x 0xE000EDD4.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1812091/+subscriptions

