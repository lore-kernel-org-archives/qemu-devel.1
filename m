Received: from eggs.gnu.org ([209.51.188.92]:38050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hJuKH-0001W3-BS
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:27:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hJuKG-0001NJ-B9
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:27:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hJuKG-0001LD-5Q
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:27:12 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6D1613082B41
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 06:27:10 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri, 26 Apr 2019 14:27:05 +0800
Message-Id: <20190426062705.4651-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH] checkpatch: allow SPDX-License-Identifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

According to: https://spdx.org/ids-how, let's still allow QEMU to use
the SPDX license identifier:

// SPDX-License-Identifier: ***

CC: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 88682cb0a9..c2aaf421da 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1949,7 +1949,8 @@ sub process {
 		}
 
 # no C99 // comments
-		if ($line =~ m{//}) {
+		if ($line =~ m{//} &&
+		    $rawline !~ m{// SPDX-License-Identifier: }) {
 			ERROR("do not use C99 // comments\n" . $herecurr);
 		}
 		# Remove C99 comments.
-- 
2.17.1
