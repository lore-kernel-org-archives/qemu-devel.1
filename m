Received: from eggs.gnu.org ([2001:4830:134:3::10]:53176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fBMQb-0006mj-Tx
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:33:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fBMQY-0004eU-MO
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:33:53 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:34477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fBMQY-0004c7-EL
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:33:50 -0400
Received: by mail-wr0-x244.google.com with SMTP id p18-v6so34571770wrm.1
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 08:33:50 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 25 Apr 2018 16:33:43 +0100
Message-Id: <20180425153343.24023-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH] hw/core: expand description of null-machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

People following old instructions for QEMU get the message "No machine
specified, and there is no default" and run -machine help to pick a
new machine. Lay people might consider the null-machine to be such a
basic starting point but they won't get far. This leads to confusion,
see https://bugs.launchpad.net/qemu/+bug/1766896 as an example.

I'm open to better words - I figured "THIS PROBABLY ISN'T WHAT YOU
WANT" seemed less helpful though.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/core/null-machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index cde4d3eb57..72f0815045 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -50,7 +50,7 @@ static void machine_none_init(MachineState *mch)
 
 static void machine_none_machine_init(MachineClass *mc)
 {
-    mc->desc = "empty machine";
+    mc->desc = "empty machine (for probing/QMP)";
     mc->init = machine_none_init;
     mc->max_cpus = 1;
     mc->default_ram_size = 0;
-- 
2.17.0
