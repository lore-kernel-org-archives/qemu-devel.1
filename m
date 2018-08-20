Received: from eggs.gnu.org ([2001:4830:134:3::10]:49159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1frnnQ-0007UU-9K
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1frnnK-0003T1-70
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:16:52 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:50457)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1frnnI-0003Pz-74
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:16:46 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 20 Aug 2018 19:15:53 +0200
Message-Id: <20180820171557.7734-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 0/4] linux-user: netlink fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>

This series fixes some netlink errors while we start "gedit".

The first patch has already been sent alone.

v2:
  - added Peter's R-b for the first patch
  - added a patch to intoduce QEMU_RTA_* enum

Laurent Vivier (4):
  linux-user: fix recvmsg()/recvfrom() with netlink and MSG_TRUNC
  linux-user: introduce QEMU_RTA_* to use with rtattr_type_t
  linux-user: update netlink route types
  linux-user: add QEMU_IFLA_INFO_KIND nested type for tun

 linux-user/syscall.c | 129 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 116 insertions(+), 13 deletions(-)

-- 
2.17.1
