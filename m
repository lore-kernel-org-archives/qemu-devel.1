Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86E2C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 16:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCE05206C3
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 16:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE05206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44589 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMbQ2-0001FI-1W
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 12:52:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hMbOd-0008LY-01
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hMbOb-0002E1-Mw
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:50:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:35120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hMbOb-0002D3-HG
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:50:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hMbOZ-0003KI-Bj
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 16:50:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 18AFC2E80CC
	for <qemu-devel@nongnu.org>; Fri,  3 May 2019 16:50:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 May 2019 16:36:51 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: arm feature-request
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: mark-rutland
X-Launchpad-Bug-Reporter: Mark Rutland (mark-rutland)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <155483243569.8652.5979441352991477638.malonedeb@wampee.canonical.com>
Message-Id:
 <155690141223.19580.17385068954807494182.launchpad@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18953";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 78f05d97a8a5469bc3a66422daa6de6a427e5d71
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1823998] Re: qemu-system-aarch64: support kernels
 bigger than 128MiB
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1823998 <1823998@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503163651.Q-gcom5hEm0277x6P6mX69_aoiv8TwXHBMqiZ_x5j6c@z>

** Tags added: arm

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1823998

Title:
  qemu-system-aarch64: support kernels bigger than 128MiB

Status in QEMU:
  New

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

