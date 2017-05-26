Received: from eggs.gnu.org ([2001:4830:134:3::10]:46152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dEKqQ-0002LC-GR
	for qemu-devel@nongnu.org; Fri, 26 May 2017 15:24:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dEKqP-0005tB-KU
	for qemu-devel@nongnu.org; Fri, 26 May 2017 15:24:18 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Fri, 26 May 2017 15:23:54 -0400
Message-Id: <20170526192404.32186-3-jcody@redhat.com>
In-Reply-To: <20170526192404.32186-1-jcody@redhat.com>
References: <20170526192404.32186-1-jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/12] blockjob: remove iostatus_reset callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

This is unused since commit 66a0fae ("blockjob: Don't touch BDS iostatus"=
,
2016-05-19).

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Message-id: 20170508141310.8674-3-pbonzini@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 blockjob.c                   | 3 ---
 include/block/blockjob_int.h | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 23022b3..71187d0 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -555,9 +555,6 @@ bool block_job_is_cancelled(BlockJob *job)
 void block_job_iostatus_reset(BlockJob *job)
 {
     job->iostatus =3D BLOCK_DEVICE_IO_STATUS_OK;
-    if (job->driver->iostatus_reset) {
-        job->driver->iostatus_reset(job);
-    }
 }
=20
 static int block_job_finish_sync(BlockJob *job,
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index 3f86cc5..bfcc5d1 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -44,9 +44,6 @@ struct BlockJobDriver {
     /** Optional callback for job types that support setting a speed lim=
it */
     void (*set_speed)(BlockJob *job, int64_t speed, Error **errp);
=20
-    /** Optional callback for job types that need to forward I/O status =
reset */
-    void (*iostatus_reset)(BlockJob *job);
-
     /** Mandatory: Entrypoint for the Coroutine. */
     CoroutineEntry *start;
=20
--=20
2.9.3
