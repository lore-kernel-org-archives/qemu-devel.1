Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A17C4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 16:04:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B2D1221E5
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 16:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B2D1221E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMZ9s-0005KM-W7
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 12:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kMZ5U-000382-MF
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 11:59:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:38140)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kMZ5R-0007Tf-FW
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 11:59:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kMZ5N-0004bQ-Vo
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2020 15:59:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E264C2E806F
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2020 15:59:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2020 15:46:47 -0000
From: Marcel Partap <1502884@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Wishlist; assignee=None; 
X-Launchpad-Bug-Tags: extension keyboard kvm norepeat repeat server vnc
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: empee584 mikael-trash
X-Launchpad-Bug-Reporter: Mikael (mikael-trash)
X-Launchpad-Bug-Modifier: Marcel Partap (empee584)
References: <20151005123157.4012.27683.malonedeb@soybean.canonical.com>
Message-Id: <160122160724.8988.3370045520599641303.malone@chaenomeles.canonical.com>
Subject: [Bug 1502884] Re: Super important feature req: QEMU VNC server:
 Introduce a keyboard "norepeat" option!
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a314d157ca9be8d00eae0214fc0d7dff1cd406e4"; Instance="production"
X-Launchpad-Hash: 9d91fef9818251b6ffa3517daa41c6aa12061de9
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/27 11:59:38
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -67
X-Spam_score: -6.8
X-Spam_bar: ------
X-Spam_report: (-6.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.078, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Reply-To: Bug 1502884 <1502884@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

... this doesn't seem to be a VNC-only issue.. I get quite the big of
repeat/stuck key presses with the GTK frontend as well.. Also, lines
like these frequently show up in the logs:

> [15512.846716] psmouse serio1: VMMouse at isa0060/serio1/input0 lost sync=
 at byte 1
> [15513.031586] psmouse serio1: VMMouse at isa0060/serio1/input0 - driver =
resynced.
> [15513.931140] psmouse serio1: VMMouse at isa0060/serio1/input0 lost sync=
 at byte 1
> [15513.935319] psmouse serio1: VMMouse at isa0060/serio1/input0 - driver =
resynced.
> [15994.802058] psmouse serio1: VMMouse at isa0060/serio1/input0 lost sync=
 at byte 1
> [15994.807817] psmouse serio1: VMMouse at isa0060/serio1/input0 - driver =
resynced.
> [18243.163746] psmouse serio1: VMMouse at isa0060/serio1/input0 lost sync=
 at byte 1
> [18243.165704] psmouse serio1: VMMouse at isa0060/serio1/input0 - driver =
resynced.
> [18243.372671] psmouse serio1: VMMouse at isa0060/serio1/input0 lost sync=
 at byte 1
> [18243.374203] psmouse serio1: VMMouse at isa0060/serio1/input0 - driver =
resynced.
> [18576.754033] psmouse serio1: VMMouse at isa0060/serio1/input0 lost sync=
 at byte 1
> [18576.771257] psmouse serio1: VMMouse at isa0060/serio1/input0 - driver =
resynced.
> [18584.556247] psmouse serio1: VMMouse at isa0060/serio1/input0 lost sync=
 at byte 1
> [18585.168172] psmouse serio1: VMMouse at isa0060/serio1/input0 - driver =
resynced.
> [18628.989958] psmouse serio1: VMMouse at isa0060/serio1/input0 lost sync=
 at byte 1
> [18628.992058] psmouse serio1: VMMouse at isa0060/serio1/input0 - driver =
resynced.
> [20227.153135] psmouse serio1: VMMouse at isa0060/serio1/input0 lost sync=
 at byte 1
> [20227.161066] psmouse serio1: VMMouse at isa0060/serio1/input0 - driver =
resynced.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1502884

Title:
  Super important feature req: QEMU VNC server: Introduce a keyboard
  "norepeat" option!

Status in QEMU:
  New

Bug description:
  Hi,

  A big issue when using QEMU's VNC server (VNC KVM) is that, when
  there's a network lag, unintended keypresses go through to the QEMU
  guest VM.

  This is frequently "enter" keypresses, causing all kinds of unintended
  consequences in the VM. So basically it's extremely dangerous.

  This is because the VNC protocol's keyboard interaction is implemented
  in terms of key down - key up events, making the server's keyboard
  autorepeat kick in when it should not.

  =

  For this reason, it would be great if QEMU's VNC server part would be enh=
anced with an option such that when a VNC protocol key down is received, th=
en locally that is treated as one single keypress only (I don't know how th=
at should be implemented but I guess either as an immediate key down - key =
up sequence locally, or key down + key up after say 0.05 seconds), instead =
of waiting for the key up event from the VNC client.

  Thanks!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1502884/+subscriptions

