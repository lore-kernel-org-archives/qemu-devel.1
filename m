Received: from eggs.gnu.org ([2001:4830:134:3::10]:45678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fK6Eg-0007dp-1f
	for qemu-devel@nongnu.org; Sat, 19 May 2018 14:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fK6Eb-0004XJ-26
	for qemu-devel@nongnu.org; Sat, 19 May 2018 14:05:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:50086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fK6Ea-0004Wz-J5
	for qemu-devel@nongnu.org; Sat, 19 May 2018 14:05:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fK6EZ-0008A3-BO
	for <qemu-devel@nongnu.org>; Sat, 19 May 2018 18:05:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 52B092E8071
	for <qemu-devel@nongnu.org>; Sat, 19 May 2018 18:05:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 May 2018 17:50:54 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1772166 <1772166@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152673788962.15828.1293088141981880409.malonedeb@wampee.canonical.com>
Message-Id: <152675225417.15942.9524022443191417673.malone@wampee.canonical.com>
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

QEMU 2.4 is from 2015, and we didn't add raspi2 support until 2016.
We've never supported the USB controller for the raspi boards. Perhaps
you're using some other fork of QEMU? If so, better to talk to whoever's
responsible for it.

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
