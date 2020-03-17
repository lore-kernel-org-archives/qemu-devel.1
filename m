Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B21EC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:29:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F08DC2051A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EnZH2f3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08DC2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEE9d-0004l5-1o
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 11:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEDxl-0002pE-8v
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:17:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEDxj-0001aM-Hk
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:17:01 -0400
Received: from mail-he1eur04on0718.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::718]:38692
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jEDxj-0001CE-8o
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:16:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUzaMurbVJCHONIutn6FVg1CKOst52OOCOhQ4RBmKUv5bEU7sLWTzJu2z033eliUNEc388RZPBN5zJ0rhEJMsLPoINqu8PCv4G7PI3CkcE5vLaoG5Ge6JmSQ0VWfRE/9DlmRT3FNBkh4UqoSQkg2t2Jclb5Liere2jDLmIAQf3Kp8Exoj3hXVM2hrYRTbBFmzcUGy7E+Xxj3ktAj1KmuR07mVQd1yPqSWDqZv5qeibfZRQiGdnLZbEEGhkYrAa+u+ejTFfnpBE7u/2WgKetngPaUbkNwBfb6/0yfIv40c7c5FWIU/I8nMOpqnycDlW0fY7b+eov4DMYInHAT+Si9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3j106k9EKlyYw31jk7ZgZGTNbLs/5KHn4gp9c3MACwY=;
 b=EZbzPJoWONsMgRl7KeReAzjlx79eRnGrWJI09WyWNKOTC2IRnhBbcge2/Q4pBy7FCiJ31d7Bp8GAYebIi3sEAjv5/pPtLw1zagiqJ7hlX95qcxxhwV7sYyrwjrmedY0Obdizl6uwkZ+XX8zF5Cw9xXSzho5i+Mwbfxevd/bF99DKQPRFOyupu46qoAicvt3yCMQbBkpUI8TvSFFCE1VOT8T1zHZMJRUwRxfFkwLms5paSuFhGDSMer3bkID2bgva7VpoXSKcNYu58moX/mbypNJB5zPnSISispCqXnNuJqcktIv1W93fK4tgKtctPvxjnLM9ePEqOiLsmdJbMq0SHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3j106k9EKlyYw31jk7ZgZGTNbLs/5KHn4gp9c3MACwY=;
 b=EnZH2f3cF4gLBA8RKYluF2zLrHo/DzeS/mJjdOC7foqoKMEYbR7QBNX/MFFDkUkvdHRhfTV5qDdukw502DyeLWWyZdMl2lnjKXJPP0sPE47J0eWqN4WcPwHHTGsSLr6hAZRG7JJtLd6dr/qV9npmHOla77MLMZ0GT7epdpesM3w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com (10.175.35.136) by
 HE1PR0802MB2620.eurprd08.prod.outlook.com (10.175.36.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.21; Tue, 17 Mar 2020 15:16:58 +0000
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f]) by HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f%12]) with mapi id 15.20.2814.021; Tue, 17 Mar
 2020 15:16:58 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 3/9] SD (Secure Card): introduce ERRP_AUTO_PROPAGATE
