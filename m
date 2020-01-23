Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3977DC33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 06:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F98224655
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 06:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F98224655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuVrp-0001NK-3H
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 01:21:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iuVrC-0000vj-JS
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 01:20:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iuVrB-0006ue-EM
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 01:20:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:54230)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iuVrB-0006tg-8z
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 01:20:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iuVrA-00020V-IK
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 06:20:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 86CCF2E80C0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 06:20:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jan 2020 06:12:23 -0000
From: Thomas Huth <1639394@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jnsnow xtrondo
X-Launchpad-Bug-Reporter: xtrondo (xtrondo)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20161105021624.30133.98019.malonedeb@wampee.canonical.com>
Message-Id: <157975994405.5350.526382048528793519.launchpad@soybean.canonical.com>
Subject: [Bug 1639394] Re: Unable to boot Solaris 8/9 x86 under Fedora 24
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="b8d1327fd820d6bf500589d6da587d5037c7d88e";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: b20812a4a44f12128391a087d66a761463184d52
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

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1639394

Title:
  Unable to boot Solaris 8/9 x86 under Fedora 24

Status in QEMU:
  Incomplete

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

