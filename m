Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C529DC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 21:32:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EB7D206DC
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 21:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB7D206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIf2C-0000Me-DN
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 17:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kIf0q-00088j-5l
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 17:30:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:58856)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kIf0m-0000vo-H3
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 17:30:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kIf0h-00051Z-RS
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 21:30:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id CDC4E2E80DB
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 21:30:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2020 21:21:27 -0000
From: David Aghaian <1895895@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: daghaian
X-Launchpad-Bug-Reporter: David Aghaian (daghaian)
X-Launchpad-Bug-Modifier: David Aghaian (daghaian)
Message-Id: <160029128826.621.15541420718494673931.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1895895] [NEW] Attaching SD-Card to specific SD-Bus Sabrelite
 (ARM)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="83bdf6c8a3a5f87722c8927e54838522f3e57504"; Instance="production"
X-Launchpad-Hash: 48abefd8af87c6dd2cb6713acd39c8c0d245b7b5
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 17:30:40
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
Reply-To: Bug 1895895 <1895895@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Currently, I am looking for a method of attaching an sd-card to a
specific bus as opposed to defaulting to the first.

QEMU Version: 5.0.0
Specifically trying to use qemu-system-arm binary


Running an "info qtree" shows the output seen in the attached image. I have=
 attempted multiple different combinations of arguments to attempt to get t=
he sd-card to appear on the FOURTH sd-bus but no luck. The machine type bei=
ng used is Sabrelite. It should be noted that I was able to PATCH QEMU to a=
chieve the result I expected but I had hoped this functionality was already=
 available and did not require modification to QEMU itself.


For reference, this is the patch that was made to source to allow the card =
to attach to a specific bus. After the change was made, an sd-card could be=
 attached to a bus with the following flags:

-drive file=3Dsdcard.img,format=3Draw,id=3Dmycard -device sd-
card,drive=3Dmycard,bus=3Dsd-bus.0


diff qemu-5.1.0.orig/hw/sd/sdhci.c qemu-5.1.0/hw/sd/sdhci.c
1311a1312,1314
>     static int index=3D0;
>     char name[64];
>     sprintf(name, "sd-bus.%d", index++);
1313c1316
<                         TYPE_SDHCI_BUS, DEVICE(s), "sd-bus");
---
>                         TYPE_SDHCI_BUS, DEVICE(s), name);


If there is a way to attach an sd-card to the specific bus that does NOT
require this change, I'd appreciate it.

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "device_tree.png"
   https://bugs.launchpad.net/bugs/1895895/+attachment/5411432/+files/devic=
e_tree.png

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1895895

Title:
  Attaching SD-Card to specific SD-Bus Sabrelite (ARM)

Status in QEMU:
  New

Bug description:
  Currently, I am looking for a method of attaching an sd-card to a
  specific bus as opposed to defaulting to the first.

  QEMU Version: 5.0.0
  Specifically trying to use qemu-system-arm binary

  =

  Running an "info qtree" shows the output seen in the attached image. I ha=
ve attempted multiple different combinations of arguments to attempt to get=
 the sd-card to appear on the FOURTH sd-bus but no luck. The machine type b=
eing used is Sabrelite. It should be noted that I was able to PATCH QEMU to=
 achieve the result I expected but I had hoped this functionality was alrea=
dy available and did not require modification to QEMU itself.

  =

  For reference, this is the patch that was made to source to allow the car=
d to attach to a specific bus. After the change was made, an sd-card could =
be attached to a bus with the following flags:

  -drive file=3Dsdcard.img,format=3Draw,id=3Dmycard -device sd-
  card,drive=3Dmycard,bus=3Dsd-bus.0

  =

  diff qemu-5.1.0.orig/hw/sd/sdhci.c qemu-5.1.0/hw/sd/sdhci.c
  1311a1312,1314
  >     static int index=3D0;
  >     char name[64];
  >     sprintf(name, "sd-bus.%d", index++);
  1313c1316
  <                         TYPE_SDHCI_BUS, DEVICE(s), "sd-bus");
  ---
  >                         TYPE_SDHCI_BUS, DEVICE(s), name);


  If there is a way to attach an sd-card to the specific bus that does
  NOT require this change, I'd appreciate it.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1895895/+subscriptions

