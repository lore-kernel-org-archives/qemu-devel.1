Received: from eggs.gnu.org ([2001:4830:134:3::10]:39525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gC1R5-0004A1-R0
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gC1R3-00025E-DT
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gC1R3-00021G-0X
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:21 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1165B30031B0
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 11:53:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D2A7410694C7
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 11:53:17 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 15 Oct 2018 13:53:08 +0200
Message-Id: <20181015115309.17089-35-armbru@redhat.com>
In-Reply-To: <20181015115309.17089-1-armbru@redhat.com>
References: <20181015115309.17089-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 34/35] vl: Fix exit status for -drive
 format=help
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
---
 vl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index 22beca29d1..89520d8007 100644
--- a/vl.c
+++ b/vl.c
@@ -4397,7 +4397,7 @@ int main(int argc, char **argv, char **envp)
     if (qemu_opts_foreach(qemu_find_opts("drive"), drive_init_func,
                           &machine_class->block_default_type, &error_fatal)) {
         /* We printed help */
-        exit(1);
+        exit(0);
     }
 
     default_drive(default_cdrom, snapshot, machine_class->block_default_type, 2,
-- 
2.17.1
