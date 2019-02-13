Received: from eggs.gnu.org ([209.51.188.92]:45637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gtuBd-0005iC-JO
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:02:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gtuBa-0002rd-BR
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:02:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gtuBX-0002nb-NT
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:02:43 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 13 Feb 2019 14:02:40 +0100
Message-Id: <20190213130240.15492-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH] build: Correct explanation of unnest-vars
 example
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>

Cc: Fam Zheng <fam@euphon.net>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 rules.mak | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rules.mak b/rules.mak
index 86e033d815..19f3d2c126 100644
--- a/rules.mak
+++ b/rules.mak
@@ -327,7 +327,7 @@ endef
 #     ../water/ice.mo-libs = -licemaker
 #     ../water/ice.mo-objs = ../water/ice1.o ../water/ice2.o
 #
-# Note that 'hot' didn't include 'season/' in the input, so 'summer.o' is not
+# Note that 'hot' didn't include 'water/' in the input, so 'steam.o' is not
 # included.
 #
 define unnest-vars
-- 
2.17.2
