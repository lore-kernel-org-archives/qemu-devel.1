Received: from eggs.gnu.org ([2001:4830:134:3::10]:55648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJCm-0007n3-3N
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJCk-0001n7-Q2
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:35 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41551)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gXJCk-0001Ti-EI
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:34 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 13 Dec 2018 00:04:08 -0500
Message-Id: <20181213050453.9677-29-cota@braap.org>
In-Reply-To: <20181213050453.9677-1-cota@braap.org>
References: <20181213050453.9677-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 28/73] gdbstub: convert to cpu_halted
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
 gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdbstub.c b/gdbstub.c
index c4e4f9f082..4e809ceddb 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1304,7 +1304,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
                 /* memtohex() doubles the required space */
                 len = snprintf((char *)mem_buf, sizeof(buf) / 2,
                                "CPU#%d [%s]", cpu->cpu_index,
-                               cpu->halted ? "halted " : "running");
+                               cpu_halted(cpu) ? "halted " : "running");
                 trace_gdbstub_op_extra_info((char *)mem_buf);
                 memtohex(buf, mem_buf, len);
                 put_packet(s, buf);
-- 
2.17.1
