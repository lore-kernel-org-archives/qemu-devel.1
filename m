Received: from eggs.gnu.org ([2001:4830:134:3::10]:36140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBnFY-0005Vr-D4
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:40:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBnFS-0000cN-Jh
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:40:00 -0500
Received: from indium.canonical.com ([91.189.90.7]:48328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eBnFS-0000bv-Dg
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:39:54 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eBnFR-0001JD-DD
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 19:39:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5FDA52E8058
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 19:39:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Nov 2017 19:29:27 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1581695 <1581695@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160513232712.9526.48086.malonedeb@soybean.canonical.com>
Message-Id: <150999656716.19979.4241868822535384353.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1581695] Re: getifaddrs: Address family not
 supported by protocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We got netlink sockets working for linux-user over the course of 2016,
and "ip addr" now works for me with a 32-bit arm chroot. This should be
fixed in QEMU 2.10.


** Changed in: qemu
       Status: New =3D> Fix Released

** Tags added: linux-user

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1581695

Title:
  getifaddrs: Address family not supported by protocol

Status in QEMU:
  Fix Released

Bug description:
  Calling ip addr fails with the following error message:
  Cannot open netlink socket: Address family not supported by protocol

  =

  My use case is running a docker raspberry pi arm container on Ubuntu 14.0=
4 x64 with qemu-static.

  My steps to reproduce are the following:

  # docker pull philipz/rpi-raspbian:latest
  # docker run -it --rm -v /usr/bin/qemu-arm-static:/usr/bin/qemu-arm-stati=
c philipz/rpi-raspbian bash
  root@3b4ddc174279:/# ip addr
  Cannot open netlink socket: Address family not supported by protocol

  A fix or an workaround would be awesome.

  note: we are also working with a embedded arm distro which has no
  package manager available, would be nice if the workaround would not
  depend on apt-get

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1581695/+subscriptions
