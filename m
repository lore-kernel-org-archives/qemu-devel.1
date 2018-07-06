Received: from eggs.gnu.org ([2001:4830:134:3::10]:51096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fbUK5-0001GS-UT
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:15:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fbUK4-0000ms-I3
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:15:09 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:52031)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fbUK4-0000m9-9x
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:15:08 -0400
Received: by mail-wm0-x244.google.com with SMTP id s12-v6so15582019wmc.1
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 10:15:08 -0700 (PDT)
Received: from 640k.lan ([82.84.124.111]) by smtp.gmail.com with ESMTPSA id
	h40-v6sm13784683wrf.40.2018.07.06.10.15.06
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 06 Jul 2018 10:15:06 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  6 Jul 2018 19:14:26 +0200
Message-Id: <1530897268-22932-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530897268-22932-1-git-send-email-pbonzini@redhat.com>
References: <1530897268-22932-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 6/8] pr-manager-helper: fix memory leak on event
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
index 519a296..3027dde 100644
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
1.8.3.1
