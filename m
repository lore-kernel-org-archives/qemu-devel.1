Received: from eggs.gnu.org ([2001:4830:134:3::10]:41657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAtJ-0003JZ-5P
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAtH-0001dJ-RQ
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:25 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fGAtH-0001cf-Fr
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:23 -0400
Received: by mail-wm0-x243.google.com with SMTP id o78-v6so24239048wmg.0
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 15:15:23 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 May 2018 00:14:45 +0200
Message-Id: <1525817687-34620-29-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 28/30] build: Silence dtc directory creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>

From: Jan Kiszka <jan.kiszka@siemens.com>

Align with other mkdir calls.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Philippe Mathieu-DaudÃ© <f4bug@amsat.org>
Message-Id: <0dd4c8f5-d60e-e564-652f-cd0101f6ee68@web.de>
Message-Id: <20180415230522.24404-5-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index d71dd5b..35554b5 100644
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
1.8.3.1
