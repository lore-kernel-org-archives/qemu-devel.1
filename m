Received: from eggs.gnu.org ([2001:4830:134:3::10]:34046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gPXDp-0001wC-Sj
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:27:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gPXDk-0001Ju-Vw
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:27:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gPXDk-0001HH-OF
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:27:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8D94EC05FF87
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 18:27:27 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 21 Nov 2018 19:27:25 +0100
Message-Id: <20181121182725.4263-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] checkpatch: g_test_message does not need a a
 trailing newline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index eccd656c41..d27bc51f8c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2802,7 +2802,8 @@ sub process {
 				info_vreport|
 				error_report|
 				warn_report|
-				info_report}x;
+				info_report|
+                                g_test_message}x;
=20
 	if ($rawline =3D~ /\b(?:$qemu_error_funcs)\s*\(.*\".*\\n/) {
 		ERROR("Error messages should not contain newlines\n" . $herecurr);
--=20
2.19.1
