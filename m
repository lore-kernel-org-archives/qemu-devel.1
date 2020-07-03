Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AC5C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:29:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 507E92084C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="u6CFVMp5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507E92084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrI0H-0001eZ-KH
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrHgY-0000W2-82
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:08:42 -0400
Received: from mail-eopbgr140133.outbound.protection.outlook.com
 ([40.107.14.133]:62071 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrHgW-0005Bb-4N
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:08:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzkjAH2agEhtANXKyyOjk9gQ8j0BRi/pu+WLQvsTTJMd7XuOdxPnfnk4PY2b+jiLVFwVW4qePRagnskSap2BE29dlOmS6cX/qoRXW0Wks/Lh8abgSesZ8HJDy6+ioaVtCMRBA/ZusCKg8oVTXu/J5TxTxQ59PEzEdlWXYcCLKFR6ucbUlt4NEopyQUrr8hhKnduRpYteXC6llKDlif4vIFICYO4H4apPVMsQF++Z8B9O4X4tuMrSv0zzQdgI4zV8jQPL7bd8MPxeS/0TqHSvpjZ60MZuVPhE96E5deSLaMCRZfhTV4x3+FzJYmc4lo5LXdCwFOBOT5voj/00cIqf5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNFydHd+Y+pOwXlqMZNody1rIFwi6JF50BVuuh2p5go=;
 b=JwLHGfGaxWyfU77mFXju2NlkSljt1j2QkfkmfUIbq0/gdnyNWbmWcBTQTpULz785T0OWf2akvs8kKXxn6bnngpaHlVvjBC2eox1CnOMNejaNl91UTwfA2GaEMJAMLO3/A9N1cTd8sM8cY4KZ2VQ8jN+lN4etmwL8GSD2hoADO2SAqEpd7QrJnU6ANU2U6ehbnG7B/6vaHhypnkLTa0mQdmlBSOFTcHrHr2Cb167betvpOhMIHnNQasoys3VHMsV94SLPOYEXNBKGMQ6WY6ecVUvXe3TDZi5ddCrLCMKkFsDGVtdKzDarXxNphvwJ7Sqc4mMcO/Xv5NL6R1Ewj4cVsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNFydHd+Y+pOwXlqMZNody1rIFwi6JF50BVuuh2p5go=;
 b=u6CFVMp55W6r7TEthhV8T/gspNhJkHoROJd9lx7w1kTfK6yy+5hEa7m8S03lNmOSsx2qbrcbaYshqxqEeY1+8amAeoF7LJ9dlVhcexbJ7Rspdjz2I3BYhRo2NGSAqDBM5aDivNewmXKJHfXdnj/77B9GUlUUuj8+OaB/SlSUi3s=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5448.eurprd08.prod.outlook.com (2603:10a6:20b:106::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Fri, 3 Jul
 2020 09:08:33 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Fri, 3 Jul 2020
 09:08:33 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 3/8] SD (Secure Card): introduce ERRP_AUTO_PROPAGATE
Date: Fri,  3 Jul 2020 12:08:11 +0300
Message-Id: <20200703090816.3295-4-vsementsov@virtuozzo.com>
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
 Transport; Fri, 3 Jul 2020 09:08:32 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3030cfb-5689-473b-9d47-08d81f30a91a
X-MS-TrafficTypeDiagnostic: AM7PR08MB5448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5448777D53C017B81F9CCABCC16A0@AM7PR08MB5448.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:156;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2GlEkcVS6y7u8cFdwU8EnuGtroEJZfechIiBxTrTIQtiHyRivN8f5N9dGvKMpG2w6IqujZmzCUpUAk4P+y94O9z7aZv+GA1NRdgDKVB0LOF1ICELHChhvquFK0M0rxZn5cs2NnlbewR5R/Osfnum9n2J+yAwy1JrEo/fTfJRohGUYDeUiPofhKgdkN9qbYeThuNUNJUGGcXtf/A+OTMa5gZzfjuaBnbkneiw74EUCgi1uBxPjdxQCtLq3m2x7OMQVGXfSCowEO8njl8UzF2hlNw9k9ttzyM6y3BQvmZw+lBhFmFKdEkxSk7HR+VD78upzg0CMSBSXMJGadYlMKO/uRG2H+MqdpIbQYI6fJNaLYkflf+dsXY6V6t5uOngo1wH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(366004)(376002)(136003)(396003)(346002)(69590400007)(66946007)(66476007)(66556008)(2906002)(86362001)(1076003)(8676002)(83380400001)(6512007)(5660300002)(8936002)(6666004)(186003)(36756003)(4326008)(6506007)(16526019)(6486002)(6916009)(26005)(478600001)(956004)(52116002)(316002)(54906003)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: vC5M3mEwsvzwYDKJAA/zHIy2rbXGLVMW+er4c/F2HrbigU2WCLVC7elwKTmy0qUkKHq36O8lkqqLUcG8iq8NHgw/QmXGz3izN4zaojzhUxyfLfu10C5TzQUoGN/3NIfLVsW9/pIFeIs6yv9e6BHdtE8PLADI5FHwaZ4YKJ50XZ2CXHONvm6rhtEXkpHf07UbNvDlSw5na8n7biPmksb9JkU2Qk20mZ5GlypmXLSf3Vf0JA7k/X7Le3KSK1LQPpnvSkKkk09KNt83c51i+/QfLDs+K/6A9bd3gvX+OOp9pjTcObAIFeWx1bHR7tkzLZI0KhM3K5eBef4o5ziBlJJ8BnT7HJpRh1x49jUBpcAOEK5n13glGOrWrq28Cv/cht8E875gHZ08w8ImzhSA5O2SQlYZjTgLox02iSE/jNsCsXgOXieIGvfZe9xkTTLKmOYj7MmbF4SqGiWXl6l64SGdkBkHlgvrc9t66PFzWZ3OJyM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3030cfb-5689-473b-9d47-08d81f30a91a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 09:08:33.0453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1ZfTqVvPAbyGVhxt1bj159Bc7iLA983Rc8omU9MXuBeTnlv1S/Fdcyg7o7ETG9MsORPNz+HTz5C8D91xuMJPvO09mmk/zLUuajfP5b60fM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5448
Received-SPF: pass client-ip=40.107.14.133;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 05:08:30
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, armbru@redhat.com,
 groug@kaod.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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

    sed -n '/^SD (Secure Card)$/,/^$/{s/^F: //p}' \
        MAINTAINERS | \
    xargs git ls-files | grep '\.[hc]$' | \
    xargs spatch \
        --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
        --macro-file scripts/cocci-macro-file.h \
        --in-place --no-show-diff --max-width 80

Reported-by: Kevin Wolf <kwolf@redhat.com>
Reported-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 hw/sd/sdhci-pci.c |  7 +++----
 hw/sd/sdhci.c     | 21 +++++++++------------
 hw/sd/ssi-sd.c    | 10 +++++-----
 3 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/hw/sd/sdhci-pci.c b/hw/sd/sdhci-pci.c
index 4f5977d487..38ec572fc6 100644
--- a/hw/sd/sdhci-pci.c
+++ b/hw/sd/sdhci-pci.c
@@ -29,13 +29,12 @@ static Property sdhci_pci_properties[] = {
 
 static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     SDHCIState *s = PCI_SDHCI(dev);
-    Error *local_err = NULL;
 
     sdhci_initfn(s);
-    sdhci_common_realize(s, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    sdhci_common_realize(s, errp);
+    if (*errp) {
         return;
     }
 
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index eb2be6529e..be1928784d 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1288,7 +1288,7 @@ static const MemoryRegionOps sdhci_mmio_ops = {
 
 static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
 {
-    Error *local_err = NULL;
+    ERRP_AUTO_PROPAGATE();
 
     switch (s->sd_spec_version) {
     case 2 ... 3:
@@ -1299,9 +1299,8 @@ static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
     }
     s->version = (SDHC_HCVER_VENDOR << 8) | (s->sd_spec_version - 1);
 
-    sdhci_check_capareg(s, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    sdhci_check_capareg(s, errp);
+    if (*errp) {
         return;
     }
 }
@@ -1332,11 +1331,10 @@ void sdhci_uninitfn(SDHCIState *s)
 
 void sdhci_common_realize(SDHCIState *s, Error **errp)
 {
-    Error *local_err = NULL;
+    ERRP_AUTO_PROPAGATE();
 
-    sdhci_init_readonly_registers(s, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    sdhci_init_readonly_registers(s, errp);
+    if (*errp) {
         return;
     }
     s->buf_maxsz = sdhci_get_fifolen(s);
@@ -1456,13 +1454,12 @@ static void sdhci_sysbus_finalize(Object *obj)
 
 static void sdhci_sysbus_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     SDHCIState *s = SYSBUS_SDHCI(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    Error *local_err = NULL;
 
-    sdhci_common_realize(s, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    sdhci_common_realize(s, errp);
+    if (*errp) {
         return;
     }
 
diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index e0fb9f3093..43e5730b00 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -241,10 +241,10 @@ static const VMStateDescription vmstate_ssi_sd = {
 
 static void ssi_sd_realize(SSISlave *d, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     ssi_sd_state *s = FROM_SSI_SLAVE(ssi_sd_state, d);
     DeviceState *carddev;
     DriveInfo *dinfo;
-    Error *err = NULL;
 
     qbus_create_inplace(&s->sdbus, sizeof(s->sdbus), TYPE_SD_BUS,
                         DEVICE(d), "sd-bus");
@@ -255,23 +255,23 @@ static void ssi_sd_realize(SSISlave *d, Error **errp)
     carddev = qdev_new(TYPE_SD_CARD);
     if (dinfo) {
         if (!qdev_prop_set_drive_err(carddev, "drive",
-                                     blk_by_legacy_dinfo(dinfo), &err)) {
+                                     blk_by_legacy_dinfo(dinfo), errp)) {
             goto fail;
         }
     }
 
-    if (!object_property_set_bool(OBJECT(carddev), "spi", true, &err)) {
+    if (!object_property_set_bool(OBJECT(carddev), "spi", true, errp)) {
         goto fail;
     }
 
-    if (!qdev_realize_and_unref(carddev, BUS(&s->sdbus), &err)) {
+    if (!qdev_realize_and_unref(carddev, BUS(&s->sdbus), errp)) {
         goto fail;
     }
 
     return;
 
 fail:
-    error_propagate_prepend(errp, err, "failed to init SD card: ");
+    error_prepend(errp, "failed to init SD card: ");
 }
 
 static void ssi_sd_reset(DeviceState *dev)
-- 
2.21.0


