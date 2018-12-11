Received: from eggs.gnu.org ([2001:4830:134:3::10]:43176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWmPI-0008I5-Ra
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:05:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWmPC-0007YB-L5
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:05:20 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 11 Dec 2018 19:03:48 +0100
Message-Id: <20181211180352.19644-27-laurent@vivier.eu>
In-Reply-To: <20181211180352.19644-1-laurent@vivier.eu>
References: <20181211180352.19644-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 26/30] util: vfio-helpers: use ARRAY_SIZE in
 qemu_vfio_init_pci()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>, Li Qiang <liq3ea@gmail.com>

From: Li Qiang <liq3ea@gmail.com>

Cc: qemu-trivial@nongnu.org

Signed-off-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <1543571638-2892-1-git-send-email-liq3ea@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 util/vfio-helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index cccc9cd42e..342d4a2285 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -348,7 +348,7 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
         goto fail;
     }
 
-    for (i = 0; i < 6; i++) {
+    for (i = 0; i < ARRAY_SIZE(s->bar_region_info); i++) {
         ret = qemu_vfio_pci_init_bar(s, i, errp);
         if (ret) {
             goto fail;
-- 
2.19.2
