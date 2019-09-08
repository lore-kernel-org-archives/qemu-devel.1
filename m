Return-Path: <SRS0=PtAT=XD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA43BC433EF
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 02:11:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 864E720693
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 02:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 864E720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6mfh-0006YT-Im
	for qemu-devel@archiver.kernel.org; Sat, 07 Sep 2019 22:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i6mf8-00068r-7v
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 22:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i6mf7-0006B4-0r
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 22:10:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:53254)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i6mf6-0006A3-RS
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 22:10:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i6mf5-0007wy-DT
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2019 02:10:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 5D2992E80C7
 for <qemu-devel@nongnu.org>; Sun,  8 Sep 2019 02:10:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Sep 2019 02:02:09 -0000
From: James Harvey <jamespharvey20@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jamespharvey20
X-Launchpad-Bug-Reporter: James Harvey (jamespharvey20)
X-Launchpad-Bug-Modifier: James Harvey (jamespharvey20)
Message-Id: <156790812963.29382.11232177290822294099.malonedeb@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19044";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 95da25d5a5c758b07aac0ef1629ec774cbac4978
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1843151] [NEW] Regression: QEMU 4.1.0 qxl and KMS
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

Public bug reported:

Host is Arch Linux.  linux 5.2.13, qemu 4.1.0.

Guest is Arch Linux Sept 2019 ISO.  linux 5.2.11.

Have replicated this both on a system using amdgpu and one using
integrated ASPEED graphics.

Downgrading from 4.1.0 to 4.0.0 works as usual, see:
https://www.youtube.com/watch?v=3DNyMdcYwOCvY

Going back to 4.1.0 reproduces, see:
https://www.youtube.com/watch?v=3DH3nGG2Mk6i0

4.1.0 displays fine until KMS kicks in.

Using 4.1.0 with virtio-vga doesn't cause this.

** Affects: qemu
     Importance: Undecided
         Status: New

** Description changed:

  Host is Arch Linux.  linux 5.2.13, qemu 4.1.0.
  =

  Guest is Arch Linux Sept 2019 ISO.  linux 5.2.11.
  =

  Have replicated this both on a system using amdgpu and one using
  integrated ASPEED graphics.
  =

  Downgrading from 4.1.0 to 4.0.0 works as usual, see:
  https://www.youtube.com/watch?v=3DNyMdcYwOCvY
  =

  Going back to 4.1.0 reproduces, see:
  https://www.youtube.com/watch?v=3DH3nGG2Mk6i0
  =

  4.1.0 displays fine until KMS kicks in.
+ =

+ Using 4.1.0 with virtio-vga doesn't cause this.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1843151

Title:
  Regression: QEMU 4.1.0 qxl and KMS resoluiton only 4x10

Status in QEMU:
  New

Bug description:
  Host is Arch Linux.  linux 5.2.13, qemu 4.1.0.

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

