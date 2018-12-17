Received: from eggs.gnu.org ([2001:4830:134:3::10]:43666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ29R-0001I7-LC
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:18:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ29Q-00055Q-Mx
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:18:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZ29Q-000550-Fk
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:18:16 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Dec 2018 00:16:57 +0100
Message-Id: <20181217231700.24482-33-pbonzini@redhat.com>
In-Reply-To: <20181217231700.24482-1-pbonzini@redhat.com>
References: <20181217231700.24482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 32/35] hw/watchdog/wdt_i6300esb: remove a
 unnecessary comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peng Hao <peng.hao2@zte.com.cn>

From: Peng Hao <peng.hao2@zte.com.cn>

The registered memory region of i6300esb is not suitable for coalesced
mmio, because a write for the region may trigger an immediate action
and can't be delayed.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Message-Id: <1544253511-82742-1-git-send-email-peng.hao2@zte.com.cn>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/watchdog/wdt_i6300esb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/watchdog/wdt_i6300esb.c b/hw/watchdog/wdt_i6300esb.c
index 7b59469888..1c6eddf86a 100644
--- a/hw/watchdog/wdt_i6300esb.c
+++ b/hw/watchdog/wdt_i6300esb.c
@@ -449,7 +449,6 @@ static void i6300esb_realize(PCIDevice *dev, Error **=
errp)
     memory_region_init_io(&d->io_mem, OBJECT(d), &i6300esb_ops, d,
                           "i6300esb", 0x10);
     pci_register_bar(&d->dev, 0, 0, &d->io_mem);
-    /* qemu_register_coalesced_mmio (addr, 0x10); ? */
 }
=20
 static void i6300esb_exit(PCIDevice *dev)
--=20
2.20.1
