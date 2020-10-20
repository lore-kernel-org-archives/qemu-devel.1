Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0885EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:08:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74E30222C8
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DNU+KMdI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E30222C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUrNa-00074s-Ee
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 09:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kUrIj-0001OP-AE; Tue, 20 Oct 2020 09:03:41 -0400
Received: from mail-vi1eur05on2136.outbound.protection.outlook.com
 ([40.107.21.136]:23328 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kUrIh-0005aC-Kw; Tue, 20 Oct 2020 09:03:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeBDpF+36Vq31j34ZD6LdM9/Mhl8zrW2IYkwJVavPY9jTOprKaBsCYsDbOKmp9YOK6WYwmuMx3KJyA2SGEOXM12sL4tsc7m2EqFy6LuL9GtbKzjLdkD8MQw66jKXSSMrsqLKsDW3jbhVoalOqRpHUeEkw0MT4aZrG+xrEiVMAbA8FKsawpoVTegqaxLdUduOQQQT8RdqiLswtf3V4Bg9AJjcfFGysHEhAarmzYi53vhOrCIydKvnyaqw676q/82HCgfW/fjExxiYWoo4BIKncZX1RMsuSK7PVOg72L7KNf67pL0u82Qmp/yjhaL59m68Bs1/RbgVWLmuSFnBPvuGuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4WzwusmfJXEk1hnIVPi1zObRVeUHyQfsJtzEZoOOLo=;
 b=eI0Xg6whSf7u8/YCR21IAwqELNbeQpR4UzZGmnNFnNr5aLwhOTQsurkamTReJcvcwodXeOpMNpnPvtswHpFVZPOm/ytDAG3bt2ouRDBKfMkc6FjdtYzJrwFD1kCuSIHxsvUXKuWzO6hhAj5dNN4jSn/pMPyfW5bVSX4BM7gr0dNWKP4+SAK0FM0aBodAA4XeOAbnwKgzn3XK80YQPIQ7dcH5g5KdP4G6pkzKTtgErByw2U/MugwrD0xp8ygLOX9E+2LicpTBP4VjxCJg/UgkkK4jU45pYDAzRIirMZ0OR8DHILnE6RbNurSKLs1B2pP3uYeqrFDdJ/M0y7zeJTntug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4WzwusmfJXEk1hnIVPi1zObRVeUHyQfsJtzEZoOOLo=;
 b=DNU+KMdIaFWXVgR0Y0UF1Z2mZxRlk6UTMyaZEmJVICk6ujIm7u92ztLvfvAdUIiwbSwjGD0t9YFMnMkGxqs8KpnyqBn5kQ2CdQ7pjeU2ZrknsZpiyBmo/YTHCPuq0pgtKkNLtekzCxSFf+zYbBQI49MmKlbpogIKQheSWdh9i0M=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AS8PR08MB6168.eurprd08.prod.outlook.com (2603:10a6:20b:294::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 20 Oct
 2020 13:03:29 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Tue, 20 Oct 2020
 13:03:29 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH v4 04/14] blockdev: fix drive_backup_prepare() missed error
Date: Tue, 20 Oct 2020 16:03:01 +0300
Message-Id: <20201020130311.14311-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201020130311.14311-1-vsementsov@virtuozzo.com>
References: <20201020130311.14311-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.66]
X-ClientProxiedBy: FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::10) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.66) by
 FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.9 via Frontend Transport; Tue, 20 Oct 2020 13:03:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b599355-79c5-4912-2999-08d874f88a75
X-MS-TrafficTypeDiagnostic: AS8PR08MB6168:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB61685763D3BFAEFD1892E1E5C11F0@AS8PR08MB6168.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GVXMRy98VX1JOW4hjZeHtOMcjlBY95YPPRYg8A/g5NwnJyJYELsfR/5J2h5hfJZgiv+liXNJ3KCVWWyIs8CPwV6LC6qeZYvHH9owmSdbb3M0V5BmiMthdhbP/6+e48XOv5QS3zdl3yf1gnCZxAbG8kwkoTwuxvVgS6VTU+vDXMb2CMSSNUTQ1Q/c/T1zt7xH1hxCp1vlPYq9TCiFXoaeVQ1s3zotG5ETdOpjv3SLkIwBd+23vTSbsbBJFYnjYvB7Nwbi4XUOlO6JCeLrQqSsUJ4nPopNpoaFjHByiJE+Q6r7YwSyGUZXjZE4rffTpxJcHm5oth4aeCia+Wm+/wW8yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(366004)(136003)(376002)(346002)(396003)(8676002)(66946007)(16526019)(478600001)(8936002)(186003)(5660300002)(52116002)(6506007)(6486002)(2906002)(6916009)(316002)(83380400001)(36756003)(2616005)(26005)(7416002)(956004)(4744005)(1076003)(86362001)(66556008)(4326008)(6512007)(6666004)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: g4V7D6Ez1IQcabodcR5NriecIub4CF07gwZH5QpwTTB6WWo/MwmZ73f3iDl7/2VzM91ErcFXdJuvXx2S9hapWTigKkTmzafkVTojcq3nbrLe8TIIKvkFC21hRho5IX6TNH4AqwmYSoJHLw9pjhGtfKWWPoP9VtQPKNg+Ja0npWwR1kQ+Xk9ZJeC0B9ggjwB2s43+KyLKWeNii9WM+d5Eyl/M4OmIpOtawRgJD2HrQSRU+w910InAswHSFPH4QMdN6gas7hLpBYAimN738RDPntCeiJS7Z6UbKF5odV8lfNVu6ojp+gAbAEyP7xLtR575o3lIG9hlrozCRGtinqfP1xOcqiMGzlyfKa7dvvW0PnXigcjCPuDJMj1bZqVjFc6fGNIyQXHs0KEZV0Se8Ij6J8D276oV2PQbRnwJPcX1xaXccRAf3WgF4pfpkwmlKvpP4wWjhBmnQmFLACWmec3mE6J1HrX3UxM1HD3R4/+vIYpi7HBtK4FXT9hN0N9RC9qZ01FrNxtMiOaIXDolaz0c3HtuQR9hxKqn2X/DAaDu2HfRwdQAhnTs2I0P/o9ZuGP6jMdyrg7Rg3KIEIJWIgeByNNALOssTHEuR4cGeGbtpzIB0SlXLMEDi9YvMrqSENYkYatIasxF4ezHZVgSf/AOXQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b599355-79c5-4912-2999-08d874f88a75
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 13:03:29.7855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yv2cSuTx/wcGm6Z4eSr8DH074lTEgibJrIPIIQrTuaEZo1881qjnOHldalra7gZAaejsZGU1Azy6yBprmZSo6bsLBi5ho0UunGtzPvHYQeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6168
Received-SPF: pass client-ip=40.107.21.136;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 09:03:34
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We leak local_err and don't report failure to the caller. It's
definitely wrong, let's fix.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 blockdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 1c74490273..c70f3724d0 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1825,8 +1825,7 @@ static void drive_backup_prepare(BlkActionState *common, Error **errp)
     aio_context_acquire(aio_context);
 
     if (set_backing_hd) {
-        bdrv_set_backing_hd(target_bs, source, &local_err);
-        if (local_err) {
+        if (bdrv_set_backing_hd(target_bs, source, errp) < 0) {
             goto unref;
         }
     }
-- 
2.21.3


