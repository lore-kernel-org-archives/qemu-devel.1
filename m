Received: from eggs.gnu.org ([2001:4830:134:3::10]:44190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eQzFG-0002YY-9e
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eQzFE-0004cD-Hq
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eQzFE-0004a5-6n
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:28 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 547BA2D6A30
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 17:30:27 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 18 Dec 2017 18:30:22 +0100
Message-Id: <20171218173023.21417-10-armbru@redhat.com>
In-Reply-To: <20171218173023.21417-1-armbru@redhat.com>
References: <20171218173023.21417-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 09/10] option: Remove shadowing opt decl from
 qemu_opt_print()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

opt was declared as a separate local inside the last loop,
shadowing the local at the top of the function.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20171005190725.18712-1-dgilbert@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
