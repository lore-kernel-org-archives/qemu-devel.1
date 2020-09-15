Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF9BC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:32:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49A0E20735
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A0E20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI8GL-0000CZ-BQ
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 06:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kI8FX-0008CE-FK
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:31:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:59760)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kI8FV-0002xr-5L
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:31:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kI8FO-0007SD-Rl
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 10:31:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B8C172E811E
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 10:31:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2020 10:24:53 -0000
From: Thomas Huth <1717414@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: iiordanov th-huth
X-Launchpad-Bug-Reporter: Iordan Iordanov (iiordanov)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <150544685826.29673.14944456813287969209.malonedeb@chaenomeles.canonical.com>
Message-Id: <160016549343.21851.11919291303523764846.malone@wampee.canonical.com>
Subject: [Bug 1717414] Re: Sending certain keysyms results in wrong symbol
 input
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="83bdf6c8a3a5f87722c8927e54838522f3e57504"; Instance="production"
X-Launchpad-Hash: 98e59b561f7de8fd7cc9b34dea5d0b4a9a4e2116
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 06:31:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: Bug 1717414 <1717414@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks for testing! So I'm closing the ticket now.

** Changed in: qemu
       Status: Incomplete =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1717414

Title:
  Sending certain keysyms results in wrong symbol input

Status in QEMU:
  Fix Released

Bug description:
  I develop bVNC, an Android VNC client. I noticed that when I connect
  to qemu VMs that have a VNC console, Keysyms that are usually sent
  over with SHIFT modifier when connecting from a PC have wrong symbols
  typed within the VM. A very short list of examples:

  exclam                              33     0x0021

  results in "1" typed in the VM.

  at                                  64     0x0040

  results in "2"

  plus                                43     0x002b

  results in "=3D"

  asterisk                            42     0x002a

  results in "8"

  On Android, KEYCODEs that correspond to the above keysyms do not come
  with SHIFT metastate. Therefore, the keysyms that they correspond to
  are not sent over with any modifiers and must just work.

  The issue was reproduced with bVNC and RealVNC viewers connecting to
  many versions of qemu (Ubuntu 14.04, oVirt 3.4, oVirt 4.1, etc.). The
  qemu version that comes with oVirt 4.1 is 2.6.0, commit hash
  bfc766d38e1fae5767d43845c15c79ac8fa6d6af.

  Sincerely,
  iordan

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1717414/+subscriptions

