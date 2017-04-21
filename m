Received: from eggs.gnu.org ([2001:4830:134:3::10]:46093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XDG-0003fX-OJ
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XDF-0007wY-T5
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:58:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d1XDF-0007wQ-MV
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:58:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 938182EAAAB
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 11:58:56 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 21 Apr 2017 13:56:45 +0200
Message-Id: <20170421115646.15544-65-quintela@redhat.com>
In-Reply-To: <20170421115646.15544-1-quintela@redhat.com>
References: <20170421115646.15544-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 64/65] hmp: info migrate_capability format tunes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

Dump the info in a single line is hard to read. Do it one per line.
Also, the first "capabilities:" didn't help much. Let's remove it.

CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hmp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hmp.c b/hmp.c
index be75e71..70db84f 100644
--- a/hmp.c
+++ b/hmp.c
@@ -268,13 +268,11 @@ void hmp_info_migrate_capabilities(Monitor *mon, co=
nst QDict *qdict)
     caps =3D qmp_query_migrate_capabilities(NULL);
=20
     if (caps) {
-        monitor_printf(mon, "capabilities: ");
         for (cap =3D caps; cap; cap =3D cap->next) {
-            monitor_printf(mon, "%s: %s ",
+            monitor_printf(mon, "%s: %s\n",
                            MigrationCapability_lookup[cap->value->capabi=
lity],
                            cap->value->state ? "on" : "off");
         }
-        monitor_printf(mon, "\n");
     }
=20
     qapi_free_MigrationCapabilityStatusList(caps);
--=20
2.9.3
