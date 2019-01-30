Received: from eggs.gnu.org ([209.51.188.92]:35481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe3i-0008MH-UA
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe3h-00016h-KW
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:54 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56785)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1goe3g-0000tH-U3
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:53 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:47:26 -0500
Message-Id: <20190130004811.27372-29-cota@braap.org>
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 28/73] gdbstub: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 gdbstub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 3129b5c284..91790112a2 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1659,13 +1659,13 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
                         object_get_canonical_path_component(OBJECT(cpu));
                     len = snprintf((char *)mem_buf, sizeof(buf) / 2,
                                    "%s %s [%s]", cpu_model, cpu_name,
-                                   cpu->halted ? "halted " : "running");
+                                   cpu_halted(cpu) ? "halted " : "running");
                     g_free(cpu_name);
                 } else {
                     /* memtohex() doubles the required space */
                     len = snprintf((char *)mem_buf, sizeof(buf) / 2,
                                    "CPU#%d [%s]", cpu->cpu_index,
-                                   cpu->halted ? "halted " : "running");
+                                   cpu_halted(cpu) ? "halted " : "running");
                 }
                 trace_gdbstub_op_extra_info((char *)mem_buf);
                 memtohex(buf, mem_buf, len);
-- 
2.17.1
