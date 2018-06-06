Received: from eggs.gnu.org ([2001:4830:134:3::10]:39219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQaG3-0004cI-39
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:21:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQaG1-0003eH-I0
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:21:55 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  6 Jun 2018 12:21:22 -0300
Message-Id: <20180606152128.449-6-f4bug@amsat.org>
In-Reply-To: <20180606152128.449-1-f4bug@amsat.org>
References: <20180606152128.449-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 05/11] hw/core/register: Add trailing '\n' to
 qemu_log() call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair@alistair23.me>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/core/register.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/register.c b/hw/core/register.c
index 0741a1af32..d2d1636250 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -96,7 +96,7 @@ void register_write(RegisterInfo *reg, uint64_t val, uint64_t we,
     if (test) {
         qemu_log_mask(LOG_UNIMP,
                       "%s:%s writing %#" PRIx64 " to unimplemented bits:" \
-                      " %#" PRIx64 "",
+                      " %#" PRIx64 "\n",
                       prefix, reg->access->name, val, ac->unimp);
     }
 
-- 
2.17.1
