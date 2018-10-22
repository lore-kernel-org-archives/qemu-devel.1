Received: from eggs.gnu.org ([2001:4830:134:3::10]:48963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gEhTq-0004pm-H9
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 17:11:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gEhTn-0001oz-1N
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 17:11:18 -0400
Received: from indium.canonical.com ([91.189.90.7]:41598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gEhTm-0001nn-O6
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 17:11:14 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gEhTk-0001qj-9N
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 21:11:12 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EEACA2E80E3
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 21:11:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Oct 2018 21:03:25 -0000
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Reply-To: Bug 1737883 <1737883@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151314764536.10749.10688753671340892012.malonedeb@wampee.canonical.com>
Message-Id: <154024220567.16730.5260196800573584161.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1737883] Re: Cannot boot FreeBSD on versatilepb
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

What version did this last work on? What version have you tested that
failed? Have you tried the latest QEMU HEAD build? What was the full
command line of your invocation?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1737883

Title:
  Cannot boot FreeBSD on versatilepb machine

Status in QEMU:
  Incomplete

Bug description:
  I know some years ago it was possible to boot FreeBSD in QEMU versatilepb=
 machine
  https://kernelnomicon.org/?p=3D229 (you can download image and kernel usi=
ng web.archive.org)
  Now when I try to do that I get only black screen with no output even in =
QEMU console.
  I also added -global versatile_pci.broken-irq-mapping=3D1, but this seem =
to have no effect.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1737883/+subscriptions
