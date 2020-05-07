Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C04CC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 21:06:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6897D20663
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 21:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6897D20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWnit-0003uw-HJ
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 17:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jWniK-0003Vk-HV
 for qemu-devel@nongnu.org; Thu, 07 May 2020 17:05:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:58562)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jWniH-0000CH-Ui
 for qemu-devel@nongnu.org; Thu, 07 May 2020 17:05:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jWniF-0007Rf-LH
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 21:05:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 8DDC42E810A
 for <qemu-devel@nongnu.org>; Thu,  7 May 2020 21:05:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2020 20:57:28 -0000
From: =?utf-8?q?Jos=C3=A9_Antonio_L=C3=B3pez_Cano?=
 <1857269@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: untio
X-Launchpad-Bug-Reporter: =?utf-8?q?Jos=C3=A9_Antonio_L=C3=B3pez_Cano_=28un?=
 =?utf-8?q?tio=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Jos=C3=A9_Antonio_L=C3=B3pez_Cano_=28un?=
 =?utf-8?q?tio=29?=
References: <157705903476.27888.2879696880940848378.malonedeb@chaenomeles.canonical.com>
Message-Id: <158888504842.5986.11057106592333625750.malone@soybean.canonical.com>
Subject: [Bug 1857269] Re: Spanish keyboard from Spain (Europe) not found
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="fbdff7602bd10fb883bf7e2ddcc7fd5a16f60398";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: b6c3515e86845422c206b42942a97bf20f26a117
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 17:05:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1857269 <1857269@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

I thought that the not fully working problem on my laptop was originated
by the es keymap file, but it is not. I have edited that file and I
receive the same error. I believe that windows version of qemu has a
problem, at least, with laptops. A few months ago I get this error with
an asus laptop and nowdays I am even worse with a hp. I can not test the
windows version with a desktop computer.

I will download every new version and I shall comment if it works.

Thanks for your attention.


** Summary changed:

- Spanish keyboard from Spain (Europe) not found
+ Keyboard not fully working on Windows version

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1857269

Title:
  Keyboard not fully working on Windows version

Status in QEMU:
  New

Bug description:
  Hello,

  I am working with windows qemu version:

  qemu-w64-setup-20190815

  I have installed a msdos virtual machine on qemu with sp keyboard
  layout (Spain at Europe). I have found that some keys do not work in
  the way they should. I believe that the problem is that es qemu
  spanish keyboard layout is the latin one, la in msdos sysytem.

  I ask you to create the Spain layout.


  Thanks in advance.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1857269/+subscriptions

