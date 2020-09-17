Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCFAC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 04:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AEB42075E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 04:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AEB42075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIlXJ-0001IA-Ch
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 00:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kIlUb-00075G-Dx
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 00:25:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:41364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kIlUU-0004aK-4g
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 00:25:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kIlUS-0005fr-OV
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 04:25:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 929D82E8107
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 04:25:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2020 04:17:20 -0000
From: Launchpad Bug Tracker <1629483@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dkerr64 janitor kamath-ben th-huth
X-Launchpad-Bug-Reporter: Benjamin Kamath (kamath-ben)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <20160930224644.27765.63692.malonedeb@chaenomeles.canonical.com>
Message-Id: <160031624013.27044.13973847429577215201.malone@loganberry.canonical.com>
Subject: [Bug 1629483] Re: Build fails on optionrom
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="83bdf6c8a3a5f87722c8927e54838522f3e57504"; Instance="production"
X-Launchpad-Hash: 385e39f7c3d2cdd1795de94c03d25bc9373a0e5f
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 00:25:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1629483 <1629483@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1629483

Title:
  Build fails on optionrom

Status in QEMU:
  Expired

Bug description:
  Git pseudo-bisected (focused on optionrom commits) it to this commit.

  commit cdbd727c20ad7aac7797dc8c95e485e1a4c6901b
  Author: Richard Henderson <rth@twiddle.net>
  Date:   Thu Jul 7 21:49:36 2016 -0700

      build: Use $(AS) for optionrom explicitly

  =

  Build output (non-verbose):

    AS    optionrom/linuxboot.o
  cpp: fatal error: '-c' is not a valid option to the preprocessor
  compilation terminated.
  cpp: fatal error: '-c' is not a valid option to the preprocessor
  compilation terminated.
    CC    optionrom/linuxboot_dma.o
    CC    /home/bkamath/dev/workspace/block-2/mothra/output/sp0/targetqga/m=
ain.o
    AS    optionrom/kvmvapic.o
  cpp: fatal error: '-c' is not a valid option to the preprocessor
  compilation terminated.

  Steps to reproduce:
  Using buildroot and overriding qemu version to 2.7.0
  Fedora 24, cpp (GCC) 6.2.1 20160916 (Red Hat 6.2.1-2)

  I tried first just building without the -c option but it hangs
  indefinitely. Reverting the above listed commit fixes the problem on
  my platform. I didn't dive much further into this, because this seems
  like a regression.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1629483/+subscriptions

