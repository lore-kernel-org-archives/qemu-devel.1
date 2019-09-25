Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B5FC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:42:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 668D320640
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 668D320640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cloudbasesolutions.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD5gb-0006Y7-Dq
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 07:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iD5fG-0005GM-Jk
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:40:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iD5fF-00017p-5y
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:40:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:39054)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iD5fF-00017V-0O
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:40:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iD5fC-0001ss-QU
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 11:40:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C5F4E2E8005
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 11:40:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Sep 2019 11:26:47 -0000
From: Adrian Vladu <avladu@cloudbasesolutions.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: mingw32 msys windows
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: avladu pmaydell
X-Launchpad-Bug-Reporter: Adrian Vladu (avladu)
X-Launchpad-Bug-Modifier: Adrian Vladu (avladu)
References: <156932212305.13447.6077258015607645915.malonedeb@gac.canonical.com>
Message-Id: <156941080775.27427.8071107314144500369.malone@soybean.canonical.com>
Subject: [Bug 1845185] Re: Cannot build qemu utils (qemu-img.exe, qemu-edid.exe,
 qemu-io.exe) statically with MSYS64 on Windows because intl and iconv
 libs are not loaded
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19048";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: da1a1326c705f451b7fc73880d37198f99b33956
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
Reply-To: Bug 1845185 <1845185@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I checked the glib package static deps:
pkg-config.exe --static --libs glib-2.0
-LC:/msys64/mingw64/lib -lintl -lglib-2.0 -lws2_32 -lole32 -lwinmm -lshlwap=
i -pthread -lpcre


Let me know if there is anything I can do next to get this issue fixed (if =
it is fixable).

Thank you,
Adrian

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

