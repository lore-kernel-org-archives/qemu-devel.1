Received: from eggs.gnu.org ([2001:4830:134:3::10]:33687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d2r5D-0007Ne-2a
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 23:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d2r59-00072B-4m
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 23:24:07 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:36782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1d2r59-00071n-0V
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 23:24:03 -0400
Received: by mail-it0-x244.google.com with SMTP id x188so19334586itb.3
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 20:24:02 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <54CC82B4-7CDC-41BC-8CD9-58C026A9EF15@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Mon, 24 Apr 2017 23:24:00 -0400
Subject: [Qemu-devel] [PATCH 8/9] Add end of test message
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

Print the message "End of test" on the risu host end.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
  risu.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/risu.c b/risu.c
index ed5b605..e7cbd57 100644
--- a/risu.c
+++ b/risu.c
@@ -63,6 +63,7 @@ void apprentice_sigill(int sig, siginfo_t *si, void  
*uc)
           return;
        case 1:
           /* end of test */
+         printf("End of test\n");
           exit(0);
        default:
           /* mismatch */
-- 
2.10.2
