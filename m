Received: from eggs.gnu.org ([209.51.188.92]:59623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzEBg-0005g2-8Y
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 00:24:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzEBe-0003mp-8c
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 00:24:52 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42295)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzEBc-0003ie-74
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 00:24:50 -0500
Received: by mail-pl1-x644.google.com with SMTP id v11so3735235plg.9
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 21:24:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 27 Feb 2019 21:24:27 -0800
Message-Id: <20190228052432.32571-4-richard.henderson@linaro.org>
In-Reply-To: <20190228052432.32571-1-richard.henderson@linaro.org>
References: <20190228052432.32571-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 3/8] decodetree: Document the usefulness of
 argument sets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de, f4bug@amsat.org

Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/devel/decodetree.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/docs/devel/decodetree.rst b/docs/devel/decodetree.rst
index d9be30b2db..62cb7f687c 100644
--- a/docs/devel/decodetree.rst
+++ b/docs/devel/decodetree.rst
@@ -69,6 +69,13 @@ with each of the fields being one of the member arguments.
 If ``!extern`` is specified, the backing structure is assumed
 to have been already declared, typically via a second decoder.
 
+Argument sets are useful when one wants to define helper functions
+for the translator functions that can perform operations on a common
+set of arguments.  This can ensure, for instance, that the ``AND``
+pattern and the ``OR`` pattern put their operands into the same named
+structure, so that a common ``gen_logic_insn`` may be able to handle
+the operations common between the two.
+
 Argument set examples::
 
   &reg3       ra rb rc
-- 
2.17.2
