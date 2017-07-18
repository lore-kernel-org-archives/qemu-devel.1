Received: from eggs.gnu.org ([2001:4830:134:3::10]:60179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLsR-0001dh-9w
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:21:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLsQ-0000k3-Kp
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:20:59 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Jul 2017 03:09:45 -0300
Message-Id: <20170718061005.29518-10-f4bug@amsat.org>
In-Reply-To: <20170718061005.29518-1-f4bug@amsat.org>
References: <20170718061005.29518-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 09/29] net: use QEMU_IS_ALIGNED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, Dmitry Fleytman <dmitry@daynix.com>, Jason Wang <jasowang@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.cocci

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 net/eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/eth.c b/net/eth.c
index 5b9ba26a56..187a6812f6 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -332,7 +332,7 @@ eth_setup_ip4_fragmentation(const void *l2hdr, size_t l2hdr_len,
         uint16_t frag_off_units = frag_offset / IP_FRAG_UNIT_SIZE;
         uint16_t new_ip_off;
 
-        assert(frag_offset % IP_FRAG_UNIT_SIZE == 0);
+        assert(QEMU_IS_ALIGNED(frag_offset, IP_FRAG_UNIT_SIZE));
         assert((frag_off_units & ~IP_OFFMASK) == 0);
 
         orig_flags = be16_to_cpu(iphdr->ip_off) & ~(IP_OFFMASK|IP_MF);
-- 
2.13.2
