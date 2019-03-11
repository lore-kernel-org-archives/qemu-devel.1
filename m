Received: from eggs.gnu.org ([209.51.188.92]:60003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h3QL0-0005Ht-HB
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:11:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h3QKz-0003R3-Pj
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:11:50 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 11 Mar 2019 20:11:24 +0100
Message-Id: <20190311191128.30562-2-laurent@vivier.eu>
In-Reply-To: <20190311191128.30562-1-laurent@vivier.eu>
References: <20190311191128.30562-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/5] thunk: improve readability of allocation
 loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Laszlo Ersek <lersek@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Aarushi Mehta <mehta.aaru20@gmail.com>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <a09acf9e093c09a70896bb9886370cf7f049f941.camel@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 thunk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/thunk.c b/thunk.c
index 17f3d320bb8e..7f31cffe0968 100644
--- a/thunk.c
+++ b/thunk.c
@@ -86,7 +86,7 @@ void thunk_register_struct(int id, const char *name, const argtype *types)
 #endif
     /* now we can alloc the data */
 
-    for(i = 0;i < 2; i++) {
+    for (i = 0; i < ARRAY_SIZE(se->field_offsets); i++) {
         offset = 0;
         max_align = 1;
         se->field_offsets[i] = g_new(int, nb_fields);
-- 
2.20.1
