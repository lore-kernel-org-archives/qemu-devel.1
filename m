Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D66C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 07:21:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 721B12171F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 07:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721B12171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60161 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEqVL-0006DN-Bm
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 03:21:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hEqUQ-0005U9-0w
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 03:20:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hEqUO-0005GY-3Q
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 03:20:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:36640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hEqUM-0005EN-9r
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 03:20:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hEqUK-0001pj-Au
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 07:20:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 371C82E80C8
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 07:20:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Apr 2019 07:06:30 -0000
From: Thomas Huth <1486278@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Wishlist;
	assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
	status=Confirmed; importance=Wishlist; assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: rawlik th-huth
X-Launchpad-Bug-Reporter: Druta Pavel (rawlik)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20150818230718.18792.42543.malonedeb@wampee.canonical.com>
Message-Id:
 <155505279030.7989.9154643681286899467.malone@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18920";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 1592c6f8791c698b67866b25f63564cf4aaf20ff
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1486278] Re: 'info vnc' monitor command does not
 show websocket information
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
Reply-To: Bug 1486278 <1486278@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412070630.bYh0ViA06RFaR2Q4e7aEf9j7nfE68zkt5sOIfAeMfiQ@z>

I think this has been fixed in QEMU v2.10.0 with this commit here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D0a9667ecdb6d7da90a2ef=
64

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1486278

Title:
  'info vnc' monitor command does not show websocket information

Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Confirmed

Bug description:
  Steps to reproduce^
  1. run
   qemu-system-x86_64  -vnc  0.0.0.0:1,websocket=3D5701 -nographic -monitor=
 stdio

  2. then type =

   (qemu) info vnc
  3.  see
       address: 0.0.0.0:5901
          auth: none
  Client: none

  There is no information about websocket parameters, but 'netstat -nltp' s=
hows me:
   ...
  tcp        0      0 0.0.0.0:5701            0.0.0.0:*               LISTE=
N      27073/qemu-system-x
  ....

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1486278/+subscriptions

