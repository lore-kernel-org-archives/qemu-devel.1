Received: from eggs.gnu.org ([2001:4830:134:3::10]:36346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ehJyz-0003Eg-9U
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:53:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ehJyy-00008e-Jj
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:53:13 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:45711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1ehJyy-00007N-Em
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:53:12 -0500
Received: by mail-ot0-x241.google.com with SMTP id 73so8756299oti.12
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 10:53:12 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu,  1 Feb 2018 12:52:57 -0600
Message-Id: <1517511182-9944-3-git-send-email-minyard@acm.org>
In-Reply-To: <1517511182-9944-1-git-send-email-minyard@acm.org>
References: <1517511182-9944-1-git-send-email-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/7] ipmi: Fix SEL get/set time commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

The minimum message size was on the wrong commands, for getting
the time it's zero and for setting the time it's 6.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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
