Received: from eggs.gnu.org ([2001:4830:134:3::10]:58310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7qiW-0007K4-DH
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:05:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7qiV-0003AZ-Im
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:05:52 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:43245)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7qiV-0003AJ-Dk
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:05:51 -0400
Received: by mail-qk0-x241.google.com with SMTP id v2so14725191qkh.10
	for <qemu-devel@nongnu.org>; Sun, 15 Apr 2018 16:05:51 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 15 Apr 2018 20:05:22 -0300
Message-Id: <20180415230522.24404-5-f4bug@amsat.org>
In-Reply-To: <20180415230522.24404-1-f4bug@amsat.org>
References: <20180415230522.24404-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 4/4] build: Silence dtc directory creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel@nongnu.org, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

From: Jan Kiszka <jan.kiszka@siemens.com>

Align with other mkdir calls.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <0dd4c8f5-d60e-e564-652f-cd0101f6ee68@web.de>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 727ef118f3..fc6f21001f 100644
--- a/Makefile
+++ b/Makefile
@@ -485,7 +485,7 @@ subdir-dtc: .git-submodule-status dtc/libfdt dtc/tests
 	$(call quiet-command,$(MAKE) $(DTC_MAKE_ARGS) CPPFLAGS="$(DTC_CPPFLAGS)" CFLAGS="$(DTC_CFLAGS)" LDFLAGS="$(LDFLAGS)" ARFLAGS="$(ARFLAGS)" CC="$(CC)" AR="$(AR)" LD="$(LD)" $(SUBDIR_MAKEFLAGS) libfdt/libfdt.a,)
 
 dtc/%: .git-submodule-status
-	mkdir -p $@
+	@mkdir -p $@
 
 # Overriding CFLAGS causes us to lose defines added in the sub-makefile.
 # Not overriding CFLAGS leads to mis-matches between compilation modes.
-- 
2.17.0
