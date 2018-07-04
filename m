Received: from eggs.gnu.org ([2001:4830:134:3::10]:57591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fajt0-00071Y-Tm
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:40:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fajsz-0003cu-81
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:40:06 -0400
Received: from mail-qk0-x235.google.com ([2607:f8b0:400d:c09::235]:35880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fajsz-0003ck-43
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:40:05 -0400
Received: by mail-qk0-x235.google.com with SMTP id a132-v6so3052649qkg.3
	for <qemu-devel@nongnu.org>; Wed, 04 Jul 2018 08:40:05 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  4 Jul 2018 12:39:15 -0300
Message-Id: <20180704153919.12432-5-f4bug@amsat.org>
In-Reply-To: <20180704153919.12432-1-f4bug@amsat.org>
References: <20180704153919.12432-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 4/8] xen: Remove useless casts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>

Patch created mechanically by rerunning:

  $  spatch --sp-file scripts/coccinelle/typecast.cocci \
            --macro-file scripts/cocci-macro-file.h \
            --dir . --in-place

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/xen/xen_pt_config_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index aee31c62bb..55a83333f2 100644
--- a/hw/xen/xen_pt_config_init.c
+++ b/hw/xen/xen_pt_config_init.c
@@ -543,7 +543,7 @@ static int xen_pt_exp_rom_bar_reg_write(XenPCIPassthroughState *s,
 {
     XenPTRegInfo *reg = cfg_entry->reg;
     XenPTRegion *base = NULL;
-    PCIDevice *d = (PCIDevice *)&s->dev;
+    PCIDevice *d = &s->dev;
     uint32_t writable_mask = 0;
     uint32_t throughable_mask = get_throughable_mask(s, reg, valid_mask);
     pcibus_t r_size = 0;
-- 
2.18.0
