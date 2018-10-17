Received: from eggs.gnu.org ([2001:4830:134:3::10]:53450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCiiA-0005yM-Cg
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCii7-0002Ds-51
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gCii6-0001Bt-NY
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:50 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 17 Oct 2018 12:05:04 +0200
Message-Id: <1539770707-7289-13-git-send-email-thuth@redhat.com>
In-Reply-To: <1539770707-7289-1-git-send-email-thuth@redhat.com>
References: <1539770707-7289-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 12/15] hw/core/generic-loader: Set a category
 for the generic-loader device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

Each device that is instantiatable by the users should be marked with
a category. Since the generic-loader does not fit anywhere else, put
it into the MISC category.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/core/generic-loader.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index fde32cb..be29ae1 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -204,6 +204,7 @@ static void generic_loader_class_init(ObjectClass *klass, void *data)
     dc->unrealize = generic_loader_unrealize;
     dc->props = generic_loader_props;
     dc->desc = "Generic Loader";
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
 static TypeInfo generic_loader_info = {
-- 
1.8.3.1
