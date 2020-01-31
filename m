Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23ABC3F68F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 02:06:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AC8A2063A
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 02:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC8A2063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixLhD-0001rk-NV
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 21:06:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ixLgg-0001T8-Ek
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 21:05:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ixLgf-0008Ks-0i
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 21:05:38 -0500
Received: from indium.canonical.com ([91.189.90.7]:54760)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ixLge-0008KQ-R6
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 21:05:36 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ixLgd-0006NX-KD
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 02:05:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 8CC3B2E80C3
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 02:05:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jan 2020 01:57:52 -0000
From: zwq <1861468@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: awdrg901
X-Launchpad-Bug-Reporter: zwq (awdrg901)
X-Launchpad-Bug-Modifier: zwq (awdrg901)
Message-Id: <158043587219.19408.12428293277725628827.malonedeb@wampee.canonical.com>
Subject: [Bug 1861468] [NEW] always fail to build qemu statically
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0a62c17273454a1313f81a74a2198ec30b44c7b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: a9b9083252b702bb6941937567616b15af5e246f
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

Public bug reported:

I want to build qemu statically so as to use qemu on Android platform(Thoug=
h Limbo emulator is available on github,it's even slower than qemu in UserL=
And(an Android APP that provides proot container for Linux dists)).
When I finished building qemu normally on my phone(Ubuntu devel in proot en=
vironment),I started to build qemu statically.I removed the old source code=
 dir and unpack the qemu source code. I had built many libraries like libSD=
L2 and libiSCSI for qemu,and of course these libraries were able to be dete=
cted by qemu configure program.But when I ran the command:

 =E2=9D=AF ./configure --static --prefix=3D/home/admin/qemu/build --target-=
list=3Daarch64-softmmu,x86_64-softmmu,i386-softmmu,mips64-softmmu,ppc64-sof=
tmmu --enable-sdl                                                          =
                               ERROR: User requested feature sdl           =
                                            =

configure was not able to find it.                                         =
     =

Install SDL2 devel

I had to give up the SDL feature.
I disabled the SDL feature and ran configure again.The configure didn't rep=
ort error,but besides SDL ,many other libraries like libUSB,libpng were mis=
sing.I ran 'make -j8 &&make install'.All seemed perfect.But when it comes t=
o the final process--linking executables,the ld program went wrong.It said =
it could not find the libraries like -lgtk3 -ldrm -lsystemd,etc.
I was confused.I had already had a test building which successfully finishe=
d.
Could you give me a possible way to solve the problem?

Platform information:
Ubuntu devel 20.04 ARM64 with GCC 9.2.1
QEMU version:I have tested almost all versions from 2.11 to 4.2.0.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1861468

Title:
  always fail to build qemu statically

Status in QEMU:
  New

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

