Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700BFC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:20:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36C262073B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nuJT8T+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C262073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfp31-0006g7-6H
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 14:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfoua-00058n-GK; Mon, 01 Jun 2020 14:11:48 -0400
Received: from mail-eopbgr70117.outbound.protection.outlook.com
 ([40.107.7.117]:10211 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfouZ-00027N-KR; Mon, 01 Jun 2020 14:11:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROWhTxOolZmx9FWSkkelPxAL9GkrtxJhDZFlF+oftlViK2sjigx2nEB2YE0ibga8CHaq7bPqLABw788HiZAK1KG17zZSVJLdRL4IkzYWjYJSZ/3uXv2tRlsMjBfKT8kc0DAvUBbQ5YHeF8BQxcWHuRvq/VQk/CfAQd0Hb2F7qvu6HN816jZAnG2LTeYoI0gaxvFENFCIbNV6wb0v38PkmtCIrprJB4x86fgIZTMWaLtxVB9XTyJnheb7s/D4WqAiTwLU8l1i3tQ6xiNAG81qerMVH1sA/nziF0JBy6aAyGqMcqM6cn+8JmNRxkgUVFebD1WJn+l1v1VFMunfw4NTMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEy0Pt/3jNPnZgXnM+NB+VMQBzQbqKsa5rmxkfRi2Dw=;
 b=Mu6wocMB1/cbUQKFpGHqfYlAvNHoaJop5QQjhdDXmvTMIIFY778xbIZBb+JUjV4M1RIjU6HW77cMMJG3icpBjNIuxVjgnCP/ynfEJzXPyrFZSnqafYSeKkbVvMgqFuB7C//ndrANDp9k5gMOHvcDTOqM0blmbaJ56FpAo+34P8IOupqqu7PKHvXO5PAVgNaDZoHQv6mKKqeCmD62/ImqZY66dyV2pMpBS71lxkCFRBr/twRTO94AzNdBG3hiwA6oKHU7u8Z7ElHP7l/53dDHEYSZN/CMX+Kr8Sjd1P9THajXP+Sl7CzjUSzGQtTFP5UwLg0jjuiv/u/oPJRx4+9r1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEy0Pt/3jNPnZgXnM+NB+VMQBzQbqKsa5rmxkfRi2Dw=;
 b=nuJT8T+2+cyuFg4070yBF1NI1E2UTd0nYu7IycYUqq1UwYCZUyNkAHL/BEPzaeXble3fIIQgl5oeqR3DpXNpUsbFCuSuW6INmny0OLtJgft1Tgbg9tZgrEIHySakFK8cLeWbFvDAMWwB/z+LlACBTIJJDZwGijqXeJZYhD5W+5k=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5317.eurprd08.prod.outlook.com (2603:10a6:20b:101::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Mon, 1 Jun
 2020 18:11:40 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 18:11:40 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 10/20] job: call job_enter from job_user_pause
Date: Mon,  1 Jun 2020 21:11:08 +0300
Message-Id: <20200601181118.579-11-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200601181118.579-1-vsementsov@virtuozzo.com>
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::38) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.170) by
 AM0P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.18 via Frontend Transport; Mon, 1 Jun 2020 18:11:39 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.170]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51c0654e-d6b7-462d-f4a8-08d806573b34
X-MS-TrafficTypeDiagnostic: AM7PR08MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53172254595AACF5B5B7557CC18A0@AM7PR08MB5317.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YHEGSCjmfzASv5cvW1D5p8LLW4fRXxcEB6jy7rU+6g1svs4NAIwV5HxiZYsa0Z2ngLErN+58rAWz63tJb8kvuMPrerz61m42N122rlBDUGeUBrU2N3XEXm+umxCo28lH+XNF/UlPn3pNJcU6FtQ385s9p588nLICrGRnT62hfgK++g43XkkFy8RGl9clYhDUNyZCPJ1zLj2EguH3U1kTMvab/DTs3ba+nvCztD6JUo4SrqT1sLFyCB0M87GNG5noI4EemJJWxtxFLJygDz/r9iXE5hlVLad/P2I5Qt7FeZcgGD8LsE9KZs+JV0G2MPfHwieiBokDavw0rAqHk80ogMV11b+UZuS4Wd3L1bHm+dVYAPUID7pghwDLRGt4K2nH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(39840400004)(346002)(366004)(186003)(16526019)(8936002)(2906002)(8676002)(26005)(107886003)(36756003)(316002)(6916009)(52116002)(2616005)(956004)(478600001)(4326008)(86362001)(6486002)(66946007)(66476007)(66556008)(4744005)(6512007)(6666004)(1076003)(69590400007)(5660300002)(83380400001)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: j/NAzrZyCfr7z6LYzlZyM+Wfi0Sjq5NbaTldXxX9uQR4lKPQfyPJdhm1QRapDro7b1H85mjtPqI9dEvl6slGWw+93zRGddz7W7RQA9cVD/2vGT/jAvmSp1hAVbSoxdCLr1qcDfrc4qx82th2zhvmSU5dIwRZcSJrLtuckDQWEKe4PA188l1/gb6FqHJRYL1h9uQJKQhyutgCxai8XSJu8ZWMDCAxi2kCDgRK4mYcZTelljSMQPtvhcFbyjdhdK4FETO7mQUrMDVfLP+3OreyCHbqCRwhxEmMHRZZP4kwyYWBa2czhwakHne3hHeTIWIRQxdPxWIVtQxDnLUUL2G86zf9jI609ZDCFKWtc59WBD8F5fJYH39nRf8+MiVvf8NXL3IwHn/TL3YLzFqfGdeel1B+P8THn74yIOEV06RxAXodByLU3dDpZVPPVFXPROKVDhUvzNJtbkRUiz2maKioBYD3D+cjzEfJXM8KTrQNV8Q=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c0654e-d6b7-462d-f4a8-08d806573b34
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 18:11:40.0422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BEdeZFG8AZA2MbU7aRk1ZBTQjKU9EddAfQ6WVr5jnyR1VcWZy52O+wA2EOOUIJFv/tWYjRXDErzXB1jLF1+xGM3rJ3WS0eHHJU9wXTqRUF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5317
Received-SPF: pass client-ip=40.107.7.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 14:11:40
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 wencongyang2@huawei.com, xiechanglong.d@gmail.com, armbru@redhat.com,
 mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If main job coroutine called job_yield (while some background process
is in progress), we should give it a chance to call job_pause_point().
It will be used in backup, when moved on async block-copy.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 job.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/job.c b/job.c
index 53be57a3a0..0a9510ece1 100644
--- a/job.c
+++ b/job.c
@@ -578,6 +578,7 @@ void job_user_pause(Job *job, Error **errp)
     }
     job->user_paused = true;
     job_pause(job);
+    job_enter(job);
 }
 
 bool job_user_paused(Job *job)
-- 
2.21.0


