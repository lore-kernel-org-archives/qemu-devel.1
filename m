Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA53C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:30:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43B8520826
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KwWCjEC9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B8520826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrI1g-0004e1-Bh
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrHgb-0000eu-N1
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:08:45 -0400
Received: from mail-eopbgr140101.outbound.protection.outlook.com
 ([40.107.14.101]:36097 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrHgZ-0005Dh-MT
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:08:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMKHghLP5oNlprDI5J7E3WEf2xjW8Q0ueBeFQMjvj7wU4WVbTXkzo15rpC89xcz7VoGaViSuT+cEjHWd6H7EeB3c30tMoetN/61GoKKXV460W97QZn3nSr5f1CIq0IZAM9Q38lTe+zv84IZwn84F1Vvsf52HTVINhfuoZQ2F1+DeK2Z9c+PnJZGvMneEl9lwZ0yT+p/rSmAVz7JV9UTVs0Yqk9BJov2TlUEIIBV9jGY0A8jsu5iHfCqcpOWwtcOZwooSbdzR+IyNeDxjULInmh/FUN9yUk37XyNZgiR+J+w05W8+zbKU3h8EZMw3f2cHdNhRw28Weua5K/1Jnx/XoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLS2vZwqKjNo8yFNC2KJ758NbGUySmI6IVyIutoTH6Q=;
 b=i4sjXxpldO+plgIylFMUO4yfAVb4GHbARzBRTl98oFzH0kWHfgQue1fTIKiTd5tRsqTB2OP2jYdRvZVUYBiCzUf+I9ZDLRuY19eaNdWtmgayNw6Oew+oR9QAkRKP3VuqNne1+3ZmlfzQup0UIe/VMszDo8Pt/2Fyx8QBCEbCQokDO9xSxMZ10pK1Y/IrZ+OepURw+OX8FipOvmz86SQxqkOgK52WRQDZAvzyOv8i8kMp0bt3xcatqTct5MAHNWehS6M/yMDsEmSRbHp/sh3OAolaAb7K4BPuzNS74kSw4giMGsIrbyKn2/eRqwCEnC11DrkEUarcAuMj7xfNzVU9yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLS2vZwqKjNo8yFNC2KJ758NbGUySmI6IVyIutoTH6Q=;
 b=KwWCjEC9+ROR9IgOvnz8g1OjNuIZ05f5Q6MKvHReof/M+m/Wcow8QXxBvXAJ74sp9RsAsv19mXXYjwgdNwW1HvBzxpwCpkIzqP1MZs8w0wXfnv/FbaLuFCkcPXHVO12vOKieSOkEyvFl4bz4MocauiDHyHrJaYYatHKiS9VQBXQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5448.eurprd08.prod.outlook.com (2603:10a6:20b:106::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Fri, 3 Jul
 2020 09:08:35 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Fri, 3 Jul 2020
 09:08:35 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 6/8] virtio-9p: introduce ERRP_AUTO_PROPAGATE
Date: Fri,  3 Jul 2020 12:08:14 +0300
Message-Id: <20200703090816.3295-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200703090816.3295-1-vsementsov@virtuozzo.com>
References: <20200703090816.3295-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0022.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.15) by
 AM0PR10CA0022.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend
 Transport; Fri, 3 Jul 2020 09:08:34 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0cba43f-a9f9-4150-9de6-08d81f30aa92
