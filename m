Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18137C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 09:16:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5E0B20665
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 09:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E0B20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsOFY-0005Je-8t
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 05:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59946)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hsOEX-0004aV-BH
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 05:15:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hsOEW-00069X-6a
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 05:15:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:39714)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hsOEV-00069A-Lx
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 05:15:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hsOET-0003fZ-BA
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 09:15:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1893C2E80E1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 09:15:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jul 2019 09:01:29 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: arm raspi2
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: aditya-govardhan
X-Launchpad-Bug-Reporter: Aditya Govardhan (aditya-govardhan)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <156377129036.14702.8663571503299830535.malonedeb@wampee.canonical.com>
Message-Id: <156447729013.7808.16737404267635516804.launchpad@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19010";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 9002f1023f581b6d54ed1daabca3fb161fd5f8ec
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

** Summary changed:

- core dump after raspi2 kernel boot
+ guest userspace process core dump after raspi2 kernel boot

** Tags added: arm

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

