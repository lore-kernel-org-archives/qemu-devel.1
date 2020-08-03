Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00F2C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 22:42:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0833A2076C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 22:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0833A2076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2jA2-0002e9-2U
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 18:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k2j8a-0001cR-EN
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 18:40:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:38356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k2j8V-0002dn-S8
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 18:40:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k2j8S-0000ND-TW
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 22:40:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id DD55A2E806D
 for <qemu-devel@nongnu.org>; Mon,  3 Aug 2020 22:40:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2020 22:30:53 -0000
From: Adriano Marto Reis <1890208@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: adrianomarto
X-Launchpad-Bug-Reporter: Adriano Marto Reis (adrianomarto)
X-Launchpad-Bug-Modifier: Adriano Marto Reis (adrianomarto)
Message-Id: <159649385359.2765.12928081922733657659.malonedeb@gac.canonical.com>
Subject: [Bug 1890208] [NEW] Mouse pointer disappears when it is over console
 window
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 92ecb7b0784311fb298164bbac8431862e0d3998
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 18:40:49
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
Reply-To: Bug 1890208 <1890208@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

The host mouse pointer disappears when it is over a console window.

I am emulating quite simple hardware: just text console and no mouse. I
don't expect the mouse to have any effect on the emulated computers, but
I need to know where the mouse pointer is. That is  important because I
need to use the mouse to switch between applications and to switch
between virtual machines (QEMU grabs Alt+Tab events). Also, it is quite
tricky to work with multiple screens when we don't know where the mouse
pointer is.

I am using:
* Virtual Machine Manager 2.2.1
* QEMU 4.2.0
* Fedora 32
* KDE Plasma 5.18.5

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1890208

Title:
  Mouse pointer disappears when it is over console window

Status in QEMU:
  New

Bug description:
  The host mouse pointer disappears when it is over a console window.

  I am emulating quite simple hardware: just text console and no mouse.
  I don't expect the mouse to have any effect on the emulated computers,
  but I need to know where the mouse pointer is. That is  important
  because I need to use the mouse to switch between applications and to
  switch between virtual machines (QEMU grabs Alt+Tab events). Also, it
  is quite tricky to work with multiple screens when we don't know where
  the mouse pointer is.

  I am using:
  * Virtual Machine Manager 2.2.1
  * QEMU 4.2.0
  * Fedora 32
  * KDE Plasma 5.18.5

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1890208/+subscriptions

