Received: from eggs.gnu.org ([2001:4830:134:3::10]:49228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1erRLL-0006Hf-1U
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:46:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1erRLJ-00011P-Nm
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:46:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52438 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1erRLJ-00010v-JC
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:46:05 -0500
Date: Thu, 1 Mar 2018 18:46:04 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1519922735-29054-10-git-send-email-mst@redhat.com>
References: <1519922735-29054-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1519922735-29054-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/13] docs/vmcoreinfo: detail unsupported host
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
Cc: Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/specs/vmcoreinfo.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/docs/specs/vmcoreinfo.txt b/docs/specs/vmcoreinfo.txt
index 8212610..bcbca6f 100644
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
MST
