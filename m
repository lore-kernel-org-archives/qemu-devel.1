Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DBBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 08:02:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 169F9206F1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 08:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 169F9206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeZxu-00079r-5Q
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 04:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jeZwl-0005rn-Ma
 for qemu-devel@nongnu.org; Fri, 29 May 2020 04:00:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:56356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jeZwk-0006Ir-EN
 for qemu-devel@nongnu.org; Fri, 29 May 2020 04:00:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jeZwi-000474-M0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 08:00:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id A57DB2E8106
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 08:00:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2020 07:55:14 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1881249@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: arm m68k reset
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <159073846050.5787.14804870953764762248.malonedeb@wampee.canonical.com>
Message-Id: <159073891456.6149.9958396664467206040.malone@wampee.canonical.com>
Subject: [Bug 1881249] Re: CPU fetch from unpopulated ROM on reset
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="275d46a24253e557e4403d52832837e4bfa425b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 6496264f7a8f02d47b5265af714b119e19e384ff
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 02:40:58
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
Reply-To: Bug 1881249 <1881249@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Different comments from Peter Maydell regarding this issue:

- https://www.mail-archive.com/qemu-devel@nongnu.org/msg683768.html

"We should be able to do this with the new 3-phase
reset API : the rom loader reset should happen in phase 2,
and the Arm CPU should only load the new PC and SP in
phase 3."

- https://www.mail-archive.com/qemu-devel@nongnu.org/msg686480.html

"The expectation at the moment is that the board code should
register a reset function with qemu_register_reset() which
calls cpu_reset(). Relying on doing a reset in realize won't
work for the case where there's a QEMU system reset, because
we don't re-init/realize everything, we just call all the
reset hooks.

If m68k reads pc/sp from memory on reset you'll probably run
into the same reset-ordering vs hw/cpu/loader.c that Arm M-profile
has; we currently work around that in the arm reset function."

- https://www.mail-archive.com/qemu-devel@nongnu.org/msg683856.html

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1881249

Title:
  CPU fetch from unpopulated ROM on reset

Status in QEMU:
  New

Bug description:
  Some architectures fetch the $PC/$SP register as vectors in memory, usual=
ly ROM.
  The CPU reset() handler is called before the ROM code is populated, resul=
ting in fetching incorrect PC/SP.

  Architectures affected:
  - M68K
  - RX
  - ARM M-profile

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1881249/+subscriptions

