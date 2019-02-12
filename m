Received: from eggs.gnu.org ([209.51.188.92]:45276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gtYQg-0002Ks-Cy
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:48:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gtYQf-00076i-MC
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:48:54 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 12 Feb 2019 13:47:56 +0000
Message-Id: <20190212134758.10514-3-dgilbert@redhat.com>
In-Reply-To: <20190212134758.10514-1-dgilbert@redhat.com>
References: <20190212134758.10514-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/4] HMP: Prepend errors with 'Error:'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, kraxel@redhat.com, mst@redhat.com
Cc: qemu-trivial@nongnu.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Always make error messages start with 'Error:' as a fallback
to make sure that anything parsing them can tell it failed.

Note: Some places don't use hmp_handle_error

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hmp.c b/hmp.c
index b2a2b1f84e..4d14718fea 100644
--- a/hmp.c
+++ b/hmp.c
@@ -62,7 +62,7 @@ static void hmp_handle_error(Monitor *mon, Error **errp=
)
 {
     assert(errp);
     if (*errp) {
-        error_report_err(*errp);
+        error_reportf_err(*errp, "Error: ");
     }
 }
=20
--=20
2.20.1
