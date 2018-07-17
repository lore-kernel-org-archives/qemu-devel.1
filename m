Received: from eggs.gnu.org ([2001:4830:134:3::10]:40850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffW4n-00031Y-Sz
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:56:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffW4j-0004ZB-8x
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:56:01 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ffW4i-0004XE-Ld
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:55:57 -0400
Received: by mail-wr1-x444.google.com with SMTP id r16-v6so2374310wrt.11
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:55:56 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 17 Jul 2018 20:55:36 +0100
Message-Id: <20180717195553.9111-2-alex.bennee@linaro.org>
In-Reply-To: <20180717195553.9111-1-alex.bennee@linaro.org>
References: <20180717195553.9111-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 for 3.0 01/18] tests/.gitignore: don't
 ignore docker tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The .gitignore was being a little over enthusiastic hiding files.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

---
v2
  - minor wording tweak for more explicitness
---
 tests/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/.gitignore b/tests/.gitignore
index 08e2df1ce1..72c18aaab0 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -9,6 +9,7 @@ qht-bench
 rcutorture
 test-*
 !test-*.c
+!docker/test-*
 test-qapi-commands.[ch]
 test-qapi-events.[ch]
 test-qapi-types.[ch]
-- 
2.17.1
