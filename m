Received: from eggs.gnu.org ([2001:4830:134:3::10]:55995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZdeL-0006lR-U5
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:20:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZdeL-0004pW-2B
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:20:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:13727)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZdeK-0004p9-RV
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:20:40 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1E270A49E8
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 15:20:40 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Dec 2018 16:19:06 +0100
Message-Id: <20181219151917.3874-25-pbonzini@redhat.com>
In-Reply-To: <20181219151917.3874-1-pbonzini@redhat.com>
References: <20181219151917.3874-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 24/35] qemu/queue.h: do not access tqe_prev
 directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Markus Armbruster <armbru@redhat.com>

Use the QTAILQ_IN_USE macro instead, it does the same thing but the next
patch will change it to a different definition.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 blockdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index e6c8349409..20a5aa56b2 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -4254,7 +4254,7 @@ void qmp_blockdev_del(const char *node_name, Error =
**errp)
         goto out;
     }
=20
-    if (!bs->monitor_list.tqe_prev) {
+    if (!QTAILQ_IN_USE(bs, monitor_list)) {
         error_setg(errp, "Node %s is not owned by the monitor",
                    bs->node_name);
         goto out;
--=20
2.20.1
