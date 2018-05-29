Received: from eggs.gnu.org ([2001:4830:134:3::10]:36635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNY89-0001SK-M2
	for qemu-devel@nongnu.org; Tue, 29 May 2018 02:29:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNY86-0001c9-I2
	for qemu-devel@nongnu.org; Tue, 29 May 2018 02:29:13 -0400
Received: from 4.mo5.mail-out.ovh.net ([178.33.111.247]:60617)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fNY86-0001bJ-Bw
	for qemu-devel@nongnu.org; Tue, 29 May 2018 02:29:10 -0400
Received: from player718.ha.ovh.net (unknown [10.109.120.118])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 2DC1C1B7377
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 08:29:08 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 29 May 2018 08:28:36 +0200
Message-Id: <20180529062838.20556-5-clg@kaod.org>
In-Reply-To: <20180529062838.20556-1-clg@kaod.org>
References: <20180529062838.20556-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/6] slirp/ncsi: fix "Get Version ID" payload
 length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
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
