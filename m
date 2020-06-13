Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1CCC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 13:08:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82E8820739
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 13:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E8820739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jk5ta-0008KW-Mn
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 09:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jk5t0-0007So-5u
 for qemu-devel@nongnu.org; Sat, 13 Jun 2020 09:07:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:47920)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jk5sy-0005A6-5M
 for qemu-devel@nongnu.org; Sat, 13 Jun 2020 09:07:49 -0400
Received: from chaenomeles.canonical.com ([91.189.89.119])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jk5sw-0008Le-9w
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2020 13:07:46 +0000
Received: from chaenomeles.canonical.com (localhost [IPv6:::1])
 by chaenomeles.canonical.com (Postfix) with ESMTPS id 3E4CD6828D8
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2020 13:07:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2020 13:07:45 -0000
From: Launchpad Bug Tracker <1840719@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=roolebo@gmail.com; 
X-Launchpad-Bug-Tags: bios floppy x86
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd roolebo
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: Roman Bolshakov (roolebo)
References: <156625651066.23088.12772675524876649281.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1840719] [NEW] win98se floppy fails to boot with isapc machine
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Message-Id: <159205366605.5376.5160861104987292619.launchpad@chaenomeles.canonical.com>
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="b190cebbf563f89e480a8b57f641753c8196bda0";
 Instance="appserver-secrets-lazr.conf"
X-Launchpad-Hash: 485db78a78c25d07e5b5ef41549785cf35541ec4
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/13 09:07:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1840719 <1840719@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

You have been subscribed to a public bug:

QEMU emulator version 4.1.50 (commit 50d69ee0d)

floppy image from:
https://winworldpc.com/download/417d71c2-ae18-c39a-11c3-a4e284a2c3a5

$ qemu-system-i386 -M isapc -fda Windows\ 98\ Second\ Edition\ Boot.img
SeaBIOS (version rel-1.12.1-0...)
Booting from Floppy...
Boot failed: could not read the boot disk

** Affects: qemu
     Importance: Undecided
     Assignee: Roman Bolshakov (roolebo)
         Status: Confirmed


** Tags: bios floppy x86
-- =

win98se floppy fails to boot with isapc machine
https://bugs.launchpad.net/bugs/1840719
You received this bug notification because you are a member of qemu-devel-m=
l, which is subscribed to QEMU.

