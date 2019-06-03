Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E718CC04AB6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 07:04:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCFCD27C7B
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 07:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCFCD27C7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58844 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXh11-0000yU-2t
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 03:04:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hXgsg-0002gf-QK
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:55:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hXgsf-00071i-BX
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:55:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:47772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hXgsf-00070L-1B
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:55:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hXgsc-0003v7-PU
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 06:55:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BED432E80CB
	for <qemu-devel@nongnu.org>; Mon,  3 Jun 2019 06:55:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Jun 2019 06:45:23 -0000
From: =?utf-8?q?Christian_Ehrhardt_=EE=83=BF?= <1830821@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=intel; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
	status=Fix Released; importance=Undecided; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=bionic; sourcepackage=qemu; 
	component=main; status=Confirmed; importance=Wishlist;
	assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=cosmic; sourcepackage=qemu; 
	component=main; status=Confirmed; importance=Wishlist;
	assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=disco; sourcepackage=qemu; 
	component=main; status=Fix Released; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Tags: intel-virt-19.10 qemu-19.10
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: paelzer quanxian-wang sbeattie
X-Launchpad-Bug-Reporter: quanxian (quanxian-wang)
X-Launchpad-Bug-Modifier: =?utf-8?q?Christian_Ehrhardt_=EE=83=BF_=28paelzer?=
	=?utf-8?q?=29?=
References: <155909595152.12810.1489513977238974514.malonedeb@soybean.canonical.com>
Message-Id: <155954432307.24515.10059972768129249740.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18968";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: bd68244785db41f7fad8ef940f01055721235083
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1830821] Re: Expose ARCH_CAP_MDS_NO in guest
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
Reply-To: Bug 1830821 <1830821@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is done upstream, no need for the upstream bug task.
For Ubuntu I'll update the tasks to match the statement of sbeattie.
There are discussions to reconsider some of the backports, but unfortunatel=
y the IA32_ARCH_CAPABILITIES infrastructure is a rather big set of changes.

** Changed in: qemu
       Status: New =3D> Fix Released

** Also affects: qemu (Ubuntu Cosmic)
   Importance: Undecided
       Status: New

** Also affects: qemu (Ubuntu Disco)
   Importance: Undecided
       Status: New

** Also affects: qemu (Ubuntu Bionic)
   Importance: Undecided
       Status: New

** Changed in: qemu (Ubuntu Disco)
       Status: New =3D> Fix Released

** Changed in: qemu (Ubuntu)
       Status: New =3D> Fix Released

** Changed in: qemu (Ubuntu Bionic)
   Importance: Undecided =3D> Wishlist

** Changed in: qemu (Ubuntu Cosmic)
   Importance: Undecided =3D> Wishlist

** Changed in: qemu (Ubuntu Bionic)
       Status: New =3D> Confirmed

** Changed in: qemu (Ubuntu Cosmic)
       Status: New =3D> Confirmed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1830821

Title:
  Expose ARCH_CAP_MDS_NO in guest

Status in intel:
  New
Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Fix Released
Status in qemu source package in Bionic:
  Confirmed
Status in qemu source package in Cosmic:
  Confirmed
Status in qemu source package in Disco:
  Fix Released

Bug description:
  Description:

  MDS_NO is bit 5 of ARCH_CAPABILITIES. Expose this bit to guest.

  Target Qemu: 4.1

To manage notifications about this bug go to:
https://bugs.launchpad.net/intel/+bug/1830821/+subscriptions

