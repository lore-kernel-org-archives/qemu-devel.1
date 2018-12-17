Received: from eggs.gnu.org ([2001:4830:134:3::10]:43637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ29O-0001FF-V9
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:18:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ29O-00054Q-8w
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:18:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZ29O-00053z-1i
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:18:14 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3183F89AEB
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 23:18:13 +0000 (UTC)
Received: from donizetti.redhat.com (unknown [10.36.112.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2E8E35D9C5
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 23:18:11 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Dec 2018 00:16:56 +0100
Message-Id: <20181217231700.24482-32-pbonzini@redhat.com>
In-Reply-To: <20181217231700.24482-1-pbonzini@redhat.com>
References: <20181217231700.24482-1-pbonzini@redhat.com>
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
index df2da09b06..440d95d117 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2262,6 +2262,11 @@ sub process {
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
