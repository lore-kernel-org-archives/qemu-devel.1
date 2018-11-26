Received: from eggs.gnu.org ([2001:4830:134:3::10]:45531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gRMkZ-00089u-Qw
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:40:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gRMkY-0004o9-NP
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:40:55 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:40543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gRMkY-0004np-Hg
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:40:54 -0500
Received: by mail-wm1-x336.google.com with SMTP id q26so19730124wmf.5
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 11:40:54 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Nov 2018 20:40:32 +0100
Message-Id: <1543261235-2834-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543261235-2834-1-git-send-email-pbonzini@redhat.com>
References: <1543261235-2834-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/15] MAINTAINERS: Add an entry for the
 Firmware Configuration (fw_cfg) device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Step in to maintain it, with Laszlo (EDK2) and Gerd (SeaBIOS)
as designated reviewers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20181122021139.1486-1-philmd@redhat.com>
Acked-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c7acb55..63effdc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1564,6 +1564,19 @@ F: hw/display/edid*
 F: include/hw/display/edid.h
 F: qemu-edid.c
 
+Firmware configuration (fw_cfg)
+M: Philippe Mathieu-DaudÃ© <philmd@redhat.com>
+R: Laszlo Ersek <lersek@redhat.com>
+R: Gerd Hoffmann <kraxel@redhat.com>
+S: Supported
+F: docs/specs/fw_cfg.txt
+F: hw/nvram/fw_cfg.c
+F: include/hw/nvram/fw_cfg.h
+F: include/standard-headers/linux/qemu_fw_cfg.h
+F: tests/libqos/fw_cfg.c
+F: tests/fw_cfg-test.c
+T: git https://github.com/philmd/qemu.git fw_cfg-next
+
 Subsystems
 ----------
 Audio
-- 
1.8.3.1
