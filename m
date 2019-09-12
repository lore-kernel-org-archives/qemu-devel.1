Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1503DC5ACAE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 08:31:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF465208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 08:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF465208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8KWC-00078G-34
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 04:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i8KVD-0006gx-3o
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i8KVC-0007Wm-1Z
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:30:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:53446)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i8KVB-0007VR-Sk
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:30:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i8KVA-0001WS-5i
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 08:30:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id ED4562E80CC
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 08:30:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Sep 2019 08:18:02 -0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dgilbert-h jamespharvey20
X-Launchpad-Bug-Reporter: James Harvey (jamespharvey20)
X-Launchpad-Bug-Modifier: Dr. David Alan Gilbert (dgilbert-h)
References: <156790812963.29382.11232177290822294099.malonedeb@chaenomeles.canonical.com>
Message-Id: <156827628273.5915.13533113096234436221.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19044";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 2666f3bc859efd3d61ad2a4447cb29812869e520
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1843151] Re: Regression: QEMU 4.1.0 qxl and KMS
 resoluiton only 4x10
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
Reply-To: Bug 1843151 <1843151@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi James,
  OK, thanks - some questions:
    a) What version of spice-server have you got on your host?
    b) Does swapping the '-vga qxl' for '-device qxl-vga,max_outputs=3D1' h=
elp? (try with and without the max_outputs=3D1)
    c) Are you able to do bisect builds to try and track down which commit =
broke it?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1843151

Title:
  Regression: QEMU 4.1.0 qxl and KMS resoluiton only 4x10

Status in QEMU:
  New

Bug description:
  Host is Arch Linux.  linux 5.2.13, qemu 4.1.0.  virt-viewer 8.0.

  Guest is Arch Linux Sept 2019 ISO.  linux 5.2.11.

  Have replicated this both on a system using amdgpu and one using
  integrated ASPEED graphics.

  Downgrading from 4.1.0 to 4.0.0 works as usual, see:
  https://www.youtube.com/watch?v=3DNyMdcYwOCvY

  Going back to 4.1.0 reproduces, see:
  https://www.youtube.com/watch?v=3DH3nGG2Mk6i0

  4.1.0 displays fine until KMS kicks in.

  Using 4.1.0 with virtio-vga doesn't cause this.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1843151/+subscriptions

