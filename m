Received: from eggs.gnu.org ([2001:4830:134:3::10]:54127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSICR-0002CT-QC
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:01:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSICM-0002qT-1y
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:01:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gSICL-0002pD-QD
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:01:25 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2BA6781DFA
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 09:01:25 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 29 Nov 2018 10:01:18 +0100
Message-Id: <20181129090120.28828-3-pbonzini@redhat.com>
In-Reply-To: <20181129090120.28828-1-pbonzini@redhat.com>
References: <20181129090120.28828-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0 2/4] checkpatch: check Signed-off-by in
 --mailback mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Pull the test before the anticipated exits from the process sub.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d58fcb1efd..c216c55e01 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2866,6 +2866,10 @@ sub process {
 		}
 	}
=20
+	if ($is_patch && $chk_signoff && $signoff =3D=3D 0) {
+		ERROR("Missing Signed-off-by: line(s)\n");
+	}
+
 	# If we have no input at all, then there is nothing to report on
 	# so just keep quiet.
 	if ($#rawlines =3D=3D -1) {
@@ -2887,9 +2891,6 @@ sub process {
 	if (!$is_patch) {
 		ERROR("Does not appear to be a unified-diff format patch\n");
 	}
-	if ($is_patch && $chk_signoff && $signoff =3D=3D 0) {
-		ERROR("Missing Signed-off-by: line(s)\n");
-	}
=20
 	print report_dump();
 	if ($summary && !($clean =3D=3D 1 && $quiet =3D=3D 1)) {
--=20
2.19.1
