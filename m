Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62A8C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 08:03:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 808B22089E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 08:03:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808B22089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55446 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heEWM-0004SH-Cg
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 04:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47369)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1heETh-0003Ae-Hd
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 04:00:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1heETd-0000Op-M3
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 04:00:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:47044)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1heETd-0000NX-DV
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 04:00:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1heETc-0000pF-3A
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 08:00:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 13CD22E80C9
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 08:00:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Jun 2019 07:47:19 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1833668@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: arm linux-user
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
Message-Id: <156110323981.19354.11667763271761846721.malonedeb@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18989";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: b6bf23581950e2b2f85631d811591f8756aae8ef
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1833668] [NEW] linux-user: Unable to run ARM
 binaries on Aarch64
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
Reply-To: Bug 1833668 <1833668@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Download a ARM package from https://packages.debian.org/sid/busybox-
static

Here tested with: busybox-static_1.30.1-4_armel.deb

$ file busybox.armel
busybox.armel: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), stat=
ically linked, for GNU/Linux 3.2.0, BuildID[sha1]=3D12cf572e016bafa240e113b=
57b3641e94b837f37, stripped

$ qemu-aarch64 --version
qemu-aarch64 version 2.11.1(Debian 1:2.11+dfsg-1ubuntu7.14)

$ qemu-aarch64 busybox.armel
busybox.armel: Invalid ELF image for this architecture

$ qemu-aarch64 -cpu cortex-a7 busybox.armel
unable to find CPU model 'cortex-a7'

Also reproduced with commit 33d609990621dea6c7d056c86f707b8811320ac1,
while the aarch64_cpus[] array contains Aarch64 CPUs, the arm_cpus[] array =
is empty:

$ gdb -q aarch64-linux-user/qemu-aarch64
(gdb) p aarch64_cpus
$1 =3D {{name =3D 0x1fe4e8 "cortex-a57", initfn =3D 0x109bc0 <aarch64_a57_i=
nitfn>, class_init =3D 0x0}, {name =3D 0x1fe508 "cortex-a53", initfn =3D 0x=
109a10 <aarch64_a53_initfn>, class_init =3D 0x0}, {name =3D 0x1fe518 "corte=
x-a72", =

    initfn =3D 0x109868 <aarch64_a72_initfn>, class_init =3D 0x0}, {name =
=3D 0x218020 "max", initfn =3D 0x109d70 <aarch64_max_initfn>, class_init =
=3D 0x0}, {name =3D 0x0, initfn =3D 0x0, class_init =3D 0x0}}
(gdb) p arm_cpus
$2 =3D {{name =3D 0x0, initfn =3D 0x0, class_init =3D 0x0}}

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: arm linux-user

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1833668

Title:
  linux-user: Unable to run ARM binaries on Aarch64

Status in QEMU:
  New

Bug description:
  Download a ARM package from https://packages.debian.org/sid/busybox-
  static

  Here tested with: busybox-static_1.30.1-4_armel.deb

  $ file busybox.armel
  busybox.armel: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), st=
atically linked, for GNU/Linux 3.2.0, BuildID[sha1]=3D12cf572e016bafa240e11=
3b57b3641e94b837f37, stripped

  $ qemu-aarch64 --version
  qemu-aarch64 version 2.11.1(Debian 1:2.11+dfsg-1ubuntu7.14)

  $ qemu-aarch64 busybox.armel
  busybox.armel: Invalid ELF image for this architecture

  $ qemu-aarch64 -cpu cortex-a7 busybox.armel
  unable to find CPU model 'cortex-a7'

  Also reproduced with commit 33d609990621dea6c7d056c86f707b8811320ac1,
  while the aarch64_cpus[] array contains Aarch64 CPUs, the arm_cpus[] arra=
y is empty:

  $ gdb -q aarch64-linux-user/qemu-aarch64
  (gdb) p aarch64_cpus
  $1 =3D {{name =3D 0x1fe4e8 "cortex-a57", initfn =3D 0x109bc0 <aarch64_a57=
_initfn>, class_init =3D 0x0}, {name =3D 0x1fe508 "cortex-a53", initfn =3D =
0x109a10 <aarch64_a53_initfn>, class_init =3D 0x0}, {name =3D 0x1fe518 "cor=
tex-a72", =

      initfn =3D 0x109868 <aarch64_a72_initfn>, class_init =3D 0x0}, {name =
=3D 0x218020 "max", initfn =3D 0x109d70 <aarch64_max_initfn>, class_init =
=3D 0x0}, {name =3D 0x0, initfn =3D 0x0, class_init =3D 0x0}}
  (gdb) p arm_cpus
  $2 =3D {{name =3D 0x0, initfn =3D 0x0, class_init =3D 0x0}}

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1833668/+subscriptions

