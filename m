Received: from eggs.gnu.org ([209.51.188.92]:38179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gm2f1-0007dt-7F
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:28:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gm2ez-0000m6-92
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:28:39 -0500
Received: from indium.canonical.com ([91.189.90.7]:46290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gm2ev-0000bp-1r
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:28:35 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1glx9F-0004AJ-Oq
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 14:35:29 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B71AD2E8033
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 14:35:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Jan 2019 14:30:08 -0000
From: Sergey Lisov <1812861@bugs.launchpad.net>
Reply-To: Bug 1812861 <1812861@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154816740902.19321.3239172253055110269.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1812861] [NEW] QEMU in user-mode emulation mode
 crashes when the user program jumps to an invalid address
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

Running this code:

void (*func)() =3D 0x12345678;

int main()
{
    func();
    return 0;
}

Produces the following output:

qemu-arm-static: /build/qemu-DqynNa/qemu-2.8+dfsg/translate-all.c:175: tb_l=
ock: Assertion `!have_tb_lock' failed.
qemu-arm-static: /build/qemu-DqynNa/qemu-2.8+dfsg/translate-all.c:175: tb_l=
ock: Assertion `!have_tb_lock' failed.
Segmentation fault

The expected result is as follows:

qemu: uncaught target signal 11 (Segmentation fault) - core dumped
Segmentation fault

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: crash usermode

** Attachment added: "qemu-bug.c"
   https://bugs.launchpad.net/bugs/1812861/+attachment/5231469/+files/qemu-=
bug.c

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1812861

Title:
  QEMU in user-mode emulation mode crashes when the user program jumps
  to an invalid address

Status in QEMU:
  New

Bug description:
  Running this code:

  void (*func)() =3D 0x12345678;

  int main()
  {
      func();
      return 0;
  }

  Produces the following output:

  qemu-arm-static: /build/qemu-DqynNa/qemu-2.8+dfsg/translate-all.c:175: tb=
_lock: Assertion `!have_tb_lock' failed.
  qemu-arm-static: /build/qemu-DqynNa/qemu-2.8+dfsg/translate-all.c:175: tb=
_lock: Assertion `!have_tb_lock' failed.
  Segmentation fault

  The expected result is as follows:

  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  Segmentation fault

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1812861/+subscriptions
