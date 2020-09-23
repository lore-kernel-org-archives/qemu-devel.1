Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA43C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 11:43:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F215720663
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 11:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F215720663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL3Bd-0003Fx-2D
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 07:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kL38k-0001Su-9C
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 07:40:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:51148)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kL38i-0007BH-4s
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 07:40:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kL38g-00054v-8l
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 11:40:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 37E272E80E7
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 11:40:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2020 11:33:35 -0000
From: Maskim Bakulin <1896754@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ruspartisan
X-Launchpad-Bug-Reporter: Maskim Bakulin (ruspartisan)
X-Launchpad-Bug-Modifier: Maskim Bakulin (ruspartisan)
Message-Id: <160086081591.406.2004357727821714311.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1896754] [NEW] Performance degradation for WinXP boot time after
 b55f54bc
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="83bdf6c8a3a5f87722c8927e54838522f3e57504"; Instance="production"
X-Launchpad-Hash: bf9a17a64308d8235eb4c921d87d0d333513ad6e
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 07:40:46
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
Reply-To: Bug 1896754 <1896754@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Qemu 5.1 loads Windows XP in TCG mode 5-6 times slower (~2 minutes) than
4.2 (25 seconds), I git bisected it, and it appears that commit
b55f54bc965607c45b5010a107a792ba333ba654 causes this issue. Probably
similar to an older fixed bug
https://bugs.launchpad.net/qemu/+bug/1672383

Command line is trivial: qemu-system-x86_64 -nodefaults -vga std -m
4096M -hda WinXP.qcow2 -monitor stdio -snapshot

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1896754

Title:
  Performance degradation for WinXP boot time after b55f54bc

Status in QEMU:
  New

Bug description:
  Qemu 5.1 loads Windows XP in TCG mode 5-6 times slower (~2 minutes)
  than 4.2 (25 seconds), I git bisected it, and it appears that commit
  b55f54bc965607c45b5010a107a792ba333ba654 causes this issue. Probably
  similar to an older fixed bug
  https://bugs.launchpad.net/qemu/+bug/1672383

  Command line is trivial: qemu-system-x86_64 -nodefaults -vga std -m
  4096M -hda WinXP.qcow2 -monitor stdio -snapshot

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1896754/+subscriptions

