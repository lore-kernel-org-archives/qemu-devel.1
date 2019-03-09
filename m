Received: from eggs.gnu.org ([209.51.188.92]:53110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2gZS-00013X-78
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 13:19:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2gZQ-0004DW-QA
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 13:19:42 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sat,  9 Mar 2019 19:19:19 +0100
Message-Id: <20190309181920.30553-2-philmd@redhat.com>
In-Reply-To: <20190309181920.30553-1-philmd@redhat.com>
References: <20190309181920.30553-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 1/2] hw/arm/virt: Remove null-check in
 virt_build_smbios()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Laszlo Ersek <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>

Since commit 578f3c7b0835 ("arm: add fw_cfg to "virt" board",
2014-12-22), the machvirt_init() unconditionally creates the
fw_cfg object.  Later, commit c30e15658b1b ("smbios: implement
smbios support for mach-virt", 2015-09-07) added a superfluous
null-check on it.
Remove this superfluous check.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: Corrected commit reference (Laszlo)
v3: Dropped 'Fixes:' (Markus)
---
 hw/arm/virt.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7f66ddad89..377e95a4cd 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1281,10 +1281,6 @@ static void virt_build_smbios(VirtMachineState *vm=
s)
     size_t smbios_tables_len, smbios_anchor_len;
     const char *product =3D "QEMU Virtual Machine";
=20
-    if (!vms->fw_cfg) {
-        return;
-    }
-
     if (kvm_enabled()) {
         product =3D "KVM Virtual Machine";
     }
--=20
2.20.1
