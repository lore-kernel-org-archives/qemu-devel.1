Received: from eggs.gnu.org ([209.51.188.92]:46348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gldZ4-0004SU-M1
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:40:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gldZ3-0007sS-UA
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:40:50 -0500
Received: from indium.canonical.com ([91.189.90.7]:56976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gldZ3-0007s6-Ok
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:40:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gldZ2-0000RP-8L
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 17:40:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 393952E80CC
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 17:40:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Jan 2019 17:32:52 -0000
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Reply-To: Bug 1812694 <1812694@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154808795140.25200.13223693574023659013.malonedeb@wampee.canonical.com>
Message-Id: <154809197269.7532.12740626127043480408.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1812694] Re: qemu-system-x86_64 version 3.0+ is
 20 times slower than version 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Your linked drive doesn't seem to have any readme or documentation for
how this is invoked. Please see:

  https://www.qemu.org/contribute/report-a-bug/

Specifically the host/guest details and the full command line that you
have used to run this binary.

As developers may be wary about running on unknown binary on their
systems you may find it quicker to do some experiments yourself. If you
run qemu under perf for 2.12 and 3.0+ (or current git) that might give
some indication about what has changed.

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1812694

Title:
  qemu-system-x86_64 version 3.0+ is 20 times slower than version 2.12

Status in QEMU:
  Incomplete

Bug description:
  version 3.0+ is 20 times slower than version 2.12
  I wrote a small 64-bit operating system (SIGMAOS) in which I use the lzma=
 decoder. unpacking the file takes 20 times slower than in version 2.12.
  You can download it from https://drive.google.com/drive/folders/0B_wEiYjz=
VkC0ZGtkbENENzF1Nms

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1812694/+subscriptions
