Received: from eggs.gnu.org ([2001:4830:134:3::10]:41546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXh3S-0003Lh-F9
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:57:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXh3P-00027T-Hh
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:57:46 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:35859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXh3P-00027L-Bq
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:57:43 -0400
Received: by mail-pg0-x244.google.com with SMTP id y129so5428668pgy.3
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 21:57:43 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 18:57:12 -1000
Message-Id: <20170719045722.25492-5-rth@twiddle.net>
In-Reply-To: <20170719045722.25492-1-rth@twiddle.net>
References: <20170719045722.25492-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/14] coccinelle: ignore ASTs pre-parsed cached
 C files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

files generated using coccinelle tool: 'spatch --use-cache'

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20170718045540.16322-2-f4bug@amsat.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 .gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitignore b/.gitignore
index 09c2363..cf65316 100644
--- a/.gitignore
+++ b/.gitignore
@@ -116,6 +116,8 @@ tags
 TAGS
 docker-src.*
 *~
+*.ast_raw
+*.depend_raw
 trace.h
 trace.c
 trace-ust.h
-- 
2.9.4