X-MS-TrafficTypeDiagnostic: AM7PR08MB5448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5448CCCE371D6225DDE0469BC16A0@AM7PR08MB5448.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:121;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZAM9mMsH9IC3xMQlNmbaCnSsdd4IpEB3A3lmslVrKWWhF+RdBGyBAVpDfXdHfj1+aoXxL4BIlNbbPHdNb7eTYgGHHZf7gH2Ojp9C69KwfX/P23C9Ne2ASTUKGqJDvvlZFLr0j3L/GkA4yf3S3dcU85giEX/9L4F2lspGvlu7rcIisUPANLqEy4YO1j2qP0t0j/NNekA95mrfq+591eYinGOOlZlkJ4SVsblIohyfclGkqcl61uEg9FAOz02lCBg0fm08WWli96dlxAbL+BDz+jQZJUSWwjRthcJB+pdyXDAg7XQK2XqgGQk1Wwvv22/UcfjFnBo/Hk8oB4UbzH+qa1RSsS5LsmWrVEsWEpYwXy3DEpWyAEoOjLghp1srTWga
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(366004)(376002)(136003)(396003)(346002)(69590400007)(66946007)(66476007)(66556008)(2906002)(86362001)(1076003)(8676002)(83380400001)(6512007)(5660300002)(8936002)(6666004)(186003)(36756003)(4326008)(6506007)(16526019)(6486002)(6916009)(26005)(478600001)(956004)(52116002)(316002)(54906003)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: o0ylnD2IjQ6jC5T/Z7d6pV3diiDSZQnoV02pVENMEca6r4oocJlalOmf9VZS5i5nm4BOC37OvRci9t4RDvh9AqQeTBswExsQ6snlRxrU4VVXxKIhC8bGyeWnEttPc9sC5X2t0jwJx3zmfuOLVYWNcFDSr+9YBRa9mjS9Aay9uzJCfEa9vHqL5i+pJ+RDajoLpP7a5LdSg9dKfRATiOe4shEnR58LDl3KErRgBllVrEfmfYALunsScVRWGoQ8YBU32CqSZQEc7uEi4qYIa4ym1joFEcooLxdNhLIs5cCEk97YsPsWSQOIknJ90i5JdTMYu3NzMKdIypJKekopLisjM2HsHU8obdZBpyPDQaogiRQtwVgKyLYhfWB92YzrQA26PkvZPCzO52eoZjm3D2wV9ZaO7dlPF3K+Y0n/171jXg0NZZabVzhCJPbkc/B0J74WeDnZYH7DvoyorKEF6WXyxJbPW6qOrmLCJVKFFy3MzWI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0cba43f-a9f9-4150-9de6-08d81f30aa92
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 09:08:35.4895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v567UGlyxMIxAMtV58RZIeP0tywMphWfNt17VajVj8KPVUW0dfACeyBHPsECKGMuFn9o/BO0v+HgA+pUpIeMy/g1bDmTyw5/9C74CxoyZhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5448
Received-SPF: pass client-ip=40.107.14.101;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 05:08:37
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, armbru@redhat.com,
 groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we want to add some info to errp (by error_prepend() or
error_append_hint()), we must use the ERRP_AUTO_PROPAGATE macro.
Otherwise, this info will not be added when errp == &error_fatal
(the program will exit prior to the error_append_hint() or
error_prepend() call).  Fix such cases.

If we want to check error after errp-function call, we need to
introduce local_err and then propagate it to errp. Instead, use
ERRP_AUTO_PROPAGATE macro, benefits are:
1. No need of explicit error_propagate call
2. No need of explicit local_err variable: use errp directly
3. ERRP_AUTO_PROPAGATE leaves errp as is if it's not NULL or
   &error_fatal, this means that we don't break error_abort
   (we'll abort on error_set, not on error_propagate)

This commit is generated by command

    sed -n '/^virtio-9p$/,/^$/{s/^F: //p}' MAINTAINERS | \
    xargs git ls-files | grep '\.[hc]$' | \
    xargs spatch \
        --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
        --macro-file scripts/cocci-macro-file.h \
        --in-place --no-show-diff --max-width 80

Reported-by: Kevin Wolf <kwolf@redhat.com>
Reported-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Acked-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p-local.c | 12 +++++-------
 hw/9pfs/9p.c       |  1 +
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 54e012e5b4..0361e0c0b4 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1479,10 +1479,10 @@ static void error_append_security_model_hint(Error *const *errp)
 
 static int local_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     const char *sec_model = qemu_opt_get(opts, "security_model");
     const char *path = qemu_opt_get(opts, "path");
     const char *multidevs = qemu_opt_get(opts, "multidevs");
-    Error *local_err = NULL;
 
     if (!sec_model) {
         error_setg(errp, "security_model property not set");
@@ -1516,11 +1516,10 @@ static int local_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **errp)
             fse->export_flags &= ~V9FS_FORBID_MULTIDEVS;
             fse->export_flags &= ~V9FS_REMAP_INODES;
         } else {
-            error_setg(&local_err, "invalid multidevs property '%s'",
+            error_setg(errp, "invalid multidevs property '%s'",
                        multidevs);
-            error_append_hint(&local_err, "Valid options are: multidevs="
+            error_append_hint(errp, "Valid options are: multidevs="
                               "[remap|forbid|warn]\n");
-            error_propagate(errp, local_err);
             return -1;
         }
     }
@@ -1530,9 +1529,8 @@ static int local_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **errp)
         return -1;
     }
 
-    if (fsdev_throttle_parse_opts(opts, &fse->fst, &local_err)) {
-        error_propagate_prepend(errp, local_err,
-                                "invalid throttle configuration: ");
+    if (fsdev_throttle_parse_opts(opts, &fse->fst, errp)) {
+        error_prepend(errp, "invalid throttle configuration: ");
         return -1;
     }
 
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 9755fba9a9..bdb1360482 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -4011,6 +4011,7 @@ void pdu_submit(V9fsPDU *pdu, P9MsgHeader *hdr)
 int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
                                Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     int i, len;
     struct stat stat;
     FsDriverEntry *fse;
-- 
2.21.0


