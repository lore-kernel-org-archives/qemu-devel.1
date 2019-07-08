Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE84C606C1
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 15:35:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1747121537
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 15:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1747121537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkVfu-0007WA-BY
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 11:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60989)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hkVbo-0005jw-PH
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 11:31:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hkVbn-0003qi-J0
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 11:31:16 -0400
Received: from indium.canonical.com ([91.189.90.7]:42578)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hkVbn-0003ki-Bh
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 11:31:15 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hkVbl-0004iX-2m
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 15:31:13 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 124992E804E
 for <qemu-devel@nongnu.org>; Mon,  8 Jul 2019 15:31:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jul 2019 15:19:39 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: arm
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: pmaydell sedrubal
X-Launchpad-Bug-Reporter: sedrubal (sedrubal)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <153782360135.24561.14757076619752022286.malonedeb@gac.canonical.com>
Message-Id: <156259917974.21433.3305464938496675800.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19007";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: ca62e06f82908712191e2d66603ca2a49ab2081a
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1794187] Re: improve error message,
 when using raspi3 and RAM>4G
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
Reply-To: Bug 1794187 <1794187@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Improved diagnostic message is now in master and will be in QEMU 4.1.


** Changed in: qemu
       Status: In Progress =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1794187

Title:
  improve error message, when using raspi3 and RAM>4G

Status in QEMU:
  Fix Committed

Bug description:
  Running `qemu-system-aarch64 image-aarch64.iso --machine raspi3 -m 8G`
  prints this error message:

  ```
  Unexpected error in visit_type_uintN() at /builddir/build/BUILD/qemu-3.0.=
0/qapi/qapi-visit-core.c:164:
  qemu-system-aarch64: Parameter 'vcram-base' expects uint32_t
  ```

  The problem is, that you musn't use more than 4 GB RAM for machine
  raspi3. As it took me some time to figure that out, I'd be glad, if
  you can print better error message, like you do, when using more than
  4 CPU cores with machine raspi3:

  ```
  Invalid SMP CPUs 8. The max CPUs supported by machine 'raspi3' is 4 =

  ```

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1794187/+subscriptions

