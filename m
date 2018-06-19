Received: from eggs.gnu.org ([2001:4830:134:3::10]:58195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fV9Hx-0005Et-8U
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:34:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fV9Hw-0003aC-GS
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:34:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53672 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fV9Hw-0003a2-CH
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:34:44 -0400
From: Peter Xu <peterx@redhat.com>
Date: Tue, 19 Jun 2018 13:34:20 +0800
Message-Id: <20180619053426.13065-2-peterx@redhat.com>
In-Reply-To: <20180619053426.13065-1-peterx@redhat.com>
References: <20180619053426.13065-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 1/7] chardev: comment details for CLOSED
 event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, peterx@redhat.com, Eric Auger <eric.auger@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

It was unclear before on what does the CLOSED event mean.  Meanwhile we
add a TODO to fix up the CLOSED event in the future when the in/out
ports are different for a chardev.

CC: Paolo Bonzini <pbonzini@redhat.com>
CC: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/chardev/char.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/chardev/char.h b/include/chardev/char.h
index 04de45795e..6f0576e214 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -22,7 +22,16 @@ typedef enum {
     CHR_EVENT_OPENED, /* new connection established */
     CHR_EVENT_MUX_IN, /* mux-focus was set to this terminal */
     CHR_EVENT_MUX_OUT, /* mux-focus will move on */
-    CHR_EVENT_CLOSED /* connection closed */
+    CHR_EVENT_CLOSED /* connection closed.  NOTE: currently this event
+                      * is only bound to the read port of the chardev.
+                      * Normally the read port and write port of a
+                      * chardev should be the same, but it can be
+                      * different, e.g., for fd chardevs, when the two
+                      * fds are different.  So when we received the
+                      * CLOSED event it's still possible that the out
+                      * port is still open.  TODO: we should only send
+                      * the CLOSED event when both ports are closed.
+                      */
 } QEMUChrEvent;
=20
 #define CHR_READ_BUF_LEN 4096
--=20
2.17.1
