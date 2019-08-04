Return-Path: <SRS0=5wN1=WA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0279C433FF
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2019 23:41:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD59220665
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2019 23:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD59220665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelpath.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huQ85-0004HN-QR
	for qemu-devel@archiver.kernel.org; Sun, 04 Aug 2019 19:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34649)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1huQ7T-0003qd-CL
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 19:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1huQ7R-0001CD-B5
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 19:40:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:34192)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1huQ7P-00019p-J6
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 19:40:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1huQ7N-0004jH-Bp
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2019 23:40:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 524582E807D
 for <qemu-devel@nongnu.org>; Sun,  4 Aug 2019 23:40:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Aug 2019 23:32:13 -0000
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
Message-Id: <156496153354.1431.13118829927704366229.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19014";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: a5afbdc2d26a4ab0c71c125e28052686b4dc5cb5
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

Commit:

https://bugs.launchpad.net/intel/+bug/1828495/comments/42

Addresses exactly this bug fix.

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

