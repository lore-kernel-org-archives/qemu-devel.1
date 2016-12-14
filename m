Received: from eggs.gnu.org ([2001:4830:134:3::10]:43303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Vlad.Lungu@windriver.com>) id 1cHByT-0006ZB-1r
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:00:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Vlad.Lungu@windriver.com>) id 1cHByQ-0005wy-1r
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:00:09 -0500
Received: from mail1.windriver.com ([147.11.146.13]:36681)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Vlad.Lungu@windriver.com>)
	id 1cHByP-0005uP-OU
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:00:05 -0500
From: Vlad Lungu <vlad.lungu@windriver.com>
Message-ID: <8d6ae82b-a3f8-7fce-de47-d338242d25f0@windriver.com>
Date: Wed, 14 Dec 2016 15:35:29 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] multiboot: copy the cmdline verbatim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, ehabkost@redhat.com, rth@twiddle.net


get_opt_value() truncates the value at the first comma
Use memcpy() instead

Signed-off-by: Vlad Lungu <vlad.lungu@windriver.com>
---
  hw/i386/multiboot.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 387caa6..b4495ad 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -109,7 +109,7 @@ static uint32_t mb_add_cmdline(MultibootState *s, 
const char *cmdline)
      hwaddr p = s->offset_cmdlines;
      char *b = (char *)s->mb_buf + p;

-    get_opt_value(b, strlen(cmdline) + 1, cmdline);
+    memcpy(b, cmdline, strlen(cmdline) + 1);
      s->offset_cmdlines += strlen(b) + 1;
      return s->mb_buf_phys + p;
  }
-- 
1.9.1
