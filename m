Received: from eggs.gnu.org ([209.51.188.92]:53414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwtcA-0004fT-IX
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 14:02:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwtc9-0001xZ-PD
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 14:02:34 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:43799)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwtc9-0001xB-IZ
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 14:02:33 -0500
Received: by mail-pl1-x631.google.com with SMTP id m10so4943518plt.10
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 11:02:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 21 Feb 2019 11:02:28 -0800
Message-Id: <20190221190229.22599-2-richard.henderson@linaro.org>
In-Reply-To: <20190221190229.22599-1-richard.henderson@linaro.org>
References: <20190221190229.22599-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 1/2] tcg: Remove TODO file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

The last update to this file was 9 years ago.  In the meantime,
4 of the 6 ideas have actually been completed.  The lat two do
not actually make sense anymore.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/TODO | 14 --------------
 1 file changed, 14 deletions(-)
 delete mode 100644 tcg/TODO

diff --git a/tcg/TODO b/tcg/TODO
deleted file mode 100644
index 074784778e..0000000000
--- a/tcg/TODO
+++ /dev/null
@@ -1,14 +0,0 @@
-- Add new instructions such as: clz, ctz, popcnt.
-
-- See if it is worth exporting mul2, mulu2, div2, divu2. 
-
-- Support of globals saved in fixed registers between TBs.
-
-Ideas:
-
-- Move the slow part of the qemu_ld/st ops after the end of the TB.
-
-- Change exception syntax to get closer to QOP system (exception
-  parameters given with a specific instruction).
-
-- Add float and vector support.
-- 
2.17.2
