Received: from eggs.gnu.org ([2001:4830:134:3::10]:47989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cN1vp-0005MO-P4
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 13:29:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cN1vl-0007b2-Qv
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 13:29:33 -0500
Received: from indium.canonical.com ([91.189.90.7]:56414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cN1vl-0007aZ-Kn
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 13:29:29 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cN1vi-0000LX-SB
	for <qemu-devel@nongnu.org>; Fri, 30 Dec 2016 18:29:26 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C25AF2E80C3
	for <qemu-devel@nongnu.org>; Fri, 30 Dec 2016 18:29:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Dec 2016 18:17:40 -0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reply-To: Bug 1399943 <1399943@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20141206152602.26252.40483.malonedeb@gac.canonical.com>
Message-Id: <20161230181740.1306.88092.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1399943] Re: qemu-system-sparc loses serial
 console data on EAGAIN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi Andreas,

Does the new 2.8 release pass your tests? If so, I will close this bug
report.


ATB,

Mark.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1399943

Title:
  qemu-system-sparc loses serial console data on EAGAIN

Status in QEMU:
  New

Bug description:
  When running a guest OS with a serial console under =

  "qemu-system-sparc -nographic", parts of the serial console output
  are sometimes lost.

  This happens when a write() to standard output by qemu returns EAGAIN,
  as may be the case when the guest is generating console output faster
  than the tty (or pty/pipe/socket, etc.) connected to qemu's standard
  output accepts it. The bug affects all releases of qemu since 1.5,
  which was the first version to set stdout to O_NONBLOCK mode. Version
  1.4.2 and earlier work correctly.

  To reproduce the bug, you will need a guest OS configured with a
  serial console, and a host with a slow tty.  The attached shell script
  "sparc-test.sh" does this by using Aboriginal Linux as the serial
  console guest, and a pty controlled by a Python script and the
  "pexpect" Python module as the slow tty. A "seq" command is sent
  to the guest to generate 100,000 lines of output containing sequential
  integers, and the output is checked for gaps. The script limits the
  tty output rate by occasionally sleeping for 1/10 of a second.

  This bug was originally reported against qemu-system-i386 as =

  bug #1335444, and has since been fixed in qemu-system-i386,
  but remains in qemu-system-sparc as of today's git sources =

  (d00e6cddc220de993573dfb5fd160ac72ccd49ab).  I am opening
  this separate bug for the sparc case because I was asked
  to do so by Paolo Bonzini in #1335444.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1399943/+subscriptions
