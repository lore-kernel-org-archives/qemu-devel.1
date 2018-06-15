Received: from eggs.gnu.org ([2001:4830:134:3::10]:47143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fTdlw-0008TF-96
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 21:43:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fTdlt-0003kh-5S
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 21:43:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59420 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fTdlt-0003k8-0a
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 21:43:25 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 15 Jun 2018 09:42:47 +0800
Message-Id: <20180615014249.22730-5-peterx@redhat.com>
In-Reply-To: <20180615014249.22730-1-peterx@redhat.com>
References: <20180615014249.22730-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 4/6] docs: mention shared state protect for
 OOB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, peterx@redhat.com, Eric Auger <eric.auger@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Out-Of-Band handlers need to protect shared state if there is any.
Mention it in the document.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 1366228b2a..bee9de35df 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -680,6 +680,9 @@ OOB command handlers must satisfy the following conditions:
 - It does not invoke system calls that may block,
 - It does not access guest RAM that may block when userfaultfd is
   enabled for postcopy live migration.
+- It needs to protect any shared state, since as long as a command
+  supports Out-Of-Band it means the handler can be run in parallel
+  with the same handler running in the other thread.
 
 If in doubt, do not implement OOB execution support.
 
-- 
2.17.1
