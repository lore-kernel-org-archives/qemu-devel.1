Received: from eggs.gnu.org ([2001:4830:134:3::10]:38698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmtO-0002Eb-Tc
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmtO-0007HB-4W
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50206 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fOmtO-0007Gw-0H
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:06 -0400
Date: Fri, 1 Jun 2018 19:26:58 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180601162620.32362-14-mst@redhat.com>
References: <20180601162620.32362-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180601162620.32362-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/31] trace: use local path for local headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

When pulling in headers that are in the same directory as the C file (as
opposed to one in include/), we should use its relative path, without a
directory.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 trace/control.h | 2 +-
 trace/qmp.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/trace/control.h b/trace/control.h
index 1903e22975..eb65c8e320 100644
--- a/trace/control.h
+++ b/trace/control.h
@@ -267,6 +267,6 @@ char *trace_opt_parse(const char *optarg);
 uint32_t trace_get_vcpu_event_count(void);
=20
=20
-#include "trace/control-internal.h"
+#include "control-internal.h"
=20
 #endif /* TRACE__CONTROL_H */
diff --git a/trace/qmp.c b/trace/qmp.c
index 756086c79f..ea99b00956 100644
--- a/trace/qmp.c
+++ b/trace/qmp.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-trace.h"
-#include "trace/control.h"
+#include "control.h"
=20
=20
 static CPUState *get_cpu(bool has_vcpu, int vcpu, Error **errp)
--=20
MST
