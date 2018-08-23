Received: from eggs.gnu.org ([2001:4830:134:3::10]:47139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fsmnj-00046F-8K
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 06:25:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fsmna-0000rc-IU
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 06:25:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44590 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fsmna-0000qB-2O
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 06:25:06 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 23 Aug 2018 11:25:02 +0100
Message-Id: <20180823102502.28122-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] scripts: report on author emails that are
 mangled by the mailing list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

In some cases the Author: email address in patches submitted to the
list gets mangled such that it says

    John Doe via Qemu-devel <qemu-devel@nongnu.org>

This change is a result of workarounds for DMARC policies.

Subsystem maintainers accepting patches need to catch these and fix
them before sending pull requests, so a checkpatch.pl test is highly
desirable.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 scripts/checkpatch.pl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 42e1c50dd8..be2114a179 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1402,6 +1402,10 @@ sub process {
 			$is_patch =3D 1;
 		}
=20
+		if ($line =3D~ /^Author: .*via Qemu-devel.*<qemu-devel\@nongnu.org>/) =
{
+		    ERROR("Author email address is mangled by the mailing list\n" . $h=
erecurr);
+		}
+
 #check the patch for a signoff:
 		if ($line =3D~ /^\s*signed-off-by:/i) {
 			# This is a signoff, if ugly, so do not double report.
--=20
2.17.1
