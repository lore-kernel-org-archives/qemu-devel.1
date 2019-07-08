Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9437C606BD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 15:37:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8478E20651
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 15:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8478E20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkVhl-0000xy-Kf
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 11:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60994)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hkVbp-0005jx-0U
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 11:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hkVbn-0003qP-Gv
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 11:31:16 -0400
Received: from indium.canonical.com ([91.189.90.7]:42534)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hkVbl-0003hZ-Dd
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 11:31:15 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hkVbj-0004gE-TA
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 15:31:11 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id D9C2D2E80C7
 for <qemu-devel@nongnu.org>; Mon,  8 Jul 2019 15:31:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jul 2019 15:18:25 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: arm feature-request
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: mark-rutland pmaydell
X-Launchpad-Bug-Reporter: Mark Rutland (mark-rutland)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <155483243569.8652.5979441352991477638.malonedeb@wampee.canonical.com>
Message-Id: <156259910564.25053.11516145760843377397.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19007";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: ccffbcabd4777ff8974b15127f59aed862737a92
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1823998] Re: qemu-system-aarch64: support kernels
 bigger than 128MiB
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
Reply-To: Bug 1823998 <1823998@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes now in master, will be in 4.1.


** Changed in: qemu
       Status: In Progress =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1823998

Title:
  qemu-system-aarch64: support kernels bigger than 128MiB

Status in QEMU:
  Fix Committed

Bug description:
  Presently QEMU reserves up to 128MiB of space for an arm64 Linux
  kernel, placing the initrd following this, and the dtb following the
  initrd.

  This is not sufficient for some debug configurations of the kernel,
  which can be larger than 128MiB. Depending on the relative size of the
  kernel Image and unpopulated BSS, the dtb (or kernel) will be
  clobbered by the other, resulting in a silent boot failure.

  Since v3.17, the kernel Image header exposes a field called
  image_size, which describes the entire size of the kernel (including
  unpopulated sections such as the BSS) as a 64-bit little-endian value.
  For kernels prior to v3.17, this field is zero. This is documented at:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/arm64/booting.txt?h=3Dv5.0#n68

  It would be great if QEMU could take the image_size field into account
  when placing the initrd and dtb to avoid overlap with the kernel.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1823998/+subscriptions

