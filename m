Received: from eggs.gnu.org ([2001:4830:134:3::10]:38423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e1kT2-0003V4-Ag
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:40:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e1kT0-0003X2-T8
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:40:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e1kT0-0003WW-Ly
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:40:22 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  9 Oct 2017 23:40:01 -0300
Message-Id: <20171010024001.4526-9-ehabkost@redhat.com>
In-Reply-To: <20171010024001.4526-1-ehabkost@redhat.com>
References: <20171010024001.4526-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL v2 8/8] x86: Correct translation of some
 rdgsbase and wrgsbase encodings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Todd Eisenberger <teisenbe@google.com>

From: Todd Eisenberger <teisenbe@google.com>

It looks like there was a transcription error when writing this code
initially.  The code previously only decoded src or dst of rax.  This
resolves
https://bugs.launchpad.net/qemu/+bug/1719984.

Signed-off-by: Todd Eisenberger <teisenbe@google.com>
Message-Id: <CAP26EVRNVb=Mq=O3s51w7fDhGVmf-e3XFFA73MRzc5b4qKBA4g@mail.gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index a8986f4c1a..7b920115f9 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8155,9 +8155,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             break;
 
         case 0xc0 ... 0xc7: /* rdfsbase (f3 0f ae /0) */
-        case 0xc8 ... 0xc8: /* rdgsbase (f3 0f ae /1) */
+        case 0xc8 ... 0xcf: /* rdgsbase (f3 0f ae /1) */
         case 0xd0 ... 0xd7: /* wrfsbase (f3 0f ae /2) */
-        case 0xd8 ... 0xd8: /* wrgsbase (f3 0f ae /3) */
+        case 0xd8 ... 0xdf: /* wrgsbase (f3 0f ae /3) */
             if (CODE64(s)
                 && (prefixes & PREFIX_REPZ)
                 && !(prefixes & PREFIX_LOCK)
-- 
2.13.6
