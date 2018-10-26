Received: from eggs.gnu.org ([2001:4830:134:3::10]:49998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gG4J6-00041t-1k
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:45:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gG47G-0005ZU-5P
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:33:42 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 26 Oct 2018 17:31:23 +0200
Message-Id: <20181026153125.24738-19-laurent@vivier.eu>
In-Reply-To: <20181026153125.24738-1-laurent@vivier.eu>
References: <20181026153125.24738-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 18/20] hw/intc/gicv3: Remove useless parenthesis
 around DIV_ROUND_UP macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org, Michael Walle <michael@walle.cc>, Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cleber Rosa <crosa@redhat.com>, Igor Mammedov <imammedo@redhat.com>, xen-devel@lists.xenproject.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Anthony Perard <anthony.perard@citrix.com>, Aurelien Jarno <aurelien@aurel32.net>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Eduardo Habkost <ehabkost@redhat.com>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Patch created mechanically by rerunning:

  $  spatch --sp-file scripts/coccinelle/round.cocci \
            --macro-file scripts/cocci-macro-file.h \
            --dir . --in-place

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20180705155811.20366-8-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/intc/arm_gicv3_common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index b798486ecf..31ec9a1ae4 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -62,7 +62,7 @@
  * avoids bugs where we forget to subtract GIC_INTERNAL from an
  * interrupt number.
  */
-#define GICV3_BMP_SIZE (DIV_ROUND_UP(GICV3_MAXIRQ, 32))
+#define GICV3_BMP_SIZE DIV_ROUND_UP(GICV3_MAXIRQ, 32)
 
 #define GIC_DECLARE_BITMAP(name) \
     uint32_t name[GICV3_BMP_SIZE]
-- 
2.17.2
