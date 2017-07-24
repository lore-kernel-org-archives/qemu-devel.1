Received: from eggs.gnu.org ([2001:4830:134:3::10]:47781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZjxW-0002zB-PF
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZjxT-0000n7-0h
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:06 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:37580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dZjxS-0000m6-Sr
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:02 -0400
Received: by mail-qt0-x243.google.com with SMTP id d10so1340103qtb.4
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 13:28:02 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 24 Jul 2017 13:26:57 -0700
Message-Id: <20170724202728.25960-2-rth@twiddle.net>
In-Reply-To: <20170724202728.25960-1-rth@twiddle.net>
References: <20170724202728.25960-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v15 01/32] tcg: Add generic DISAS_NORETURN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, vilanova@ac.upc.edu

This will allow some amount of cleanup to happen before
switching the backends over to enum DisasJumpType.

Reviewed-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Lluís Vilanova <vilanova@ac.upc.edu>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 include/exec/exec-all.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 440fc31b37..b434988979 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -63,6 +63,7 @@ typedef ram_addr_t tb_page_addr_t;
 #define DISAS_JUMP    1 /* only pc was modified dynamically */
 #define DISAS_TB_JUMP 2 /* only pc was modified statically */
 #define DISAS_UPDATE  3 /* cpu state was modified dynamically */
+#define DISAS_NORETURN 4 /* the tb has already been exited */
 
 #include "qemu/log.h"
 
-- 
2.13.3
