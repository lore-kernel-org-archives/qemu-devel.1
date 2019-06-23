Return-Path: <SRS0=JchA=UW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361D2C43613
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2019 20:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AA43206BA
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2019 20:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA43206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46674 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hf96U-0004vm-US
	for qemu-devel@archiver.kernel.org; Sun, 23 Jun 2019 16:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43689)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hf8VZ-0004R6-HN
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 15:50:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hf8VY-0003wL-Cf
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 15:50:37 -0400
Received: from indium.canonical.com ([91.189.90.7]:54364)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hf8VY-0003te-6n
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 15:50:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hf8VV-00078u-Py
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2019 19:50:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id BE40A2E802E
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2019 19:50:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Jun 2019 19:41:54 -0000
From: Dark Dragon <darkdragon-001@web.de>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: darkdragon-001
X-Launchpad-Bug-Reporter: Dark Dragon (darkdragon-001)
X-Launchpad-Bug-Modifier: Dark Dragon (darkdragon-001)
Message-Id: <156131891438.18960.11146618661074230951.malonedeb@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18989";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 0318194b42928b838947402e7b7af6c912b31446
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Sun, 23 Jun 2019 16:27:44 -0400
Subject: [Qemu-devel] [Bug 1833871] [NEW] qemu-img convert file.vmdk:
 Invalid footer
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
Reply-To: Bug 1833871 <1833871@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Steps to reproduce
- Open ESXi 6.5 Web UI
- Export OVF
- qemu-img convert disk.vmdk disk.qcow2

Error:

    qemu-img: Could not open './disk-1.vmdk': Invalid footer

I found another person having this problem here:
https://forum.proxmox.com/threads/error-converting-vmdk-file-to-qcow2-file.=
38264/
As I guess from the answer, the guy went over to manually copy the flat fil=
e from the datastore instead of using the ovf-exported file.

Nevertheless, I think this bug should be investigated further and
closed. Probably it is just some metadata issue and should not be too
hard to fix once the root of the problem is found.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1833871

Title:
  qemu-img convert file.vmdk: Invalid footer

Status in QEMU:
  New

Bug description:
  Steps to reproduce
  - Open ESXi 6.5 Web UI
  - Export OVF
  - qemu-img convert disk.vmdk disk.qcow2

  Error:

      qemu-img: Could not open './disk-1.vmdk': Invalid footer

  I found another person having this problem here:
  https://forum.proxmox.com/threads/error-converting-vmdk-file-to-qcow2-fil=
e.38264/
  As I guess from the answer, the guy went over to manually copy the flat f=
ile from the datastore instead of using the ovf-exported file.

  Nevertheless, I think this bug should be investigated further and
  closed. Probably it is just some metadata issue and should not be too
  hard to fix once the root of the problem is found.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1833871/+subscriptions

