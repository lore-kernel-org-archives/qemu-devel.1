Received: from eggs.gnu.org ([2001:4830:134:3::10]:48542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fK5NY-0003zV-I4
	for qemu-devel@nongnu.org; Sat, 19 May 2018 13:10:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fK5NU-00067F-In
	for qemu-devel@nongnu.org; Sat, 19 May 2018 13:10:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:54718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fK5NU-00066v-CT
	for qemu-devel@nongnu.org; Sat, 19 May 2018 13:10:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fK5NT-0003lw-HO
	for <qemu-devel@nongnu.org>; Sat, 19 May 2018 17:10:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 824342E8F35
	for <qemu-devel@nongnu.org>; Sat, 19 May 2018 17:10:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 May 2018 17:05:31 -0000
From: George <1772166@bugs.launchpad.net>
Reply-To: Bug 1772166 <1772166@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152673788962.15828.1293088141981880409.malonedeb@wampee.canonical.com>
Message-Id: <152674953169.2744.18004670257827067460.malone@gac.canonical.com>
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

I need this for raspberry pi emulation and the most recent doesn't work
as you can see from my other bug post.

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
