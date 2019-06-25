Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D31C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 15:38:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73E77208E3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 15:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E77208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33198 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfnWJ-0002iv-PT
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 11:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33754)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hfnTn-0000ix-1z
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:35:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hfnTl-0005ld-Me
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:35:30 -0400
Received: from indium.canonical.com ([91.189.90.7]:44672)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hfnTl-0005kn-F8
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:35:29 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hfnTj-0003gT-W5
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 15:35:28 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id EBC062E8078
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 15:35:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Jun 2019 15:27:50 -0000
From: Laurent Vivier <Laurent@vivier.eu>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: arm linux-user
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: laurent-vivier philmd rth
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: Laurent Vivier (laurent-vivier)
References: <156110323981.19354.11667763271761846721.malonedeb@wampee.canonical.com>
 <156147381286.18147.1572558561573422063.malone@gac.canonical.com>
Message-Id: <d5c913aa-0edf-ff4b-f21e-8c1a375e10fd@vivier.eu>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18991";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 1140a9ecac8d9d59f05bad407b4c6b90b42fe7d3
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: Re: [Qemu-devel] [Bug 1833668] Re: linux-user: Unable to run ARM
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
Message-ID: <20190625152750.J0oBE7CEHcFIcx9IK6leMQnrwaIKbt_MWeofBa84Ghs@z>

Le 25/06/2019 =C3=A0 16:43, Richard Henderson a =C3=A9crit=C2=A0:
> Of course.  There's a separate qemu-arm executable for that.

On some other architectures (like ppc/ppc64) the idea is the 64bit
version supports also all 32bit versions CPUs.

I think it's why this bug has been opened.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1833668

Title:
  linux-user: Unable to run ARM binaries on Aarch64

Status in QEMU:
  Invalid

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

