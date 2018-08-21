Received: from eggs.gnu.org ([2001:4830:134:3::10]:56091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fs0Ql-0006FB-0Q
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fs0Qf-0003gA-83
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:46:18 -0400
Received: from indium.canonical.com ([91.189.90.7]:41166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fs0Qf-0003f3-0Q
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:46:13 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fs0Qd-0004Rh-2N
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 06:46:11 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EBFE22E8524
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 06:46:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Aug 2018 06:31:10 -0000
From: Thomas Huth <1614521@bugs.launchpad.net>
Reply-To: Bug 1614521 <1614521@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160818130339.29660.13425.malonedeb@gac.canonical.com>
Message-Id: <153483307090.16823.13736962398588064078.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1614521] Re: -display accepts "none[a-z,
 0-9]*" instead of 'none'
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
https://bugs.launchpad.net/bugs/1614521

Title:
  -display accepts "none[a-z,0-9]*" instead of 'none'

Status in QEMU:
  Fix Released

Bug description:
  When using the '-display' option the parameter 'none' is not the only
  string that causes the behaviour of 'none'. I can use '-display
  noneMICKEYMOUSE' and still have the none behaviour.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1614521/+subscriptions
