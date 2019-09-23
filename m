Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB089C4CED0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 19:11:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C471220665
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 19:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C471220665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCTkb-00075S-Vb
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 15:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iCTjs-0006X9-Er
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 15:11:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iCTjr-0006dn-6p
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 15:11:12 -0400
Received: from indium.canonical.com ([91.189.90.7]:48692)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iCTjr-0006dW-1U
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 15:11:11 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iCTjp-0007gT-Sh
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 19:11:09 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id D72E62E8074
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 19:11:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Sep 2019 18:56:31 -0000
From: RTOS Pharos <1777777@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: janitor pmaydell rtos.pharos
X-Launchpad-Bug-Reporter: RTOS Pharos (rtos.pharos)
X-Launchpad-Bug-Modifier: RTOS Pharos (rtos.pharos)
References: <152947435461.1911.16896504402050089205.malonedeb@chaenomeles.canonical.com>
Message-Id: <156926499196.13698.2399392543551586795.malone@gac.canonical.com>
Subject: [Bug 1777777] Re: arm9 clock pending (SP804)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19048";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 243abb23ac013d78d119c4cda7b65ef65919e86a
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

Forgot to state the qemu argument, it's this one:

~/cross-compiler/qemu/2.5/bin/qemu-system-arm -M versatilepb -m 128M
-nographic -kernel myApplication

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1777777

Title:
  arm9 clock pending (SP804)

Status in QEMU:
  New

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

