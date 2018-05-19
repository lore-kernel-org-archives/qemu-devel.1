Received: from eggs.gnu.org ([2001:4830:134:3::10]:51825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fK2Pl-0002D8-2N
	for qemu-devel@nongnu.org; Sat, 19 May 2018 10:00:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fK2Pg-0006oY-7u
	for qemu-devel@nongnu.org; Sat, 19 May 2018 10:00:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:53152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fK2Pg-0006mu-1V
	for qemu-devel@nongnu.org; Sat, 19 May 2018 10:00:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fK2Pe-0001LH-Qn
	for <qemu-devel@nongnu.org>; Sat, 19 May 2018 14:00:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C0B0E2E8F38
	for <qemu-devel@nongnu.org>; Sat, 19 May 2018 14:00:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 May 2018 13:51:29 -0000
From: George <1772166@bugs.launchpad.net>
Reply-To: Bug 1772166 <1772166@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152673788962.15828.1293088141981880409.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] =?utf-8?b?W0J1ZyAxNzcyMTY2XSBbTkVXXSBxZW11IDIuNC4x?=
 =?utf-8?q?=3A_dereferencing_pointer_to_incomplete_type_=E2=80=98struct_uc?=
 =?utf-8?b?b250ZXh04oCZ?=
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

Trying to compile qemu release 2.4.1

Getting compile error

user-exec.c: In function =E2=80=98cpu_resume_from_signal=E2=80=99:
user-exec.c:72:37: error: dereferencing pointer to incomplete type =E2=80=
=98struct ucontext=E2=80=99
         sigprocmask(SIG_SETMASK, &uc->uc_sigmask, NULL);
                                     ^~
user-exec.c: In function =E2=80=98cpu_arm_signal_handler=E2=80=99:
user-exec.c:214:41: error: dereferencing pointer to incomplete type =E2=80=
=98struct ucontext=E2=80=99

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: 2.4.1

** Tags added: 2.4.1

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
