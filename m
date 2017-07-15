Received: from eggs.gnu.org ([2001:4830:134:3::10]:38015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJbE-0003XP-QY
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:42:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJbE-0003BH-1P
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:42:56 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:36131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWJbD-0003B5-Rw
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:42:55 -0400
Received: by mail-pg0-x242.google.com with SMTP id y129so13364630pgy.3
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 02:42:55 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 14 Jul 2017 23:42:11 -1000
Message-Id: <20170715094243.28371-3-rth@twiddle.net>
In-Reply-To: <20170715094243.28371-1-rth@twiddle.net>
References: <20170715094243.28371-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v14 02/34] tcg: Add generic DISAS_NORETURN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vilanova@ac.upc.edu, cota@braap.org, alex.bennee@linaro.org, crosthwaite.peter@gmail.com, pbonzini@redhat.com

This will allow some amount of cleanup to happen before
switching the backends over to enum DisasJumpType.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 include/exec/exec-all.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 48d9d11..6760078 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -40,6 +40,7 @@ typedef ram_addr_t tb_page_addr_t;
 #define DISAS_JUMP    1 /* only pc was modified dynamically */
 #define DISAS_UPDATE  2 /* cpu state was modified dynamically */
 #define DISAS_TB_JUMP 3 /* only pc was modified statically */
+#define DISAS_NORETURN 4 /* the tb has already been exited */
 
 #include "qemu/log.h"
 
-- 
2.9.4
