Received: from eggs.gnu.org ([2001:4830:134:3::10]:38235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gEZPq-0002Qu-85
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:34:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gEZPn-0003Ff-Vn
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:34:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gEZPn-0002xY-Ee
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:34:35 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F0BA2C05D3F3
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 12:34:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-34.ams2.redhat.com
	[10.36.117.34])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B74B719484
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 12:34:21 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 22 Oct 2018 14:34:09 +0200
Message-Id: <20181022123413.28044-37-armbru@redhat.com>
In-Reply-To: <20181022123413.28044-1-armbru@redhat.com>
References: <20181022123413.28044-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 36/40] vl: Fix exit status for -drive format=help
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20181017082702.5581-35-armbru@redhat.com>
---
 vl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index 4efa2d08d4..812ceba425 100644
--- a/vl.c
+++ b/vl.c
@@ -4398,7 +4398,7 @@ int main(int argc, char **argv, char **envp)
     if (qemu_opts_foreach(qemu_find_opts("drive"), drive_init_func,
                           &machine_class->block_default_type, &error_fatal)) {
         /* We printed help */
-        exit(1);
+        exit(0);
     }
 
     default_drive(default_cdrom, snapshot, machine_class->block_default_type, 2,
-- 
2.17.2
