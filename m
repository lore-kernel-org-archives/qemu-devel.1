Received: from eggs.gnu.org ([2001:4830:134:3::10]:32963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1er48A-0000rz-33
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 10:58:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1er485-000623-7n
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 10:58:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33364 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1er485-00061n-2x
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 10:58:53 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C4521A27F2
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 15:58:51 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 28 Feb 2018 16:58:39 +0100
Message-Id: <20180228155839.24886-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] docs/vmcoreinfo: detail unsupported host
 format behaviour
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 docs/specs/vmcoreinfo.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/docs/specs/vmcoreinfo.txt b/docs/specs/vmcoreinfo.txt
index 821261067f..bcbca6fe47 100644
--- a/docs/specs/vmcoreinfo.txt
+++ b/docs/specs/vmcoreinfo.txt
@@ -29,6 +29,10 @@ processing of entry values.
 A write of 0 in guest_format will disable further processing of
 vmcoreinfo entry values & content.
=20
+You may write a guest_format that is not supported by the host, in
+which case the entry data can be ignored by qemu (but you may still
+access it through a debugger, via vmcoreinfo_realize::vmcoreinfo_state).
+
 Format & content
 ****************
=20
--=20
2.16.1.73.g5832b7e9f2
