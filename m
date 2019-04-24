Received: from eggs.gnu.org ([209.51.188.92]:57291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJBGv-0008GW-JY
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:20:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJBGu-0000wq-DG
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:20:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:43850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJBGu-0000vp-7i
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:20:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJBGs-0007fI-NY
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:20:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AFBE52E80C8
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:20:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 06:09:44 -0000
From: Thomas Huth <1817865@bugs.launchpad.net>
Reply-To: Bug 1817865 <1817865@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155125923743.16914.13241911895735421382.malonedeb@soybean.canonical.com>
Message-Id: <155608618538.16959.4237724165339356729.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1817865] Re: sorecvfrom freezes guest
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
https://bugs.launchpad.net/bugs/1817865

Title:
  sorecvfrom freezes guest

Status in QEMU:
  Fix Released

Bug description:
  QEMU release 3.1.0; Guest running win10.

  Sometimes sorecvfrom() is called from slirp.c because revents =3D=3D
  G_IO_IN, however inside sorecvfrom() function, ioctlsocket() returns 0
  bytes available and recvfrom could be blocking indefinitely.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1817865/+subscriptions
