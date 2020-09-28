Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9038EC4741F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 08:26:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBA322076B
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 08:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA322076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMoUF-00033f-MN
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 04:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kMoSo-0001YD-1h
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 04:24:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:55932)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kMoSl-0004SW-PB
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 04:24:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kMoSi-0002Dl-GU
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 08:24:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 702CA2E80E8
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 08:24:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2020 08:15:14 -0000
From: Daniel Berrange <1502884@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Wishlist; assignee=None; 
X-Launchpad-Bug-Tags: extension keyboard kvm norepeat repeat server vnc
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: berrange empee584 mikael-trash
X-Launchpad-Bug-Reporter: Mikael (mikael-trash)
X-Launchpad-Bug-Modifier: Daniel Berrange (berrange)
References: <20151005123157.4012.27683.malonedeb@soybean.canonical.com>
Message-Id: <160128091428.9920.14889627074354651084.malone@chaenomeles.canonical.com>
Subject: [Bug 1502884] Re: Super important feature req: QEMU VNC server:
 Introduce a keyboard "norepeat" option!
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a314d157ca9be8d00eae0214fc0d7dff1cd406e4"; Instance="production"
X-Launchpad-Hash: 12c03eefb872236dc214c557f1e7013f381350b1
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:20:37
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

The VNC server doesn't get involved in key repeat functionality, it just
passes keys from the client onto the guest OS.  The client can indicate
that it is doing key repeat by sending a series of "key down" events,
and only 1 "key up" event to indicate end of auto-repeat. The guest OS
can itself implement auto-repeat at any frequency it wishes by watching
the key stream. The "-norepeat" option to X11 VNC that is referred to
here isn't something related to the VNC part of x11vnc, but rather it
appears related to the X11 part which corresponds to the guest OS in
QEMU's case. I don't see there is much QEMU can do here.

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

