Received: from eggs.gnu.org ([2001:4830:134:3::10]:55623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZt4m-0006hT-Ec
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 02:12:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZt4j-0000nu-9e
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 02:12:12 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 25 Jul 2017 03:11:58 -0300
Message-Id: <20170725061158.10745-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] Makefile: add
 all-user/all-linux-user/all-softmmu meta-targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

Useful to build a whole set at once.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 5f18243d05..da899522e4 100644
--- a/Makefile
+++ b/Makefile
@@ -814,6 +814,11 @@ endif
 # Dependencies in Makefile.objs files come from our recursive subdir rules
 -include $(wildcard *.d tests/*.d)
 
+.PHONY: subdir-all-user subdir-all-linux-user subdir-all-softmmu
+subdir-all-user: $(patsubst %,subdir-%,$(filter %-user,$(TARGET_DIRS)))
+subdir-all-linux-user: $(patsubst %,subdir-%,$(filter %-linux-user,$(TARGET_DIRS)))
+subdir-all-softmmu: $(patsubst %,subdir-%,$(filter %-softmmu,$(TARGET_DIRS)))
+
 include $(SRC_PATH)/tests/docker/Makefile.include
 
 .PHONY: help
@@ -827,7 +832,7 @@ help:
 	@echo  ''
 	@$(if $(TARGET_DIRS), \
 		echo 'Architecture specific targets:'; \
-		$(foreach t, $(TARGET_DIRS), \
+		$(foreach t, $(TARGET_DIRS) all-user all-linux-user all-softmmu, \
 		printf "  %-30s - Build for %s\\n" $(patsubst %,subdir-%,$(t)) $(t);) \
 		echo '')
 	@echo  'Cleaning targets:'
-- 
2.13.3
