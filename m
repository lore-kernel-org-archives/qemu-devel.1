Received: from eggs.gnu.org ([2001:4830:134:3::10]:56151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZdeZ-0006w9-A2
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:20:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZdeX-0004w7-1n
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:20:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZdeT-0004uM-F4
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:20:51 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C8D2B19D377
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 15:20:48 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-112-76.ams2.redhat.com
	[10.36.112.76])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1807617197
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 15:20:47 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Dec 2018 16:19:13 +0100
Message-Id: <20181219151917.3874-32-pbonzini@redhat.com>
In-Reply-To: <20181219151917.3874-1-pbonzini@redhat.com>
References: <20181219151917.3874-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 31/35] checkpatch: warn about qemu/queue.h head
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

These are just like any other struct or union, so they should have
CamelCase typedefs.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3d1ba9e8ae..d10dddf1be 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2310,6 +2310,11 @@ sub process {
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
2.20.1
