Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F98C33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 10:36:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED55C206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 10:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED55C206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixTfS-0001Ef-6F
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 05:36:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ixTef-0000Su-2O
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 05:36:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ixTed-00087n-6A
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 05:36:04 -0500
Received: from indium.canonical.com ([91.189.90.7]:38432)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ixTeb-0007xO-Ha
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 05:36:03 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ixTeY-0003WD-IY
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 10:35:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 67BB82E80D1
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 10:35:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jan 2020 10:25:22 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: awdrg901 pmaydell
X-Launchpad-Bug-Reporter: zwq (awdrg901)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <158043587219.19408.12428293277725628827.malonedeb@wampee.canonical.com>
Message-Id: <158046632238.26286.5921928148092886867.malone@soybean.canonical.com>
Subject: [Bug 1861468] Re: always fail to build qemu statically
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0a62c17273454a1313f81a74a2198ec30b44c7b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: af4f9ba01f0b0c6328754ac4385438778fb68a1f
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

QEMU is not really intended to be built statically except for the
'linux-user' emulators. The configure script will allow you to build the
system emulator binaries and the tools statically, but that is more on a
"if it happens to work for you, great" basis, rather than a supported
one.

In general: you need to have static library versions of all the
development packages like libsdl2, libglib, libgtk, etc etc -- it sounds
like you have only the dynamic libraries available, in which case
statically linking them will not work, and configure will either note
that it couldn't use the package (as happened with SDL) or just not be
able to link at the end. You will have better luck also if you use
configure --disable... options to reduce the use of optional stuff like
libiSCSI which you probably don't need. Then you can avoid having to
find static versions of those libraries.


** Changed in: qemu
       Status: New =3D> Invalid

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

