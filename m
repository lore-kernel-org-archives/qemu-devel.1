Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C45AC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:30:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7825206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CdhqX/r7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7825206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEEAf-0005hq-06
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 11:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEDxo-0002uk-8p
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:17:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEDxm-0001s2-N4
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:17:04 -0400
Received: from mail-he1eur04on071f.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::71f]:1794
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jEDxl-0001d5-Dr
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:17:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/sgbF2csToL4EQ/QRD4IpegW9WXHLqxouTsidGXmFOXWdOzk2Y3Y0HwxfOF1GZ6pxMwYJnLjMc2htjbY7aZBdP3/rAVoo//tPYhCzSguMS7jgBwtbvGO8Xu7DQIVOr5dUROxC2mBVwZVbCi5T62LzuZrQDc/gT90zor0c8kOPPlLKKT92XupGS2mfP8v4Dg9JjfXBzXUEXmz5iHY7WDxinhKfZ7g+ahU2kNzCXrRxW3pr8TiAKJ2/AJgQNItQLChyZi128aYwzWQpAuF6ULkCtz+ifXehvTzqPTfwr5Uj9n8kvxm8Z2UpCh5VtYfIOGiGq9Rbchy+vwPXp26L8PBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZ5KSBMMchwQplb7Nasj1nIDPDK99nh5LVhMiQmxtcU=;
 b=BpFk3VrC6azPDKtgqe1EOVnz0IZUHyBs82fD5JLO1vTTouF2q1yf4owgQ21Pr+vMmelrvrA3NfpsiJaWCy3ASXjXMXTo1EXWMGEHpot8lPNmbZ6jaKsWXP71CoPUkqJjKWvHkBek96beU+QhNKU7tKIRnuGMjSOon2ft7/5lWoZ6Uz9mwYnOvdYrb0q5l6e6948rLgAEEE6WM2P18y6sX03vKFUzBgncz/2JFJI26GuRoml1Qtm5ZgGjTTcJ6k+7xJMw/vg6+JfQ3TdfRYXUQAIReKN6GM1T5sjaDz2hLHEc71MNA4cZXCcZ6Dj+PUsYFZwvJaSBR5eZ3gF2yHkTtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZ5KSBMMchwQplb7Nasj1nIDPDK99nh5LVhMiQmxtcU=;
 b=CdhqX/r7iH0J0AjmGpnPkEh1xrjHYRDcLQQe3/j9E/WId3YCgT0iWUCgPcE8cijWUXbjLbzm5S+moWQ2/PX0PUtZ7pLcWKyR3OqLxxNzh0iwTjZnAxHMjiuyuW0j38w0NP8pWKSG6PbHOl+kvkezN8MehYzUYdHOkmuF/XrOcvE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com (10.175.35.136) by
 HE1PR0802MB2620.eurprd08.prod.outlook.com (10.175.36.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.21; Tue, 17 Mar 2020 15:17:00 +0000
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f]) by HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f%12]) with mapi id 15.20.2814.021; Tue, 17 Mar
 2020 15:17:00 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 5/9] fw_cfg: introduce ERRP_AUTO_PROPAGATE
Date: Tue, 17 Mar 2020 18:16:21 +0300
Message-ID: <20200317151625.20797-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200317151625.20797-1-vsementsov@virtuozzo.com>
References: <20200317151625.20797-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::15) To HE1PR0802MB2507.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.248) by
 AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend
 Transport; Tue, 17 Mar 2020 15:16:59 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.248]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b402085f-ac58-4a18-5fb7-08d7ca863d6a
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2620:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB26202DB3BA6807F948EE2E11C1F60@HE1PR0802MB2620.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:156;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39850400004)(376002)(136003)(346002)(366004)(396003)(199004)(66946007)(6666004)(1076003)(66556008)(54906003)(66476007)(86362001)(6486002)(16526019)(5660300002)(6916009)(186003)(6506007)(52116002)(4326008)(81166006)(6512007)(81156014)(8676002)(8936002)(316002)(2906002)(26005)(478600001)(956004)(36756003)(2616005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0802MB2620;
 H:HE1PR0802MB2507.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uZ0171N2+WSzo0vQJ6058PXCLl2WCUSbQmz2Gz3HBZEYy1KIRQXZq5cWyHpmHXhb164vlhiidZGSCQmYHVKvAhXFanxZLt70KZIjDD5qri0x75iDronxla7ogCyeOjUM5+CA1IRULhGtnVbOL8MSaZVr7bjBThdZItM87MhvV19dgMdsZvG/KBjfrXxOddnPZ+vbuKZ0m6Pdo2XhCuCJQBYPd+9qKPqSSrML1WsJ8zatWNDMrhh/W4rMOX9T2bB5jDvtqfhytP3+XgE838JX5MpUZ086f9UmhgT4imnIHjfPMQBPTgOgQHGSmRoozItG1Je1pk3Z7IHZoTbToTl9cXv4BM81+eHbrtp45UOQwRDWz9/UG+yPrNqv6mOfwQatwdzvwtuwFprKxn48B/aipCEzTeJtsJ19olQFGUZVvB1qTRcMirOXHpBp+7MZz5b7
X-MS-Exchange-AntiSpam-MessageData: QzSOlQUZX1n2S8dbgMu+lV4/IUDTBP+5SQIRHrVAt5Ma3PZqVJhefcqxDeFYmYOWvZ7YIiq7ohDWL7XV9LEdT0A9KnfNcHAl1jj5CmFkfqCxUu2QzCoOENECtMOtMuxQFHDBQfya+43QICCVLhssDQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b402085f-ac58-4a18-5fb7-08d7ca863d6a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 15:17:00.4003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/+IOxlnGqtOPUwg28pVN6mLYkF7B5eYOTFUBtFAA29EHFqFxZrvuNdLDUv5cbUkrD3X+aMO2OQzgBpOB9VqynlEIb2SgxU56S/lzxwn2PM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2620
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0d::71f
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
 armbru@redhat.com, Greg Kurz <groug@kaod.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>
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

    sed -n '/^Firmware configuration (fw_cfg)$/,/^$/{s/^F: //p}' \
        MAINTAINERS | \
    xargs git ls-files | grep '\.[hc]$' | \
    xargs spatch \
        --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
        --macro-file scripts/cocci-macro-file.h \
        --in-place --no-show-diff --max-width 80

Reported-by: Kevin Wolf <kwolf@redhat.com>
Reported-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/nvram/fw_cfg.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 179b302f01..22ff2be0c0 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1142,12 +1142,11 @@ static Property fw_cfg_io_properties[] =3D {
=20
 static void fw_cfg_io_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     FWCfgIoState *s =3D FW_CFG_IO(dev);
-    Error *local_err =3D NULL;
=20
-    fw_cfg_file_slots_allocate(FW_CFG(s), &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    fw_cfg_file_slots_allocate(FW_CFG(s), errp);
+    if (*errp) {
         return;
     }
=20
@@ -1193,14 +1192,13 @@ static Property fw_cfg_mem_properties[] =3D {
=20
 static void fw_cfg_mem_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     FWCfgMemState *s =3D FW_CFG_MEM(dev);
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
     const MemoryRegionOps *data_ops =3D &fw_cfg_data_mem_ops;
-    Error *local_err =3D NULL;
=20
-    fw_cfg_file_slots_allocate(FW_CFG(s), &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    fw_cfg_file_slots_allocate(FW_CFG(s), errp);
+    if (*errp) {
         return;
     }
=20
--=20
2.21.0


