Received: from eggs.gnu.org ([2001:4830:134:3::10]:58996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e20Ed-0000rV-Mb
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:30:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e20Ec-00059a-Jr
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:30:35 -0400
Received: from mail-pf0-x22b.google.com ([2607:f8b0:400e:c00::22b]:54761)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e20Ec-000599-FR
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:30:34 -0400
Received: by mail-pf0-x22b.google.com with SMTP id m28so13340485pfi.11
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 12:30:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 10 Oct 2017 12:30:03 -0700
Message-Id: <20171010193003.28857-21-richard.henderson@linaro.org>
In-Reply-To: <20171010193003.28857-1-richard.henderson@linaro.org>
References: <20171010193003.28857-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL v2 20/20] tcg/mips: delete commented out extern
 keyword.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jiang Biao <jiang.biao2@zte.com.cn>

From: Jiang Biao <jiang.biao2@zte.com.cn>

Delete commented out extern keyword on link_error().

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
Message-Id: <1506762042-32145-1-git-send-email-jiang.biao2@zte.com.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index e993138930..4b55ab8856 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -36,7 +36,7 @@
 #else
 /* To assert at compile-time that these values are never used
    for TCG_TARGET_REG_BITS == 64.  */
-/* extern */ int link_error(void);
+int link_error(void);
 # define LO_OFF  link_error()
 # define HI_OFF  link_error()
 #endif
-- 
2.13.6
