Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51223C33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 11:32:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24CBF206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 11:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24CBF206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixUXJ-0000pi-Bn
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 06:32:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ixUVd-0008Re-M5
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:30:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ixUVa-0006KX-S5
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:30:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:49048)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ixUVa-0006I9-MU
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:30:46 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ixUVZ-0001eH-GA
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 11:30:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 775452E8048
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 11:30:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jan 2020 11:16:45 -0000
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: build faq static
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: awdrg901 pmaydell
X-Launchpad-Bug-Reporter: zwq (awdrg901)
X-Launchpad-Bug-Modifier: =?utf-8?q?Alex_Benn=C3=A9e_=28ajbennee=29?=
References: <158043587219.19408.12428293277725628827.malonedeb@wampee.canonical.com>
Message-Id: <158046940583.26233.6384010925484623305.launchpad@soybean.canonical.com>
Subject: [Bug 1861468] Re: always fail to build qemu statically
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0a62c17273454a1313f81a74a2198ec30b44c7b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: de70fd0b4e8949b02db07b3bba72bb1ebf594295
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
Reply-To: Bug 1861468 <1861468@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Tags added: build faq static

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1861468

Title:
  always fail to build qemu statically

Status in QEMU:
  Invalid

Bug description:
  I want to build qemu statically so as to use qemu on Android platform(Tho=
ugh Limbo emulator is available on github,it's even slower than qemu in Use=
rLAnd(an Android APP that provides proot container for Linux dists)).
  When I finished building qemu normally on my phone(Ubuntu devel in proot =
environment),I started to build qemu statically.I removed the old source co=
de dir and unpack the qemu source code. I had built many libraries like lib=
SDL2 and libiSCSI for qemu,and of course these libraries were able to be de=
tected by qemu configure program.But when I ran the command:

   =E2=9D=AF ./configure --static --prefix=3D/home/admin/qemu/build --targe=
t-list=3Daarch64-softmmu,x86_64-softmmu,i386-softmmu,mips64-softmmu,ppc64-s=
oftmmu --enable-sdl                                                        =
                                 ERROR: User requested feature sdl         =
                                              =

  configure was not able to find it.                                       =
       =

  Install SDL2 devel

  I had to give up the SDL feature.
  I disabled the SDL feature and ran configure again.The configure didn't r=
eport error,but besides SDL ,many other libraries like libUSB,libpng were m=
issing.I ran 'make -j8 &&make install'.All seemed perfect.But when it comes=
 to the final process--linking executables,the ld program went wrong.It sai=
d it could not find the libraries like -lgtk3 -ldrm -lsystemd,etc.
  I was confused.I had already had a test building which successfully finis=
hed.
  Could you give me a possible way to solve the problem?

  Platform information:
  Ubuntu devel 20.04 ARM64 with GCC 9.2.1
  QEMU version:I have tested almost all versions from 2.11 to 4.2.0.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1861468/+subscriptions

