Received: from eggs.gnu.org ([209.51.188.92]:46170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwVfQ-00054d-6m
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:28:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwVfP-00022n-Gc
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:28:20 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gwVfP-00022I-AE
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:28:19 -0500
Received: by mail-wr1-x442.google.com with SMTP id v13so26972607wrw.5
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 09:28:19 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 20 Feb 2019 17:28:11 +0000
Message-Id: <20190220172811.10588-9-alex.bennee@linaro.org>
In-Reply-To: <20190220172811.10588-1-alex.bennee@linaro.org>
References: <20190220172811.10588-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 8/8] tests/softfloat: always do quick
 softfloat tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Some operations take a long time and enabling "-l 2 -r all" can take
more than a day which is stretching the definition of a "slow" test.
Lets default to the quick test and leave a note for those who wish to
run by hand.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/Makefile.include | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index b39e989f72..3741f8f6dd 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -896,11 +896,9 @@ $(FP_TEST_BIN):
 	         "BUILD", "$(notdir $@)")
 
 # The full test suite can take a bit of time, default to a quick run
-ifeq ($(SPEED), quick)
+# "-l 2 -r all" can take more than a day for some operations and is best
+# run manually
 FP_TL=-l 1
-else
-FP_TL=-l 2 -r all
-endif
 
 # $1 = tests, $2 = description
 test-softfloat = $(call quiet-command, \
-- 
2.20.1
