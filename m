Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9066DC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 09:47:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2400821929
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 09:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2400821929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAt1o-00007h-68
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 05:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iAt0T-0007cD-Ou
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 05:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iAt0S-0004a3-G0
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 05:45:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:54332)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iAt0S-0004Zf-AA
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 05:45:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iAt0Q-0002Pr-8Z
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 09:45:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 268162E80DA
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 09:45:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Sep 2019 09:34:45 -0000
From: Patrick van Logchem <1844644@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: patrickvl
X-Launchpad-Bug-Reporter: Patrick van Logchem (patrickvl)
X-Launchpad-Bug-Modifier: Patrick van Logchem (patrickvl)
Message-Id: <156888568548.4915.345807497840369560.malonedeb@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19048";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: a9ee7deeafede82b41b69079abd267ce1c53d162
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1844644] [NEW] Compiler warnings using MSVC
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
Reply-To: Bug 1844644 <1844644@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

The following line of code results in an implicit truncation of an uint16_t=
 value to an uint8_t variable, which triggers a compiler warning in MSVC : =
https://github.com/qemu/qemu/blob/f8c3db33a5e863291182f8862ddf81618a7c6194/=
hw/usb/dev-hub.c#L387
(Two lines down, the same thing happens.)

This warning can be silenced by doing an explicit truncation, for
example by a casting the value explicitly to uint8_t type, or by anding
the value with 0xFF.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1844644

Title:
  Compiler warnings using MSVC

Status in QEMU:
  New

Bug description:
  The following line of code results in an implicit truncation of an uint16=
_t value to an uint8_t variable, which triggers a compiler warning in MSVC =
: https://github.com/qemu/qemu/blob/f8c3db33a5e863291182f8862ddf81618a7c619=
4/hw/usb/dev-hub.c#L387
  (Two lines down, the same thing happens.)

  This warning can be silenced by doing an explicit truncation, for
  example by a casting the value explicitly to uint8_t type, or by
  anding the value with 0xFF.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1844644/+subscriptions

