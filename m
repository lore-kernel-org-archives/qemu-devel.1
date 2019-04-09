Received: from eggs.gnu.org ([209.51.188.92]:51436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDt5u-00085S-Di
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:55:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDt5t-0004hC-86
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:55:30 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:39999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hDt5s-0004bc-Ts
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:55:29 -0400
Received: by mail-wr1-x434.google.com with SMTP id h4so21584283wre.7
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 08:55:23 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  9 Apr 2019 17:55:16 +0200
Message-Id: <1554825316-33288-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1554825316-33288-1-git-send-email-pbonzini@redhat.com>
References: <1554825316-33288-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 5/5] tests: Make check-block a phony target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

From: Markus Armbruster <armbru@redhat.com>

Fixes: b93b63f574c "test makefile overhaul"

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190319072104.32591-1-armbru@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 6b904d7..36fc73f 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1164,7 +1164,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
 
 # Consolidated targets
 
-.PHONY: check-qapi-schema check-qtest check-unit check check-clean
+.PHONY: check-block check-qapi-schema check-qtest check-unit check check-clean
 check-qapi-schema: $(patsubst %,check-%, $(check-qapi-schema-y)) check-tests/qapi-schema/doc-good.texi
 check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
 check-block: $(patsubst %,check-%, $(check-block-y))
-- 
1.8.3.1
