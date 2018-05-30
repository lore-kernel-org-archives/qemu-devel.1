Received: from eggs.gnu.org ([2001:4830:134:3::10]:57163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNuJw-0007B9-T9
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNuJt-00065E-Mz
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:10:52 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:43131)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fNuJt-00064W-HR
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:10:49 -0400
Received: from player168.ha.ovh.net (unknown [10.109.122.118])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id E150013557B
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 08:10:47 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 30 May 2018 08:10:33 +0200
Message-Id: <20180530061035.22592-2-clg@kaod.org>
In-Reply-To: <20180530061035.22592-1-clg@kaod.org>
References: <20180530061035.22592-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/3] slirp/ncsi: fix "Get Version ID"
 payload length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 slirp/ncsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/slirp/ncsi.c b/slirp/ncsi.c
index d12ba3e494b0..02d0e9def3e8 100644
--- a/slirp/ncsi.c
+++ b/slirp/ncsi.c
@@ -60,7 +60,7 @@ static const struct ncsi_rsp_handler {
         { NCSI_PKT_RSP_EGMF,    4, NULL },
         { NCSI_PKT_RSP_DGMF,    4, NULL },
         { NCSI_PKT_RSP_SNFC,    4, NULL },
-        { NCSI_PKT_RSP_GVI,    36, NULL },
+        { NCSI_PKT_RSP_GVI,    40, NULL },
         { NCSI_PKT_RSP_GC,     32, ncsi_rsp_handler_gc },
         { NCSI_PKT_RSP_GP,     -1, NULL },
         { NCSI_PKT_RSP_GCPS,  172, NULL },
--=20
2.13.6
