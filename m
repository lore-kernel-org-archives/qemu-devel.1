Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737D8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:44:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B1342074D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AswDY8/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1342074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZZhP-0007Zg-Dc
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 08:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZZe5-0002Ar-Bn; Fri, 15 May 2020 08:40:57 -0400
Received: from mail-eopbgr150102.outbound.protection.outlook.com
 ([40.107.15.102]:11310 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZZe4-0008VJ-7K; Fri, 15 May 2020 08:40:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnLuggn/DIDpc+Rc9MOCTDhQfU/VLN2fyyJwU72OObTE2/fwqE/m537v6hf/P3IMAuFNDmISCuyV4DNFZJxPe9ImI4/jX6BqJfLiJSkDn+SYPAoS5k1G1557UAAlO/g9cYz+KyyAsR6ZmBVotECWaWRt18PjVWVONIQY3hlT2gAb0OenQ1jR5uLWVCzpv59wBOH/aVelxx0ROSy+JrNBO+Vy+j6msq67NdL51JbLpOX6+BM+yJ0Ez+U0QNDR2yvDwdZMB5KV4uoynpkwOFIr5SNhmoq2VRl/t5JZg5bkE0hnOtwvfhhMY7z26VgX7oLuCJczBzx2MGstHFjhp9EMWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8L1mEFwFjcRzqL8J+Te2vzHwB6npe2ycUNigAGbXEs=;
 b=GxabazftCSiDihCsyxTj1Xgu2I2IAY2DXY2Y15n00b48y73FYwyYJoHLPt/4VsfyjCpeS3238UYCuG5W8n83mPDnr0fJ8Zb2B+nGHyt/DayoREGpjJBdWmlRqwekeQuE5AjZYGB0Yae6iK1a72q3QCyM/Euq4r71req3bGFx3rlz6Kr9msNdpRCTG/Hf8Fp38k5Rt7jxCdLrqmTJi41tpee8LziPaj9I/6ZChV3f+ZvdOaU3SN41wtOa2IX+smdoQKgDcChwjloKHYAU1nnxY3o7WoWgKVC81LNeh7YOt5HpoPAd9CDBk1tfHDWZ/8zkHrMFbn4E0PjWxienEjDb3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8L1mEFwFjcRzqL8J+Te2vzHwB6npe2ycUNigAGbXEs=;
 b=AswDY8/sK5s2INExW55YFayYABj2IfRQfRbwl/NUVk3jnzMNckR7BVq71pI7ZTKm5u6NLChl9p1b/OVCqc6d6fCEPxeUI9UGmbA6nirG+vrvseuX0DWKt8fDxN94fcwmjud/qtLmu12EYtT82DNEPcpCJJxpr/cddb5mXl99Vrs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5381.eurprd08.prod.outlook.com (2603:10a6:20b:105::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 12:40:51 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.016; Fri, 15 May 2020
 12:40:51 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 1/7] block: Mark commit, mirror, blkreplay as filters
Date: Fri, 15 May 2020 15:40:18 +0300
Message-Id: <20200515124024.3491-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200515124024.3491-1-vsementsov@virtuozzo.com>
References: <20200515124024.3491-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0039.eurprd03.prod.outlook.com (2603:10a6:208::16)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.184) by
 AM0PR03CA0039.eurprd03.prod.outlook.com (2603:10a6:208::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 12:40:50 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96c2e4c3-4935-482a-2806-08d7f8cd336c
X-MS-TrafficTypeDiagnostic: AM7PR08MB5381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53813DA1C8D818F630A98C28C1BD0@AM7PR08MB5381.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:33;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +rVcYCc0CoiCTK0KOZ6f0ie95GqBOy0ezZn42VxsUqn4j/Qugz4PZ26oxMXOszRLTgq2V0Xo7oqAi3Iu/jJfkmfN841VAG+HLOZVJ0l2GITa5WS49IF5qIYxLn7SSrZ+tiOBXGp5U+d4Lk4bFkvaHp5Gsf7PKW4rXrmREnJvKIrgqfA3lPl/S6N9RO/YX3gBTzk+VzLSr4oCu0QYDn7QcBvfSzPLS+R5bUgyQ+KkRuFv2VDtdaO+q7KdZQGfE8LumAa5g/cphX0TQIbH6h/WdDbbzaehDHRrFemcTYxtsQ8WsUjKATbJZomUjFzKAk2o0YDhNGtO6BaodVS2T9ZID+yJ6/Mt3t7MEwIlcJd8d9JuFKPXW2NLxylhx3jtcqOCxW8BLT1qZd5uClCc+7m/nAvVZEOzJ/L5Myu1z9Ho6QDNxpzjWnwbgpLFb2aBdgvt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39840400004)(52116002)(6486002)(36756003)(8676002)(7416002)(8936002)(6916009)(478600001)(6666004)(86362001)(6512007)(4326008)(316002)(26005)(5660300002)(16526019)(186003)(6506007)(2616005)(2906002)(1076003)(956004)(66556008)(66946007)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: lO/EcPi7p9azvQUuFxzLaYkUn6KmvC15bwg0G7H0D59lR1VyWtbc5fNZTk5ZpZhd1R1SQHeX01RRjiBId4p3wHJCionhSKq5lUG4fUjyf4zyiaEpFVRNSU/xJzJszO5/jnf+Efxp4H7CKnhKTLIMagfs1GwEsvPvLkW7mfm/HVQNBowW5wmVLSS/3np0UyfQs707DN2vqSOkKAEoL+0LVJttVqHA308XC2VzJoCS0NldH1g+5Ho7VoBZFQS2eqp4uunjNiv6KJSkn49fn1y7i5fXue6QT3u+8xCG9iSyV69byuExxzFQ43ftI0J9+ViZ9hjdCrMb3iFs3Jlq+elx9lws6r03HgPn3kkwKipjr3m9tu317WLaJyh2pw8O7/5lMTsEgrJsdyZXg6rRDP7O2drTGWrSUHToiabxS5GKHE8lk/0uMojuXOOHilod1MhNa70U3GnLGqBf3/YbREGrge4WKNC3jP/EwktPPVhrL8lNq/WVPx4KxWKRB2TnXRp7
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c2e4c3-4935-482a-2806-08d7f8cd336c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 12:40:51.2378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OAxxAU3l+lXUcE2biLv0fopK/Sy37ZD6bX2o76xsi7ddx8BquJAwEDxAy1dyNqL6fTe3w9i83zY6j7FSKlI9/ndGqpeGxWKDj1BnzPVFUDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5381
Received-SPF: pass client-ip=40.107.15.102;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 08:40:51
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 stefanha@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, mreitz@redhat.com, pavel.dovgaluk@ispras.ru,
 den@openvz.org, pbonzini@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

