Received: from eggs.gnu.org ([2001:4830:134:3::10]:33562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4b-00025D-F7
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4W-0006oN-Bo
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:05 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4V-0005qd-EC
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:59 -0400
Received: by mail-wr1-x444.google.com with SMTP id w11-v6so13895593wrc.5
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:22 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:01:49 +0200
Message-Id: <1534870966-9287-18-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 17/74] seqlock: constify seqlock_read_begin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/seqlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/seqlock.h b/include/qemu/seqlock.h
index 8dee11d..c367516 100644
--- a/include/qemu/seqlock.h
+++ b/include/qemu/seqlock.h
@@ -45,7 +45,7 @@ static inline void seqlock_write_end(QemuSeqLock *sl)
     atomic_set(&sl->sequence, sl->sequence + 1);
 }
 
-static inline unsigned seqlock_read_begin(QemuSeqLock *sl)
+static inline unsigned seqlock_read_begin(const QemuSeqLock *sl)
 {
     /* Always fail if a write is in progress.  */
     unsigned ret = atomic_read(&sl->sequence);
-- 
1.8.3.1
