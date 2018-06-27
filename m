Received: from eggs.gnu.org ([2001:4830:134:3::10]:48841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYHtK-0007as-43
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 17:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYHtG-0005hK-6N
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 17:22:18 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:46911)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fYHtF-0005gH-Sb
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 17:22:14 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 27 Jun 2018 23:21:51 +0200
Message-Id: <20180627212152.26525-2-laurent@vivier.eu>
In-Reply-To: <20180627212152.26525-1-laurent@vivier.eu>
References: <20180627212152.26525-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 1/2] linux-user: add netlink
 CARRIER_UP_COUNT/CARRIER_DOWN_COUNT
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

Error is reported with libuv test suite:

 not ok 311 - udp_multicast_interface6
 # exit code 134
 # Output from process `udp_multicast_interface6`:
 # Unknown host QEMU_IFLA type: 47
 # Unknown host QEMU_IFLA type: 48
 # Unknown host QEMU_IFLA type: 47
 # Unknown host QEMU_IFLA type: 48
 # Unknown host QEMU_IFLA type: 47
 # Unknown host QEMU_IFLA type: 48
 # Unknown host QEMU_IFLA type: 47
 # Unknown host QEMU_IFLA type: 48
 # Unknown host QEMU_IFLA type: 47
 # Unknown host QEMU_IFLA type: 48

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 2117fb13b4..4460f1e39a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2522,6 +2522,8 @@ static abi_long host_to_target_data_link_rtattr(struct rtattr *rtattr)
     case QEMU_IFLA_NUM_VF:
     case QEMU_IFLA_GSO_MAX_SEGS:
     case QEMU_IFLA_GSO_MAX_SIZE:
+    case QEMU_IFLA_CARRIER_UP_COUNT:
+    case QEMU_IFLA_CARRIER_DOWN_COUNT:
         u32 = RTA_DATA(rtattr);
         *u32 = tswap32(*u32);
         break;
-- 
2.14.4
