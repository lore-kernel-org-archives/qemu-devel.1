Return-Path: <SRS0=qvFP=5O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9799C43331
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 20:41:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9000C20748
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 20:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9000C20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIekL-0006XA-NE
	for qemu-devel@archiver.kernel.org; Sun, 29 Mar 2020 16:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jIeji-00066F-BF
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 16:40:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jIejg-0002kp-Vk
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 16:40:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:49472)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jIejg-0002k8-Qi
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 16:40:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jIejf-0007jj-Bu
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2020 20:40:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 563EC2E80C7
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2020 20:40:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 29 Mar 2020 20:33:57 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided;
 assignee=wilburm@gmail.com; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: mattwilbur pmaydell
X-Launchpad-Bug-Reporter: Matt Wilbur (mattwilbur)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <158540989331.24425.14224651637245896063.malonedeb@soybean.canonical.com>
Message-Id: <158551403766.20605.9886570301666642580.malone@gac.canonical.com>
Subject: [Bug 1869497] Re: x86_cpu_gdb_read_register segfaults when gdb
 requests registers
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a296f04231dee355be5db73cc878b9e21689a253";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: ca0123787fcae4782bb847ab8dfbcba369c04a79
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
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
Reply-To: Bug 1869497 <1869497@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks for tracking down the source of the bug. Our 'submitting patches'
policy is at https://wiki.qemu.org/Contribute/SubmitAPatch in case you
haven't already found it. (It's quite long but for a simple one-shot
bugfix patch the important stuff is just the summarized bits at the
top.)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1869497

Title:
  x86_cpu_gdb_read_register segfaults when gdb requests registers

Status in QEMU:
  New

Bug description:
  When attempting to attach to the gdbstub, a segfault occurs.

  I traced this down to a problem in a call to gdb_get_reg16 where the
  mem_buf was being treated like a uint8_t* instead of a GByteArray.
  The buffer passed to gdb_get_reg16 ends up passing an invalid
  GByteArray pointer, which subsequentlycauses a segfault in memcpy.

  I have a fix for this - just need to educate myself on how to submit a
  patch.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1869497/+subscriptions

