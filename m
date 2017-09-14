Received: from eggs.gnu.org ([2001:4830:134:3::10]:41360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dsZSX-0000AB-0l
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dsZSS-0001Rw-3e
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:05:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:37485)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dsZSR-0001QU-Ti
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:05:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dsZSP-0006UC-9L
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 19:05:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3DBA22E848F
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 19:05:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Sep 2017 18:55:38 -0000
From: Thomas Huth <932490@bugs.launchpad.net>
Reply-To: Bug 932490 <932490@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120215021135.22747.33099.malonedeb@soybean.canonical.com>
Message-Id: <150541534122.24556.12013991838110852419.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 932490] Re: Qemu fails on -fda /dev/fd0 when no
 medium is present
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Incomplete =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/932490

Title:
  Qemu fails on -fda /dev/fd0 when no medium is present

Status in QEMU:
  Won't Fix

Bug description:
  # qemu-system-x86_64 --version
  QEMU emulator version 1.0 (qemu-kvm-1.0), Copyright (c) 2003-2008 Fabrice=
 Bellard

  # qemu-system-x86_64 -fda /dev/fd0
  qemu-system-x86_64: -fda /dev/fd0: could not open disk image /dev/fd0: No=
 such device or address

  Starting with a medium (floppy disk) inserted, then removing or
  changing the medium works fine.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/932490/+subscriptions
