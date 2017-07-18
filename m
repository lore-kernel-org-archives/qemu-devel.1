Received: from eggs.gnu.org ([2001:4830:134:3::10]:60635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLsx-00027z-Bl
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:21:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLsw-0001P5-J5
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:21:31 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Jul 2017 03:09:57 -0300
Message-Id: <20170718061005.29518-22-f4bug@amsat.org>
In-Reply-To: <20170718061005.29518-1-f4bug@amsat.org>
References: <20170718061005.29518-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 21/29] qga: use ARRAY_SIZE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.cocci

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 qga/commands-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index d8e412275e..2a5d5cb4ba 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -896,7 +896,7 @@ static void build_guest_fsinfo_for_real_device(char const *syspath,
     if (p && sscanf(q, "%u", &host) == 1) {
         has_host = true;
         nhosts = build_hosts(syspath, p, has_ata, hosts,
-                             sizeof(hosts) / sizeof(hosts[0]), errp);
+                             ARRAY_SIZE(hosts), errp);
         if (nhosts < 0) {
             goto cleanup;
         }
-- 
2.13.2
