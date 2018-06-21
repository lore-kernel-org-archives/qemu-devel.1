Received: from eggs.gnu.org ([2001:4830:134:3::10]:54392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVt8R-0005go-8L
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:32:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVt8Q-0003lJ-DH
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:31:59 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:40759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVt8Q-0003kL-6c
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:31:58 -0400
Received: by mail-wr0-x231.google.com with SMTP id g18-v6so1831711wro.7
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 23:31:58 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 21 Jun 2018 07:25:25 +0100
Message-Id: <20180621062605.941-18-alex.bennee@linaro.org>
In-Reply-To: <20180621062605.941-1-alex.bennee@linaro.org>
References: <20180621062605.941-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 17/57] tests/tcg/i386: Build fix for
 hello-i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Fam Zheng <famz@redhat.com>

We have -Werror=missing-prototype, add a dummy prototype to avoid that
warning.

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/i386/hello-i386.c b/tests/tcg/i386/hello-i386.c
index fa00380de2..cfeb24b2f5 100644
--- a/tests/tcg/i386/hello-i386.c
+++ b/tests/tcg/i386/hello-i386.c
@@ -20,6 +20,7 @@ static inline int write(int fd, const char * buf, int len)
   return status;
 }
 
+void _start(void);
 void _start(void)
 {
     write(1, "Hello World\n", 12);
-- 
2.17.1
