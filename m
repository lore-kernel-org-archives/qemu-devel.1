Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A161C43461
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 20:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4EE9221EB
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 20:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4EE9221EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHYVF-0002Iy-NC
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 16:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kHYUL-0001TT-Fa
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 16:20:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:34336)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kHYUJ-0005Mq-DG
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 16:20:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kHYUH-0004nO-RO
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 20:20:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id CA2532E8053
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 20:20:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2020 20:14:43 -0000
From: Iordan Iordanov <1717414@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: iiordanov th-huth
X-Launchpad-Bug-Reporter: Iordan Iordanov (iiordanov)
X-Launchpad-Bug-Modifier: Iordan Iordanov (iiordanov)
References: <150544685826.29673.14944456813287969209.malonedeb@chaenomeles.canonical.com>
Message-Id: <160002808378.539.10580247804736902993.malone@chaenomeles.canonical.com>
Subject: [Bug 1717414] Re: Sending certain keysyms results in wrong symbol
 input
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="83bdf6c8a3a5f87722c8927e54838522f3e57504"; Instance="production"
X-Launchpad-Hash: 223636fc25da1cdd0e1fa7ecbde26752368c1f83
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 15:05:35
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -66
X-Spam_score: -6.7
X-Spam_bar: ------
X-Spam_report: (-6.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Seems to work fine now. Thank you!!

iordan

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1717414

Title:
  Sending certain keysyms results in wrong symbol input

Status in QEMU:
  Incomplete

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

