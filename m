Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F47C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 09:36:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E105D20449
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 09:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E105D20449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsl1r-0004wz-3h
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 05:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36814)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hsl1J-00047V-L8
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 05:35:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hsl1H-0007fL-TT
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 05:35:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:35398)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hsl1G-0007cW-OH
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 05:35:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hsl1E-0004Ee-9t
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:35:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 3CCBA2E80D0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:35:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 31 Jul 2019 09:26:07 -0000
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: arm raspi2 tcg
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: aditya-govardhan
X-Launchpad-Bug-Reporter: Aditya Govardhan (aditya-govardhan)
X-Launchpad-Bug-Modifier: =?utf-8?q?Alex_Benn=C3=A9e_=28ajbennee=29?=
References: <156377129036.14702.8663571503299830535.malonedeb@wampee.canonical.com>
Message-Id: <156456516800.15945.6740228791160171660.launchpad@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19012";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: cf5ab1a5bf6920d6b288ab77ae5a0ab32fb5f854
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1837347] Re: guest userspace process core dump
 after raspi2 kernel boot
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
Reply-To: Bug 1837347 <1837347@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Tags added: tcg

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1837347

Title:
  guest userspace process core dump after raspi2 kernel boot

Status in QEMU:
  New

Bug description:
  Host info:
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  x86-64, Ubuntu 18.04, QEMU 4.0.0 (downloaded tarball from main site)

  Guest info:
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  ARM7l, Raspbian OS off the main raspberry pi site

  QEMU command:
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  qemu-system-arm -M raspi2 -kernel bootpart/kernel7.img -dtb bootpart/bcm2=
709-rpi-2-b.dtb -drive file=3D2019-07-10-raspbian-buster.img,format=3Draw,i=
f=3Dsd -append "rw earlyprintk console=3DttyAMA0,115200 fsck.repair=3Dyes r=
ootwait memtest=3D1 loglevel=3D8 dwc_otg.lpm_enable=3D0 root=3D/dev/mmcblk0=
p2" -serial stdio

  kernel7.img and bcm2709-rpi-2-b.dtb were obtained by the following
  commands:

  guestfish --ro -a 2019-07-10-raspbian-buster.img -m /dev/sda1
  ><fs> copy-out / bootpart/
  ><fs> quit

  Output:
  =3D=3D=3D=3D=3D=3D=3D

  https://pastebin.com/fL1eXhV0

  References:
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  https://translatedcode.wordpress.com/2016/11/03/installing-debian-on-qemu=
s-32-bit-arm-virt-board/
  https://translatedcode.wordpress.com/2018/04/25/debian-on-qemus-raspberry=
-pi-3-model/

  =

  The core dump error can occur at both times, before logging in and after =
logging in, in this case I have given the output after logging in to show t=
he initial processes running.

  Also please let me know if I using any kernel flags incorrectly

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1837347/+subscriptions

