Received: from eggs.gnu.org ([2001:4830:134:3::10]:43005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ28U-0000FY-Qf
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ28U-0003CI-24
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZ28T-0003Bp-SZ
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:17 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Dec 2018 00:16:29 +0100
Message-Id: <20181217231700.24482-5-pbonzini@redhat.com>
In-Reply-To: <20181217231700.24482-1-pbonzini@redhat.com>
References: <20181217231700.24482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/35] checkpatch: check Signed-off-by in
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Pull the test before the anticipated exits from the process sub.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c503122911..d20bc58578 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2816,6 +2816,10 @@ sub process {
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
@@ -2837,9 +2841,6 @@ sub process {
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
2.20.1
