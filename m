Received: from eggs.gnu.org ([2001:4830:134:3::10]:55356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cW68E-0001II-Iv
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cW68D-0006pz-SA
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cW68D-0006pY-NK
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:49 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D5015C59D3
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 18:47:49 +0000 (UTC)
Received: from dgilbert-t530.redhat.com (ovpn-116-204.ams2.redhat.com
	[10.36.116.204])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v0OIlhUs020536
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 13:47:49 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 24 Jan 2017 18:47:33 +0000
Message-Id: <20170124184742.1639-7-dgilbert@redhat.com>
In-Reply-To: <20170124184742.1639-1-dgilbert@redhat.com>
References: <20170124184742.1639-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 06/15] block/vvfat: Remove the undesirable
 comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Ashijeet Acharya <ashijeetacharya@gmail.com>

Remove the "// assert(is_consistent(s))" comment in block/vvfat.c

Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
Message-Id: <1484566314-3987-2-git-send-email-ashijeetacharya@gmail.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 block/vvfat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index ded2109..7b706dc 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1189,7 +1189,6 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
         init_mbr(s, cyls, heads, secs);
     }
 
-    //    assert(is_consistent(s));
     qemu_co_mutex_init(&s->lock);
 
     /* Disable migration when vvfat is used rw */
-- 
2.9.3
