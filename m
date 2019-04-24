Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F11C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 05:42:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAB67218D3
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 05:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB67218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36205 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJAft-0006nH-TF
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 01:42:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJAeN-0005sR-Q6
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:40:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJAeM-00081h-CX
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:40:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:38112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJAeM-000811-6Y
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:40:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJAeL-0003sx-90
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 05:40:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3F4C82E80D1
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 05:40:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 05:33:47 -0000
From: Thomas Huth <1806824@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Tags: arm
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ajbennee pmaydell yvt
X-Launchpad-Bug-Reporter: YVT (yvt)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <154399222698.26202.11105511106314070474.malonedeb@gac.canonical.com>
Message-Id:
 <155608402791.14088.15889989836662585779.launchpad@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 8acba68b812bd11996176ba2fac9a1b2c5d293d1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1806824] Re: SIE-200 (TrustZone) MPC: BLK_MAX
 returns an incorrect value
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
Reply-To: Bug 1806824 <1806824@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424053347.YdU6586Nt-8PieZXsufBoGy_hQ0LcxP5Mcsz3zFOUgo@z>

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1806824

Title:
  SIE-200 (TrustZone) MPC: BLK_MAX returns an incorrect value

Status in QEMU:
  Fix Released

Bug description:
  Version: =

  $ qemu-system-arm --version
  QEMU emulator version 3.0.92 (v3.1.0-rc2-31-gd522fba244)

  Arm SIE-200 Technical Reference Manual describes that BLK_MAX
  indicates the maximum value of "block based index register" (BLK_IDX).
  For example, the value 1 would indicate that BLK_IDX can be 0 or 1.
  According to my experiments, the AN505 FPGA image apparently follows
  this behavior.

  In the current implementation of QEMU, it appears to indicate the
  number of possible values for BLK_IDX, i.e., one plus the value it's
  supposed to return.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1806824/+subscriptions

