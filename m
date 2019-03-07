Received: from eggs.gnu.org ([209.51.188.92]:36590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1yBy-0001CJ-KF
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1yBx-0002NT-PG
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:30 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1yBx-0002MJ-HH
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:29 -0500
Received: by mail-pg1-x541.google.com with SMTP id i130so11979805pgd.1
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 10:56:29 -0800 (PST)
Received: from cloudburst.twiddle.net (97-113-188-82.tukw.qwest.net.
	[97.113.188.82]) by smtp.gmail.com with ESMTPSA id
	g12sm8801973pgr.76.2019.03.07.10.56.27 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 07 Mar 2019 10:56:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Mar 2019 10:56:13 -0800
Message-Id: <20190307185622.29026-4-richard.henderson@linaro.org>
In-Reply-To: <20190307185622.29026-1-richard.henderson@linaro.org>
References: <20190307185622.29026-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 03/12] decodetree: Document the usefulness
 of argument sets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
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
