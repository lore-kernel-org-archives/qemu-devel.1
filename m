Received: from eggs.gnu.org ([2001:4830:134:3::10]:32796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dq8gg-0003c4-Vz
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dq8gb-0002So-Ne
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:06:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dq8gb-0002SJ-EF
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:06:25 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Fri,  8 Sep 2017 10:05:18 +0800
Message-Id: <1504836324-4871-13-git-send-email-jasowang@redhat.com>
In-Reply-To: <1504836324-4871-1-git-send-email-jasowang@redhat.com>
References: <1504836324-4871-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 12/18] e1000: Rename the SEC symbol to SEQEC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Kamil Rytarowski <n54@gmx.com>, Jason Wang <jasowang@redhat.com>

From: Kamil Rytarowski <n54@gmx.com>

SunOS defines SEC in <sys/time.h> as 1 (commonly used time symbols).

This fixes build on SmartOS (Joyent).

Patch cherry-picked from pkgsrc by jperkin (Joyent).

Signed-off-by: Kamil Rytarowski <n54@gmx.com>
Reviewed-by: Dmitry Fleytman <dmitry@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/e1000.c         | 4 ++--
 hw/net/e1000_regs.h    | 2 +-
 hw/net/e1000e_core.c   | 2 +-
 hw/net/e1000x_common.h | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index f2e5072..eebe3a9 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -1127,7 +1127,7 @@ static uint32_t (*macreg_readops[])(E1000State *, int) = {
     getreg(TADV),     getreg(ITR),      getreg(FCRUC),    getreg(IPAV),
     getreg(WUC),      getreg(WUS),      getreg(SCC),      getreg(ECOL),
     getreg(MCC),      getreg(LATECOL),  getreg(COLC),     getreg(DC),
-    getreg(TNCRS),    getreg(SEC),      getreg(CEXTERR),  getreg(RLEC),
+    getreg(TNCRS),    getreg(SEQEC),    getreg(CEXTERR),  getreg(RLEC),
     getreg(XONRXC),   getreg(XONTXC),   getreg(XOFFRXC),  getreg(XOFFTXC),
     getreg(RFC),      getreg(RJC),      getreg(RNBC),     getreg(TSCTFC),
     getreg(MGTPRC),   getreg(MGTPDC),   getreg(MGTPTC),   getreg(GORCL),
@@ -1223,7 +1223,7 @@ static const uint8_t mac_reg_access[0x8000] = {
     [FFLT]    = markflag(MAC),    [FFMT]    = markflag(MAC),
     [SCC]     = markflag(MAC),    [FCRUC]   = markflag(MAC),
     [LATECOL] = markflag(MAC),    [COLC]    = markflag(MAC),
-    [SEC]     = markflag(MAC),    [CEXTERR] = markflag(MAC),
+    [SEQEC]   = markflag(MAC),    [CEXTERR] = markflag(MAC),
     [XONTXC]  = markflag(MAC),    [XOFFRXC] = markflag(MAC),
     [RJC]     = markflag(MAC),    [RNBC]    = markflag(MAC),
     [MGTPDC]  = markflag(MAC),    [MGTPTC]  = markflag(MAC),
diff --git a/hw/net/e1000_regs.h b/hw/net/e1000_regs.h
index 23eed50..ae99f58 100644
--- a/hw/net/e1000_regs.h
+++ b/hw/net/e1000_regs.h
@@ -260,7 +260,7 @@
 #define E1000_COLC     0x04028  /* Collision Count - R/clr */
 #define E1000_DC       0x04030  /* Defer Count - R/clr */
 #define E1000_TNCRS    0x04034  /* TX-No CRS - R/clr */
-#define E1000_SEC      0x04038  /* Sequence Error Count - R/clr */
+#define E1000_SEQEC    0x04038  /* Sequence Error Count - R/clr */
 #define E1000_CEXTERR  0x0403C  /* Carrier Extension Error Count - R/clr */
 #define E1000_RLEC     0x04040  /* Receive Length Error Count - R/clr */
 #define E1000_XONRXC   0x04048  /* XON RX Count - R/clr */
diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 8140564..43a8d89 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -2855,7 +2855,7 @@ static uint32_t (*e1000e_macreg_readops[])(E1000ECore *, int) = {
     e1000e_getreg(RDLEN0),
     e1000e_getreg(RDH1),
     e1000e_getreg(LATECOL),
-    e1000e_getreg(SEC),
+    e1000e_getreg(SEQEC),
     e1000e_getreg(XONTXC),
     e1000e_getreg(WUS),
     e1000e_getreg(GORCL),
diff --git a/hw/net/e1000x_common.h b/hw/net/e1000x_common.h
index 21bf28e..3072ce9 100644
--- a/hw/net/e1000x_common.h
+++ b/hw/net/e1000x_common.h
@@ -40,7 +40,7 @@ enum {
     defreg(VFTA),    defreg(VET),     defreg(RDTR),    defreg(RADV),
     defreg(TADV),    defreg(ITR),     defreg(SCC),     defreg(ECOL),
     defreg(MCC),     defreg(LATECOL), defreg(COLC),    defreg(DC),
-    defreg(TNCRS),   defreg(SEC),     defreg(CEXTERR), defreg(RLEC),
+    defreg(TNCRS),   defreg(SEQEC),   defreg(CEXTERR), defreg(RLEC),
     defreg(XONRXC),  defreg(XONTXC),  defreg(XOFFRXC), defreg(XOFFTXC),
     defreg(FCRUC),   defreg(AIT),     defreg(TDFH),    defreg(TDFT),
     defreg(TDFHS),   defreg(TDFTS),   defreg(TDFPC),   defreg(WUC),
-- 
2.7.4
