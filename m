Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF57C41517
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 08:05:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0716122C97
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 08:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0716122C97
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqYlB-0002Ty-B3
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 04:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38521)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hqYkv-0001Zx-2O
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hqYkq-0003hZ-1r
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:05:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:53112)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hqYkp-0003h5-RN
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:05:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hqYko-0005aw-4k
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 08:05:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1A9172E80C7
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 08:05:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jul 2019 07:59:10 -0000
From: Stefan <1837851@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: qemu-kvm
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: stefan-proxmox
X-Launchpad-Bug-Reporter: Stefan (stefan-proxmox)
X-Launchpad-Bug-Modifier: Stefan (stefan-proxmox)
Message-Id: <156404155054.10633.9207967667458929652.malonedeb@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19010";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 620157ead50239f72e3fe3db600e352835e5bbb3
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1837851] [NEW] hv-tlbflush malfunctions on Intel
 host CPUs with neither EPT nor VPID (qemu-kvm)
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
Reply-To: Bug 1837851 <1837851@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Enabling hv-tlbflush on older hosts using Intel CPUs supporting VT-x but
neither EPT nor VPID will lead to bluescreens on the guest.

It seems KVM only checks if EPT is available, and if it isn't it
forcibly uses VPID. If that's *also* not available, it defaults to
basically a no-op hypercall, though windows is expecting the TLB to be
flushed.

hv-tlbflush is pretty useless on machines not supporting these
extensions anyway (only reasonably fix I can see would be to flush the
*entire* TLB on tlbflush hypercall in KVM (i.e. a kernel fix), but that
would remove any performance benefits), so I would suggest some kind of
preliminary check and warning/error if hv-tlbflush is specified on such
a host.

All CPUs mentioned in this thread[0] are confirmed to be affected by the
bug, and I have successfully reproduced it on an Intel Core2Duo E8500.

[0] https://forum.proxmox.com/threads/windows-guest-bluescreen-with-
proxmox-6.56053/

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: qemu-kvm

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1837851

Title:
  hv-tlbflush malfunctions on Intel host CPUs with neither EPT nor VPID
  (qemu-kvm)

Status in QEMU:
  New

Bug description:
  Enabling hv-tlbflush on older hosts using Intel CPUs supporting VT-x
  but neither EPT nor VPID will lead to bluescreens on the guest.

  It seems KVM only checks if EPT is available, and if it isn't it
  forcibly uses VPID. If that's *also* not available, it defaults to
  basically a no-op hypercall, though windows is expecting the TLB to be
  flushed.

  hv-tlbflush is pretty useless on machines not supporting these
  extensions anyway (only reasonably fix I can see would be to flush the
  *entire* TLB on tlbflush hypercall in KVM (i.e. a kernel fix), but
  that would remove any performance benefits), so I would suggest some
  kind of preliminary check and warning/error if hv-tlbflush is
  specified on such a host.

  All CPUs mentioned in this thread[0] are confirmed to be affected by
  the bug, and I have successfully reproduced it on an Intel Core2Duo
  E8500.

  [0] https://forum.proxmox.com/threads/windows-guest-bluescreen-with-
  proxmox-6.56053/

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1837851/+subscriptions

