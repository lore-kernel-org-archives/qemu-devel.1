Received: from eggs.gnu.org ([2001:4830:134:3::10]:35921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRZbE-0001OC-0M
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 03:19:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRZbC-0002di-T9
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 03:19:36 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 20 Dec 2017 09:19:22 +0100
Message-Id: <20171220081927.8761-6-armbru@redhat.com>
In-Reply-To: <20171220081927.8761-1-armbru@redhat.com>
References: <20171220081927.8761-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 05/10] qemu-options: Add missing -iscsi
 Texinfo documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Ronnie Sahlberg <ronniesahlberg@gmail.com>
---
 qemu-options.hx | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 3d05bcf557..a173378d98 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1190,6 +1190,12 @@ DEF("iscsi", HAS_ARG, QEMU_OPTION_iscsi,
     "                iSCSI session parameters\n", QEMU_ARCH_ALL)
=20
 STEXI
+@item -iscsi
+@findex -iscsi
+Configure iSCSI session parameters.
+ETEXI
+
+STEXI
 @end table
 ETEXI
 DEFHEADING()
--=20
2.13.6
