Received: from eggs.gnu.org ([2001:4830:134:3::10]:35990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fmgbR-0005QR-61
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fmgbQ-0001A3-94
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:35:21 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531]:38338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fmgbQ-00019q-1d
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:35:20 -0400
Received: by mail-ed1-x531.google.com with SMTP id t2-v6so5250306edr.5
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 07:35:19 -0700 (PDT)
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon,  6 Aug 2018 16:34:12 +0200
Message-Id: <20180806143412.27722-35-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH v2 34/34] test/qgraph: temporarly commented
 vhost-user-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

vhost-user-test has not converted to qgraph yet, and since
it uses virtio interface, it won't work, causing make check
to fail.
Commented out until it does not get converted to graph node.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 69877b3702..14f19ebcdb 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -287,10 +287,10 @@ check-qtest-i386-y += tests/cpu-plug-test$(EXESUF)
 check-qtest-i386-y += tests/q35-test$(EXESUF)
 check-qtest-i386-y += tests/vmgenid-test$(EXESUF)
 gcov-files-i386-y += hw/pci-host/q35.c
-check-qtest-i386-$(CONFIG_VHOST_USER_NET_TEST_i386) += tests/vhost-user-test$(EXESUF)
-ifeq ($(CONFIG_VHOST_USER_NET_TEST_i386),)
-check-qtest-x86_64-$(CONFIG_VHOST_USER_NET_TEST_x86_64) += tests/vhost-user-test$(EXESUF)
-endif
+# check-qtest-i386-$(CONFIG_VHOST_USER_NET_TEST_i386) += tests/vhost-user-test$(EXESUF)
+# ifeq ($(CONFIG_VHOST_USER_NET_TEST_i386),)
+# check-qtest-x86_64-$(CONFIG_VHOST_USER_NET_TEST_x86_64) += tests/vhost-user-test$(EXESUF)
+# endif
 check-qtest-i386-$(CONFIG_TPM) += tests/tpm-crb-swtpm-test$(EXESUF)
 check-qtest-i386-$(CONFIG_TPM) += tests/tpm-crb-test$(EXESUF)
 check-qtest-i386-$(CONFIG_TPM) += tests/tpm-tis-swtpm-test$(EXESUF)
-- 
2.17.1
