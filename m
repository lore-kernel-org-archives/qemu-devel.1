Received: from eggs.gnu.org ([209.51.188.92]:60223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h3QL8-0005Rc-UN
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:12:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h3QL8-0003aJ-Al
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:11:58 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 11 Mar 2019 20:11:27 +0100
Message-Id: <20190311191128.30562-5-laurent@vivier.eu>
In-Reply-To: <20190311191128.30562-1-laurent@vivier.eu>
References: <20190311191128.30562-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 4/5] hw/arm/virt: Remove null-check in
 virt_build_smbios()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Laszlo Ersek <lersek@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Since commit 578f3c7b0835 ("arm: add fw_cfg to "virt" board",
2014-12-22), the machvirt_init() unconditionally creates the
fw_cfg object.  Later, commit c30e15658b1b ("smbios: implement
smbios support for mach-virt", 2015-09-07) added a superfluous
null-check on it.
Remove this superfluous check.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190309181920.30553-2-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/arm/virt.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7f66ddad89f6..377e95a4cdb0 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1281,10 +1281,6 @@ static void virt_build_smbios(VirtMachineState *vms)
     size_t smbios_tables_len, smbios_anchor_len;
     const char *product = "QEMU Virtual Machine";
 
-    if (!vms->fw_cfg) {
-        return;
-    }
-
     if (kvm_enabled()) {
         product = "KVM Virtual Machine";
     }
-- 
2.20.1
