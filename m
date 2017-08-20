Received: from eggs.gnu.org ([2001:4830:134:3::10]:44717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1djY3e-0007Fd-99
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 17:46:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1djY3a-0003q2-Bs
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 17:46:58 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:36557)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1djY3a-0003pG-5D
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 17:46:54 -0400
Received: by mail-pg0-x243.google.com with SMTP id y129so20854746pgy.3
	for <qemu-devel@nongnu.org>; Sun, 20 Aug 2017 14:46:51 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Sun, 20 Aug 2017 16:46:40 -0500
Message-Id: <1503265602-9349-2-git-send-email-minyard@acm.org>
In-Reply-To: <1503265602-9349-1-git-send-email-minyard@acm.org>
References: <1503265602-9349-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH v2 1/3] ipmi: Fix SEL get/set time commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

The minimum message size was on the wrong commands, for getting
the time it's zero and for setting the time it's 6.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/ipmi/ipmi_bmc_sim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 277c28c..cc068f2 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -1802,8 +1802,8 @@ static const IPMICmdHandler storage_cmds[] = {
     [IPMI_CMD_GET_SEL_ENTRY] = { get_sel_entry, 8 },
     [IPMI_CMD_ADD_SEL_ENTRY] = { add_sel_entry, 18 },
     [IPMI_CMD_CLEAR_SEL] = { clear_sel, 8 },
-    [IPMI_CMD_GET_SEL_TIME] = { get_sel_time, 6 },
-    [IPMI_CMD_SET_SEL_TIME] = { set_sel_time },
+    [IPMI_CMD_GET_SEL_TIME] = { get_sel_time },
+    [IPMI_CMD_SET_SEL_TIME] = { set_sel_time, 6 },
 };
 
 static const IPMINetfn storage_netfn = {
-- 
2.7.4
