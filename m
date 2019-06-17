Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC300C31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 09:32:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEF3A2085A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 09:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF3A2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45568 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcnze-0003Rx-Lv
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 05:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56565)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hcnyR-0002pp-Gs
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 05:30:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hcnyQ-0004Vm-Ch
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 05:30:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:37638)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hcnyQ-0004Uf-5w
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 05:30:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hcnyN-0004o3-AD
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 09:30:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 47FCA2E807B
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 09:30:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Jun 2019 09:21:54 -0000
From: Stefan <1833048@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: stefan-proxmox
X-Launchpad-Bug-Reporter: Stefan (stefan-proxmox)
X-Launchpad-Bug-Modifier: Stefan (stefan-proxmox)
Message-Id: <156076331418.27432.10852069688574998095.malonedeb@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18981";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 777df570cc3787404f2c45ceedfb9b9e5518f706
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1833048] [NEW] Guest Agent get-fsinfo doesn't
 show ZFS volumes
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
Reply-To: Bug 1833048 <1833048@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Calling get-fsinfo on a virtual machine does not include ZFS
(zfsonlinux, debian guest tested) volumes. Calling on a system with a
single ZFS disk (ZFS as root fs) simply returns '[]', if other disks
exist on the guest it only shows these.

Expected behaviour: Show file system details like with other fs formats.

Tried with debian stretch default qemu-guest-agent package and v4.0.0 from =
git, compiled locally - result is the same.
Host is using QEMU 3.0.1, but that shouldn't matter, right?

** Affects: qemu
     Importance: Undecided
         Status: New

** Description changed:

- Calling get-fsinfo on a virtual machine does not include ZFS volumes.
- Calling on a system with a single ZFS disk (ZFS as root fs) simply
- returns '[]', if other disks exist on the guest it only shows these.
+ Calling get-fsinfo on a virtual machine does not include ZFS
+ (zfsonlinux, debian guest tested) volumes. Calling on a system with a
+ single ZFS disk (ZFS as root fs) simply returns '[]', if other disks
+ exist on the guest it only shows these.
  =

  Expected behaviour: Show file system details like with other fs formats.
  =

  Tried with debian stretch default qemu-guest-agent package and v4.0.0 fro=
m git, compiled locally - result is the same.
  Host is using QEMU 3.0.1, but that shouldn't matter, right?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1833048

Title:
  Guest Agent get-fsinfo doesn't show ZFS volumes

Status in QEMU:
  New

Bug description:
  Calling get-fsinfo on a virtual machine does not include ZFS
  (zfsonlinux, debian guest tested) volumes. Calling on a system with a
  single ZFS disk (ZFS as root fs) simply returns '[]', if other disks
  exist on the guest it only shows these.

  Expected behaviour: Show file system details like with other fs
  formats.

  Tried with debian stretch default qemu-guest-agent package and v4.0.0 fro=
m git, compiled locally - result is the same.
  Host is using QEMU 3.0.1, but that shouldn't matter, right?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1833048/+subscriptions

