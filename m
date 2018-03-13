Received: from eggs.gnu.org ([2001:4830:134:3::10]:57811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evshg-0005Mr-1y
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evshf-0002nP-CI
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:32 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:36081)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evshf-0002mN-4n
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:31 -0400
Received: by mail-wr0-x242.google.com with SMTP id d10so2571198wrf.3
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:47:30 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:17 +0100
Message-Id: <20180313224719.4954-8-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/69] build-sys: make help could have 'modules'
 target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Available when configure --enable-modules.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180306161728.20890-1-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 9a75c48ae0..5d9ef3b8fd 100644
--- a/Makefile
+++ b/Makefile
@@ -1046,6 +1046,9 @@ include $(SRC_PATH)/tests/vm/Makefile.include
 help:
 	@echo  'Generic targets:'
 	@echo  '  all             - Build all'
+ifdef CONFIG_MODULES
+	@echo  '  modules         - Build all modules'
+endif
 	@echo  '  dir/file.o      - Build specified target only'
 	@echo  '  install         - Install QEMU, documentation and tools'
 	@echo  '  ctags/TAGS      - Generate tags file for editors'
-- 
2.14.3
