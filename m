Received: from eggs.gnu.org ([2001:4830:134:3::10]:57207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fdx19-0004lR-JZ
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:17:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fdx16-0003ap-W7
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:17:47 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:53125)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fdx16-0003aB-Ow
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:17:44 -0400
Received: by mail-wm0-x244.google.com with SMTP id o11-v6so2697282wmh.2
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 05:17:44 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 13 Jul 2018 13:17:26 +0100
Message-Id: <20180713121741.19262-2-alex.bennee@linaro.org>
In-Reply-To: <20180713121741.19262-1-alex.bennee@linaro.org>
References: <20180713121741.19262-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 for 3.0 01/16] tests/.gitignore: don't
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
