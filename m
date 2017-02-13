Received: from eggs.gnu.org ([2001:4830:134:3::10]:45555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdO8r-00050m-J6
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdO8q-0001ZU-CE
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:37 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:32967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cdO8q-0001ZH-7z
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:36 -0500
Received: by mail-qk0-x242.google.com with SMTP id 11so16662086qkl.0
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 13:26:36 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 14 Feb 2017 08:25:29 +1100
Message-Id: <20170213212536.31871-18-rth@twiddle.net>
In-Reply-To: <20170213212536.31871-1-rth@twiddle.net>
References: <20170213212536.31871-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 17/24] target/openrisc: Implement msync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/openrisc/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 6c8f05c..dd4ba8c 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1144,6 +1144,7 @@ static void dec_sys(DisasContext *dc, uint32_t insn)
 
     case 0x200:    /* l.msync */
         LOG_DIS("l.msync\n");
+        tcg_gen_mb(TCG_MO_ALL);
         break;
 
     case 0x270:    /* l.psync */
-- 
2.9.3
