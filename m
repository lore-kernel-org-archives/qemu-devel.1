Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7249C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 23:07:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A94BB24670
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 23:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A94BB24670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irVHU-0005TI-M6
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 18:07:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1irVFr-0003ml-DY
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 18:05:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1irVFm-0006B0-TB
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 18:05:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:53578)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1irVFm-00067l-MB
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 18:05:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1irVFj-0003SE-HX
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 23:05:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 826122E80C3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 23:05:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jan 2020 22:58:24 -0000
From: Richard Henderson <rth@twiddle.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=rth@twiddle.net; 
X-Launchpad-Bug-Tags: arm
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: grassead
X-Launchpad-Bug-Reporter: Adrien Grassein (grassead)
X-Launchpad-Bug-Modifier: Richard Henderson (rth)
References: <157903678645.2454.11578772527064917210.malonedeb@soybean.canonical.com>
Message-Id: <157904270513.5472.1169884341287216277.launchpad@gac.canonical.com>
Subject: [Bug 1859713] Re: ARM v8.3a pauth not working
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 52156171e949b8d3160df812ca026c4a400edd4e
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
Reply-To: Bug 1859713 <1859713@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: New =3D> Confirmed

** Changed in: qemu
     Assignee: (unassigned) =3D> Richard Henderson (rth)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1859713

Title:
  ARM v8.3a pauth not working

Status in QEMU:
  Confirmed

Bug description:
  Host: Ubuntu 19.10 - x86_64 machine
  QEMU version: 3a63b24a1bbf166e6f455fe43a6bbd8dea413d92 (master)

  ARMV8.3 pauth is not working well.

  With a test code containing two pauth instructions:
      - paciasp that sign LR with A key and sp as context;
      - autiasp that verify the signature.

  Test:
      - Run the program and corrupt LR just before autiasp (ex 0x3e00000400=
660 instead of 0x3e000000400664)

  Expected:
      - autiasp places an invalid pointer in LR

  Result:
      - autiasp successfully auth the pointer and places 0x0400660 in LR.

  Further explanations:
      Adding traces in qemu code shows that "pauth_computepac" is not robus=
t enough against truncating.
      With 0x31000000400664 as input of pauth_auth, we obtain "0x55b1d65b2c=
138e14" for PAC, "0x30" for bot_bit and "0x38" for top_bit.
      With 0x310040008743ec as input of pauth (with same key), we obtain "0=
x55b1d65b2c138ef4" for PAC, "0x30" for bot_bit and "0x38" for top_bit.
      Values of top_bit and bottom_bit are strictly the same and it should =
not.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1859713/+subscriptions

