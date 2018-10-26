Received: from eggs.gnu.org ([2001:4830:134:3::10]:50000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gG4Jk-00041v-Tm
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gG46Z-00052K-JB
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:32:59 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 26 Oct 2018 17:31:16 +0200
Message-Id: <20181026153125.24738-12-laurent@vivier.eu>
In-Reply-To: <20181026153125.24738-1-laurent@vivier.eu>
References: <20181026153125.24738-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 11/20] cpu.h: fix a typo in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org, Michael Walle <michael@walle.cc>, Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cleber Rosa <crosa@redhat.com>, Igor Mammedov <imammedo@redhat.com>, xen-devel@lists.xenproject.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Anthony Perard <anthony.perard@citrix.com>, Aurelien Jarno <aurelien@aurel32.net>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Eduardo Habkost <ehabkost@redhat.com>, Li Qiang <liq3ea@gmail.com>

From: Li Qiang <liq3ea@gmail.com>

Found by reading the code.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
Message-Id: <1536150548-2797-1-git-send-email-liq3ea@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/qom/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 4e238b0d9f..def0c64308 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -852,7 +852,7 @@ extern CPUInterruptHandler cpu_interrupt_handler;
 /**
  * cpu_interrupt:
  * @cpu: The CPU to set an interrupt on.
- * @mask: The interupts to set.
+ * @mask: The interrupts to set.
  *
  * Invokes the interrupt handler.
  */
-- 
2.17.2
