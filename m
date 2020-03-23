Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352B4C10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 20:26:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B6520714
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 20:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B6520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fifthhorseman.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGTeO-0004Js-5Z
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 16:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jGTdj-0003tx-Qu
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 16:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jGTdi-0006kk-Ft
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 16:25:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:37302)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jGTdi-0006kF-AN
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 16:25:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jGTdg-0006si-Qc
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 20:25:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C5FBC2E8075
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 20:25:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Mar 2020 20:18:16 -0000
From: dkg <dkg@fifthhorseman.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dkg0
X-Launchpad-Bug-Reporter: dkg (dkg0)
X-Launchpad-Bug-Modifier: dkg (dkg0)
References: <158499422385.10961.5853987871982902669.malonedeb@soybean.canonical.com>
Message-Id: <158499469651.10911.14679160686941485194.malone@soybean.canonical.com>
Subject: [Bug 1868617] Re: multiseat: route different spice tablet events to
 distinct vdagents
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="3a6db24bbe7280ec09bae73384238390fcc98ad3";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 46fb604eff0f4609eb93b30a6b8e1dc7a6808ff0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
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
Reply-To: Bug 1868617 <1868617@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Here are two different ways i can think of to potentially solve this
(i'm not qemu hacker, feel free to correct me or propose a better
solution):

 - the spicevmc chardev's "name" parameter could be used to identify the
agent numerically (e.g. "vdagent:1" instead of "vdagent")

 - the -device virtserialport could identify whether it is connected via
a multiseat PCI bridge (pci-bridge-seat) and group it with the other
monitor from there.

Is one of these approaches preferable?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1868617

Title:
  multiseat: route different spice tablet events to distinct vdagents

Status in QEMU:
  New

Bug description:
  docs/multiseat.txt says:

  > Note on spice: Spice handles multihead just fine.  But it can't do
  > multiseat.  For tablet events the event source is sent to the spice
  > agent.  But qemu can't figure it, so it can't do input routing.
  > Fixing this needs a new or extended input interface between
  > libspice-server and qemu.  For keyboard events it is even worse:  The
  > event source isn't included in the spice protocol, so the wire
  > protocol must be extended to support this.

  I'm not sure exactly what "can't figure it" means, but it looks to me
  like qemu can't route incoming tablet events from a spice client to
  distinct vdagent channels.

  I think this part of the process can be fixed within qemu.  I've
  reported https://gitlab.freedesktop.org/spice/spice-gtk/issues/121 to
  address the issues with the keyboard interface at the protocol level.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1868617/+subscriptions

