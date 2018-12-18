Received: from eggs.gnu.org ([2001:4830:134:3::10]:46591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gZDRe-0002oR-Ie
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:21:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gZDRb-0005vS-Dt
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:21:50 -0500
Received: from mail.ispras.ru ([83.149.199.45]:55498)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gZDRb-0005uz-4N
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:21:47 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 18 Dec 2018 14:21:48 +0300
Message-ID: <20181218112148.11727.84619.stgit@pasha-VirtualBox>
In-Reply-To: <20181218112056.11727.96529.stgit@pasha-VirtualBox>
References: <20181218112056.11727.96529.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v8 09/20] replay: provide and accessor for rr
 filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, thomas.dullien@googlemail.com, pbonzini@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

This patch adds an accessor function for the name of the record/replay
log file. Adding an accessor instead of making variable global,
prevents accidental modification of this variable by other modules.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 include/sysemu/replay.h |    2 ++
 replay/replay.c         |    5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 3a7c58e..b3f593f 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -71,6 +71,8 @@ void replay_start(void);
 void replay_finish(void);
 /*! Adds replay blocker with the specified error description */
 void replay_add_blocker(Error *reason);
+/* Returns name of the replay log file */
+const char *replay_get_filename(void);
 
 /* Processing the instructions */
 
diff --git a/replay/replay.c b/replay/replay.c
index b75820a..aa53411 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -394,3 +394,8 @@ void replay_add_blocker(Error *reason)
 {
     replay_blockers = g_slist_prepend(replay_blockers, reason);
 }
+
+const char *replay_get_filename(void)
+{
+    return replay_filename;
+}
