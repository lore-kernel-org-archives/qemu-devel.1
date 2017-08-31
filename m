Received: from eggs.gnu.org ([2001:4830:134:3::10]:42106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dnMq6-0003E1-Fk
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:36:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dnMq1-0006iT-1l
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:36:46 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 31 Aug 2017 12:34:30 +0200
Message-Id: <20170831103432.6007-28-marcandre.lureau@redhat.com>
In-Reply-To: <20170831103432.6007-1-marcandre.lureau@redhat.com>
References: <20170831103432.6007-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 27/29] i386: replace g_malloc()+memcpy() with
 g_memdup()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

I found these pattern via grepping the source tree. I don't have a
coccinelle script for it!

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 hw/i386/multiboot.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index f13e23139b..6001f4caa2 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -352,8 +352,7 @@ int load_multiboot(FWCfgState *fw_cfg,
     mb_debug("           mb_mods_count =3D %d\n", mbs.mb_mods_count);
=20
     /* save bootinfo off the stack */
-    mb_bootinfo_data =3D g_malloc(sizeof(bootinfo));
-    memcpy(mb_bootinfo_data, bootinfo, sizeof(bootinfo));
+    mb_bootinfo_data =3D g_memdup(bootinfo, sizeof(bootinfo));
=20
     /* Pass variables to option rom */
     fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ENTRY, mh_entry_addr);
--=20
2.14.1.146.gd35faa819