The commit, mirror, and blkreplay block nodes are filters, so they should
be marked as such.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/blkreplay.c | 1 +
 block/commit.c    | 2 ++
 block/mirror.c    | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/block/blkreplay.c b/block/blkreplay.c
index c96ac8f4bc..131c9e8477 100644
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -135,6 +135,7 @@ static int blkreplay_snapshot_goto(BlockDriverState *bs,
 static BlockDriver bdrv_blkreplay = {
     .format_name            = "blkreplay",
     .instance_size          = 0,
+    .is_filter              = true,
 
     .bdrv_open              = blkreplay_open,
     .bdrv_child_perm        = bdrv_filter_default_perms,
diff --git a/block/commit.c b/block/commit.c
index 87f6096d90..445a28069b 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -240,6 +240,8 @@ static BlockDriver bdrv_commit_top = {
     .bdrv_co_block_status       = bdrv_co_block_status_from_backing,
     .bdrv_refresh_filename      = bdrv_commit_top_refresh_filename,
     .bdrv_child_perm            = bdrv_commit_top_child_perm,
+
+    .is_filter                  = true,
 };
 
 void commit_start(const char *job_id, BlockDriverState *bs,
diff --git a/block/mirror.c b/block/mirror.c
index aca95c9bc9..b6de24bc3c 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1527,6 +1527,8 @@ static BlockDriver bdrv_mirror_top = {
     .bdrv_co_block_status       = bdrv_co_block_status_from_backing,
     .bdrv_refresh_filename      = bdrv_mirror_top_refresh_filename,
     .bdrv_child_perm            = bdrv_mirror_top_child_perm,
+
+    .is_filter                  = true,
 };
 
 static BlockJob *mirror_start_job(
-- 
2.21.0


