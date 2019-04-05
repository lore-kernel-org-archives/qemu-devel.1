Received: from eggs.gnu.org ([209.51.188.92]:48848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hCY0p-0003Xa-5N
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:12:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hCY0o-0003V9-7M
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:12:43 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:34373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hCY0n-0003QV-Lg
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:12:42 -0400
Received: by mail-qt1-f170.google.com with SMTP id k2so9398652qtm.1
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 16:12:41 -0700 (PDT)
Date: Fri, 5 Apr 2019 19:12:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1553199229-25318-1-git-send-email-liam.merwick@oracle.com>
References: <20190405231225.30165-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405231225.30165-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 1/5] acpi: verify file entries in
 bios_linker_loader_add_pointer()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Liam Merwick <liam.merwick@oracle.com>, Igor Mammedov <imammedo@redhat.com>

From: Liam Merwick <liam.merwick@oracle.com>

The callers to bios_linker_find_file() assert that the file entry returned
is not NULL, except for those in bios_linker_loader_add_pointer().  Add two
asserts in that case for completeness and to facilitate static code analysis.

Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
Message-Id: <1553199229-25318-1-git-send-email-liam.merwick@oracle.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/bios-linker-loader.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/acpi/bios-linker-loader.c b/hw/acpi/bios-linker-loader.c
index d16b8bbcb1..626c04a39f 100644
--- a/hw/acpi/bios-linker-loader.c
+++ b/hw/acpi/bios-linker-loader.c
@@ -283,6 +283,8 @@ void bios_linker_loader_add_pointer(BIOSLinker *linker,
     const BiosLinkerFileEntry *source_file =
         bios_linker_find_file(linker, src_file);
 
+    assert(dst_file);
+    assert(source_file);
     assert(dst_patched_offset < dst_file->blob->len);
     assert(dst_patched_offset + dst_patched_size <= dst_file->blob->len);
     assert(src_offset < source_file->blob->len);
-- 
MST
