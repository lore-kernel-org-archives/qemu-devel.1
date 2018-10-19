Received: from eggs.gnu.org ([2001:4830:134:3::10]:58842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFZ-0004cj-Qa
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFX-00031X-Hs
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:49 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:53185)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gDJFW-0002lR-W5
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:47 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 18 Oct 2018 21:05:49 -0400
Message-Id: <20181019010625.25294-21-cota@braap.org>
In-Reply-To: <20181019010625.25294-1-cota@braap.org>
References: <20181019010625.25294-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v3 20/56] gdbstub: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdbstub.c b/gdbstub.c
index c8478de8f5..a5ff50d9e7 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1305,7 +1305,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
