Received: from eggs.gnu.org ([2001:4830:134:3::10]:48544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gAQZg-00028l-4m
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 22:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gAQZc-0004JQ-38
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 22:19:40 -0400
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu, 11 Oct 2018 04:19:20 +0200
Message-Id: <20181011021931.4249-2-edgar.iglesias@gmail.com>
In-Reply-To: <20181011021931.4249-1-edgar.iglesias@gmail.com>
References: <20181011021931.4249-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v2 01/12] net: cadence_gem: Disable TSU feature
 bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, philmd@redhat.com, frasse.iglesias@gmail.com, figlesia@xilinx.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Disable the Timestamping Unit feature bit since QEMU does not
yet support it. This allows guest SW to correctly probe for
its existance.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/net/cadence_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 0fa4b0dc44..e560b7a142 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1228,7 +1228,7 @@ static void gem_reset(DeviceState *d)
     s->regs[GEM_MODID] = s->revision;
     s->regs[GEM_DESCONF] = 0x02500111;
     s->regs[GEM_DESCONF2] = 0x2ab13fff;
-    s->regs[GEM_DESCONF5] = 0x002f2145;
+    s->regs[GEM_DESCONF5] = 0x002f2045;
     s->regs[GEM_DESCONF6] = 0x00000200;
 
     /* Set MAC address */
-- 
2.17.1
