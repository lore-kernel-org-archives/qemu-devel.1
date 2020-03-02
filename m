Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B960EC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 13:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E2BE2064A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 13:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E2BE2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8kwj-000448-R0
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 08:17:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48815)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j8knl-0006Gv-Uf
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 08:08:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j8knk-0003Pa-QF
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 08:08:05 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:51768 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1j8knj-0003Mq-K9; Mon, 02 Mar 2020 08:08:04 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 64C489648BA4CAF3AFE9;
 Mon,  2 Mar 2020 21:07:58 +0800 (CST)
Received: from huawei.com (10.133.205.93) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Mon, 2 Mar 2020
 21:07:52 +0800
From: Chen Qun <kuhn.chenqun@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH v3 12/12] monitor/hmp-cmds: Remove redundant statement in
 hmp_rocker_of_dpa_groups()
Date: Mon, 2 Mar 2020 21:07:15 +0800
Message-ID: <20200302130715.29440-14-kuhn.chenqun@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20200302130715.29440-1-kuhn.chenqun@huawei.com>
References: <20200302130715.29440-1-kuhn.chenqun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [10.133.205.93]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com, "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>, Euler Robot <euler.robot@huawei.com>,
 Chen Qun <kuhn.chenqun@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Clang static code analyzer show warning:
monitor/hmp-cmds.c:2867:17: warning: Value stored to 'set' is never read
                set =3D true;
                ^     ~~~~

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

v1->v2: move the 'set' declaration to the for() statement(Base on Philipp=
e's suggestion).
---
 monitor/hmp-cmds.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 53bc3f76c4..c6b0495822 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -2808,7 +2808,6 @@ void hmp_rocker_of_dpa_groups(Monitor *mon, const Q=
Dict *qdict)
     const char *name =3D qdict_get_str(qdict, "name");
     uint8_t type =3D qdict_get_try_int(qdict, "type", 9);
     Error *err =3D NULL;
-    bool set =3D false;
=20
     list =3D qmp_query_rocker_of_dpa_groups(name, type !=3D 9, type, &er=
r);
     if (err !=3D NULL) {
@@ -2820,6 +2819,7 @@ void hmp_rocker_of_dpa_groups(Monitor *mon, const Q=
Dict *qdict)
=20
     for (g =3D list; g; g =3D g->next) {
         RockerOfDpaGroup *group =3D g->value;
+        bool set =3D false;
=20
         monitor_printf(mon, "0x%08x", group->id);
=20
@@ -2864,14 +2864,11 @@ void hmp_rocker_of_dpa_groups(Monitor *mon, const=
 QDict *qdict)
=20
         if (group->has_set_eth_dst) {
             if (!set) {
-                set =3D true;
                 monitor_printf(mon, " set");
             }
             monitor_printf(mon, " dst %s", group->set_eth_dst);
         }
=20
-        set =3D false;
-
         if (group->has_ttl_check && group->ttl_check) {
             monitor_printf(mon, " check TTL");
         }
--=20
2.23.0



