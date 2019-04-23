Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E7FC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 05:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8483320675
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 05:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8483320675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48495 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIoBD-0008Jv-4k
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 01:41:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hIo9g-0007FF-QP
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 01:39:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hIo0J-0007ak-KJ
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 01:30:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:47716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hIo0H-0007Xb-UO
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 01:30:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hIo0F-0006XX-H6
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 05:29:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 782442E806D
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 05:29:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Apr 2019 05:15:47 -0000
From: Thomas Huth <1615079@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bugreport-mailinator th-huth
X-Launchpad-Bug-Reporter: Bug Report (bugreport-mailinator)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20160819182404.11358.22174.malonedeb@soybean.canonical.com>
Message-Id:
 <155599654722.16959.17041950424430486409.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: cf589dc61d39fdd5426b5b8c4abccbe19ad05ffb
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
Message-ID: <20190423051547.1-TwhvsONcDGp0AQLcBoVNP8TIOAOUOiUtS9NgnKTr8@z>

Are you talking about serial console? Or graphical (VGA) console? Which
QEMU target (x86? ... and which machine?)? How did you start QEMU? ...
this bug report clearly lacks some more information...

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1615079

Title:
  GTK+ UI virtual consoles scrolling broken

Status in QEMU:
  Incomplete

Bug description:
  "In the virtual consoles, you can use Ctrl-Up, Ctrl-Down, Ctrl-PageUp
  and Ctrl-PageDown to move in the back log."

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1615079/+subscriptions

