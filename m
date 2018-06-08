Received: from eggs.gnu.org ([2001:4830:134:3::10]:35846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRMe7-0001Yv-8d
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 15:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRMe2-0006tC-2R
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 15:01:59 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  8 Jun 2018 16:01:45 -0300
Message-Id: <20180608190145.10872-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH RESEND] Makefile: Remove qemu-version.h and
 qemu-options.def during 'make distclean'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-trivial@nongnu.org

qemu-version.h and qemu-options.def are generated files
that should be deleted during 'make distclean'.

This solves building issues with out-of-tree builds from
a source tree that has been built in (see d1bd2423a90):

- /qemu-version.h existing in source tree:

    /source/qemu/qemu-nbd.c: In function ‘version’:
    /source/qemu/qemu-nbd.c:133:6: error: expected ‘)’ before
    ‘QEMU_FULL_VERSION’
     "%s " QEMU_FULL_VERSION "\n"
          ^~~~~~~~~~~~~~~~~~
          )
    /source/qemu/qemu-nbd.c:133:3: error: format ‘%s’ expects a matching
    ‘char *’ argument [-Werror=format=]
     "%s " QEMU_FULL_VERSION "\n"
      ~^
    cc1: all warnings being treated as errors

- /qemu-options.def existing in source tree:

    /source/qemu/vl.c: In function ‘main’:
    /source/qemu/vl.c:3052:18: error: ‘QEMU_OPTION_blockdev’ undeclared
    (first use in this function); did you mean ‘QEMU_OPTION_clock’?
                 case QEMU_OPTION_blockdev:
                      ^~~~~~~~~~~~~~~~~~~~
                      QEMU_OPTION_clock
    /source/qemu/vl.c:3052:18: note: each undeclared identifier is reported
    only once for each function it appears in

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
resend: Cc Peter, removed dup line in comment

 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 023b3437ec..7ae453ffa2 100644
--- a/Makefile
+++ b/Makefile
@@ -757,6 +757,7 @@ qemu-%.tar.bz2:
 distclean: clean
 	rm -f config-host.mak config-host.h* config-host.ld $(DOCS) qemu-options.texi qemu-img-cmds.texi qemu-monitor.texi qemu-monitor-info.texi
 	rm -f config-all-devices.mak config-all-disas.mak config.status
+	rm -f qemu-version.h qemu-options.def
 	rm -f po/*.mo tests/qemu-iotests/common.env
 	rm -f roms/seabios/config.mak roms/vgabios/config.mak
 	rm -f qemu-doc.info qemu-doc.aux qemu-doc.cp qemu-doc.cps
-- 
2.17.1
