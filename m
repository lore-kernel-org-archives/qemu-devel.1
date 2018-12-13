Received: from eggs.gnu.org ([2001:4830:134:3::10]:43977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gXMuh-0005FM-Kn
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 04:04:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gXMub-0001Ga-6E
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 04:04:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gXMua-0001Du-OP
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 04:04:04 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wBD8xPC1065109
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 04:04:03 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pbku7j84j-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 04:04:03 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 13 Dec 2018 09:04:01 -0000
From: Greg Kurz <groug@kaod.org>
Date: Thu, 13 Dec 2018 10:03:41 +0100
In-Reply-To: <20181213090343.1137475-1-groug@kaod.org>
References: <20181213090343.1137475-1-groug@kaod.org>
Message-Id: <20181213090343.1137475-2-groug@kaod.org>
Subject: [Qemu-devel] [PULL 1/3] 9p: use g_new(T,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

Because it is a recommended coding practice (see HACKING).

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/9pfs/9p.c | 4 ++--
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
-- 
2.17.2
