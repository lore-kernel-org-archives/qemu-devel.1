Received: from eggs.gnu.org ([2001:4830:134:3::10]:59080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ctdrx-00015L-Q5
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 13:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ctdru-0000vk-I0
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 13:28:21 -0400
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu, 30 Mar 2017 12:28:12 -0500
Message-Id: <1490894892-8055-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH v2 resend] ipmi: Fix macro issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Ed Maste <emaste@freebsd.org>, Eric Blake <eblake@redhat.com>, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Macro parameters should almost always have () around them when used.
llvm reported an error on this.

Remove redundant parenthesis and put parenthesis around the entire
macros with assignments in case they are used in an expression.

Remove some unused macros.

Reported in https://bugs.launchpad.net/bugs/1651167

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 hw/ipmi/isa_ipmi_bt.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index 1c69cb3..2fcc3d2 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -37,40 +37,30 @@
 #define IPMI_BT_HBUSY_BIT          6
 #define IPMI_BT_BBUSY_BIT          7
 
-#define IPMI_BT_CLR_WR_MASK        (1 << IPMI_BT_CLR_WR_BIT)
 #define IPMI_BT_GET_CLR_WR(d)      (((d) >> IPMI_BT_CLR_WR_BIT) & 0x1)
-#define IPMI_BT_SET_CLR_WR(d, v)   (d) = (((d) & ~IPMI_BT_CLR_WR_MASK) | \
-                                       (((v & 1) << IPMI_BT_CLR_WR_BIT)))
 
-#define IPMI_BT_CLR_RD_MASK        (1 << IPMI_BT_CLR_RD_BIT)
 #define IPMI_BT_GET_CLR_RD(d)      (((d) >> IPMI_BT_CLR_RD_BIT) & 0x1)
-#define IPMI_BT_SET_CLR_RD(d, v)   (d) = (((d) & ~IPMI_BT_CLR_RD_MASK) | \
-                                       (((v & 1) << IPMI_BT_CLR_RD_BIT)))
 
-#define IPMI_BT_H2B_ATN_MASK       (1 << IPMI_BT_H2B_ATN_BIT)
 #define IPMI_BT_GET_H2B_ATN(d)     (((d) >> IPMI_BT_H2B_ATN_BIT) & 0x1)
-#define IPMI_BT_SET_H2B_ATN(d, v)  (d) = (((d) & ~IPMI_BT_H2B_ATN_MASK) | \
-                                        (((v & 1) << IPMI_BT_H2B_ATN_BIT)))
 
 #define IPMI_BT_B2H_ATN_MASK       (1 << IPMI_BT_B2H_ATN_BIT)
 #define IPMI_BT_GET_B2H_ATN(d)     (((d) >> IPMI_BT_B2H_ATN_BIT) & 0x1)
-#define IPMI_BT_SET_B2H_ATN(d, v)  (d) = (((d) & ~IPMI_BT_B2H_ATN_MASK) | \
-                                        (((v & 1) << IPMI_BT_B2H_ATN_BIT)))
+#define IPMI_BT_SET_B2H_ATN(d, v)  ((d) = (((d) & ~IPMI_BT_B2H_ATN_MASK) | \
+                                        (((v) & 1) << IPMI_BT_B2H_ATN_BIT)))
 
 #define IPMI_BT_SMS_ATN_MASK       (1 << IPMI_BT_SMS_ATN_BIT)
 #define IPMI_BT_GET_SMS_ATN(d)     (((d) >> IPMI_BT_SMS_ATN_BIT) & 0x1)
-#define IPMI_BT_SET_SMS_ATN(d, v)  (d) = (((d) & ~IPMI_BT_SMS_ATN_MASK) | \
-                                        (((v & 1) << IPMI_BT_SMS_ATN_BIT)))
+#define IPMI_BT_SET_SMS_ATN(d, v)  ((d) = (((d) & ~IPMI_BT_SMS_ATN_MASK) | \
+                                        (((v) & 1) << IPMI_BT_SMS_ATN_BIT)))
 
 #define IPMI_BT_HBUSY_MASK         (1 << IPMI_BT_HBUSY_BIT)
 #define IPMI_BT_GET_HBUSY(d)       (((d) >> IPMI_BT_HBUSY_BIT) & 0x1)
-#define IPMI_BT_SET_HBUSY(d, v)    (d) = (((d) & ~IPMI_BT_HBUSY_MASK) | \
-                                       (((v & 1) << IPMI_BT_HBUSY_BIT)))
+#define IPMI_BT_SET_HBUSY(d, v)    ((d) = (((d) & ~IPMI_BT_HBUSY_MASK) | \
+                                       (((v) & 1) << IPMI_BT_HBUSY_BIT)))
 
 #define IPMI_BT_BBUSY_MASK         (1 << IPMI_BT_BBUSY_BIT)
-#define IPMI_BT_GET_BBUSY(d)       (((d) >> IPMI_BT_BBUSY_BIT) & 0x1)
-#define IPMI_BT_SET_BBUSY(d, v)    (d) = (((d) & ~IPMI_BT_BBUSY_MASK) | \
-                                       (((v & 1) << IPMI_BT_BBUSY_BIT)))
+#define IPMI_BT_SET_BBUSY(d, v)    ((d) = (((d) & ~IPMI_BT_BBUSY_MASK) | \
+                                       (((v) & 1) << IPMI_BT_BBUSY_BIT)))
 
 
 /* Mask register */
@@ -79,13 +69,13 @@
 
 #define IPMI_BT_B2H_IRQ_EN_MASK      (1 << IPMI_BT_B2H_IRQ_EN_BIT)
 #define IPMI_BT_GET_B2H_IRQ_EN(d)    (((d) >> IPMI_BT_B2H_IRQ_EN_BIT) & 0x1)
-#define IPMI_BT_SET_B2H_IRQ_EN(d, v) (d) = (((d) & ~IPMI_BT_B2H_IRQ_EN_MASK) | \
-                                        (((v & 1) << IPMI_BT_B2H_IRQ_EN_BIT)))
+#define IPMI_BT_SET_B2H_IRQ_EN(d, v) ((d) = (((d) & ~IPMI_BT_B2H_IRQ_EN_MASK) |\
+                                        (((v) & 1) << IPMI_BT_B2H_IRQ_EN_BIT)))
 
 #define IPMI_BT_B2H_IRQ_MASK         (1 << IPMI_BT_B2H_IRQ_BIT)
 #define IPMI_BT_GET_B2H_IRQ(d)       (((d) >> IPMI_BT_B2H_IRQ_BIT) & 0x1)
-#define IPMI_BT_SET_B2H_IRQ(d, v)    (d) = (((d) & ~IPMI_BT_B2H_IRQ_MASK) | \
-                                        (((v & 1) << IPMI_BT_B2H_IRQ_BIT)))
+#define IPMI_BT_SET_B2H_IRQ(d, v)    ((d) = (((d) & ~IPMI_BT_B2H_IRQ_MASK) | \
+                                        (((v) & 1) << IPMI_BT_B2H_IRQ_BIT)))
 
 typedef struct IPMIBT {
     IPMIBmc *bmc;
-- 
2.7.4
