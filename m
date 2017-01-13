Received: from eggs.gnu.org ([2001:4830:134:3::10]:51042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cRs8o-0007l4-I5
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 22:02:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cRs8l-00059r-Hw
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 22:02:58 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cRs8l-00059h-BI
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 22:02:55 -0500
Received: by mail-wm0-x241.google.com with SMTP id l2so8345620wml.2
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 19:02:55 -0800 (PST)
Message-ID: <5878435d.54b31c0a.39a7b.4e93@mx.google.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 12 Jan 2017 19:02:20 -0800
Subject: [Qemu-devel] [PATCH] nvdimm: allow read/write zero-size namespace
 label
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@linux.intel.com, qemu-devel@nongnu.org
Cc: Li Qiang <liqiang6-s@360.cn>

From: Li Qiang <liqiang6-s@360.cn>

The spec doesn't say the namespace label can't be zero
when read/write it. As this is no harmful, just allow
it.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
---
 hw/mem/nvdimm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index db896b0..4042097 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -114,7 +114,7 @@ static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
 static void nvdimm_validate_rw_label_data(NVDIMMDevice *nvdimm, uint64_t size,
                                         uint64_t offset)
 {
-    assert((nvdimm->label_size >= size + offset) && (offset + size > offset));
+    assert((nvdimm->label_size >= size + offset) && (offset + size >= offset));
 }
 
 static void nvdimm_read_label_data(NVDIMMDevice *nvdimm, void *buf,
-- 
1.8.3.1
