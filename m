Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B45BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 08:57:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1046D20829
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 08:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1046D20829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Qqz-0005xU-9z
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 04:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k1QpY-0004Ef-80
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 04:55:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:33936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k1QpV-0008KT-RU
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 04:55:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k1QpT-0005iU-26
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 08:55:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 0AEAB2E80EE
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 08:55:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2020 08:47:18 -0000
From: James Le Cuirot <1845185@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: mingw32 msys windows
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: avladu chewi philmd pmaydell
X-Launchpad-Bug-Reporter: Adrian Vladu (avladu)
X-Launchpad-Bug-Modifier: James Le Cuirot (chewi)
References: <156932212305.13447.6077258015607645915.malonedeb@gac.canonical.com>
Message-Id: <159618523857.11064.10602683036696344428.malone@chaenomeles.canonical.com>
Subject: [Bug 1845185] Re: Cannot build qemu utils (qemu-img.exe, qemu-edid.exe,
 qemu-io.exe) statically with MSYS64 on Windows because intl and iconv
 libs are not loaded
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: e7080f47c9b5f7608e682a8c5f1b89756e7d8b66
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 02:41:21
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: Bug 1845185 <1845185@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

My distribution has not added 2.65.0 yet but it should be fixed now,
yes.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1845185

Title:
  Cannot build qemu utils (qemu-img.exe, qemu-edid.exe, qemu-io.exe)
  statically with MSYS64 on Windows because intl and iconv libs are not
  loaded

Status in QEMU:
  New

Bug description:
  Using MSYS2 and mingw32 instructions from
  https://wiki.qemu.org/Hosts/W32#Native_builds_with_MSYS2, I could not
  statically build the qemu-utils using the latest qemu master branch.

  Steps to reproduce the issue:
  1. Install MSYS2 on a Windows 10 x64 box
  2. Install required mingw64 toolchain: pacman -S base-devel mingw-w64-x86=
_64-toolchain git python mingw-w64-x86_64-glib2 mingw64/mingw-w64-x86_64-gt=
k3 mingw64/mingw-w64-x86_64-SDL2
  3. clone qemu
  4. Run configure for static build for the tools only
  =C2=A0=C2=A0./configure --disable-user --disable-system --disable-docs --=
enable-tools  --disable-guest-agent --disable-capstone --disable-sheepdog -=
-enable-debug --static
  =C2=A0=C2=A0# I had to remove sheepdog, capstone and guest agent because =
other errors popped out, but let's not go in the rabbit hole.
  5. Run 'make -j'. the following errors appeared, signaling that intl lib =
is not loaded. If I add intl lib, iconv lib needs to be loaded too.

  make: *** [/home/ader1990/qemu/rules.mak:124: qemu-img.exe] Error 1
  make: *** Waiting for unfinished jobs....
  C:/msys64l/mingw64/lib\libglib-2.0.a(giowin32.c.obj):(.text+0x1522): unde=
fined reference to `libintl_sprintf'
  C:/msys64l/mingw64/lib\libglib-2.0.a(giowin32.c.obj):(.text+0x154f): unde=
fined reference to `libintl_sprintf'
  C:/msys64l/mingw64/lib\libglib-2.0.a(giowin32.c.obj):(.text+0x157e): unde=
fined reference to `libintl_sprintf'
  C:/msys64l/mingw64/lib\libglib-2.0.a(giowin32.c.obj):(.text+0x15ad): unde=
fined reference to `libintl_sprintf'
  C:/msys64l/mingw64/lib\libglib-2.0.a(giowin32.c.obj):(.text+0x15dc): unde=
fined reference to `libintl_sprintf'
  C:/msys64l/mingw64/lib\libglib-2.0.a(giowin32.c.obj):(.text+0x1622): more=
 undefined references to `libintl_sprintf' follow
  C:/msys64l/mingw64/lib\libglib-2.0.a(ggettext.c.obj):(.text+0x43): undefi=
ned reference to `libintl_textdomain'
  C:/msys64l/mingw64/lib\libglib-2.0.a(ggettext.c.obj):(.text+0x52): undefi=
ned reference to `libintl_gettext'
  C:/msys64l/mingw64/lib\libglib-2.0.a(ggettext.c.obj):(.text+0x203): undef=
ined reference to `libintl_bindtextdomain'
  C:/msys64l/mingw64/lib\libglib-2.0.a(ggettext.c.obj):(.text+0x21e): undef=
ined reference to `libintl_bind_textdomain_codeset'
  C:/msys64l/mingw64/lib\libglib-2.0.a(ggettext.c.obj):(.text+0x2c1): undef=
ined reference to `libintl_dgettext'
  C:/msys64l/mingw64/lib\libglib-2.0.a(ggettext.c.obj):(.text+0x4e1): undef=
ined reference to `libintl_dcgettext'
  C:/msys64l/mingw64/lib\libglib-2.0.a(ggettext.c.obj):(.text+0x53a): undef=
ined reference to `libintl_dngettext'

  Patch to fix the issue (added intl and iconv to the libs):

  diff --git a/configure b/configure
  index 30aad233d1..e2ab8ef026 100755
  --- a/configure
  +++ b/configure
  @@ -920,7 +920,7 @@ if test "$mingw32" =3D "yes" ; then
  =C2=A0=C2=A0=C2=A0DSOSUF=3D".dll"
  =C2=A0=C2=A0=C2=A0# MinGW needs -mthreads for TLS and macro _MT.
  =C2=A0=C2=A0=C2=A0QEMU_CFLAGS=3D"-mthreads $QEMU_CFLAGS"
  -  LIBS=3D"-lwinmm -lws2_32 -liphlpapi $LIBS"
  +  LIBS=3D"-lwinmm -lws2_32 -liphlpapi -lintl -liconv $LIBS"
  =C2=A0=C2=A0=C2=A0write_c_skeleton;
  =C2=A0=C2=A0=C2=A0if compile_prog "" "-liberty" ; then
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0LIBS=3D"-liberty $LIBS"

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1845185/+subscriptions

