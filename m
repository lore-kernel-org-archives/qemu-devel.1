Received: from eggs.gnu.org ([2001:4830:134:3::10]:42779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fK4b4-00047j-63
	for qemu-devel@nongnu.org; Sat, 19 May 2018 12:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fK4b1-0008NE-0g
	for qemu-devel@nongnu.org; Sat, 19 May 2018 12:20:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:49502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fK4b0-0008Mv-QP
	for qemu-devel@nongnu.org; Sat, 19 May 2018 12:20:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fK4az-0008DH-Me
	for <qemu-devel@nongnu.org>; Sat, 19 May 2018 16:20:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A7AE82E8056
	for <qemu-devel@nongnu.org>; Sat, 19 May 2018 16:20:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 May 2018 16:14:07 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1772166 <1772166@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152673788962.15828.1293088141981880409.malonedeb@wampee.canonical.com>
Message-Id: <152674644775.15756.13233907384807102411.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] =?utf-8?b?W0J1ZyAxNzcyMTY2XSBSZTogcWVtdSAyLjQuMTog?=
 =?utf-8?q?dereferencing_pointer_to_incomplete_type_=E2=80=98struct_uconte?=
 =?utf-8?b?eHTigJk=?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

2.4.1 is a very old release of QEMU. I would recommend moving to a more
recent release.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1772166

Title:
  qemu 2.4.1: dereferencing pointer to incomplete type =E2=80=98struct ucon=
text=E2=80=99

Status in QEMU:
  New

Bug description:
  Trying to compile qemu release 2.4.1

  Getting compile error

  user-exec.c: In function =E2=80=98cpu_resume_from_signal=E2=80=99:
  user-exec.c:72:37: error: dereferencing pointer to incomplete type =E2=80=
=98struct ucontext=E2=80=99
           sigprocmask(SIG_SETMASK, &uc->uc_sigmask, NULL);
                                       ^~
  user-exec.c: In function =E2=80=98cpu_arm_signal_handler=E2=80=99:
  user-exec.c:214:41: error: dereferencing pointer to incomplete type =E2=
=80=98struct ucontext=E2=80=99

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1772166/+subscriptions
