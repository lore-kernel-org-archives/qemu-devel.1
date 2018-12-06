Received: from eggs.gnu.org ([2001:4830:134:3::10]:33537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gV2zn-0003LE-Il
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 18:23:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gV2zh-0001SZ-UT
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 18:23:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gV2zf-0001Qq-P6
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 18:23:43 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 193FDC0270B4
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 23:23:42 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-112-16.ams2.redhat.com
	[10.36.112.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8431E62675
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 23:23:41 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  7 Dec 2018 00:23:33 +0100
Message-Id: <20181206232333.22408-7-pbonzini@redhat.com>
In-Reply-To: <20181206232333.22408-1-pbonzini@redhat.com>
References: <20181206232333.22408-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 6/6] checkpatch: warn about queue/queue.h head
 structs that are not typedef-ed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a8d6e44107..b4b3495044 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2263,6 +2263,11 @@ sub process {
 			}
 		}
=20
+		if ($line =3D~ /^.\s*(Q(?:S?LIST|SIMPLEQ|TAILQ)_HEAD)\s*\(\s*[^,]/ &&
+		    $line !~ /^.typedef/) {
+		    ERROR("named $1 should be typedefed separately\n" . $herecurr);
+		}
+
 # Need a space before open parenthesis after if, while etc
 		if ($line=3D~/\b(if|while|for|switch)\(/) {
 			ERROR("space required before the open parenthesis '('\n" . $herecurr)=
;
--=20
2.19.2
