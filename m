Received: from eggs.gnu.org ([2001:4830:134:3::10]:35104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHXzC-00071X-R2
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 12:02:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHXz9-0003vu-MX
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 12:02:38 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun,  4 Jun 2017 18:45:17 +0300
Message-Id: <016b4a93e733778d75088d8e87ab1bd7e73425b4.1496591095.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
References: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
References: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/22] register: display register prefix (name)
 since it is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/core/register.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/core/register.c b/hw/core/register.c
index da38ef3a54..900294b9c4 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -195,8 +195,8 @@ void register_write_memory(void *opaque, hwaddr addr,
     }
=20
     if (!reg) {
-        qemu_log_mask(LOG_GUEST_ERROR, "Write to unimplemented register =
at " \
-                      "address: %#" PRIx64 "\n", addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write to unimplemented regis=
ter " \
+                      "at address: %#" PRIx64 "\n", reg_array->prefix, a=
ddr);
         return;
     }
=20
@@ -224,8 +224,8 @@ uint64_t register_read_memory(void *opaque, hwaddr ad=
dr,
     }
=20
     if (!reg) {
-        qemu_log_mask(LOG_GUEST_ERROR, "Read to unimplemented register a=
t " \
-                      "address: %#" PRIx64 "\n", addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s:  read to unimplemented regis=
ter " \
+                      "at address: %#" PRIx64 "\n", reg_array->prefix, a=
ddr);
         return 0;
     }
=20
--=20
2.11.0