Date: Tue, 17 Mar 2020 18:16:19 +0300
Message-ID: <20200317151625.20797-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200317151625.20797-1-vsementsov@virtuozzo.com>
References: <20200317151625.20797-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::15) To HE1PR0802MB2507.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.248) by
 AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend
 Transport; Tue, 17 Mar 2020 15:16:56 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.248]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc883ae0-82fd-445c-5132-08d7ca863bda
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2620:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB2620748174A6DAC13F696E34C1F60@HE1PR0802MB2620.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:156;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39850400004)(376002)(136003)(346002)(366004)(396003)(199004)(66946007)(6666004)(1076003)(66556008)(54906003)(66476007)(86362001)(6486002)(16526019)(5660300002)(6916009)(186003)(69590400007)(6506007)(52116002)(4326008)(81166006)(6512007)(81156014)(8676002)(8936002)(316002)(2906002)(26005)(478600001)(956004)(36756003)(2616005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0802MB2620;
 H:HE1PR0802MB2507.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KA8yngjKwceDqyFpD91l9l/hO/vsHs057NFVsaVfJils0j8yQQdom0irq+JH8AvILGIiTw2XgHNJLak0ilqiJyiMeZbYJl2S8896GBK5MF+Sbg786XM6NlonK7WDIa7hjS+4LnhocoA7tcoDWAYLo+cSTD1aXOorq0xAx/BgWckY+40FEOyOtVVpJcTaxUcd7YxAn+LuBUGCk+INwrlar8V6ja9U2LfS8G52NEcjja69QycO0F8hac7bDZpddxx7cVjjjtXclf+otgA9IDJ0Er3Upbvum+LBPOiYv1A20fGm8CH3sLq/hA4s+tfEA8GvyukAur/Aow1xSGWEHI9yI0/M5pmHDIJ73OdT8naCrl4xtXwm5cC78+XaJMKWvuI8xcgCoFncYVJp5SeqQ6rl2KFdJwDEojDKy+r9xag1Qi6e0vl+lxjsiGPLEogcZ3Uag3m5wcb6Yq8uIztDLDQaswQNtiHvO3ANpS/91B5gE4ZiTdh9qhz038+ottAG8ej8
X-MS-Exchange-AntiSpam-MessageData: dHX5WTbpw0Za30vKnIfuOuu5IdERtRnmQcvPigXuw+xl7pCHYpbyMtGwI4C6S10343dHNZUycmjW/yuX88w9EB5BHBW6HwXqCir6J0dgdhr4nkm/fzzZ3onQHmtloimRTmQq7ptgqx5cHK+3TuShNg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc883ae0-82fd-445c-5132-08d7ca863bda
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 15:16:57.8934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HBnXhpuUNYA9BMHhNXOodC/vXvExKMhZn0X+Nw795chCVpQ5KbBo1i/q8Cw1npeIXlywy9RxSWK67kjtxsjDA7iiWe1Ob5M0ntPw+gQTMNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2620
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0d::718
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 armbru@redhat.com, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we want to add some info to errp (by error_prepend() or
error_append_hint()), we must use the ERRP_AUTO_PROPAGATE macro.
Otherwise, this info will not be added when errp =3D=3D &error_fatal
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
 hw/sd/ssi-sd.c    | 16 ++++++++--------
 3 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/hw/sd/sdhci-pci.c b/hw/sd/sdhci-pci.c
index 19fa8bd8ed..ceaf3ea35b 100644
--- a/hw/sd/sdhci-pci.c
+++ b/hw/sd/sdhci-pci.c
@@ -29,13 +29,12 @@ static Property sdhci_pci_properties[] =3D {
=20
 static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     SDHCIState *s =3D PCI_SDHCI(dev);
-    Error *local_err =3D NULL;
=20
     sdhci_initfn(s);
-    sdhci_common_realize(s, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    sdhci_common_realize(s, errp);
+    if (*errp) {
         return;
     }
=20
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index de63ffb037..c25ac3c099 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1288,7 +1288,7 @@ static const MemoryRegionOps sdhci_mmio_ops =3D {
=20
 static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
 {
-    Error *local_err =3D NULL;
+    ERRP_AUTO_PROPAGATE();
=20
     switch (s->sd_spec_version) {
     case 2 ... 3:
@@ -1299,9 +1299,8 @@ static void sdhci_init_readonly_registers(SDHCIState =
*s, Error **errp)
     }
     s->version =3D (SDHC_HCVER_VENDOR << 8) | (s->sd_spec_version - 1);
=20
-    sdhci_check_capareg(s, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    sdhci_check_capareg(s, errp);
+    if (*errp) {
         return;
     }
 }
@@ -1332,11 +1331,10 @@ void sdhci_uninitfn(SDHCIState *s)
=20
 void sdhci_common_realize(SDHCIState *s, Error **errp)
 {
-    Error *local_err =3D NULL;
+    ERRP_AUTO_PROPAGATE();
=20
-    sdhci_init_readonly_registers(s, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    sdhci_init_readonly_registers(s, errp);
+    if (*errp) {
         return;
     }
     s->buf_maxsz =3D sdhci_get_fifolen(s);
@@ -1456,13 +1454,12 @@ static void sdhci_sysbus_finalize(Object *obj)
=20
 static void sdhci_sysbus_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     SDHCIState *s =3D SYSBUS_SDHCI(dev);
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
-    Error *local_err =3D NULL;
=20
-    sdhci_common_realize(s, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    sdhci_common_realize(s, errp);
+    if (*errp) {
         return;
     }
=20
diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 829797b597..bc44e1a0f5 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -241,10 +241,10 @@ static const VMStateDescription vmstate_ssi_sd =3D {
=20
 static void ssi_sd_realize(SSISlave *d, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     ssi_sd_state *s =3D FROM_SSI_SLAVE(ssi_sd_state, d);
     DeviceState *carddev;
     DriveInfo *dinfo;
-    Error *err =3D NULL;
=20
     qbus_create_inplace(&s->sdbus, sizeof(s->sdbus), TYPE_SD_BUS,
                         DEVICE(d), "sd-bus");
@@ -254,26 +254,26 @@ static void ssi_sd_realize(SSISlave *d, Error **errp)
     dinfo =3D drive_get_next(IF_SD);
     carddev =3D qdev_create(BUS(&s->sdbus), TYPE_SD_CARD);
     if (dinfo) {
-        qdev_prop_set_drive(carddev, "drive", blk_by_legacy_dinfo(dinfo), =
&err);
-        if (err) {
+        qdev_prop_set_drive(carddev, "drive", blk_by_legacy_dinfo(dinfo), =
errp);
+        if (*errp) {
             goto fail;
         }
     }
=20
-    object_property_set_bool(OBJECT(carddev), true, "spi", &err);
-    if (err) {
+    object_property_set_bool(OBJECT(carddev), true, "spi", errp);
+    if (*errp) {
         goto fail;
     }
=20
-    object_property_set_bool(OBJECT(carddev), true, "realized", &err);
-    if (err) {
+    object_property_set_bool(OBJECT(carddev), true, "realized", errp);
+    if (*errp) {
         goto fail;
     }
=20
     return;
=20
 fail:
-    error_propagate_prepend(errp, err, "failed to init SD card: ");
+    error_prepend(errp, "failed to init SD card: ");
 }
=20
 static void ssi_sd_reset(DeviceState *dev)
--=20
2.21.0


