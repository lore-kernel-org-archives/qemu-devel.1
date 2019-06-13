Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F47C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 19:59:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90E2B2147A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 19:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E2B2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelpath.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45356 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbVsK-0006HI-NO
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 15:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54561)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hbVkV-0006x6-0S
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 15:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hbVkT-00035E-2H
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 15:51:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:48450)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hbVkS-00032K-QQ
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 15:51:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hbVkP-0007VN-26
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 19:50:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 880492E80EC
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 19:50:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Jun 2019 19:35:44 -0000
From: Rafael David Tinoco <rafaeldtinoco@kernelpath.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=intel; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=Confirmed; importance=Wishlist; assignee=rafaeldtinoco@kernelpath.com; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=bionic; sourcepackage=qemu; 
 component=main; status=Confirmed; importance=Wishlist;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=cosmic; sourcepackage=qemu; 
 component=main; status=Confirmed; importance=Wishlist;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=disco; sourcepackage=qemu; 
 component=main; status=Confirmed; importance=Wishlist;
 assignee=None; 
X-Launchpad-Bug-Tags: intel-virt-19.10 qemu-19.10
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: paelzer quanxian-wang rafaeldtinoco sbeattie
X-Launchpad-Bug-Reporter: quanxian (quanxian-wang)
X-Launchpad-Bug-Modifier: Rafael David Tinoco (rafaeldtinoco)
X-Launchpad-Bug-Duplicate: 1828495
References: <155909595152.12810.1489513977238974514.malonedeb@soybean.canonical.com>
Message-Id: <156045454446.22508.10745644521843620597.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18981";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: d1fc8e75a701c2aac63ad4f320a928758b70988b
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1830821] Re: Expose ARCH_CAP_MDS_NO in guest
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
Reply-To: Bug 1830821 <1830821@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

*** This bug is a duplicate of bug 1828495 ***
    https://bugs.launchpad.net/bugs/1828495

I'm marking this bug as a duplicate of LP: #1828495 since both are
asking for mitigations pass-through to i386 kvm guests and I'm preparing
a fix for both simultaneously.

** This bug has been marked a duplicate of bug 1828495
   [KVM][CLX] CPUID_7_0_EDX_ARCH_CAPABILITIES is not enabled in VM.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1830821

Title:
  Expose ARCH_CAP_MDS_NO in guest

Status in intel:
  New
Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Confirmed
Status in qemu source package in Bionic:
  Confirmed
Status in qemu source package in Cosmic:
  Confirmed
Status in qemu source package in Disco:
  Confirmed

Bug description:
  Description:

  MDS_NO is bit 5 of ARCH_CAPABILITIES. Expose this bit to guest.

  Target Qemu: 4.1

To manage notifications about this bug go to:
https://bugs.launchpad.net/intel/+bug/1830821/+subscriptions

