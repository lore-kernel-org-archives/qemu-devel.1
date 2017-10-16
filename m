Received: from eggs.gnu.org ([2001:4830:134:3::10]:55056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e45CP-0003Gz-JR
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:12:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e45CO-00018N-JX
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:12:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1e45CO-00017S-D4
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:12:52 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 16 Oct 2017 15:12:41 +0200
Message-Id: <1508159564-30317-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1508159564-30317-1-git-send-email-thuth@redhat.com>
References: <1508159564-30317-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/5] M68K: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Dmitry Fleytman <dmitry@daynix.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
[PMD: squashed commits]
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/m68k/mcf5206.c | 4 ++--
 hw/m68k/mcf5208.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index fbf3f0f..bd8e993 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -138,7 +138,7 @@ static m5206_timer_state *m5206_timer_init(qemu_irq i=
rq)
     m5206_timer_state *s;
     QEMUBH *bh;
=20
-    s =3D (m5206_timer_state *)g_malloc0(sizeof(m5206_timer_state));
+    s =3D g_new0(m5206_timer_state, 1);
     bh =3D qemu_bh_new(m5206_timer_trigger, s);
     s->timer =3D ptimer_init(bh, PTIMER_POLICY_DEFAULT);
     s->irq =3D irq;
@@ -534,7 +534,7 @@ qemu_irq *mcf5206_init(MemoryRegion *sysmem, uint32_t=
 base, M68kCPU *cpu)
     m5206_mbar_state *s;
     qemu_irq *pic;
=20
-    s =3D (m5206_mbar_state *)g_malloc0(sizeof(m5206_mbar_state));
+    s =3D g_new0(m5206_mbar_state, 1);
=20
     memory_region_init_io(&s->iomem, NULL, &m5206_mbar_ops, s,
                           "mbar", 0x00001000);
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index c9c5f5e..68589c3 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -184,7 +184,7 @@ static void mcf5208_sys_init(MemoryRegion *address_sp=
ace, qemu_irq *pic)
     memory_region_add_subregion(address_space, 0xfc0a8000, iomem);
     /* Timers.  */
     for (i =3D 0; i < 2; i++) {
-        s =3D (m5208_timer_state *)g_malloc0(sizeof(m5208_timer_state));
+        s =3D g_new0(m5208_timer_state, 1);
         bh =3D qemu_bh_new(m5208_timer_trigger, s);
         s->timer =3D ptimer_init(bh, PTIMER_POLICY_DEFAULT);
         memory_region_init_io(&s->iomem, NULL, &m5208_timer_ops, s,
--=20
1.8.3.1
