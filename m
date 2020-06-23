Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18146C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 17:51:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2E6720702
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 17:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E6720702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnn4s-0006g7-5I
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 13:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jnn4E-0006Gb-0Q
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 13:50:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:51006)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jnn4A-0004AP-9q
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 13:50:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jnn48-0008N4-8L
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 17:50:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 36E532E806B
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 17:50:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2020 17:45:11 -0000
From: John Snow <1883739@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bugs-syssec jnsnow
X-Launchpad-Bug-Reporter: Bugs SysSec (bugs-syssec)
X-Launchpad-Bug-Modifier: John Snow (jnsnow)
References: <159232297702.28606.15425668787325606341.malonedeb@soybean.canonical.com>
Message-Id: <159293431121.13683.2949884626544778793.malone@wampee.canonical.com>
Subject: [Bug 1883739] Re: ide_dma_cb: Assertion `prep_size >= 0 && prep_size
 <= n * 512' failed.
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1cbd0aa39df153c901321817f9b57cf3f232b507";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 4718098c05a79cc41b302bfdbf417ec41dbe420b
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 09:11:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1883739 <1883739@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ACK. I do not have time to fix this bug at the moment under the belief
that it's likely low-priority and only "misbehaving guests" can trigger
it. Some advice:

1. Do not use IDE in production deployments after initial installation,
if you can help it. Use a performant virtio solution.

2. If anyone would like to fix this problem, I will be more than happy
to point you to the exact lines of code that cause the problem. I think
the fix will be easy, but testing will be time-consuming as it involves
understanding error behavior of real hardware that I don't personally
have the setup to quickly test or verify.

>From memory: the problem is that ide_dma_cb expects that it was able to
prepare at least one sector's worth of scatter-gather list to begin DMA,
but it's possible to give malformed SG lists where IDE is unable to
process the remainder of a sector in a list.

It was not clear to me at the time when I first investigated this what a
real controller would do if it got an incomplete sector and how it
should signal that.

It was also not clear to me if the sg_prepare function for the pci bmdma
controller would ever encounter a situation where further entries in the
list might be received "later" and we should "wait" for them.

If this bug is more dangerous than a self-inflicted DOS, please let me
know and I'll re-prioritize. Patches, email and IRC chats welcome.

--js

** Changed in: qemu
       Status: New =3D> Confirmed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1883739

Title:
  ide_dma_cb: Assertion `prep_size >=3D 0 && prep_size <=3D n * 512' failed.

Status in QEMU:
  Confirmed

Bug description:
  To reproduce run the QEMU with the following command line:
  ```
  qemu-system-x86_64 -cdrom hypertrash.iso -nographic -m 100 -enable-kvm -n=
et none -drive id=3Ddisk,file=3Dhda.img,if=3Dnone -device ahci,id=3Dahci -d=
evice ide-hd,drive=3Ddisk,bus=3Dahci.0
  ```

  QEMU Version:
  ```
  # qemu-5.0.0
  $ ./configure --target-list=3Dx86_64-softmmu --enable-sanitizers; make
  $ x86_64-softmmu/qemu-system-x86_64 --version
  QEMU emulator version 5.0.0
  Copyright (c) 2003-2020 Fabrice Bellard and the QEMU Project developers
  ```

  To create disk image run:
  ```
  dd if=3D/dev/zero of=3Dhda.img bs=3D1024 count=3D1024
  ```

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1883739/+subscriptions

