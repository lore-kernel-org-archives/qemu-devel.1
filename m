Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF7BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 13:56:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AD2D2083E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 13:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD2D2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0mZ9-0008Ia-HV
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 09:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k0mYa-0007nf-1x
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 09:55:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:59868)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k0mYY-000509-3m
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 09:55:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k0mYW-0002mg-A0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 13:55:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 3BB622E805D
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 13:55:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2020 13:50:28 -0000
From: pts <1889421@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ptspts
X-Launchpad-Bug-Reporter: pts (ptspts)
X-Launchpad-Bug-Modifier: pts (ptspts)
Message-Id: <159603062878.10118.11664292810636734356.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1889421] [NEW] VVFAT is not writable from Windows NT 3.5,
 3.51 and 4.0
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: adbc865b41beb6e37396561b9153b5044facafe9
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 08:55:41
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1889421 <1889421@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

I'm running Windows NT 3.5, 3.51 and 4.0 in QEMU 4.2.0 on Linux. I'm
using a VVFAT filesystem. Command lines:

$ qemu-system-i386 -L pc -cpu 486 -m 64 -vga cirrus -drive
file=3Dnt351.img,format=3Draw -net nic,model=3Dpcnet -net user -soundhw
sb16,pcspk -drive file=3Dfat:rw:drived,format=3Draw

$ qemu-system-i386 --version
QEMU emulator version 4.2.0 (Debian 1:4.2-6)
Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

Creating a new directory or file on drive D: (the VVFAT filesystem)
fails on Windows NT 3.5, 3.51 and 4.0 (see screenshot). It succeeds on
Windows NT 3.1.

Is there a workaround, e.g. a QEMU flag or a change in the Windows NT
driver settings?

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "screenshot"
   https://bugs.launchpad.net/bugs/1889421/+attachment/5396980/+files/qemu_=
vvfat_windows_nt.png

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1889421

Title:
  VVFAT is not writable from Windows NT 3.5, 3.51 and 4.0

Status in QEMU:
  New

Bug description:
  I'm running Windows NT 3.5, 3.51 and 4.0 in QEMU 4.2.0 on Linux. I'm
  using a VVFAT filesystem. Command lines:

  $ qemu-system-i386 -L pc -cpu 486 -m 64 -vga cirrus -drive
  file=3Dnt351.img,format=3Draw -net nic,model=3Dpcnet -net user -soundhw
  sb16,pcspk -drive file=3Dfat:rw:drived,format=3Draw

  $ qemu-system-i386 --version
  QEMU emulator version 4.2.0 (Debian 1:4.2-6)
  Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

  Creating a new directory or file on drive D: (the VVFAT filesystem)
  fails on Windows NT 3.5, 3.51 and 4.0 (see screenshot). It succeeds on
  Windows NT 3.1.

  Is there a workaround, e.g. a QEMU flag or a change in the Windows NT
  driver settings?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1889421/+subscriptions

