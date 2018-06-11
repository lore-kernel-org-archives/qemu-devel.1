Received: from eggs.gnu.org ([2001:4830:134:3::10]:42499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSBQn-0004b7-JB
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 21:15:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSBQm-0002QH-On
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 21:15:37 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 10 Jun 2018 22:14:25 -0300
Message-Id: <20180611011501.10235-5-f4bug@amsat.org>
In-Reply-To: <20180611011501.10235-1-f4bug@amsat.org>
References: <20180611011501.10235-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 04/40] checkpatch: Recognize IEC binary
 prefix definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

This fixes:

    ERROR: "foo * bar" should be "foo *bar"
    #310: FILE: hw/ppc/ppc440_uc.c:564:
    +        size = 8 * MiB * sh;
    total: 1 errors, 0 warnings, 433 lines checked

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e3d8c2cdfc..4923674c71 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -322,6 +322,7 @@ sub build_types {
 				(?:${all}\b)
 			)
 			(?:\s+$Modifier|\s+const)*
+			(?:[KMGTPE]iB)
 		  }x;
 	$Type	= qr{
 			$NonptrType
-- 
2.17.1
