Received: from eggs.gnu.org ([2001:4830:134:3::10]:40528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fcXye-0000lU-Ij
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:21:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fcXya-0005UN-HR
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:21:24 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:39980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fcXya-0005U4-AO
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:21:20 -0400
Received: by mail-wr1-x436.google.com with SMTP id t6-v6so11417697wrn.7
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 08:21:20 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  9 Jul 2018 16:21:08 +0100
Message-Id: <20180709152117.21585-2-alex.bennee@linaro.org>
In-Reply-To: <20180709152117.21585-1-alex.bennee@linaro.org>
References: <20180709152117.21585-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 3.0 01/10] tests/.gitignore: don't ignore
 docker tests
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

This was being a little over enthusiastic hiding files.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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
