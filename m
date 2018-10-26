Received: from eggs.gnu.org ([2001:4830:134:3::10]:49850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gG4J3-0003mJ-II
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gG47O-0005gr-M7
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:33:47 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 26 Oct 2018 17:31:21 +0200
Message-Id: <20181026153125.24738-17-laurent@vivier.eu>
In-Reply-To: <20181026153125.24738-1-laurent@vivier.eu>
References: <20181026153125.24738-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/20] tests/bios-tables-test: Remove an useless
 cast
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

  $  spatch --sp-file scripts/coccinelle/typecast.cocci \
            --macro-file scripts/cocci-macro-file.h \
            --dir . --in-place

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20180705155811.20366-5-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 tests/bios-tables-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index af4b1fb6bd..02e77ec811 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -319,7 +319,7 @@ static bool load_asl(GArray *sdts, AcpiSdtTable *sdt)
     ret = g_spawn_command_line_sync(command_line->str, &out, &out_err, NULL, &error);
     g_assert_no_error(error);
     if (ret) {
-        ret = g_file_get_contents(sdt->asl_file, (gchar **)&sdt->asl,
+        ret = g_file_get_contents(sdt->asl_file, &sdt->asl,
                                   &sdt->asl_len, &error);
         g_assert(ret);
         g_assert_no_error(error);
-- 
2.17.2
