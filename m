Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287DCC2D0E5
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 15:46:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0106220716
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 15:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0106220716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIDfQ-0002Hb-39
	for qemu-devel@archiver.kernel.org; Sat, 28 Mar 2020 11:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jIDeT-00011D-Tt
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 11:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jIDeS-00038N-M7
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 11:45:37 -0400
Received: from indium.canonical.com ([91.189.90.7]:35958)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jIDeS-00037T-GO
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 11:45:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jIDeR-0001mr-0C
 for <qemu-devel@nongnu.org>; Sat, 28 Mar 2020 15:45:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B77802E80D0
 for <qemu-devel@nongnu.org>; Sat, 28 Mar 2020 15:45:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Mar 2020 15:38:13 -0000
From: Matt Wilbur <1869497@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: mattwilbur
X-Launchpad-Bug-Reporter: Matt Wilbur (mattwilbur)
X-Launchpad-Bug-Modifier: Matt Wilbur (mattwilbur)
Message-Id: <158540989331.24425.14224651637245896063.malonedeb@soybean.canonical.com>
Subject: [Bug 1869497] [NEW] x86_cpu_gdb_read_register segfaults when gdb
 requests registers
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a296f04231dee355be5db73cc878b9e21689a253";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 7394a06de9c01889ca289e63bf03ab377a54703e
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

Public bug reported:

When attempting to attach to the gdbstub, a segfault occurs.

I traced this down to a problem in a call to gdb_get_reg16 where the
mem_buf was being treated like a uint8_t* instead of a GByteArray.  The
buffer passed to gdb_get_reg16 ends up passing an invalid GByteArray
pointer, which subsequentlycauses a segfault in memcpy.

I have a fix for this - just need to educate myself on how to submit a
patch.

** Affects: qemu
     Importance: Undecided
         Status: New

** Description changed:

  When attempting to attach to the gdbstub, a segfault occurs.
  =

- I traced this down to a problem in a call to gdb_get_reg16 where the mem_=
buf
- was being treated like a uint8_t* instead of a GByteArray.  The buffer pa=
ssed
- to gdb_get_reg16 ends up passing an invalid GByteArray pointer, which sub=
sequently
- causes a segfault in memcpy.
+ I traced this down to a problem in a call to gdb_get_reg16 where the
+ mem_buf was being treated like a uint8_t* instead of a GByteArray.  The
+ buffer passed to gdb_get_reg16 ends up passing an invalid GByteArray
+ pointer, which subsequentlycauses a segfault in memcpy.
  =

  I have a fix for this - just need to educate myself on how to submit a
  patch.

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

