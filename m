Received: from eggs.gnu.org ([2001:4830:134:3::10]:46081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1cOTeJ-000851-7V
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 13:17:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1cOTeF-0007Hr-5r
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 13:17:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:42919)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <msuchanek@suse.de>) id 1cOTeE-0007Hm-VW
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 13:17:23 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 02F1AAAB5
	for <qemu-devel@nongnu.org>; Tue,  3 Jan 2017 18:17:22 +0000 (UTC)
From: Michal Suchanek <msuchanek@suse.de>
Date: Tue,  3 Jan 2017 19:16:49 +0100
Message-Id: <b386e3ca9c209468134595553970b9a88cfb631b.1483467324.git.msuchanek@suse.de>
In-Reply-To: <ee97fcda99c77c62d64c1baa88fd17fed7639626.1483467324.git.msuchanek@suse.de>
References: <ee97fcda99c77c62d64c1baa88fd17fed7639626.1483467324.git.msuchanek@suse.de>
In-Reply-To: <ee97fcda99c77c62d64c1baa88fd17fed7639626.1483467324.git.msuchanek@suse.de>
References: <20161213173354.jffasav66gdl7v4q@wingsuit>
	<ee97fcda99c77c62d64c1baa88fd17fed7639626.1483467324.git.msuchanek@suse.de>
Subject: [Qemu-devel] [PATCH v2 2/2] Quiet uninitialized variable warning.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michal Suchanek <msuchanek@suse.de>

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 src/vdagentd/vdagentd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/vdagentd/vdagentd.c b/src/vdagentd/vdagentd.c
index 991514e..60a866e 100644
--- a/src/vdagentd/vdagentd.c
+++ b/src/vdagentd/vdagentd.c
@@ -334,6 +334,7 @@ static void do_client_file_xfer(struct vdagent_virtio_port *vport,
         id = d->id;
         break;
     }
+    default: return; /* quiet uninitialized variable warning */
     }
 
     conn = g_hash_table_lookup(active_xfers, GUINT_TO_POINTER(id));
-- 
2.10.2
