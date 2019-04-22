Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6598EC10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 17:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 352122077C
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 17:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 352122077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40234 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIcOO-0006me-S7
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 13:06:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hIcN9-0006Av-6O
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 13:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hIcN8-0005Ma-8P
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 13:04:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:34342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hIcN6-0005K2-Bj
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 13:04:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hIcN4-0005Dm-1v
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 17:04:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 063602E800F
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 17:04:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Apr 2019 16:53:03 -0000
From: Bug Report <1615079@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bugreport-mailinator
X-Launchpad-Bug-Reporter: Bug Report (bugreport-mailinator)
X-Launchpad-Bug-Modifier: Bug Report (bugreport-mailinator)
References: <20160819182404.11358.22174.malonedeb@soybean.canonical.com>
Message-Id:
 <155595198337.16887.16029173689703845818.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 8ab87d7dd511aad11ee93c115543aa4199f9e2a1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1615079] Re: GTK+ UI virtual consoles scrolling
 broken
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1615079 <1615079@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422165303.BT2z9pS2BkfhpNu99ZyNAkibjO_b-PhidmfI9YWwbdM@z>

VTE is required for this to work?

if yes, the configure script should have info about the dependency

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1615079

Title:
  GTK+ UI virtual consoles scrolling broken

Status in QEMU:
  New

Bug description:
  "In the virtual consoles, you can use Ctrl-Up, Ctrl-Down, Ctrl-PageUp
  and Ctrl-PageDown to move in the back log."

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1615079/+subscriptions

