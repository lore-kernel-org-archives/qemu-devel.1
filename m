Received: from eggs.gnu.org ([2001:4830:134:3::10]:33912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gAEZx-0001uP-4S
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 09:31:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gAEZv-0002Zg-DU
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 09:31:09 -0400
Received: from mail.ispras.ru ([83.149.199.45]:44054)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gAEZv-0002Z9-50
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 09:31:07 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 10 Oct 2018 16:34:19 +0300
Message-ID: <20181010133419.24538.65437.stgit@pasha-VirtualBox>
In-Reply-To: <20181010133333.24538.53169.stgit@pasha-VirtualBox>
References: <20181010133333.24538.53169.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v7 08/19] replay: provide and accessor for rr
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
Cc: peter.maydell@linaro.org, war2jordan@live.com, pavel.dovgaluk@ispras.ru, mst@redhat.com, jasowang@redhat.com, zuban32s@gmail.com, kraxel@redhat.com, thomas.dullien@googlemail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, armbru@redhat.comdovgaluk@ispras.ru, dgilbert@redhat.com, boost.lists@gmail.com, alex.bennee@linaro.org, rth@twiddle.net, kwolf@redhat.com, crosthwaite.peter@gmail.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, pbonzini@redhat.com

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
index ceee20a..e6b1045 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -387,3 +387,8 @@ void replay_add_blocker(Error *reason)
 {
     replay_blockers = g_slist_prepend(replay_blockers, reason);
 }
+
+const char *replay_get_filename(void)
+{
+    return replay_filename;
+}
