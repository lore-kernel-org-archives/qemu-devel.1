Received: from eggs.gnu.org ([2001:4830:134:3::10]:50442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gX1ZU-00052K-3m
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:16:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gX1ZR-0001q9-Db
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:16:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gX1ZR-0001oK-72
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:16:49 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 12 Dec 2018 10:16:32 +0000
Message-Id: <20181212101632.2600-3-stefanha@redhat.com>
In-Reply-To: <20181212101632.2600-1-stefanha@redhat.com>
References: <20181212101632.2600-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] trace: simple style changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Larry Dewey <ldewey@suse.com>

From: Larry Dewey <ldewey@suse.com>

This changes two lines in simple.c that end with a comma, and replaces th=
em
with a semi-colon.

Signed-off-by: Larry Dewey <ldewey@suse.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20181127190849.10558-1-ldewey@suse.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 trace/simple.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/trace/simple.c b/trace/simple.c
index 701dec639c..ac904eca91 100644
--- a/trace/simple.c
+++ b/trace/simple.c
@@ -169,9 +169,9 @@ static gpointer writeout_thread(gpointer opaque)
         wait_for_trace_records_available();
=20
         if (g_atomic_int_get(&dropped_events)) {
-            dropped.rec.event =3D DROPPED_EVENT_ID,
+            dropped.rec.event =3D DROPPED_EVENT_ID;
             dropped.rec.timestamp_ns =3D get_clock();
-            dropped.rec.length =3D sizeof(TraceRecord) + sizeof(uint64_t=
),
+            dropped.rec.length =3D sizeof(TraceRecord) + sizeof(uint64_t=
);
             dropped.rec.pid =3D trace_pid;
             do {
                 dropped_count =3D g_atomic_int_get(&dropped_events);
--=20
2.19.2
