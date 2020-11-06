Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB2DC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 12:46:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FC76206B2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 12:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="e/zJBc9t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC76206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb18J-0008E7-CZ
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 07:46:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kb15M-000326-BI; Fri, 06 Nov 2020 07:43:20 -0500
Received: from mail-eopbgr130093.outbound.protection.outlook.com
 ([40.107.13.93]:31364 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kb15I-0001NI-VB; Fri, 06 Nov 2020 07:43:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2sCt9XtOv9ay0li87X47OK8Ka93fJcUoAygx8vbpt2iLyFOl2KIniHdw+je3a3fAQ5Pzybikjr+p6QqHifPjhc/sLTupr4X1ABADAsgTbEytcxa/oHIKgFsAM7W8KbFdLc6u59fjTTfQxCGB4nRJYuaz24nnvTt7xfVOjADzEJamPQjFbXx5g9t1fx7y/WHv3Ce9Z69hsRavG7HHIDhmSS97AcJLNiFqlYitCsjKIadolfL99RLn5PmYVJau5tttEiUu1eKC5cjGxKN6yE81IXZ65T5dfS/YQQZYPzxO5068AY7ZtaINdN8ED1TdmkPKMk/3MJHxUGDE/2xpD/16w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Iq73J5SSkhISuVlW5mi9lRpv/TCriU803cVP7647uw=;
 b=U9+hwZKl96b1rksbqo1ydbqJ21S3i+NdN8FmonPKRG9j2kmK/pXPU+xcDEOVbK73IImoBHfNLkrD/yNg1sJ2Yk/nlhwG9nAo9fKXSfqvHBTmB7BsNbyvii/yJARU2lXBDSihekcVBKcIbnUz3enjPWYBFVX629ZT/HK9J/erqy0DkEhYuRRvF5Fywd1TtpPGPXewLVAqmWQVlE1X8p/nI4j/RK0tR4a5DpJoVDF+IBS+qdmFy+TyMZpUUAp4NqeWuBZWDNhPqr9aBChiAjgeyAFZCSUTf4o7OHvCH39kTzu7+89YC3vyS/lAAlbPAOY4GiqHN5CEoF+fNXwrTpCbbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Iq73J5SSkhISuVlW5mi9lRpv/TCriU803cVP7647uw=;
 b=e/zJBc9tXXDAYfxt6svVgCGTZ3h69HNrL9e3waMXd72dv8dPO0gOa6OvLrLJky8/pM/rBf02DuwJKqbRkL0SRJBELRsYKBJv1LuRFAzzUkvqh2z0wMZvs02a7W0h3NHNHmehHnTZWntuZ1DqUh1+VFTAEw1G7ZIYqo7VFPxnaFA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1841.eurprd08.prod.outlook.com (2603:10a6:203:2e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Fri, 6 Nov
 2020 12:43:01 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.032; Fri, 6 Nov 2020
 12:43:01 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com,
 berto@igalia.com, vsementsov@virtuozzo.com, den@openvz.org
Subject: [PATCH v2 6/7] block: bdrv_child_set_perm() drop redundant parameters.
Date: Fri,  6 Nov 2020 15:42:40 +0300
Message-Id: <20201106124241.16950-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201106124241.16950-1-vsementsov@virtuozzo.com>
References: <20201106124241.16950-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.66]
X-ClientProxiedBy: AM3PR07CA0104.eurprd07.prod.outlook.com
 (2603:10a6:207:7::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.66) by
 AM3PR07CA0104.eurprd07.prod.outlook.com (2603:10a6:207:7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.13 via Frontend Transport; Fri, 6 Nov 2020 12:43:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a9138c0-1a6c-4b9e-879e-08d882517f35
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1841:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB18417E0CC65737B537E291AFC1ED0@AM5PR0801MB1841.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:747;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: APpYuqNmRmt7iaq4tU/WXiuk1nDE3CsFMgrd2qV6iHImwSB8zRYkIhPZv7gfu6xGcUfi+DIYKPy6vDicvU81irqyLdcK0D9ZvcV9q0stA/CCqzI6eJ318l4GEaoMVX+f/xxunLshfDF1kB3ibm+iXmwkUpbwi6XbJe4goobWiBJmDeWWzqQ2ti+ZHJtr8aZ3myXCzkDTHLcitAbJ/sMaPkLn40q9vEEIPSBdDRL16dYRKpu9M8itq6I7VpAEnHzUQLyr9GkU20afrO9SRopth9aaLNZqQS4YW2rhutRuQ2pfPPEM3uNKVZYlRUskbKcD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(366004)(39840400004)(346002)(6916009)(86362001)(66476007)(66946007)(6666004)(2906002)(8936002)(8676002)(1076003)(66556008)(5660300002)(52116002)(83380400001)(4326008)(36756003)(6486002)(2616005)(316002)(16526019)(6506007)(26005)(186003)(6512007)(478600001)(107886003)(956004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 9/kgP/l2oGySMLPZFzbTUfBoEUjF9QbjotQbjjfI5qLBQWXLSFf7azXj13OfZEzrn3I2158ZvphBwPq9/9SPLhuPKtDpe9q/8hfw9zzUo+xo3/Ux1lNg8pkPjJ54jzLuVY0TB9A5jtsAlDtdA4wOJE9TVI2W911UWW5r1s5RsadUSpqUb0PqyQfznbDVHbpYgx7M+E0gyFKHHoVQQty3lyNzouy0qvE6+avCIvjp91zQRtbnTgpz8mGGJT3P2gIP7F/D2TXPXMiPwMDrj5JYcQAb5VVJE+zXFPVJVm23fC+gdMCv2154WhuoH2zQlXtIrvbJI19ADoLfIzqcVX9GmEOw5Ll0fcVLtERr1DKZSZvELdl8QvOz3n2Td4mWBtvfIW28ApzJWf64C9jVBamZBAsbDz6XmBO6mJbA05apOIPCiMXkBb4dSrD9e7kfuDx8F3ry7o5SjdN8qL7UHndixe/0eh7HY4nzPq4NSV6a9LbJWP3ozxDdzJHOAvMXUzAVMWCVPgq7BsPJH4EQipzS7rxHJikMdozP6aqjOKaGilrQ7N9jBry76NK1T9QvAvtXjoEpvgZyBU9ziOGvsnZPp857+pR08Xc4fQ0kY9tRbOx79RuAggRiIjOwMx6nhKelcadKqdCkAiU5dpONhGqrjQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9138c0-1a6c-4b9e-879e-08d882517f35
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 12:43:01.2863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufcK1UZ1liOR2+kuCWNwUfRvXQAF4ckiXmTBzYlOe6slR7wL7QmiwYmMt1ZsK5yU2aOrWkDl6jH1PQWlCnhwxxY3Xl7csRwOuArmPHK80KA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1841
Received-SPF: pass client-ip=40.107.13.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 07:42:57
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We must set the permission used for _check_.  Assert that we have
backup and drop extra arguments.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/block.c b/block.c
index b61d20252f..b44db05d14 100644
--- a/block.c
+++ b/block.c
@@ -1897,7 +1897,7 @@ static int bdrv_child_check_perm(BdrvChild *c, BlockReopenQueue *q,
                                  GSList *ignore_children,
                                  bool *tighten_restrictions, Error **errp);
 static void bdrv_child_abort_perm_update(BdrvChild *c);
-static void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared);
+static void bdrv_child_set_perm(BdrvChild *c);
 
 typedef struct BlockReopenQueueEntry {
      bool prepared;
@@ -2131,11 +2131,7 @@ static void bdrv_set_perm(BlockDriverState *bs)
 
     /* Update all children */
     QLIST_FOREACH(c, &bs->children, next) {
-        uint64_t cur_perm, cur_shared;
-        bdrv_child_perm(bs, c->bs, c, c->role, NULL,
-                        cumulative_perms, cumulative_shared_perms,
-                        &cur_perm, &cur_shared);
-        bdrv_child_set_perm(c, cur_perm, cur_shared);
+        bdrv_child_set_perm(c);
     }
 }
 
@@ -2298,13 +2294,10 @@ static int bdrv_child_check_perm(BdrvChild *c, BlockReopenQueue *q,
     return 0;
 }
 
-static void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared)
+static void bdrv_child_set_perm(BdrvChild *c)
 {
     c->has_backup_perm = false;
 
-    c->perm = perm;
-    c->shared_perm = shared;
-
     bdrv_set_perm(c->bs);
 }
 
@@ -2362,7 +2355,7 @@ int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
         return ret;
     }
 
-    bdrv_child_set_perm(c, perm, shared);
+    bdrv_child_set_perm(c);
 
     return 0;
 }
-- 
2.21.3


