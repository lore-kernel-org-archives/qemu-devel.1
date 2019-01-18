Received: from eggs.gnu.org ([209.51.188.92]:59279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gkY3o-0006SL-SA
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:36:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gkY3l-0001X2-Vl
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:36:04 -0500
Received: from indium.canonical.com ([91.189.90.7]:53834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gkY3k-0001P4-1q
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:36:00 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gkY3g-0004XY-51
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 17:35:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 10C702E80D2
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 17:35:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Jan 2019 17:25:18 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1798659 <1798659@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153989027444.15424.224613242357516969.malonedeb@gac.canonical.com>
Message-Id: <154783231820.971.16258964895392341851.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1798659] Re: Replace comma with semicolon in
 trace/simple.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fixed in commit 7ff5920717d413d8b7c3ba13d9, which will be in the
upcoming 4.0 release.


** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1798659

Title:
  Replace comma with semicolon in trace/simple.c

Status in QEMU:
  Fix Committed

Bug description:
  In the master branch in trace/simple.c in writeout_thread (https://github=
.com/qemu/qemu/blob/master/trace/simple.c#L174) we currently have:
    dropped.rec.length =3D sizeof(TraceRecord) + sizeof(uint64_t),
    dropped.rec.pid =3D trace_pid;

  It seems to me like a typo that the first line ends with a comma.
  Currently this causes no harm, but I think this should be fixed.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1798659/+subscriptions
