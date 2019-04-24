Received: from eggs.gnu.org ([209.51.188.92]:59016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJGNO-000495-PY
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 07:47:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJG72-0007W0-DM
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 07:30:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:50564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJG72-0007VP-7P
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 07:30:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJG6z-0006D7-Dg
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 11:30:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 668272E80C0
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 11:30:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 11:20:53 -0000
From: Thomas Huth <1826175@bugs.launchpad.net>
Reply-To: Bug 1826175 <1826175@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155609955691.16667.3366200166619949036.malonedeb@soybean.canonical.com>
Message-Id: <155610485379.16775.7821715224844031569.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1826175] Re: Compilation on MSYS2/MinGW-w64 fails
 with error: "No rule to make target capstone.lib"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This change needs to go in via the capstone project. capstone is just an
unmodified "submodule" in QEMU - we do not include any QEMU-only changes
here.

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1826175

Title:
  Compilation on MSYS2/MinGW-w64 fails with error: "No rule to make
  target capstone.lib"

Status in QEMU:
  Invalid

Bug description:
  I submitted this bug to Capstone directly but I figured it'd be useful
  to post it here too. The IS_MINGW check in the Makefile for Capstone
  fails under MSYS2 MinGW-w64 because cc --version doesn't have mingw in
  the output anymore:

  $ whereis cc
  cc: /mingw64/bin/cc.exe

  $ cc --version
  cc.exe (Rev2, Built by MSYS2 project) 8.3.0
  Copyright (C) 2018 Free Software Foundation, Inc.
  This is free software; see the source for copying conditions.  There is NO
  warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E.

  Really simple patch:

  diff --git "a/Makefile" "b/Makefile"
  index 063f50db..1d9f042e 100644
  --- "a/Makefile"
  +++ "b/Makefile"
  @@ -288,7 +288,7 @@ CFLAGS :=3D $(CFLAGS:-fPIC=3D)
   # On Windows we need the shared library to be executable
   else
   # mingw?
  -IS_MINGW :=3D $(shell $(CC) --version | grep -i mingw | wc -l)
  +IS_MINGW :=3D $(shell $(CC) --version | grep -i msys2 | wc -l)
   ifeq ($(IS_MINGW),1)
   EXT =3D dll
   AR_EXT =3D lib

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1826175/+subscriptions
