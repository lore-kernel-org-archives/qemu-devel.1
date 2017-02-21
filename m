Received: from eggs.gnu.org ([2001:4830:134:3::10]:37449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg5Kh-0000mm-B5
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:58:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg5Kg-0002Lw-Je
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:57:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cg5Kg-0002KI-Do
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:57:58 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7DC3A42BA3
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 07:57:58 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Feb 2017 08:57:51 +0100
Message-Id: <1487663871-11859-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] spice: set merge-lists
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

This way you can use -spice multiple times on the command line
and qemu will actually pick up all options.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/spice-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/spice-core.c b/ui/spice-core.c
index 39ccab7..d613f1a 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -412,6 +412,7 @@ static SpiceChannelList *qmp_query_spice_channels(void)
 
 static QemuOptsList qemu_spice_opts = {
     .name = "spice",
+    .merge_lists = true,
     .head = QTAILQ_HEAD_INITIALIZER(qemu_spice_opts.head),
     .desc = {
         {
-- 
1.8.3.1
