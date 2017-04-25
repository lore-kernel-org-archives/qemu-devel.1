Received: from eggs.gnu.org ([2001:4830:134:3::10]:34016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d2r61-0007wt-0m
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 23:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d2r5y-0007Sc-Vw
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 23:24:57 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:34958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1d2r5y-0007SN-N3
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 23:24:54 -0400
Received: by mail-it0-x241.google.com with SMTP id 70so1390295ita.2
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 20:24:54 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <64739DD5-CBC0-4837-8635-E081D57385A5@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Mon, 24 Apr 2017 23:24:51 -0400
Subject: [Qemu-devel] [PATCH 9/9] Add more descriptive comment for mismatch
 or end of test condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

Replace the comment "mismatch, or end of test" with "called for a  
mismatch,
or for the end of a test". This describes what happens better.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
  risu.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/risu.c b/risu.c
index e7cbd57..bd771b1 100644
--- a/risu.c
+++ b/risu.c
@@ -48,7 +48,7 @@ void master_sigill(int sig, siginfo_t *si, void *uc)
           advance_pc(uc);
           return;
        default:
-         /* mismatch, or end of test */
+         /* called for a mismatch, or for the end of a test */
           siglongjmp(jmpbuf, 1);
     }
  }
-- 
2.10.2
