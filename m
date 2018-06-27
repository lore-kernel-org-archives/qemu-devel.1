Received: from eggs.gnu.org ([2001:4830:134:3::10]:49129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYHtj-0007tP-D8
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 17:22:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYHtf-0006Gm-Ec
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 17:22:43 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:46003)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fYHtf-0006FH-5w
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 17:22:39 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 27 Jun 2018 23:21:50 +0200
Message-Id: <20180627212152.26525-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 0/2] linux-user: minor fixes
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

This series fixes a couple of problem I've found
using the libuv test suite.

Laurent Vivier (2):
  linux-user: add netlink CARRIER_UP_COUNT/CARRIER_DOWN_COUNT
  linux-user: update do_setsockopt()

 linux-user/syscall.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.14.4
