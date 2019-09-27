Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C745AC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:36:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96BE3206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96BE3206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDjru-0001sV-Ny
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 02:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51001)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iDjPS-0007ON-DL
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 02:07:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iDjPR-00006z-3c
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 02:07:18 -0400
Received: from indium.canonical.com ([91.189.90.7]:37264)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iDjPQ-0008V8-U6
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 02:07:17 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iDjPP-0007Vb-C2
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 06:07:15 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 453B92E80CB
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 06:07:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Sep 2019 06:01:07 -0000
From: RTOS Pharos <1777777@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: janitor pmaydell rtos.pharos
X-Launchpad-Bug-Reporter: RTOS Pharos (rtos.pharos)
X-Launchpad-Bug-Modifier: RTOS Pharos (rtos.pharos)
References: <152947435461.1911.16896504402050089205.malonedeb@chaenomeles.canonical.com>
Message-Id: <156956406824.19697.12036542530355749063.malone@wampee.canonical.com>
Subject: [Bug 1777777] Re: arm9 clock pending (SP804)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19056";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 6d688f809bb3a6beacefe81db3f0e317f927361c
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
Reply-To: Bug 1777777 <1777777@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thank you for checking this issue.

I looked at the ptimer code, like you said. Just one question: isn't this u=
sed by other hw as well?
Maybe this problem is more general...

I also tried (basically) the same example on a aarch64 (raspberry pi3),
and I don't find any problems there. Maybe could be helpful to look how
this problem is solved there.

Just trying to help

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1777777

Title:
  arm9 clock pending (SP804)

Status in QEMU:
  Confirmed

Bug description:
  Hello all,

  I'm using the versatilepb board and the timer Interrupt Mask Status
  register (offset 0x14 of the SP804) does not seem to be working
  properly on the latest qemu-2.12. I tried on the 2.5 (i believe this
  is the mainstream version that comes with Linux) and it works
  perfectly.

  What happens is that the pending bit does not seem to be set in some
  scenarios. In my case, I see the timer value decreasing to 0 and then
  being reset to the reload value and neither does the interrupt is
  triggered nor the pending bit is set.

  I believe this is a matter of timing since in the "long" run the
  system eventually catches up (after a few microseconds).

  Thank you

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1777777/+subscriptions

