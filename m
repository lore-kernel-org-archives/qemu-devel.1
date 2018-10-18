Received: from eggs.gnu.org ([2001:4830:134:3::10]:58545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gDE0V-0007N0-Ig
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 15:30:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gDE0Q-0005a2-Fi
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 15:30:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:51604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gDE0M-0004ZE-K8
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 15:30:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gDE0J-0007Ra-62
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 19:30:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DF92E2E80D2
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 19:30:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Oct 2018 19:17:54 -0000
From: Oren Milman <orenmn@gmail.com>
Reply-To: Bug 1798659 <1798659@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <153989027444.15424.224613242357516969.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1798659] [NEW] A typo in trace/simple.c
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

In the master branch in trace/simple.c in writeout_thread (https://github.c=
om/qemu/qemu/blob/master/trace/simple.c#L174) we currently have:
  dropped.rec.length =3D sizeof(TraceRecord) + sizeof(uint64_t),
  dropped.rec.pid =3D trace_pid;

It seems to me like a typo that the first line ends with a comma.
Currently this causes no harm, but I think this should be fixed.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1798659

Title:
  A typo in trace/simple.c

Status in QEMU:
  New

Bug description:
  In the master branch in trace/simple.c in writeout_thread (https://github=
.com/qemu/qemu/blob/master/trace/simple.c#L174) we currently have:
    dropped.rec.length =3D sizeof(TraceRecord) + sizeof(uint64_t),
    dropped.rec.pid =3D trace_pid;

  It seems to me like a typo that the first line ends with a comma.
  Currently this causes no harm, but I think this should be fixed.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1798659/+subscriptions
