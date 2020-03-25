Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F42C2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 20:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3530820658
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 20:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3530820658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHCHx-0003Al-7g
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 16:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jHCCu-0001dP-5Q
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 16:00:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jHCCs-0007Eb-Ac
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 16:00:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:46152)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jHCCr-0007Aq-Ta
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 16:00:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jHCCj-00037d-Ss
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 20:00:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id D6F222E80AB
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 20:00:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Mar 2020 19:52:40 -0000
From: Manuel Reimer <manuel.reimer@gmx.de>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: manuel-reimer
X-Launchpad-Bug-Reporter: Manuel Reimer (manuel-reimer)
X-Launchpad-Bug-Modifier: Manuel Reimer (manuel-reimer)
Message-Id: <158516596046.18657.8423350120096244746.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1869073] [NEW] qemu-arm-static crashes "segmentation fault" when
 running "git clone -s"
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="3a6db24bbe7280ec09bae73384238390fcc98ad3";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 15cdb13b23b09ef9a6d4c367ae1b6b84021ff708
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
Reply-To: Bug 1869073 <1869073@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

I want to use qemu-arm-static to cross-compile software. The compiler
itself is a native cross-compiler connected via "distcc".

The problem is that a script tries to do some stuff with "git" and with
a "git clone -s" command the whole story reproducibly stops with a
"segmentation fault".

I don't know how to properly debug the issue but it happens 100% of the
time that I get the "crash" or git just hangs forever with 100% CPU
usage.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1869073

Title:
  qemu-arm-static crashes "segmentation fault" when running "git clone
  -s"

Status in QEMU:
  New

Bug description:
  I want to use qemu-arm-static to cross-compile software. The compiler
  itself is a native cross-compiler connected via "distcc".

  The problem is that a script tries to do some stuff with "git" and
  with a "git clone -s" command the whole story reproducibly stops with
  a "segmentation fault".

  I don't know how to properly debug the issue but it happens 100% of
  the time that I get the "crash" or git just hangs forever with 100%
  CPU usage.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1869073/+subscriptions

