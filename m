Return-Path: <SRS0=zX6u=BS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C724C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 08:29:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3700920855
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 08:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3700920855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4KEE-0003JI-FE
	for qemu-devel@archiver.kernel.org; Sat, 08 Aug 2020 04:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k4K9k-0000QA-TW
 for qemu-devel@nongnu.org; Sat, 08 Aug 2020 04:24:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:50324)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k4K9j-0003h1-AC
 for qemu-devel@nongnu.org; Sat, 08 Aug 2020 04:24:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k4K9h-0001Es-Vd
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2020 08:24:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E1F5F2E808C
 for <qemu-devel@nongnu.org>; Sat,  8 Aug 2020 08:24:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2020 08:13:22 -0000
From: Michael Tokarev <1423528@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: mbiebl mjt+launchpad-tls th-huth
X-Launchpad-Bug-Reporter: Michael Biebl (mbiebl)
X-Launchpad-Bug-Modifier: Michael Tokarev (mjt+launchpad-tls)
References: <20150219122612.20987.32403.malonedeb@gac.canonical.com>
Message-Id: <159687440302.26993.2465706050102566305.launchpad@gac.canonical.com>
Subject: [Bug 1423528] Re: setting unsupported timeout for i6300esb watchdog
 causes hw reset
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="6a138c03da9cc3e2e03f6dd3bbb4a615b0be6ec2";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 51dc40cc0e41cc7a242fd65bc029c1374670b1c3
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/08 03:59:35
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
Reply-To: Bug 1423528 <1423528@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: Incomplete =3D> Confirmed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1423528

Title:
   setting unsupported timeout for i6300esb watchdog causes hw reset

Status in QEMU:
  Confirmed

Bug description:
  Bug-Debian: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D778291
  Version: 2.1

  systemd utilizes existing watchdog hardware and set's a 10min timer on re=
boot.
  The i6300esb under qemu doesn't like such a timeout, and immediately rese=
ts the hardware:

  The last message one gets is
  [    9.402243] i6300esb: Unexpected close, not stopping watchdog!

  =

  The linked bug report contains information how this bug can easily be rep=
roduced.
  With any image using a recent enough systemd as PID 1 you should be able =
to reproduce it by running

  qemu-system-x86_64 -curses -enable-kvm -device i6300esb -watchdog-
  action reset -hda <image with systemd>

  =

  I'm uncertain if this is a qemu or kernel/driver bug. If the latter, plea=
se re-assign the bug as necessary.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1423528/+subscriptions

