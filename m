Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E985C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:33:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72DE7206EC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72DE7206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihxoM-00040y-GA
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 10:33:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ihxmK-0002Sp-Cx
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:31:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ihxmJ-0001X8-7L
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:31:52 -0500
Received: from indium.canonical.com ([91.189.90.7]:46160)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ihxmI-0001U1-Tj
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:31:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ihxmE-0000Ur-Px
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 15:31:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 85B952E8BCB
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 15:31:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Dec 2019 15:09:09 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: arm virtualization
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: pmaydell udo-hypervisor
X-Launchpad-Bug-Reporter: Udo Steinberg (udo-hypervisor)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <156802847195.6589.6854466446567964580.malonedeb@soybean.canonical.com>
Message-Id: <157676814962.27144.12936295906178826703.malone@chaenomeles.canonical.com>
Subject: [Bug 1843254] Re: arm emulation of HCR.TID3 traps are not implemented
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 9e4b76643051f468f5570678aa47c95e5a9862fb
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
Reply-To: Bug 1843254 <1843254@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The last bit of TID3 trapping is now in QEMU git master and will be in
5.0.


** Changed in: qemu
       Status: In Progress =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1843254

Title:
  arm emulation of HCR.TID3 traps are not implemented

Status in QEMU:
  Fix Committed

Bug description:
  On ARM (aarch64), HCR_EL2.TID3 [bit18] is supposed to trap ID group 3,
  which includes the ID_AA64{PFR,DFR,ISAR,MMFR,AFR}*_EL1 registers.
  However, setting that HCR bit has no effect and accesses to those ID
  registers are not trapped to EL2 with an EC syndrome value of 0x18.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1843254/+subscriptions

