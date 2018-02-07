Received: from eggs.gnu.org ([2001:4830:134:3::10]:50270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1ejOT7-0000ae-Ki
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:04:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1ejOT2-0004CP-Iq
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:04:53 -0500
Received: from mail.ispras.ru ([83.149.199.45]:47502)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1ejOT2-0004C4-A8
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:04:48 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 07 Feb 2018 15:04:49 +0300
Message-ID: <20180207120449.5389.23124.stgit@pasha-VirtualBox>
In-Reply-To: <20180207120353.5389.54531.stgit@pasha-VirtualBox>
References: <20180207120353.5389.54531.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v6 10/20] replay/replay.c: bump
 REPLAY_VERSION again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, thomas.dullien@googlemail.com, pbonzini@redhat.com, alex.bennee@linaro.org

From: Alex Benn=C3=A9e <alex.bennee@linaro.org>

This time commit 802f045a5f61b781df55e4492d896b4d20503ba7 broke the
replay file format. Also add a comment about this to
replay-internal.h.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
---
 replay/replay-internal.h |    2 +-
 replay/replay.c          |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index be96d7e..8e4c701 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -12,7 +12,7 @@
  *
  */
=20
-
+/* Any changes to order/number of events will need to bump REPLAY_VERSIO=
N */
 enum ReplayEvents {
     /* for instruction event */
     EVENT_INSTRUCTION,
diff --git a/replay/replay.c b/replay/replay.c
index ff58a5a..4f24498 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -22,7 +22,7 @@
=20
 /* Current version of the replay mechanism.
    Increase it when file format changes. */
-#define REPLAY_VERSION              0xe02006
+#define REPLAY_VERSION              0xe02007
 /* Size of replay log header */
 #define HEADER_SIZE                 (sizeof(uint32_t) + sizeof(uint64_t)=
)
=20
