Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218D4C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 18:39:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E279E208E4
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 18:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QuTAvifX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E279E208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWlQr-0006PI-1b
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 14:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWlPv-0005Mu-LW; Thu, 07 May 2020 14:38:43 -0400
Received: from mail-eopbgr70113.outbound.protection.outlook.com
 ([40.107.7.113]:38020 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWlPq-00009Z-Ac; Thu, 07 May 2020 14:38:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOU8OabIx+FCDO825Ei+pFAMzPCs2xx59QklSu7mLaMlwIoRlIdR2ONoG2B1mTzPJ5pBCsvE5kTzWdGbT+uxc2Ypq6P/TunEM/TKXY74XFwIAryfF01qtDxfF2YE40EGaczI7X5ZUzOXnRyhwUf7UjcC0Asza6QPLld6Zo0tOdsHvkFBObOu5RdvpzxCx6YIWSgOPTacBypHMtbHm7qCQgBcQlKqBlZK+cjalyH7PgloXzEAyrQVacEQLvLY7QDdsQG/RA74smBk5ohIxndW6SjrkVR2nKdolxzTujEkUwoGamnqURE8zprhsTo7ANsQNoNqb3WcMAVQSY055bVUdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wv6WwqxXUEr8iugeG5mdtr1SOOuJXFcfuFxOtPJZnk=;
 b=E8sYCnAK20FLI6lySD90k8xkP0ZtOMqAtMOzSd3XgJzyFO8WYO5wonzCXmc4M7nOj213ZYtRCbmonyRR25Mle6QWg6fSXPAy4c60OFHx8ffI5DMw7rxpOx4I3bGcAhVN+JPH0q18Qu/MYjZltlQNdRECHEjOGKycKPRvIG6XTx99ud9Sjk0ssEdHM8bWPjVfr1v6QpKZUuEbKbq8Mj7VTrnFcbNzcuwvLH/k64rq1XZTlkZ50xRbtyIqbbY+5rzGzWSEU2HGAvRrdqXhl+RY5bHVIGJN0q2IGen9bMh+3SPGdYivMMNxeY1WEF4jLsxd6fjiZb/FmqxsHM5iY29ULQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wv6WwqxXUEr8iugeG5mdtr1SOOuJXFcfuFxOtPJZnk=;
 b=QuTAvifXBFmx1Exes0OSEPYEuwZDz6cbem5ACyjJDJmAlvObJkd9vanRuk/fOI2Epc8CFtTXfyCWTOl8JsOktsvQKD1LOGwNdHlc/bbbV9344C2RL9QkbKYsyWaOz2N42dBKL7E8toaYsXQ/sj278ZLN89j1lz69gGcNkMRnbBA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 7 May
 2020 18:38:34 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.034; Thu, 7 May 2020
 18:38:34 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH] block/block-copy: fix use-after-free of task pointer
Date: Thu,  7 May 2020 21:38:00 +0300
Message-Id: <20200507183800.22626-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::20) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.171) by
 AM0P190CA0010.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.29 via Frontend Transport; Thu, 7 May 2020 18:38:34 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9d1080f-dacc-435a-66e6-08d7f2b5d976
