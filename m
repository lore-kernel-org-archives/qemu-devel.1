Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1137C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 04:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5F9320724
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 04:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F9320724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGb9m-00079i-QL
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 00:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jGb8a-0005KO-Ke
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 00:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jGb8Z-0005mU-EQ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 00:26:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:37142)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jGb8Z-0005ly-9L
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 00:25:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jGb8X-0001hN-1D
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 04:25:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B61B22E80C7
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 04:25:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Mar 2020 04:17:22 -0000
From: Launchpad Bug Tracker <1639394@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: janitor jnsnow xtrondo
X-Launchpad-Bug-Reporter: xtrondo (xtrondo)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <20161105021624.30133.98019.malonedeb@wampee.canonical.com>
Message-Id: <158502344281.22792.14295000479344803462.malone@loganberry.canonical.com>
Subject: [Bug 1639394] Re: Unable to boot Solaris 8/9 x86 under Fedora 24
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="3a6db24bbe7280ec09bae73384238390fcc98ad3";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 02c3de6750db06f9b28c21aad45fa55ac4baf027
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
Reply-To: Bug 1639394 <1639394@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1639394

Title:
  Unable to boot Solaris 8/9 x86 under Fedora 24

Status in QEMU:
  Expired

Bug description:
  qemu-system-x86_64 -version
  QEMU emulator version 2.6.2 (qemu-2.6.2-4.fc24), Copyright (c) 2003-2008 =
Fabrice Bellard

  Try several ways without success, I think it was a regression because pro=
blem seems to be related with ide fixed on 0.6.0:
  - int13 CDROM BIOS fix (aka Solaris x86 install CD fix)
  - int15, ah=3D86 BIOS fix (aka Solaris x86 hardware probe hang up fix)

  Solaris 10/11 works without a problem, also booting with "scsi" will
  circumvent initial problem, but later found problems related with
  "scsi" cdrom boot and also will not found the "ide" disk device.

  =

  qemu-system-i386 -m 712 -drive file=3D/dev/Virtual_hdd/beryllium0,format=
=3Draw -cdrom /repo/Isos/sol-9_905_x86.iso

  SunOS Secondary Boot version 3.00

  prom_panic: Could not mount filesystem.
  Entering boot debugger:
  [136419]

  =

  Regards,
  \\CA,

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1639394/+subscriptions

