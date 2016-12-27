Received: from eggs.gnu.org ([2001:4830:134:3::10]:35487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtZx-0002Pr-NR
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtZw-0001JL-Va
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:17 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47873)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cLtZw-0001J1-Os
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:16 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtZv-0003uT-Ty
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 15:22:15 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Dec 2016 15:21:05 +0000
Message-Id: <1482852077-19397-14-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
References: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/25] aspeed: remove
 cannot_destroy_with_object_finalize_yet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Cédric Le Goater <clg@kaod.org>

With commit ce5b1bbf624b ("exec: move cpu_exec_init() calls to realize
functions"), we can now remove cannot_destroy_with_object_finalize_yet.

Suggested-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 1480434248-27138-5-git-send-email-clg@kaod.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed_soc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index db145e2..3a6b91f 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -251,12 +251,6 @@ static void aspeed_soc_class_init(ObjectClass *oc, void *data)
 
     sc->info = (AspeedSoCInfo *) data;
     dc->realize = aspeed_soc_realize;
-
-    /*
-     * Reason: creates an ARM CPU, thus use after free(), see
-     * arm_cpu_class_init()
-     */
-    dc->cannot_destroy_with_object_finalize_yet = true;
 }
 
 static const TypeInfo aspeed_soc_type_info = {
-- 
2.7.4
