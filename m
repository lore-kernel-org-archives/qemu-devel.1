Received: from eggs.gnu.org ([2001:4830:134:3::10]:44764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cT5W8-0008RG-6q
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 06:32:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cT5W2-0002at-Fg
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 06:32:04 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:33331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cT5W2-0002ai-AI
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 06:31:58 -0500
Received: by mail-pf0-x241.google.com with SMTP id e4so3692133pfg.0
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 03:31:58 -0800 (PST)
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Mon, 16 Jan 2017 17:01:50 +0530
Message-Id: <1484566314-3987-2-git-send-email-ashijeetacharya@gmail.com>
In-Reply-To: <1484566314-3987-1-git-send-email-ashijeetacharya@gmail.com>
References: <1484566314-3987-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v6 1/5] block/vvfat: Remove the undesirable
 comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com
Cc: jsnow@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, quintela@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com, groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, Ashijeet Acharya <ashijeetacharya@gmail.com>

Remove the "// assert(is_consistent(s))" comment in block/vvfat.c

Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
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
2.6.2
