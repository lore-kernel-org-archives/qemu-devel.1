Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A4DC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 14:12:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6C5A21734
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 14:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C5A21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaJWf-0001Wi-HB
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 09:12:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaJVF-00017H-Hk
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 09:11:13 -0500
Received: from indium.canonical.com ([91.189.90.7]:44682)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaJV8-0006bw-Og
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 09:11:09 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kaJV5-00014V-Cd
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 14:10:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 4B9392E8133
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 14:10:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2020 13:59:40 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1797262@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: arm
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ajbennee philmd pmaydell xrobau
X-Launchpad-Bug-Reporter: Rob Thomas (xrobau)
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <153921596093.13046.16485884973780639345.malonedeb@wampee.canonical.com>
Message-Id: <160449838102.6848.2800482197630083361.malone@chaenomeles.canonical.com>
Subject: [Bug 1797262] Re: qemu arm no longer able to boot RPI Kernels
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="8e1d622aa7e69e8b5bd9e10dd26da4991d9a7dfb"; Instance="production"
X-Launchpad-Hash: 95edf26425b08d7f1526604be161eeb13760462c
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 09:01:04
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -64
X-Spam_score: -6.5
X-Spam_bar: ------
X-Spam_report: (-6.5 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1797262 <1797262@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Should be now fixed by commits 74de7145fd6..83ad4695478 (CPRMAN model
added).

** Changed in: qemu
     Assignee: Philippe Mathieu-Daud=C3=A9 (philmd) =3D> (unassigned)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1797262

Title:
  qemu arm no longer able to boot RPI Kernels

Status in QEMU:
  Confirmed

Bug description:
  Since RPi Kernel 1.20170427, qemu is no longer able to emulate the
  Rasberry Pi, as the linux kernel is complaining about timing issues.

  Old kernel output - https://pastebin.com/wvkneNNF
  New kernel output - https://pastebin.com/QTwgCkV2

  Note that the actual error is caused by the kernel being unable to get
  the timing source for the mmc (Line 160), which causes an unable-to-
  mount-root panic.  There are other issues with the serial port
  returning an invalid speed, which displays a divide-by-zero error,
  which is PROBABLY a symptom of the same root cause.

  This is simple to replicate - The last working kernel is available
  here:

  https://github.com/raspberrypi/firmware/tree/1.20170405/boot

  Download kernel7 and the dtb, and try to boot with (for example)

  qemu-system-aarch64 -M raspi2 -kernel kernel7.img -dtb
  bcm2709-rpi-2-b.dtb -serial stdio -sd noobs.img -append
  "root=3D/dev/mmcblk0p2 init=3D/bin/bash"

  This works, and boots successfully.

  However, if you replace the kernel7.img and dtb with ones taken from
  https://github.com/raspberrypi/firmware/tree/1.20170427/boot it will
  NOT boot because of various clock timing issues (as in the second
  paste)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1797262/+subscriptions

