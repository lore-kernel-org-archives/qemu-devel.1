Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E62C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 08:26:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F65F206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 08:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F65F206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5PcB-0000kz-MM
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 04:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k5PbW-0008Ld-7n
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 04:25:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:41588)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k5PbS-0001C3-4x
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 04:25:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k5PbQ-0007sr-L0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 08:25:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 9D2DC2E808C
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 08:25:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2020 08:11:09 -0000
From: Dominik Danieluk <1366363@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: highcheng pandan th-huth
X-Launchpad-Bug-Reporter: Winston Wu (highcheng)
X-Launchpad-Bug-Modifier: Dominik Danieluk (pandan)
References: <20140906165232.5566.76013.malonedeb@wampee.canonical.com>
Message-Id: <159713346957.9816.3885231629309216020.malone@wampee.canonical.com>
Subject: [Bug 1366363] Re: qemu-git gravis ultrasound not working
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="6a138c03da9cc3e2e03f6dd3bbb4a615b0be6ec2";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: c8798da416bdf525cd8523024354c226e9a69e6d
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 04:25:48
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
Reply-To: Bug 1366363 <1366363@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The conscan screenshot for my previous post ...

** Attachment added: "conscan.png"
   https://bugs.launchpad.net/qemu/+bug/1366363/+attachment/5400606/+files/=
conscan.png

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1366363

Title:
  qemu-git gravis ultrasound not working

Status in QEMU:
  Incomplete

Bug description:
  Qemu git 2.1.50 with dos622 and windows 3.11.

  Parameter:

  For build: default-configs/sound.mak CONFIG_GUS=3Dy

  Starting parameter: qemu-system-i386 -cpu 486 -m 32M -vga cirrus -hda
  disk1.img -soundhw gus,pcspk -parallel none -net nic,model=3Dne2k_isa
  -net user

  The installer of GUS driver 4.11 does not recognize the card. And
  conscan tells me that ioport 220-240 and not safe for synth base. It
  seems that there is a port conflict.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1366363/+subscriptions

