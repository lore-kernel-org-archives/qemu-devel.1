Received: from eggs.gnu.org ([209.51.188.92]:41481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gjk59-00059e-PY
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 07:14:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gjk54-0003yp-71
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 07:14:07 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gjk53-0003rb-C5
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 07:14:02 -0500
Received: by mail-wm1-x344.google.com with SMTP id m22so1758284wml.3
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 04:13:59 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 16 Jan 2019 12:13:50 +0000
Message-Id: <20190116121350.23863-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] hw/block/xen: use proper format string for
 printing sectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul.durrant@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>, "open list:Block layer core" <qemu-block@nongnu.org>

The %lu format string is different depending on the host architecture
which causes builds like the debian-armhf-cross build to fail. Use the
correct PRi64 format string.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/block/xen-block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index be28b63442..a636487b3e 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -215,7 +215,7 @@ static void xen_block_realize(XenDevice *xendev, Error **errp)
 
     xen_device_backend_printf(xendev, "sector-size", "%u",
                               conf->logical_block_size);
-    xen_device_backend_printf(xendev, "sectors", "%lu",
+    xen_device_backend_printf(xendev, "sectors", "%"PRIi64,
                               blk_getlength(conf->blk) /
                               conf->logical_block_size);
 
-- 
2.17.1
