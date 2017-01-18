Received: from eggs.gnu.org ([2001:4830:134:3::10]:59660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTmsS-0004Vb-8V
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 04:50:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTmsO-0001vH-I0
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 04:50:00 -0500
Received: from indium.canonical.com ([91.189.90.7]:57644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cTmsO-0001v2-Bp
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 04:49:56 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cTmsN-0001aU-8N
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 09:49:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 16ADC2E80AF
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 09:49:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Jan 2017 09:35:26 -0000
From: Thomas Huth <788881@bugs.launchpad.net>
Reply-To: Bug 788881 <788881@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110526230010.27755.45888.malonedeb@wampee.canonical.com>
Message-Id: <20170118093526.20707.79107.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 788881] Re: i386-bsd-user and similar don't build
 on Mac OS X
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The bsd-user target is currently unmainted in QEMU, and I think it is
not meant for Mac OS X, but rather for FreeBSD and friends. So let's
close this ticket now...

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/788881

Title:
  i386-bsd-user and similar don't build on Mac OS X

Status in QEMU:
  Invalid

Bug description:
  0.14.1 crashes on Mac OS X 64bit with some targets (*-bsd-user):

    CC    i386-bsd-user/cpu-exec.o
  /Users/michael/Downloads/qemu-0.14.1/cpu-exec.c: In function =E2=80=98cpu=
_x86_signal_handler=E2=80=99:
  /Users/michael/Downloads/qemu-0.14.1/cpu-exec.c:895: error: dereferencing=
 pointer to incomplete type
  /Users/michael/Downloads/qemu-0.14.1/cpu-exec.c:895: error: =E2=80=98REG_=
RIP=E2=80=99 undeclared (first use in this function)
  /Users/michael/Downloads/qemu-0.14.1/cpu-exec.c:895: error: (Each undecla=
red identifier is reported only once
  /Users/michael/Downloads/qemu-0.14.1/cpu-exec.c:895: error: for each func=
tion it appears in.)
  /Users/michael/Downloads/qemu-0.14.1/cpu-exec.c:897: error: dereferencing=
 pointer to incomplete type
  /Users/michael/Downloads/qemu-0.14.1/cpu-exec.c:897: error: =E2=80=98REG_=
TRAPNO=E2=80=99 undeclared (first use in this function)
  /Users/michael/Downloads/qemu-0.14.1/cpu-exec.c:898: error: dereferencing=
 pointer to incomplete type
  /Users/michael/Downloads/qemu-0.14.1/cpu-exec.c:898: error: =E2=80=98REG_=
ERR=E2=80=99 undeclared (first use in this function)
  /Users/michael/Downloads/qemu-0.14.1/cpu-exec.c:899: error: dereferencing=
 pointer to incomplete type
  make[1]: *** [cpu-exec.o] Error 1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/788881/+subscriptions
