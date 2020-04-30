Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCD8C47255
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A9692137B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A9692137B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU9b7-0002wy-3R
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 09:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jU9OT-0001oH-P2
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:40:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jU9Ln-0007Oo-Op
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:38:25 -0400
Received: from indium.canonical.com ([91.189.90.7]:60296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jU9Ln-0007OA-8z
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:35:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jU9Ll-0005Bv-J6
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 13:35:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 7D4042E8110
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 13:35:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Apr 2020 13:28:31 -0000
From: Laurent Vivier <Laurent@vivier.eu>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=rth@twiddle.net; 
X-Launchpad-Bug-Tags: arm
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: grassead rth vdehors
X-Launchpad-Bug-Reporter: Adrien Grassein (grassead)
X-Launchpad-Bug-Modifier: Laurent Vivier (laurent-vivier)
References: <157903678645.2454.11578772527064917210.malonedeb@soybean.canonical.com>
Message-Id: <158825331294.6154.611155583087276882.launchpad@soybean.canonical.com>
Subject: [Bug 1859713] Re: ARM v8.3a pauth not working
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="fbdff7602bd10fb883bf7e2ddcc7fd5a16f60398";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: e930f37effa10ff7b42c01e05b0b3738b559dc9e
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 09:35:36
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1859713

Title:
  ARM v8.3a pauth not working

Status in QEMU:
  Fix Released

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

