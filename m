Received: from eggs.gnu.org ([2001:4830:134:3::10]:40571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eEWPf-0008V9-OV
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:17:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eEWPe-0006ZR-RB
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:17:43 -0500
Received: from mail.ispras.ru ([83.149.199.45]:52696)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eEWPe-0006Yt-Ji
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:17:42 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 14 Nov 2017 11:17:50 +0300
Message-ID: <20171114081750.27640.53609.stgit@pasha-VirtualBox>
In-Reply-To: <20171114081630.27640.53933.stgit@pasha-VirtualBox>
References: <20171114081630.27640.53933.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v2 14/26] replay/replay.c: bump
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, pbonzini@redhat.com, alex.bennee@linaro.org

From: Alex Benn=C3=A9e <alex.bennee@linaro.org>

This time commit 802f045a5f61b781df55e4492d896b4d20503ba7 broke the
replay file format. Also add a comment about this to
replay-internal.h.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

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
