Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BFAC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:07:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1EB5207E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1EB5207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iro0K-0002cn-Qm
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 14:07:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1irnzR-00029b-Q4
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:06:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1irnzN-0007gL-WE
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:06:05 -0500
Received: from indium.canonical.com ([91.189.90.7]:57532)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1irnzN-0007fN-QX
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:06:01 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1irnzK-0006FO-Oi
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 19:05:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B97C92E80C9
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 19:05:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jan 2020 18:58:02 -0000
From: John Snow <1859418@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jnsnow mark.zealey
X-Launchpad-Bug-Reporter: Mark Zealey (mark.zealey)
X-Launchpad-Bug-Modifier: John Snow (jnsnow)
References: <157890928787.14410.16804441855204869910.malonedeb@wampee.canonical.com>
Message-Id: <157911468264.27144.9927170754642681293.malone@chaenomeles.canonical.com>
Subject: [Bug 1859418] Re: disk driver with iothread setting hangs live
 migrations
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 82069851f293f74e0fcf82b5062d8d6410ab4363
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Bug 1859418 <1859418@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Initially I suspected that https://lists.gnu.org/archive/html/qemu-
devel/2020-01/msg03048.html may have addressed this issue, but I think
because you're not using backup it might not.

...Oh, qemu 2.12 is *quite old* and not supported upstream anymore. Do
you have the ability to test on a more modern QEMU version?

If not, I might need to redirect you back to the RH Bugzilla for issues
with the stable version they ship for RH/CentOS. I don't want to play
bug tracker pingpong with you, so I'll leave this issue open (but marked
"incomplete") and wait for a reply.

--js

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1859418

Title:
  disk driver with iothread setting hangs live migrations

Status in QEMU:
  Incomplete

Bug description:
  Per report raised at
  https://bugzilla.redhat.com/show_bug.cgi?id=3D1790093

  Description of problem:

  A disk driver definition using iothread parameter causes live
  migration with copy storage to hang during or just before the final
  ram sync stage.

  Interestingly, having the scsi controller as a separate iothread does
  not trigger the issue.

  Version-Release number of selected component (if applicable):

  I can reproduce this on centos7 with qemu-ev and with centos 8:

  qemu-kvm-ev-2.12.0-33.1.el7_7.4.x86_64
  qemu-kvm-2.12.0-65.module_el8.0.0+189+f9babebb.5.x86_64

  Steps to Reproduce:
  1. Create a definition with 1 iothread on the disk image:

        <driver name=3D'qemu' type=3D'qcow2' iothread=3D'1' />

  2. Issue a live migrate request like: virsh migrate --live --copy-storage=
-all vm qemu+tcp://remote/system
  3. Live migrate on source copies storage and then hangs at 80-99%, I gues=
s during the ram copy phase.

  Keeping exactly the same config but without the iothread on the disk
  driver has successful migrations every time.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1859418/+subscriptions

