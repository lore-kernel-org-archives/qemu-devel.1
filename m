Received: from eggs.gnu.org ([209.51.188.92]:57417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJBH3-0008Ii-NM
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:20:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJBH2-00019c-Ko
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:20:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:44384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJBH2-00017n-Eh
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:20:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJBH1-0007nD-Ku
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:20:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9C40A2E80C9
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:20:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 06:11:54 -0000
From: Thomas Huth <1798659@bugs.launchpad.net>
Reply-To: Bug 1798659 <1798659@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153989027444.15424.224613242357516969.malonedeb@gac.canonical.com>
Message-Id: <155608631514.13880.11850226665415342118.launchpad@gac.canonical.com>
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

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1798659

Title:
  Replace comma with semicolon in trace/simple.c

Status in QEMU:
  Fix Released

Bug description:
  In the master branch in trace/simple.c in writeout_thread (https://github=
.com/qemu/qemu/blob/master/trace/simple.c#L174) we currently have:
    dropped.rec.length =3D sizeof(TraceRecord) + sizeof(uint64_t),
    dropped.rec.pid =3D trace_pid;

  It seems to me like a typo that the first line ends with a comma.
  Currently this causes no harm, but I think this should be fixed.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1798659/+subscriptions
