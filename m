Received: from eggs.gnu.org ([2001:4830:134:3::10]:58633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsig-0006L6-VE
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsif-00047g-SS
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:35 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:40562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsif-00047K-M6
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:33 -0400
Received: by mail-wr0-x244.google.com with SMTP id s12so14430wre.7
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:48:33 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:47:08 +0100
Message-Id: <20180313224719.4954-59-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 58/69] replay/replay.c: bump REPLAY_VERSION again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Alex Bennée <alex.bennee@linaro.org>

This time commit 802f045a5f61b781df55e4492d896b4d20503ba7 broke the
replay file format. Also add a comment about this to
replay-internal.h.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20180227095231.1060.91180.stgit@pasha-VirtualBox>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 replay/replay-internal.h | 2 +-
 replay/replay.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index be96d7e879..8e4c701751 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -12,7 +12,7 @@
  *
  */
 
-
+/* Any changes to order/number of events will need to bump REPLAY_VERSION */
 enum ReplayEvents {
     /* for instruction event */
     EVENT_INSTRUCTION,
diff --git a/replay/replay.c b/replay/replay.c
index 7a23c62d61..9cddb6bfc9 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -22,7 +22,7 @@
 
 /* Current version of the replay mechanism.
    Increase it when file format changes. */
-#define REPLAY_VERSION              0xe02006
+#define REPLAY_VERSION              0xe02007
 /* Size of replay log header */
 #define HEADER_SIZE                 (sizeof(uint32_t) + sizeof(uint64_t))
 
-- 
2.14.3
