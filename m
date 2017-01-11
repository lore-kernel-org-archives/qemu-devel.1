Received: from eggs.gnu.org ([2001:4830:134:3::10]:37270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRDHC-0007ql-O4
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 02:24:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRDH7-00081q-Pm
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 02:24:54 -0500
Received: from indium.canonical.com ([91.189.90.7]:60347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cRDH7-00080o-KK
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 02:24:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cRDH5-0001Mm-V4
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 07:24:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E0C902E80C9
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 07:24:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Jan 2017 07:11:22 -0000
From: Thomas Huth <622367@bugs.launchpad.net>
Reply-To: Bug 622367 <622367@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100822180158.18591.82477.malonedeb@palladium.canonical.com>
Message-Id: <20170111071122.20423.64907.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 622367] Re: No BIOS MPFP structure with smp=92
 and more
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

QEMU 0.12 is quite outdated nowadays ... can you still reproduce this
issue with the latest version of QEMU (currently version 2.8)?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/622367

Title:
  No BIOS MPFP structure with smp=3D92 and more

Status in QEMU:
  Incomplete

Bug description:
  qemu 0.12.2, SeaBios 0.5.1, running qemu-system-x86_64.exe with option -s=
mp.
  If smp>=3D92 then no MP floating point structure present in 1 Mb. This ma=
y be verified by pmemsave 0 0x100000 in debugger and search for _MP_ signat=
ure in file.

  qemu 0.10.5 (bios build 05/08/09) can smp=3D128 (and even 255 if not
  hangs :).

  Host win 7 x64 RTM 7600.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/622367/+subscriptions
