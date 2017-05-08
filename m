Received: from eggs.gnu.org ([2001:4830:134:3::10]:57498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d7jPe-0007Dq-2N
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:13:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d7jPd-0003Cm-5H
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:13:22 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  8 May 2017 16:13:01 +0200
Message-Id: <20170508141310.8674-3-pbonzini@redhat.com>
In-Reply-To: <20170508141310.8674-1-pbonzini@redhat.com>
References: <20170508141310.8674-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 02/11] blockjob: remove iostatus_reset callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jcody@redhat.com, jsnow@redhat.com, stefanha@redhat.com

This is unused since commit 66a0fae ("blockjob: Don't touch BDS iostatus"=
,
2016-05-19).

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 blockjob.c                   | 3 ---
 include/block/blockjob_int.h | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 23022b3331..71187d0c9e 100644
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
index 3f86cc5acc..bfcc5d1241 100644
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
2.12.2
