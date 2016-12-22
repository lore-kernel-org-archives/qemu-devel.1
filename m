Received: from eggs.gnu.org ([2001:4830:134:3::10]:54060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cK4Og-0007dB-3a
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 09:31:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cK4Ob-00087e-An
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 09:31:06 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:34132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1cK4Ob-00087T-5P
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 09:31:01 -0500
Received: by mail-oi0-x242.google.com with SMTP id 3so4088330oih.1
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 06:31:01 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu, 22 Dec 2016 08:30:47 -0600
Message-Id: <1482417047-15588-1-git-send-email-minyard@acm.org>
In-Reply-To: <20161219154752.14563.46483.malonedeb@wampee.canonical.com>
References: <20161219154752.14563.46483.malonedeb@wampee.canonical.com>
Subject: [Qemu-devel] [PATCH] ipmi: Add parenthesis around some macro
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1651167 <1651167@bugs.launchpad.net>, qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Macro parameters should almost always have () around them when used.
llvm reported an error on this.

Reported in https://bugs.launchpad.net/bugs/1651167

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/ipmi/isa_ipmi_bt.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index f036617..8a97314 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -40,37 +40,37 @@
 #define IPMI_BT_CLR_WR_MASK        (1 << IPMI_BT_CLR_WR_BIT)
 #define IPMI_BT_GET_CLR_WR(d)      (((d) >> IPMI_BT_CLR_WR_BIT) & 0x1)
 #define IPMI_BT_SET_CLR_WR(d, v)   (d) = (((d) & ~IPMI_BT_CLR_WR_MASK) | \
-                                       (((v & 1) << IPMI_BT_CLR_WR_BIT)))
+                                       ((((v) & 1) << IPMI_BT_CLR_WR_BIT)))
 
 #define IPMI_BT_CLR_RD_MASK        (1 << IPMI_BT_CLR_RD_BIT)
 #define IPMI_BT_GET_CLR_RD(d)      (((d) >> IPMI_BT_CLR_RD_BIT) & 0x1)
 #define IPMI_BT_SET_CLR_RD(d, v)   (d) = (((d) & ~IPMI_BT_CLR_RD_MASK) | \
-                                       (((v & 1) << IPMI_BT_CLR_RD_BIT)))
+                                       ((((v) & 1) << IPMI_BT_CLR_RD_BIT)))
 
 #define IPMI_BT_H2B_ATN_MASK       (1 << IPMI_BT_H2B_ATN_BIT)
 #define IPMI_BT_GET_H2B_ATN(d)     (((d) >> IPMI_BT_H2B_ATN_BIT) & 0x1)
 #define IPMI_BT_SET_H2B_ATN(d, v)  (d) = (((d) & ~IPMI_BT_H2B_ATN_MASK) | \
-                                        (((v & 1) << IPMI_BT_H2B_ATN_BIT)))
+                                        ((((v) & 1) << IPMI_BT_H2B_ATN_BIT)))
 
 #define IPMI_BT_B2H_ATN_MASK       (1 << IPMI_BT_B2H_ATN_BIT)
 #define IPMI_BT_GET_B2H_ATN(d)     (((d) >> IPMI_BT_B2H_ATN_BIT) & 0x1)
 #define IPMI_BT_SET_B2H_ATN(d, v)  (d) = (((d) & ~IPMI_BT_B2H_ATN_MASK) | \
-                                        (((v & 1) << IPMI_BT_B2H_ATN_BIT)))
+                                        ((((v) & 1) << IPMI_BT_B2H_ATN_BIT)))
 
 #define IPMI_BT_SMS_ATN_MASK       (1 << IPMI_BT_SMS_ATN_BIT)
 #define IPMI_BT_GET_SMS_ATN(d)     (((d) >> IPMI_BT_SMS_ATN_BIT) & 0x1)
 #define IPMI_BT_SET_SMS_ATN(d, v)  (d) = (((d) & ~IPMI_BT_SMS_ATN_MASK) | \
-                                        (((v & 1) << IPMI_BT_SMS_ATN_BIT)))
+                                        ((((v) & 1) << IPMI_BT_SMS_ATN_BIT)))
 
 #define IPMI_BT_HBUSY_MASK         (1 << IPMI_BT_HBUSY_BIT)
 #define IPMI_BT_GET_HBUSY(d)       (((d) >> IPMI_BT_HBUSY_BIT) & 0x1)
 #define IPMI_BT_SET_HBUSY(d, v)    (d) = (((d) & ~IPMI_BT_HBUSY_MASK) | \
-                                       (((v & 1) << IPMI_BT_HBUSY_BIT)))
+                                       ((((v) & 1) << IPMI_BT_HBUSY_BIT)))
 
 #define IPMI_BT_BBUSY_MASK         (1 << IPMI_BT_BBUSY_BIT)
 #define IPMI_BT_GET_BBUSY(d)       (((d) >> IPMI_BT_BBUSY_BIT) & 0x1)
 #define IPMI_BT_SET_BBUSY(d, v)    (d) = (((d) & ~IPMI_BT_BBUSY_MASK) | \
-                                       (((v & 1) << IPMI_BT_BBUSY_BIT)))
+                                       ((((v) & 1) << IPMI_BT_BBUSY_BIT)))
 
 
 /* Mask register */
@@ -80,12 +80,12 @@
 #define IPMI_BT_B2H_IRQ_EN_MASK      (1 << IPMI_BT_B2H_IRQ_EN_BIT)
 #define IPMI_BT_GET_B2H_IRQ_EN(d)    (((d) >> IPMI_BT_B2H_IRQ_EN_BIT) & 0x1)
 #define IPMI_BT_SET_B2H_IRQ_EN(d, v) (d) = (((d) & ~IPMI_BT_B2H_IRQ_EN_MASK) | \
-                                        (((v & 1) << IPMI_BT_B2H_IRQ_EN_BIT)))
+                                        ((((v) & 1) << IPMI_BT_B2H_IRQ_EN_BIT)))
 
 #define IPMI_BT_B2H_IRQ_MASK         (1 << IPMI_BT_B2H_IRQ_BIT)
 #define IPMI_BT_GET_B2H_IRQ(d)       (((d) >> IPMI_BT_B2H_IRQ_BIT) & 0x1)
 #define IPMI_BT_SET_B2H_IRQ(d, v)    (d) = (((d) & ~IPMI_BT_B2H_IRQ_MASK) | \
-                                        (((v & 1) << IPMI_BT_B2H_IRQ_BIT)))
+                                        ((((v) & 1) << IPMI_BT_B2H_IRQ_BIT)))
 
 typedef struct IPMIBT {
     IPMIBmc *bmc;
-- 
2.7.4
