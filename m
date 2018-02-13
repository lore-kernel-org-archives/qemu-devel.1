Received: from eggs.gnu.org ([2001:4830:134:3::10]:40097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <t.pageflt@gmail.com>) id 1elZF8-0002um-QA
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 06:59:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <t.pageflt@gmail.com>) id 1elZF5-0005ok-Ie
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 06:59:26 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:54732)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <t.pageflt@gmail.com>) id 1elZF5-0005lM-Ca
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 06:59:23 -0500
Received: by mail-wm0-x243.google.com with SMTP id i186so15503794wmi.4
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 03:59:22 -0800 (PST)
From: Dimitris Karagkasidis <t.pageflt@gmail.com>
Message-ID: <807b2724-7a5f-9d62-55aa-b5b3cf0c9503@gmail.com>
Date: Tue, 13 Feb 2018 12:59:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] monitor.c: Fix infinite loop in monitor's
 auto-complete functionality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

The QEMU monitor enters an infinite loop when trying to auto-complete commands
that accept only optional parameters. The commands currently affected by this
issue are 'info registers' and 'info mtree'.

Signed-off-by: Dimitris Karagkasidis <t.pagef.lt@gmail.com>
---
 monitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index f4992505b1..d8b7270d9b 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3741,7 +3741,7 @@ static void monitor_find_completion_by_table(Monitor *mon,
             }
         }
         str = args[nb_args - 1];
-        while (*ptype == '-' && ptype[1] != '\0') {
+        while (*ptype == '-' && ptype[2] != '\0') {
             ptype = next_arg_type(ptype);
         }
         switch(*ptype) {
-- 
2.14.1
