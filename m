Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9811C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 09:28:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8824E20449
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 09:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8824E20449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38510 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJECk-00021n-Hz
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 05:28:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJEB8-0000ib-07
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 05:26:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJEA4-0007TG-PL
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 05:25:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:57956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJEA3-0007Sg-SH
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 05:25:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJEA3-0005Vq-2V
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 09:25:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F059A2E80C8
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 09:25:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 09:09:25 -0000
From: Thomas Huth <1548170@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: famz kode54 th-huth
X-Launchpad-Bug-Reporter: Christopher Snowhill (kode54)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20160222040615.1630.88377.malonedeb@soybean.canonical.com>
Message-Id:
 <155609696519.13556.16569528594945360980.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 96924fa06f4a18b24bca158ab6005c3d9c192fda
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1548170] Re: qemu-kvm-spice spice server locks up
 when large user image is set
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
Reply-To: Bug 1548170 <1548170@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424090925.N8HrZhQKnQ3TerZsWsmfd2u5L_Uu6p5kpInZu_CzLr4@z>

If I get comment #2 right, the spice issue has been fixed sometime
between v2.0 and v2.5, so I'm closing this ticket now. If you still
encounter this issue with the latest version of QEMU (currently v4.0),
feel free to open again (or report a new bug ticket for other issues).

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1548170

Title:
  qemu-kvm-spice spice server locks up when large user image is set

Status in QEMU:
  Fix Released

Bug description:
  QEMU emulator version 2.0.0 (Debian 2.0.0+dfsg-2ubuntu1.22), Copyright
  (c) 2003-2008 Fabrice Bellard

  I have QEMU kvm spice installed, running a Windows 10 1511, freshly
  installed this morning, using VirtIO root volume, Ethernet, and QXL
  graphics through Spice. It successfully installed the latest updates,
  and installed Visual Studio 2010 Professional plus Service Pack 1 and
  updates.

  Upon attempting to configure the following PNG as my account's user
  picture in the Settings control panel applet:

  https://static.kode54.net/pwywcomm_christopher_8bpp.png

  It added successfully, but then I noticed that Windows does not
  support alpha blended user pictures, and it blended it against white,
  so I quickly replaced it with the following:

  https://static.kode54.net/pwywcomm_christopher_blended.png

  Upon assigning that, with the other one still in the previous image
  buttons, Spice locked up completely. The VM was still running, as
  evidenced by a successful Remote Desktop session.

  Do I need to replace my entire Qemu setup with a Git or hand built
  official version to verify that this isn't Ubuntu's fault?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1548170/+subscriptions

