Received: from eggs.gnu.org ([2001:4830:134:3::10]:58868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eRKtU-0005j1-5q
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:37:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eRKtT-0002le-Dh
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:37:28 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 19 Dec 2017 13:37:12 -0300
Message-Id: <20171219163713.31383-2-f4bug@amsat.org>
In-Reply-To: <20171219163713.31383-1-f4bug@amsat.org>
References: <20171219163713.31383-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/2] qemu-iotests: add missing rule to build
 socket_scm_helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Wenchao Xia <xiawenc@linux.vnet.ibm.com>, Stratos Psomadakis <psomas@grnet.gr>, Eric Blake <eblake@redhat.com>

'make check-block' uses it on Linux.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index b4bcc872f2..fa5e9597f1 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -919,7 +919,7 @@ check-qapi-schema: $(patsubst %,check-%, $(check-qapi-schema-y)) check-tests/qap
 check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
 check-unit: $(patsubst %,check-%, $(check-unit-y))
 check-speed: $(patsubst %,check-%, $(check-speed-y))
-check-block: $(patsubst %,check-%, $(check-block-y))
+check-block: $(patsubst %,check-%, $(check-block-y)) QEMU_IOTESTS_HELPERS-$(CONFIG_LINUX)
 check: check-qapi-schema check-unit check-qtest
 check-clean:
 	$(MAKE) -C tests/tcg clean
-- 
2.15.1
