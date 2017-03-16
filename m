Received: from eggs.gnu.org ([2001:4830:134:3::10]:38530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1coR2u-0000bw-Cu
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 04:46:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1coR2p-00010L-EN
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 04:46:08 -0400
Received: from indium.canonical.com ([91.189.90.7]:58975)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1coR2p-000109-0m
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 04:46:03 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1coR2l-0007tE-Jy
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 08:45:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8E0992E80E8
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 08:45:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Mar 2017 08:36:55 -0000
From: Jordan Justen <1673373@bugs.launchpad.net>
Reply-To: Bug 1673373 <1673373@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170316083655.32185.94003.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1673373] [NEW] qemu -version output is incorrect
 with configure --with-pkgversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

Since qemu v2.7.0, up to the current master
(1883ff34b540daacae948f493b0ba525edf5f642)
the pkgversion feature appears to have a bug:

$ ./configure --target-list=3Dx86_64-softmmu --with-pkgversion=3Dfoo

Results in this output:

$ x86_64-softmmu/qemu-system-x86_64 -version
QEMU emulator version 2.8.90(foo)
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

This appears to have been introduced in:

67a1de0d19 Makefile: Derive "PKGVERSION" from "git describe" by default

The previous commit (077de81a4c) produces this output:

$ x86_64-softmmu/qemu-system-x86_64 -version
QEMU emulator version 2.6.50 (foo), Copyright (c) 2003-2008 Fabrice Bellard

** Affects: qemu
     Importance: Undecided
     Assignee: Jordan Justen (jljusten)
         Status: New

** Changed in: qemu
     Assignee: (unassigned) =3D> Jordan Justen (jljusten)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1673373

Title:
  qemu -version output is incorrect with configure --with-pkgversion

Status in QEMU:
  New

Bug description:
  Since qemu v2.7.0, up to the current master
  (1883ff34b540daacae948f493b0ba525edf5f642)
  the pkgversion feature appears to have a bug:

  $ ./configure --target-list=3Dx86_64-softmmu --with-pkgversion=3Dfoo

  Results in this output:

  $ x86_64-softmmu/qemu-system-x86_64 -version
  QEMU emulator version 2.8.90(foo)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

  This appears to have been introduced in:

  67a1de0d19 Makefile: Derive "PKGVERSION" from "git describe" by
  default

  The previous commit (077de81a4c) produces this output:

  $ x86_64-softmmu/qemu-system-x86_64 -version
  QEMU emulator version 2.6.50 (foo), Copyright (c) 2003-2008 Fabrice Bella=
rd

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1673373/+subscriptions
