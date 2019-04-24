Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D4CC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 06:27:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3D2C218D3
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 06:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D2C218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36638 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJBNb-0005ds-Uw
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 02:27:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJBLy-0004TR-EM
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:25:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJBLw-0005a0-JJ
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:25:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:45130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJBLu-0005VM-Kl
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:25:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJBLr-0008MJ-2X
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:25:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 110E12E80C7
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:25:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 06:09:16 -0000
From: Thomas Huth <1392468@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: berrange fturco ingo-buerk jakub th-huth zta77
X-Launchpad-Bug-Reporter: =?utf-8?q?Ingo_B=C3=BCrk_=28ingo-buerk=29?=
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20141113201019.18949.57499.malonedeb@gac.canonical.com>
Message-Id:
 <155608615763.14250.13052145300196974826.launchpad@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 714de9b374495ef7251f5fe389e9ff0a38ce2be0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1392468] Re: qemu uses a bitmap icon
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
Reply-To: Bug 1392468 <1392468@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424060916.JXR7qrfE1qU_9oJlsfvB3ZgLRIdpn76gMsx0xVy6GX0@z>

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1392468

Title:
  qemu uses a bitmap icon

Status in QEMU:
  Fix Released

Bug description:
  qemu currently uses the icon in pc-bios/qemu-icon.bmp, which,
  obviously, is a bitmap file. It is loaded such that white pixels will
  be transparent. This can cause nasty artifacts in the display.

  Unless there is a specific reason to use bitmaps, I'd suggest moving
  to, e.g., a PNG file with a proper alpha channel.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1392468/+subscriptions

