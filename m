Received: from eggs.gnu.org ([2001:4830:134:3::10]:50672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gSOXE-0007TZ-Cj
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 10:47:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gSOXB-0006Tn-7k
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 10:47:24 -0500
Received: from 10.mo179.mail-out.ovh.net ([46.105.79.46]:44059)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gSOXA-0006TF-Tm
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 10:47:21 -0500
Received: from player734.ha.ovh.net (unknown [10.109.146.106])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 12FA010A8B6
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 16:47:17 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 29 Nov 2018 16:47:12 +0100
Message-ID: <154350643288.788685.710801848628732800.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH for 4.0 1/2] 9p: use g_new(T,
 n) instead of g_malloc(sizeof(T) * n)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

Because it is a recommended coding practice (see HACKING).

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index bdf7919abfc5..55821343e594 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1331,8 +1331,8 @@ static void coroutine_fn v9fs_walk(void *opaque)
     trace_v9fs_walk(pdu->tag, pdu->id, fid, newfid, nwnames);
 
     if (nwnames && nwnames <= P9_MAXWELEM) {
-        wnames = g_malloc0(sizeof(wnames[0]) * nwnames);
-        qids   = g_malloc0(sizeof(qids[0]) * nwnames);
+        wnames = g_new0(V9fsString, nwnames);
+        qids   = g_new0(V9fsQID, nwnames);
         for (i = 0; i < nwnames; i++) {
             err = pdu_unmarshal(pdu, offset, "s", &wnames[i]);
             if (err < 0) {
