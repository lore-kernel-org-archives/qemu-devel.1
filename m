Received: from eggs.gnu.org ([2001:4830:134:3::10]:44402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fJjgq-0000EM-W0
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fJjgn-0001kJ-3M
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:01:17 -0400
Received: from indium.canonical.com ([91.189.90.7]:54630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fJjgm-0001ja-TG
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:01:13 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fJjgl-000489-Ip
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 18:01:11 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8D8A82E804E
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 18:01:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 May 2018 17:47:36 -0000
From: Juho Hiltunen <1771570@bugs.launchpad.net>
Reply-To: Bug 1771570 <1771570@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152647807950.16381.7444115224433592455.malonedeb@soybean.canonical.com>
Message-Id: <152666565666.2744.2828126064980578338.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1771570] Re: qemu-aarch64 $program > $file
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

Running "unbuffer qemu-aarch64 $program > $file" allows to pipe the
output.

Is it intentional that I need to disable buffering to allow piping to
other processes? If yes, this issue can be closed.

further reading about unbuffer:
https://unix.stackexchange.com/questions/25372/turn-off-buffering-in-
pipe#25378

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
