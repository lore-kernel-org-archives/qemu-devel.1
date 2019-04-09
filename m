Received: from eggs.gnu.org ([209.51.188.92]:37184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hDr4c-0005gD-3C
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hDr4b-000182-6D
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:46:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:48518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hDr4a-00017d-UJ
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:46:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hDr4Z-0004jI-2I
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 13:45:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 100E22E80CB
	for <qemu-devel@nongnu.org>; Tue,  9 Apr 2019 13:45:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Apr 2019 13:36:31 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1812861 <1812861@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154816740902.19321.3239172253055110269.malonedeb@gac.canonical.com>
Message-Id: <155481699208.7911.8526085627494961075.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1812861] Re: QEMU in user-mode emulation mode
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

** Tags removed: usermode
** Tags added: linux-user

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
