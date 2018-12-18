Received: from eggs.gnu.org ([2001:4830:134:3::10]:35915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gZGNE-0000uc-Ht
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:29:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gZGN8-0000yF-28
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:29:26 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 18 Dec 2018 15:28:49 +0100
Message-Id: <20181218142851.9477-3-laurent@vivier.eu>
In-Reply-To: <20181218142851.9477-1-laurent@vivier.eu>
References: <20181218142851.9477-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/4] i386: hvf: drop debug printf in
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, qemu-block@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, David Hildenbrand <david@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-trivial@nongnu.org, Roman Bolshakov <r.bolshakov@yadro.com>

From: Roman Bolshakov <r.bolshakov@yadro.com>

It's going to clutter QEMU logs if 0x0f00 is trapped.

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20181203100415.53027-2-r.bolshakov@yadro.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
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
2.19.2
