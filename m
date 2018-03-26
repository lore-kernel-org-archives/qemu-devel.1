Received: from eggs.gnu.org ([2001:4830:134:3::10]:38225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0Lmv-0002HU-UM
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 02:39:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0Lmr-0006k5-3E
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 02:39:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38656 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f0Lmq-0006jy-VD
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 02:39:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 895A47C6DC
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 06:39:20 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 26 Mar 2018 14:38:57 +0800
Message-Id: <20180326063901.27425-5-peterx@redhat.com>
In-Reply-To: <20180326063901.27425-1-peterx@redhat.com>
References: <20180326063901.27425-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 4/8] qapi: restrict allow-oob value to
 be "true"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

It was missed in the first version of OOB series.  We should check this
to make sure we throw the right error when fault value is passed in.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 scripts/qapi/common.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 2c05e3c284..3e14bc41f2 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -872,7 +872,7 @@ def check_keys(expr_elem, meta, required, optional=[]):
             raise QAPISemError(info,
                                "'%s' of %s '%s' should only use false value"
                                % (key, meta, name))
-        if key == 'boxed' and value is not True:
+        if (key == 'boxed' or key == 'allow-oob') and value is not True:
             raise QAPISemError(info,
                                "'%s' of %s '%s' should only use true value"
                                % (key, meta, name))
-- 
2.14.3
