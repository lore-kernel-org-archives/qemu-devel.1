Return-Path: <SRS0=q9Vo=YU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB5ACA9EAF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 06:26:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31A3620873
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 06:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A3620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=voltagex.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOc0e-0002fU-6q
	for qemu-devel@archiver.kernel.org; Sun, 27 Oct 2019 02:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33244)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iObzh-00016j-2w
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 02:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iObzf-0006dx-RB
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 02:25:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:49466)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iObzf-0006dl-L1
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 02:25:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iObze-0001UM-Jo
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2019 06:25:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 86F082E8010
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2019 06:25:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Oct 2019 06:17:41 -0000
From: Adam Baxter <voltagex@voltagex.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: qemu-img
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: the.netadmin voltagex
X-Launchpad-Bug-Reporter: Zixuan Wang (the.netadmin)
X-Launchpad-Bug-Modifier: Adam Baxter (voltagex)
References: <152222836105.21062.2375148895134658603.malonedeb@chaenomeles.canonical.com>
Message-Id: <157215706185.2702.3460525326125677929.malone@gac.canonical.com>
Subject: [Bug 1759522] Re: windows qemu-img create vpc/vhdx error
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="469f241f4e73cc0bdffa4e30654052a2af068e06";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 2e1a848a5b712c2767f75115b036c96d876dbab5
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Bug 1759522 <1759522@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Can confirm this is still an issue with 4.1.0.

?field.comment=3DCan confirm this is still an issue with 4.1.0.


** Attachment added: "Files created on Windows and Debian"
   https://bugs.launchpad.net/qemu/+bug/1759522/+attachment/5300530/+files/=
vhdx_comparison.7z

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1759522

Title:
  windows qemu-img create vpc/vhdx error

Status in QEMU:
  New

Bug description:
  On windows, using qemu-img (version 2.11.90) to create vpc/vhdx
  virtual disk tends to fail. Here's the way to reproduce:

  1. Install qemu-w64-setup-20180321.exe

  2. Use `qemu-img create -f vhdx -o subformat=3Dfixed disk.vhdx 512M` to c=
reate a vhdx:
     Formatting 'disk.vhdx', fmt=3Dvhdx size=3D536870912 log_size=3D1048576=
 block_size=3D0 subformat=3Dfixed

  3. Execute `qemu-img info disk.vhdx` gives the result, (note the `disk si=
ze` is incorrect):
     image: disk.vhdx
     file format: vhdx
     virtual size: 512M (536870912 bytes)
     disk size: 1.4M
     cluster_size: 8388608

  4. On Windows 10 (V1709), double click disk.vhdx gives an error:
     Make sure the file is in an NTFS volume and isn't in a compressed fold=
er or volume.

     Using Disk Management -> Action -> Attach VHD gives an error:
     The requested operation could not be completed due to a virtual disk s=
ystem limitation. Virtual hard disk files must be uncompressed and uneccryp=
ted and must not be sparse.

  Comparison with Windows 10 created VHDX:

  1. Using Disk Management -> Action -> Create VHD:
     File name: win.vhdx
     Virtual hard disk size: 512MB
     Virtual hard disk format: VHDX
     Virtual hard disk type: Fixed size

  2. Detach VHDX

  3. Execute `qemu-img info win.vhdx` gives the result:
     image: win.vhdx
     file format: vhdx
     virtual size: 512M (536870912 bytes)
     disk size: 516M
     cluster_size: 33554432

  Comparison with qemu-img under Ubuntu:

  1. Version: qemu-img version 2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.16),
  Copyright (c) 2004-2008 Fabrice Bellard

  2. qemu-img create -f vhdx -o subformat=3Dfixed lin.vhdx 512M
     Formatting 'lin.vhdx', fmt=3Dvhdx size=3D536870912 log_size=3D1048576 =
block_size=3D0 subformat=3Dfixed

  3. qemu-img info lin.vhdx
     image: lin.vhdx
     file format: vhdx
     virtual size: 512M (536870912 bytes)
     disk size: 520M
     cluster_size: 8388608

  4. Load lin.vhdx under Windows 10 is ok

  The same thing happens on `vpc` format with or without
  `oformat=3Dfixed`, it seems that windows version of qemu-img has some
  incorrect operation? My guess is that windows version of qemu-img
  doesn't handle the description field of vpc/vhdx, which leads to an
  incorrect `disk size` field.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1759522/+subscriptions

