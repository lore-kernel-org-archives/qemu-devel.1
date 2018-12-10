Received: from eggs.gnu.org ([2001:4830:134:3::10]:33507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gWQIF-0000CX-VK
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:28:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gWQIF-0003mv-6M
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:28:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38697)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gWQIE-0003ln-Vi
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:28:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3FE413002091
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 18:28:34 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 10 Dec 2018 19:28:16 +0100
Message-Id: <20181210182816.2014-9-pbonzini@redhat.com>
In-Reply-To: <20181210182816.2014-1-pbonzini@redhat.com>
References: <20181210182816.2014-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 8/8] checkpatch: warn about qemu/queue.h head
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
Cc: armbru@redhat.com

These are just like any other struct or union, so they should have
CamelCase typedefs.

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
