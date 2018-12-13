Received: from eggs.gnu.org ([2001:4830:134:3::10]:55665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJCm-0007ng-Ig
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJCl-0001oI-A9
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:36 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39477)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gXJCk-0001Ui-UD
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:35 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 13 Dec 2018 00:04:14 -0500
Message-Id: <20181213050453.9677-35-cota@braap.org>
In-Reply-To: <20181213050453.9677-1-cota@braap.org>
References: <20181213050453.9677-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 34/73] exec: use cpu_reset_interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index bb6170dbff..04d505500b 100644
--- a/exec.c
+++ b/exec.c
@@ -776,7 +776,7 @@ static int cpu_common_post_load(void *opaque, int version_id)
 
     /* 0x01 was CPU_INTERRUPT_EXIT. This line can be removed when the
        version_id is increased. */
-    cpu->interrupt_request &= ~0x01;
+    cpu_reset_interrupt(cpu, 1);
     tlb_flush(cpu);
 
     /* loadvm has just updated the content of RAM, bypassing the
-- 
2.17.1
