Return-Path: <SRS0=s7fR=UB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BF3C28CC2
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 04:31:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51FB127845
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 04:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51FB127845
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44786 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXI9b-0007hG-5w
	for qemu-devel@archiver.kernel.org; Sun, 02 Jun 2019 00:31:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hXI8i-0007JI-9g
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 00:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hXI84-0001rK-Cf
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 00:29:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:41128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hXI84-0001qd-2o
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 00:29:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hXI82-0005k1-MN
	for <qemu-devel@nongnu.org>; Sun, 02 Jun 2019 04:29:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 936162E8076
	for <qemu-devel@nongnu.org>; Sun,  2 Jun 2019 04:29:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Jun 2019 04:17:29 -0000
From: Launchpad Bug Tracker <1567254@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: janitor john-frankish th-huth
X-Launchpad-Bug-Reporter: John Frankish (john-frankish)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <20160407073359.3051.6082.malonedeb@chaenomeles.canonical.com>
Message-Id: <155944904966.14260.11870120270500548086.malone@loganberry.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18968";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 0fe125523c794776dd0f4099f39604f9afcfce51
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1567254] Re: qemu-2.5.1 will not run with gtk3/vte
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1567254 <1567254@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1567254

Title:
  qemu-2.5.1 will not run with gtk3/vte

Status in QEMU:
  Expired

Bug description:
  Using qemu-2.5.1 and compiling without gtk3 and vte-2.90.

  This works:

  CC=3D"gcc -mtune=3Dgeneric -Os -pipe" CXX=3D"g++ -mtune=3Dgeneric -Os -pi=
pe
  -fno-exceptions -fno-rtti" ./configure --prefix=3D/usr/local
  --localstatedir=3D/var --libexecdir=3D/usr/local/lib/qemu --interp-
  prefix=3D/usr/local/share/qemu --audio-drv-list=3D"oss alsa sdl" --target-
  list=3D"i386-softmmu i386-linux-user x86_64-softmmu x86_64-linux-user"
  --smbd=3D/usr/local/sbin/smbd --disable-curses

  find . -name config-host.mak -type f -exec sed -i 's/-O2//g' {} \;

  make
  sudo make install

  If I then add gtk3 and vte-2.90 development files and compile again,
  this fails with or without --disable-docs:

   sudo make install
  ...
  make -C po install
  make[1]: Entering directory '/usr/src/qemu-2.5.1/po'
    GEN   tr.mo
  /bin/sh: msgfmt: not found
  Makefile:13: recipe for target 'tr.mo' failed
  make[1]: *** [tr.mo] Error 127
  make[1]: Leaving directory '/usr/src/qemu-2.5.1/po'
  Makefile:443: recipe for target 'install' failed
  make: *** [install] Error 2

  If I then add gettext and re-compile, "qemu-system-x86_64 -blah-blah"
  opens a window, displays the bios message and stops.

  * configure script should check for gettext
  * if "--disable-docs" is passed, "make install" should not try to install=
 docs
  * qemu should work when compiled with gtk3 and vte
  * why does qemu insist on vte-2.90, when vte-2.91 has been out +/- 2 year=
s?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1567254/+subscriptions

