Received: from eggs.gnu.org ([2001:4830:134:3::10]:48082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fJjzn-0000MY-1t
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:20:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fJjzj-0002Qz-Tw
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:20:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:33068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fJjzj-0002Qe-NM
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:20:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fJjzi-0008Cf-73
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 18:20:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0687E2E8F3A
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 18:20:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 May 2018 18:09:56 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1771570 <1771570@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152647807950.16381.7444115224433592455.malonedeb@soybean.canonical.com>
Message-Id: <152666699698.2944.10092016721742995283.malone@gac.canonical.com>
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

No, this should work on qemu-aarch64 the same way as for x86. I just
tried redirection to a file with a sample program, and it worked fine
for me. Can you provide a test case binary that fails like this, please?

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
