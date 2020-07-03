Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05936C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:27:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C329C20826
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BZRkdtJu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C329C20826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHyv-0006LP-2e
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrHgW-0000QT-4j
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:08:40 -0400
Received: from mail-eopbgr40109.outbound.protection.outlook.com
 ([40.107.4.109]:51961 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrHgT-0005DK-G5
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:08:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9Ovg7si6e/BIsnBhddDQCNF6Z0hEML8lq+IS20nq2zKpoWj7dAR1AgjrnZP6c9qOiKWNjuAe8jdQ/W+Dae7Gin4Hz0o7jwJlkXTlNxx80w+CPvJyrQyygYE/is4SHY8EuuZuQLoNmTHsMvsjxsowRMIQZ4yPFFch1HW4MfQwTXE6KqP2bVsYN3UWtCVQ+G3qwFTuc/IGLNho9EpO26z5di78f1dGrHXDj6+2GApHeKgAQUl7CL0t8jiCTXB9Y0PgMNjUA1g1ixHp0ns0je/tylGT8I8FMU89OBivcxeDtxstAT6NzPgL6itnKwjokBMvHUGe7Cv7r0WthBacHdQrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/m9Qz845bbRNJv7IZ3xLxWb11W294MOi+4/b6edhPP0=;
 b=EpqZ7aG03rYjV6QLvw24hyzk7H5aPiI83bEqw2fsB/Oyclx5eW8Bi12l6j14Bha7MIvwiZwUlUqlb4NWqEoXOrEs+dPIkZCrEjeUdU68ngjYwRq/FAPtGDStSkxCjism6M+pPvegvDenNdhG5zovHaZA0RwWOXCy63xMbxcNYxasB5qfqo5od81IKh0UEhyIWbKKYHT/jR9ndNCPbOaU8nkIYRMrGVbw693VCjbagKI7tZ5Sx9nmP4rwIfGrjWrnx3HuHLnLt6wXMqgROAxaFEo+RTpf/auoFNEyYtJgFqEFuBjofcQt0D/XPKRaB5UpJJk78+E3l53de2muBjaVKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/m9Qz845bbRNJv7IZ3xLxWb11W294MOi+4/b6edhPP0=;
 b=BZRkdtJuWKpWaSMZio03KSoK7kyi2l2GFGiO5Uu8IQBxTizWbpIHH4iRj0PdBYA3UQcw5H67Z4HEl432pUkn3ouampC+yeQv1VrC4w+ykln57iAihTouim3eBdnZp7ph16qqhS77W3HICwEpXeR1rSRJ36rdSJ5W/uhe9ZD2Ego=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4691.eurprd08.prod.outlook.com (2603:10a6:20b:cc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Fri, 3 Jul
 2020 09:08:34 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Fri, 3 Jul 2020
 09:08:34 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 5/8] fw_cfg: introduce ERRP_AUTO_PROPAGATE
Date: Fri,  3 Jul 2020 12:08:13 +0300
Message-Id: <20200703090816.3295-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200703090816.3295-1-vsementsov@virtuozzo.com>
References: <20200703090816.3295-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-MS-Office365-Filtering-Correlation-Id: 45753270-1dbb-463e-8cbe-08d81f30aa1e
X-MS-TrafficTypeDiagnostic: AM6PR08MB4691:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4691DE9687DE85B778B00518C16A0@AM6PR08MB4691.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:156;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ilzMwJeilzhxIchhHBMlg7+VeLKJ+NRzXQw+TeW/fkFo8gNRGtJukNMOcfC83HqrN35hpg1FZ+aOqwAB1q/p6nbyZyR+bSGEXFlrDwwIg1Gtb8xtKRYj+ECVs3EjoZzL7Qd3Y4za3IWrItR5pTMLiQ4QxHdKMk/fsBs2KnheIVfij6Af/26uNn1aK1017JLE2LXHFNR3x8Ui/zsFraVrDFUjgsGAgUTUA380C0nP48TManuDJLCn1j/lX9gm5beguSnlepWu0Kb0Nx2k86nKTBKMv4ss8socRH119QSDQ8psVDgHngfXNmAI3new3aFfWGzXZjU5SeI0G8/f5kdERw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(39840400004)(396003)(366004)(346002)(8676002)(6666004)(16526019)(36756003)(186003)(66556008)(6506007)(66476007)(956004)(2616005)(478600001)(54906003)(66946007)(86362001)(316002)(6916009)(26005)(6486002)(52116002)(4326008)(8936002)(6512007)(5660300002)(2906002)(83380400001)(1076003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: sOI4s0nOpouT7lDYdXwRhrDmhAw4bII9xXTt89nBZpAt30GV8ZcR07MIOiVCoMQj8ZPST172jEwL8lMsl8Om4WEq/kCzemdv5mVZSa7qf0P/Bo1FfSfirO9zwRWWIs97retiZultn26+xaDjPCU8AnOA65F5gu4E8YcX9zETAwNmK9SXrU3JkvTXJsIkrFiNxuDzJoJcQ8QDP8XHk2Hr3PCBC9zbaFHdaHRnn5oA1qZenJxQsW65UIOo0JE3jyTP7fBGqWcjRDmTfWTTcnSmsGlr0IY/1TvXAs8CUttf5YSQZMF1tSwhk1rrwhG0NJt6L7Nq0dqq+oPEhrCouR0/EFy1XuVO+w/HJhLjLvH/IbznibphfgrQ0Eoi2XwdqJAY2bnv6zPekAMZYbWSQKa70qFiIx+oUM6M+xEAPZ2sWTDsUK2WZIYwwAH1+WiY+THiiS8Izvpht/BLlt/Vcwv2f2E4pBwq1k5P3PM2tWMvz7M=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45753270-1dbb-463e-8cbe-08d81f30aa1e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 09:08:34.7219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uhpd5ydqTro+aYg/Vpu4o24Ss0Oj91uA+i3T62IdEppTNas8RlfV18bNIDc4u+rVhne0y829T+jStqj2FwK6SFIzqFVcNi+/gyTWqVnY4KI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4691
Received-SPF: pass client-ip=40.107.4.109;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 05:08:35
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
 Laszlo Ersek <lersek@redhat.com>, armbru@redhat.com, groug@kaod.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/nvram/fw_cfg.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 0408a31f8e..d5386c3235 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1231,12 +1231,11 @@ static Property fw_cfg_io_properties[] = {
 
 static void fw_cfg_io_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     FWCfgIoState *s = FW_CFG_IO(dev);
-    Error *local_err = NULL;
 
-    fw_cfg_file_slots_allocate(FW_CFG(s), &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    fw_cfg_file_slots_allocate(FW_CFG(s), errp);
+    if (*errp) {
         return;
     }
 
@@ -1282,14 +1281,13 @@ static Property fw_cfg_mem_properties[] = {
 
 static void fw_cfg_mem_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     FWCfgMemState *s = FW_CFG_MEM(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     const MemoryRegionOps *data_ops = &fw_cfg_data_mem_ops;
-    Error *local_err = NULL;
 
-    fw_cfg_file_slots_allocate(FW_CFG(s), &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    fw_cfg_file_slots_allocate(FW_CFG(s), errp);
+    if (*errp) {
         return;
     }
 
-- 
2.21.0


