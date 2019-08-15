Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E182C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:50:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EC2220578
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC2220578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyIx7-0001b2-Oj
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 12:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1hyIjs-0002sh-0w
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hyIjo-0003Ju-G8
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1246)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hyIjo-0003Jb-B7
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9602D11A1A;
 Thu, 15 Aug 2019 16:36:31 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-19.ams2.redhat.com
 [10.36.117.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 04F85BAB7;
 Thu, 15 Aug 2019 16:36:29 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 17:34:53 +0100
Message-Id: <20190815163504.18937-23-dgilbert@redhat.com>
In-Reply-To: <20190815163504.18937-1-dgilbert@redhat.com>
References: <20190815163504.18937-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Thu, 15 Aug 2019 16:36:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 22/33] hmp: Remove migration capabilities from
 "info migrate"
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: quintela@redhat.com, yury-kotov@yandex-team.ru,
 richardw.yang@linux.intel.com, marcandre.lureau@redhat.com,
 ivanren@tencent.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

With the growth of migration capabilities, it is not proper to display
them in "info migrate". Users are recommended to use "info
migrate_capabiltiies" to list them.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Message-Id: <20190806003645.8426-1-richardw.yang@linux.intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 monitor/hmp-cmds.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 5ca3ebe942..35788c0645 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -220,24 +220,11 @@ static char *SocketAddress_to_str(SocketAddress *ad=
dr)
 void hmp_info_migrate(Monitor *mon, const QDict *qdict)
 {
     MigrationInfo *info;
-    MigrationCapabilityStatusList *caps, *cap;
=20
     info =3D qmp_query_migrate(NULL);
-    caps =3D qmp_query_migrate_capabilities(NULL);
=20
     migration_global_dump(mon);
=20
-    /* do not display parameters during setup */
-    if (info->has_status && caps) {
-        monitor_printf(mon, "capabilities: ");
-        for (cap =3D caps; cap; cap =3D cap->next) {
-            monitor_printf(mon, "%s: %s ",
-                           MigrationCapability_str(cap->value->capabilit=
y),
-                           cap->value->state ? "on" : "off");
-        }
-        monitor_printf(mon, "\n");
-    }
-
     if (info->has_status) {
         monitor_printf(mon, "Migration status: %s",
                        MigrationStatus_str(info->status));
@@ -370,7 +357,6 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdic=
t)
         monitor_printf(mon, "]\n");
     }
     qapi_free_MigrationInfo(info);
-    qapi_free_MigrationCapabilityStatusList(caps);
 }
=20
 void hmp_info_migrate_capabilities(Monitor *mon, const QDict *qdict)
--=20
2.21.0


