Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56076C38A2F
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 13:46:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 241B02054F
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 13:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 241B02054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPnno-0002Ip-7y
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 09:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jPnmx-0001i9-CM
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 09:45:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jPnmw-0006B3-18
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 09:45:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:32770)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jPnmv-000696-R2
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 09:45:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jPnmu-0006Fg-Au
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2020 13:45:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 515D72E8053
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2020 13:45:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Apr 2020 13:39:55 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1869497@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=wilburm@gmail.com; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: mattwilbur philmd pmaydell
X-Launchpad-Bug-Reporter: Matt Wilbur (mattwilbur)
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <158540989331.24425.14224651637245896063.malonedeb@soybean.canonical.com>
Message-Id: <158721719584.27488.13166280673214591005.malone@gac.canonical.com>
Subject: [Bug 1869497] Re: x86_cpu_gdb_read_register segfaults when gdb
 requests registers
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="2e26c9bbd21cdca248baaea29aeffb920afcc32a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 141123de846d389063ece0061a41dd40fb089ae5
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

Fixed in commit bbc40fefcee0d69d61ceaf8c0695d2ce43cdc87b.

** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1869497

Title:
  x86_cpu_gdb_read_register segfaults when gdb requests registers

Status in QEMU:
  Fix Committed

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

