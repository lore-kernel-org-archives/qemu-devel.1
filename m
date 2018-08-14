Received: from eggs.gnu.org ([2001:4830:134:3::10]:37587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fpdBA-0003MO-Dj
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fpdAv-0002l9-BM
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:32:24 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:55267)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fpdAu-0002kq-Lk
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:32:09 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 14 Aug 2018 18:19:01 +0200
Message-Id: <20180814161904.12216-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 0/3] linux-user: netlink fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

This series fixes some netlink errors while we start "gedit".

The first patch has already been sent alone.

Laurent Vivier (3):
  linux-user: fix recvmsg()/recvfrom() with netlink and MSG_TRUNC
  linux-user: update netlink route types
  linux-user: add QEMU_IFLA_INFO_KIND nested type for tun

 linux-user/syscall.c | 76 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 2 deletions(-)

-- 
2.17.1
