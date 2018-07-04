Received: from eggs.gnu.org ([2001:4830:134:3::10]:37387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fagWB-00030g-2t
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:04:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fagW7-0003Ew-Vj
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:04:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52194 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fagW7-0003Ei-RS
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:04:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C70E77890
	for <qemu-devel@nongnu.org>; Wed,  4 Jul 2018 12:04:15 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-235.ams2.redhat.com
	[10.36.117.235])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 843EA2026D76
	for <qemu-devel@nongnu.org>; Wed,  4 Jul 2018 12:04:14 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  4 Jul 2018 14:04:11 +0200
Message-Id: <20180704120412.19020-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] pr-manager-helper: fix memory leak on event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Reported by Coverity.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scsi/pr-manager-helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scsi/pr-manager-helper.c b/scsi/pr-manager-helper.c
index 519a296905..3027dde60d 100644
--- a/scsi/pr-manager-helper.c
+++ b/scsi/pr-manager-helper.c
@@ -46,6 +46,7 @@ static void pr_manager_send_status_changed_event(PRManagerHelper *pr_mgr)
     if (id) {
         qapi_event_send_pr_manager_status_changed(id, !!pr_mgr->ioc,
                                                   &error_abort);
+        g_free(id);
     }
 }
 
-- 
2.17.1