X-MS-TrafficTypeDiagnostic: AM7PR08MB5494:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5494E6069DDBF9E2DDDB6460C1A50@AM7PR08MB5494.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:45;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GJTpY8Tj6+NkqTajwxY7NDLpm77ket3c5icNVOFRbMe5ly3ymghsaJOAfnzbFfHZFUKKOjklpJSzRz1eZh69bQLBA3L0XoQh8xIVFGZfLEez4onlj7rDfZd0jayUz2m9NJDnAy5qBkiUPJqfZf+MaSQ5jYhEyTmrB1MAbOzkTiD5A/NQBAbPR4rcphtvs0ukoVuvdOqu37eANHHqdKyW6Oz0MaaIgzUhlOJRPrfiTdvSxs+tGBhPM4Tw/oeDArlgg0WDKBNlFcPhCB9k8i0AkujAE8iKpAGtlEa8D1463xhKPRSZHsnODDwrr4YtdB1EE2dnPiNWnAW0pZ53VC7+KUV7N9htWgUm8zbP7eCYsj3Oc3frSAI+M2Q2LaqWiUl1o0EhuGtuzpcJEXrwA33EB3H4FODstoNuOQj65pFv5f0TiRrmtqs7QBlRqAbG2FvTSSPVHxnW20BtA62rOC1jSr2j0egLY29T82WgbXSCSjbreH/80DbfPkAPIGz3qt7GbFsRJVd3tKwHnHPNMa2aXNr+FxIKg+C/1H1iS3x3pgW1a1y5V4TbPqd0s76bZhZX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(346002)(39850400004)(136003)(366004)(33430700001)(26005)(5660300002)(66556008)(66476007)(33440700001)(6486002)(6666004)(186003)(16526019)(6506007)(6512007)(956004)(316002)(2616005)(69590400007)(478600001)(4744005)(1076003)(2906002)(36756003)(52116002)(66946007)(6916009)(83290400001)(8676002)(86362001)(4326008)(83320400001)(107886003)(83280400001)(83310400001)(8936002)(83300400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: iWif70SdgHW5c5bwAC7zzfA4gTBL8Dg6BRwDUyeO1XyVpHeykc5GeQQhxN4wjfx0GesMh4WHXnT1ybrRfl1Q+Nek9vw3xijABZhk+wivjxwh1AP2hP6ZrEyKLlr9/QvRltlcERYJEFoHL5AvZcBxr0WHDFR2Z+RtiO6mOj1xTwBYkZ1LGI23ujNFAJYG68tM4N1LK7gSjhTahgHwYYl+89wviFcz0pSajqNvAVpvAQbeKy59WkxRomNL/20iBpOELo/CQgSr9MjFf8QLdmokRSMEaWXdIsta7HaeJBfg6lyjk3dz9AsujjjYX2G4zwIj5smAHG6of7E9pBsFKToPOu615blNneQ8pXYD26djhczTQGI7Me1jLnTEr4o0F+buzTICQ0aQXMKrI967r3XuhVeNdDlRMXTsh58beYUYNYDGWE56TDLRNNAcgrxnFAS4jBtPMgNCnzxCgtEJi1bTO0pxVphL2IMFGdv4oitAbFAcENkg0PYsUR9zl7J4/jL2u/PfS5+mcL7++ybc1hXPEUl8T6CuMlZsqtzmON4v4kszZjQVBzGUbQ/HbeI256tXz7XL4uFy88mRVfH4qwQgPrXMIvO4R+ULfAkLI9+AXiSyj9SEL7VKsgoIkfKaaPBmYAkXghT3KlCWJVtzdTX6pE3ho7cQUFvLiUV9XzeD8SwMFJdxCC0s7OCrZeb9e7qxg1O12QLf9ImRTbS869Di0tiI0QnvbLQ/dpAH2ib1RjLGOoUT3cvRJSudDwql9JBpBNY4Zbhi3SNDYz1i7kcJEqnho3zkunAvyOm22n9jnOk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d1080f-dacc-435a-66e6-08d7f2b5d976
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 18:38:34.9285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZRZD10pT9hAEyadaeE0/5l/RS+tet/W4BL1bW9fAFevI8P/6D9bTpe5b0xTHbqxtNMFdL2+7tPR4v1wYvNNY86Emh4A/JA2yKl2Q7f3V58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5494
Received-SPF: pass client-ip=40.107.7.113;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 14:38:35
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Obviously, we should g_free the task after trace point and offset
update.

Reported-by: Coverity
Fixes: 4ce5dd3e9b5ee0fac18625860eb3727399ee965e
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

Be free to add Coverity number to the commit message, I don't know it.

 block/block-copy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 03500680f7..4713c8f2a3 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -591,13 +591,13 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
         }
         if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
             block_copy_task_end(task, 0);
-            g_free(task);
             progress_set_remaining(s->progress,
                                    bdrv_get_dirty_count(s->copy_bitmap) +
                                    s->in_flight_bytes);
             trace_block_copy_skip_range(s, task->offset, task->bytes);
             offset = task_end(task);
             bytes = end - offset;
+            g_free(task);
             continue;
         }
         task->zeroes = ret & BDRV_BLOCK_ZERO;
-- 
2.21.0


