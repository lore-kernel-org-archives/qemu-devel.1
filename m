Received: from eggs.gnu.org ([2001:4830:134:3::10]:36555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gTl73-0003dw-Ou
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:06:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gTl6y-0004DL-E8
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:06:01 -0500
From: Roman Bolshakov <r.bolshakov@yadro.com>
Date: Mon, 3 Dec 2018 13:04:15 +0300
Message-ID: <20181203100415.53027-2-r.bolshakov@yadro.com>
In-Reply-To: <20181203100415.53027-1-r.bolshakov@yadro.com>
References: <20181203100415.53027-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-3.1 2/2] i386: hvf: drop debug printf in
 decode_sldtgroup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Roman Bolshakov <r.bolshakov@yadro.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

It's going to clutter QEMU logs if 0x0f00 is trapped.

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 target/i386/hvf/x86_decode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index d125a6ef83..5f513c5563 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -525,8 +525,6 @@ static void decode_sldtgroup(CPUX86State *env, struct x86_decode *decode)
         X86_DECODE_CMD_INVL
     };
     decode->cmd = group[decode->modrm.reg];
-    printf("%llx: decode_sldtgroup: %d\n", env->hvf_emul->fetch_rip,
-            decode->modrm.reg);
 }
 
 static void decode_lidtgroup(CPUX86State *env, struct x86_decode *decode)
-- 
2.17.2 (Apple Git-113)
