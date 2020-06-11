Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B74CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:42:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4351206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="X2N2OUXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4351206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjQHt-00071H-RJ
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jjQ36-0002dM-Jq; Thu, 11 Jun 2020 12:27:28 -0400
Received: from mail-db8eur05on2110.outbound.protection.outlook.com
 ([40.107.20.110]:32417 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jjQ34-0006oc-Nm; Thu, 11 Jun 2020 12:27:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsMbsAk4uJyCUqcJrSh6UJGJu4gUg7qRhgD7JtycVS7Qf2Nry/3xkrvne+BG+JdtH/5+oVWmlpc/QBCBsQEy/Q18+98O5uxafjaxQW4mP+M28RUHralUKbx9Yw/wm3iOmMa0dSIJW7gxDB8wfPK845H6+FGJ+s+Cor8uAbCElqCrDRwSun4PHdeRFx8g0p+Vk/iYnmEQ7iODy/VSmUPORnEJZe7SoMo96PyUllvogLnqRwSkBQ6Rebd95y4FZF4rXhrTGtCUO85tcryMfzyA1sl2WgGUzR2nLUuCBmfYWHctrgQLZlzqCt1+0RJwuouPZjiEEZhcsr0UoUNGPRLUJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARsDwo3NL2rF2drTnTEncmtKWCAtf9odtNkvr+PoF9I=;
 b=jEJegKilqZjuiJATPRU08Zf4ltfa8gbdHYcQfe3sj3tKLaoC/cmOJGH6hv5kROfHCLzuX51S2SWmwjYPuppdLKLmE99NihRNkLxA5S9ERxZvhRXsil6QEW+KEIL1ASG1FjKQGiSWmAHNU8qHGiXitUv3Fsl4gPJqVYz4oGZQTnvoUI7RwdC9u39obdhwiermKMXTHAt+OYdDhZ8UlsvVWpw3b3+1NF6mafk3r9Kl83lQZWPkGViv5VVuuN50At5+CU27Uiwba8oU+ujSO5u3ZEEVbeha8/AHxWkMhgerK3ZSpEoVJO0drJTcoWi9jKQ95ky+T77T0NKvawHFu+TQRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARsDwo3NL2rF2drTnTEncmtKWCAtf9odtNkvr+PoF9I=;
 b=X2N2OUXNDrUK7UUTFMB3CXEfArBZ7lFqd+CsovvH+hOkjyIivsvgAM3VraL7dJsFDEbXUEZplduV+7axdW395dzM5Zq5T/S+iFG0Z38L9378aN8udKdZp4Hix48p5GAKk93hYh9vVltfeTAzCSpH9dvuOfISu1yTVdVX6LCScq4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5493.eurprd08.prod.outlook.com (2603:10a6:20b:102::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Thu, 11 Jun
 2020 16:27:14 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3088.022; Thu, 11 Jun 2020
 16:27:14 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 4/4] block/io: auto-no-fallback for write-zeroes
Date: Thu, 11 Jun 2020 19:26:55 +0300
Message-Id: <20200611162655.4538-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200611162655.4538-1-vsementsov@virtuozzo.com>
References: <20200611162655.4538-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0148.eurprd05.prod.outlook.com
 (2603:10a6:207:3::26) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.159) by
 AM3PR05CA0148.eurprd05.prod.outlook.com (2603:10a6:207:3::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Thu, 11 Jun 2020 16:27:14 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.159]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 071e37bd-a663-4879-49ca-08d80e244cfd
