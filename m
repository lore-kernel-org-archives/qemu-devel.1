Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FA5C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 18:01:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3689820665
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 18:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3689820665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcBTZ-00086O-3D
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 13:01:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kcBA5-0000i1-7v
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:41:01 -0500
Received: from indium.canonical.com ([91.189.90.7]:46580)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kcBA1-0001Az-8I
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:41:00 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kcB9y-0008E0-SZ
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 17:40:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C6E562E8133
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 17:40:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2020 17:34:49 -0000
From: Max Ehrlich <1671677@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: queuecumber th-huth
X-Launchpad-Bug-Reporter: Max Ehrlich (queuecumber)
X-Launchpad-Bug-Modifier: Max Ehrlich (queuecumber)
References: <20170310022816.24904.27346.malonedeb@wampee.canonical.com>
Message-Id: <160494328983.12267.4525529195898721762.malone@gac.canonical.com>
Subject: [Bug 1671677] Re: vfio-pci passthrough issue after resume from suspend
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: aeedbdbee61e0287d9c2439a7620b4ce5d23f84e
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 11:16:03
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
Reply-To: Bug 1671677 <1671677@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I don't use this setup anymore so I don't know if it's still an issue,
it would have been nice if someone had responded to my report when I
filed it over 3 years ago. Go ahead and close it.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1671677

Title:
  vfio-pci passthrough issue after resume from suspend

Status in QEMU:
  Incomplete

Bug description:
  =

  I'm running into a weird issue with the vfio-pci driver through qemu

  I use it on a laptop and I passthrough an external GPU connected via
  PCI express. In general this works well, however if the laptop has
  *ever* suspended since its last boot, then the windows guest reports
  an error 43 on the card and I get no output on the monitor that it is
  connected to. This is really weird to me since it works fine if I boot
  the latop from power-off, and hotplug the card. It's only if the
  laptop has ever suspended since it's last boot that I see this issue.
  Even if it was suspended before the card was ever hotplugged.

  In other words:
  laptop off -> boot -> hotplug GPU : works great
  laptop off -> boot -> do stuff (GPU *NOT* connected) -> sleep -> resume -=
> hotplug GPU: problem
  laptop off -> boot -> hotplug GPU -> unplug GPU -> hotplug GPU : works gr=
eat
  laptop off -> boot -> hotplug GPU -> unplug GPU -> sleep -> resume -> hot=
plug GPU: problem

  Weird stuff...

  I'm honestly not sure that vfio-pci/qemu is to blame here since there
  are so many moving parts, but im not really sure where else to report
  this to

  What I have tried is using the sysfs interface to
  remove/rescan/poweroff/etc the PCI devices in questions (graphics card
  and it's HDMI audio) and this also does help.

  QEMU version: 2.6.1

  Please let me know what other information I can provide

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1671677/+subscriptions

