Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254BAC28CBF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:57:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 009C321721
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:57:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009C321721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42228 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVBRO-0002uZ-9c
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 04:57:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hVBPu-0001op-Qh
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hVBPr-0000dL-5T
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:55:36 -0400
Received: from indium.canonical.com ([91.189.90.7]:49080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hVBPp-0000Ya-9Y
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:55:35 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hVBPm-0002Yg-D7
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 08:55:30 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2F7002E80CB
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 08:55:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 May 2019 08:39:37 -0000
From: Thomas Huth <1590322@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: sayantan-bhowmik94 th-huth
X-Launchpad-Bug-Reporter: sayantan (sayantan-bhowmik94)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20160608085308.24358.59591.malonedeb@gac.canonical.com>
Message-Id: <155894637775.13135.4009553633125100648.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18968";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 371d5b5628eb1ad668d838717dd1c994742ff8e9
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1590322] Re: mouse_button 0 takes back to initial
 position
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
Reply-To: Bug 1590322 <1590322@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Did you mean "mouse_button 0" instead of "mouse_move 0" here?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1590322

Title:
  mouse_button 0 takes back to initial position

Status in QEMU:
  Incomplete

Bug description:
  i wrote a python script to perform some drag function in the Qemu simulat=
or.
  mouse_move x , y
  mouse_button 1
  mouse_move new_x,new_y
  mouse_move 0

  =

  The mouse_move 0 doesn't release the mouse in the position new_x,new_y in=
stead it takes  it back to the point x,y and then releases the mouse

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1590322/+subscriptions