X-MS-TrafficTypeDiagnostic: AM7PR08MB5493:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54938E582B638ED8DFAC15F4C1800@AM7PR08MB5493.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:381;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 31D/3P4cGnF/rn6yZPpjFMKCYkipvOKHQ3RAK//diq7toScNbm+KwNeTU4II48vu7afaM1wAdiNER0VV0A+kZg9qXJJ7stoHibPYUMoq4+xyey9W9Wz6F6z7fscEOh/PEkcVo41iznKB8OumaismPSonPr+ZUXZse7OYeMCnKnxhz9hvwpmm1R73XJHSb+eFcX7xBkGE7BbJBAIx/pDVuGWAMwzAL21kPu8pObQlTV4SGiRHcLT0Ah6u61enjTynshc1QkaBHbSF/osN73lHfRwOsXH2A1LuO7lfcCIETWc0NEq/xLFPl9dSED4F7keZtYjF1Jf9OqnnmjkrTNzUSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(39840400004)(366004)(396003)(6512007)(316002)(478600001)(16526019)(186003)(8676002)(36756003)(6486002)(8936002)(52116002)(83380400001)(2616005)(107886003)(6506007)(26005)(956004)(4326008)(6916009)(66556008)(6666004)(66476007)(5660300002)(1076003)(86362001)(66946007)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: W990FI9mTfT4aBO9oUzOsY4jaXbOxXgPADE3TAk4C6dvrr44o2DtS8ACw3mQ0fnDVt7QbooohLUrFJuxejdhK4Z3HPpIX0q2R+F9n7ytELCVQ/W+hSGvuiIEl1ncgJhfuUAPOSKn9RAm+a2Z+vdHu9MoTZe2rrlV/Zo6XhUHuq9Rsho7rsvacsz5m6FKjJaUDDYbZ0Yf8y68KaZxkSAHO+sEDoQ8JTV6yMAgH+b8vr6kXqie5TEk+VDPXhedlNsh+Y8KW3133EcyLgTrnCqX/Ez7rzFwdzYm5NTcaRolLlHPhg18AMo7qH+KpgsX6M5z44QIoxvZ5lSil57luLhwEx6T27IiHnvt4XOZuWOxgJjkjKbC/VhklFaD/IqvAOO4Tmjbuw3eHKzQN7fGPMXdfirMlqt9JQXxBGfCl6/1O9SsiwD5J5KHoq3Wp3f8ME+HhMOs5VgBz5F4urNxY7FWLyuqwSZUkWa448VtBEPcalv8pJPI9xicOwNYBKWOvRPp
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071e37bd-a663-4879-49ca-08d80e244cfd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 16:27:14.7394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RV5TrI4Q4SErdv7Xq7X+8Prav2/dKT2fPFrKDDu2T1ZcyORDKDnEyYizvwtX/TjHz7DRAj/3iKDLY7523Efsdpwtw4rcCHP5gUJFnCUinA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5493
Received-SPF: pass client-ip=40.107.20.110;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 12:27:11
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When BDRV_REQ_NO_FALLBACK is supported, the NBD driver supports a
larger request size.  Add code to try large zero requests with a
NO_FALLBACK request prior to having to split a request into chunks
according to max_pwrite_zeroes.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/block/io.c b/block/io.c
index 3fae97da2d..ad219cb220 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1778,6 +1778,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     int alignment = MAX(bs->bl.pwrite_zeroes_alignment,
                         bs->bl.request_alignment);
     int max_transfer = MIN_NON_ZERO(bs->bl.max_transfer, MAX_BOUNCE_BUFFER);
+    bool auto_no_fallback = false;
 
     assert(alignment % bs->bl.request_alignment == 0);
 
@@ -1785,6 +1786,16 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
         return -ENOMEDIUM;
     }
 
+    if (!(flags & BDRV_REQ_NO_FALLBACK) &&
+        (bs->supported_zero_flags & BDRV_REQ_NO_FALLBACK) &&
+        bs->bl.max_pwrite_zeroes && bs->bl.max_pwrite_zeroes < bytes &&
+        bs->bl.max_pwrite_zeroes < bs->bl.max_pwrite_zeroes_fast)
+    {
+        assert(drv->bdrv_co_pwrite_zeroes);
+        flags |= BDRV_REQ_NO_FALLBACK;
+        auto_no_fallback = true;
+    }
+
     if ((flags & ~bs->supported_zero_flags) & BDRV_REQ_NO_FALLBACK) {
         return -ENOTSUP;
     }
@@ -1829,6 +1840,14 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
         if (drv->bdrv_co_pwrite_zeroes) {
             ret = drv->bdrv_co_pwrite_zeroes(bs, offset, num,
                                              flags & bs->supported_zero_flags);
+            if (ret == -ENOTSUP && auto_no_fallback) {
+                auto_no_fallback = false;
+                flags &= ~BDRV_REQ_NO_FALLBACK;
+                max_write_zeroes =
+                    QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_pwrite_zeroes,
+                                                 INT_MAX), alignment);
+                continue;
+            }
             if (ret != -ENOTSUP && (flags & BDRV_REQ_FUA) &&
                 !(bs->supported_zero_flags & BDRV_REQ_FUA)) {
                 need_flush = true;
-- 
2.21.0


