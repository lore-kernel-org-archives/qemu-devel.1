Received: from eggs.gnu.org ([2001:4830:134:3::10]:45651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cpwvV-0003uh-ON
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:00:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cpwvU-00071f-A0
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:00:45 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:59221)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cpwvU-00070a-3g
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:00:44 -0400
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
	by Forcepoint Email with ESMTPS id 0EE59110D882B
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 13:00:40 +0000 (GMT)
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Mon, 20 Mar 2017 13:00:25 +0000
Message-ID: <1490014826-4472-10-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1490014826-4472-1-git-send-email-yongbok.kim@imgtec.com>
References: <1490014826-4472-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for v2.9 09/10] dma/rc4030: fix a mixed
 declarations and code warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
---
 hw/dma/rc4030.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index 5f10b9d..0080141 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -99,8 +99,8 @@ typedef struct rc4030State
=20
 static void set_next_tick(rc4030State *s)
 {
-    qemu_irq_lower(s->timer_irq);
     uint32_t tm_hz;
+    qemu_irq_lower(s->timer_irq);
=20
     tm_hz =3D 1000 / (s->itr + 1);
=20
--=20
2.7.4
