Received: from eggs.gnu.org ([2001:4830:134:3::10]:42749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8RtF-0004fR-SK
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 10:15:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8RtB-0004nZ-4U
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 10:15:09 -0400
Received: from indium.canonical.com ([91.189.90.7]:57828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e8RtA-0004m2-UY
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 10:15:05 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e8RtA-0002dY-6O
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 14:15:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2CD3E2E8033
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 14:15:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Oct 2017 14:01:22 -0000
From: Thomas Huth <1261743@bugs.launchpad.net>
Reply-To: Bug 1261743 <1261743@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131217131934.17694.64752.malonedeb@chaenomeles.canonical.com>
Message-Id: <150919928262.4447.4311140892379856656.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1261743] Re: trace-backend "simple" doesn't
 support "disable" property of event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I assume Stefan's fix had been included (likely
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D736ec1677f1ae7e64f2f =
?),
so I'm closing this ticket now. But if you still can reproduce this
issue, please let us know.

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1261743

Title:
  trace-backend "simple" doesn't support "disable" property of event

Status in QEMU:
  Fix Released

Bug description:
  trace-backend "simple" generates wrong eventid in trace/generated-
  tracers.c after "disable" property occured in trace-events record.

  Result: missing or mixing logs in trace file.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1261743/+subscriptions
