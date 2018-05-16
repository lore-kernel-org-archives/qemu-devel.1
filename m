Received: from eggs.gnu.org ([2001:4830:134:3::10]:32925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fIwpE-0002Hi-Kq
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fIwpA-0002YZ-VE
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:50:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:37082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fIwpA-0002Xd-OL
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:50:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fIwp9-0006Mh-OY
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 13:50:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B7AEE2E8033
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 13:50:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 May 2018 13:41:19 -0000
From: Juho Hiltunen <1771570@bugs.launchpad.net>
Reply-To: Bug 1771570 <1771570@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152647807950.16381.7444115224433592455.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1771570] [NEW] qemu-aarch64 $program > $file
 doesn't pipe output to file in 2.12.0
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

Running qemu-aarch64 $program > $file doesn't pipe anything to $file.
The file is created but empty.

qemu-aarch64 --help > $file works, so piping output in my system seems to w=
ork.
qemu-x86_64 $program > $file works, too.

I'm running version 2.12.0 build from source with ./configure && make

Output of uname -a:
Linux zhostname>  4.4.0-101-generic #124-Ubuntu SMP Fri Nov 10 18:29:59 UTC=
 2017 x86_64 x86_64 x86_64 GNU/Linux

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1771570

Title:
  qemu-aarch64 $program  > $file doesn't pipe output to file in 2.12.0

Status in QEMU:
  New

Bug description:
  Running qemu-aarch64 $program > $file doesn't pipe anything to $file.
  The file is created but empty.

  qemu-aarch64 --help > $file works, so piping output in my system seems to=
 work.
  qemu-x86_64 $program > $file works, too.

  I'm running version 2.12.0 build from source with ./configure && make

  Output of uname -a:
  Linux zhostname>  4.4.0-101-generic #124-Ubuntu SMP Fri Nov 10 18:29:59 U=
TC 2017 x86_64 x86_64 x86_64 GNU/Linux

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1771570/+subscriptions
