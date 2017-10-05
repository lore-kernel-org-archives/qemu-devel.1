Received: from eggs.gnu.org ([2001:4830:134:3::10]:54360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e0BUZ-0002RR-Ht
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 15:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e0BUW-00067b-A0
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 15:07:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e0BUW-00065W-3j
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 15:07:28 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C2AAA128B
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 19:07:26 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu,  5 Oct 2017 20:07:25 +0100
Message-Id: <20171005190725.18712-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu_opt_print: Remove shadowing opt decl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, armbru@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

opt was declared as a separate local inside the last loop,
shadowing the local at the top of the function.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 util/qemu-option.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index 9b1dc8093b..877c5b4d67 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -766,7 +766,7 @@ void qemu_opts_print(QemuOpts *opts, const char *separator)
     }
     for (; desc && desc->name; desc++) {
         const char *value;
-        QemuOpt *opt = qemu_opt_find(opts, desc->name);
+        opt = qemu_opt_find(opts, desc->name);
 
         value = opt ? opt->str : desc->def_value_str;
         if (!value) {
-- 
2.13.6
