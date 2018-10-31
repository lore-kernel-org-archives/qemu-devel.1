Received: from eggs.gnu.org ([2001:4830:134:3::10]:35647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gHoo2-0004q3-OM
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gHony-0004O0-53
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:37:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gHonx-0004N8-U5
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:36:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E4B5331256C1
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 11:36:56 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 31 Oct 2018 11:36:51 +0000
Message-Id: <20181031113651.32430-3-berrange@redhat.com>
In-Reply-To: <20181031113651.32430-1-berrange@redhat.com>
References: <20181031113651.32430-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] scripts: report on author emails that are
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

In some cases the Author: email address in patches submitted to the
list gets mangled such that it says

    John Doe via Qemu-devel <qemu-devel@nongnu.org>

This change is a result of workarounds for DMARC policies.

Subsystem maintainers accepting patches need to catch these and fix
them before sending pull requests, so a checkpatch.pl test is highly
desirable.

Reviewed-by: Eric Blake <eblake@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 scripts/checkpatch.pl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3765b0e35e..06ec14e7f7 100755
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
2.19.1
