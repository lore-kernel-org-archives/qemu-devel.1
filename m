Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CA2C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:27:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E3EF2074B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HHIkwycy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3EF2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfp9r-00029S-GD
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 14:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfoug-0005PV-PS; Mon, 01 Jun 2020 14:11:54 -0400
Received: from mail-eopbgr70093.outbound.protection.outlook.com
 ([40.107.7.93]:39047 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfouf-00026c-NL; Mon, 01 Jun 2020 14:11:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dtb1/0aC/AhbduEQ72TXAP5hcBE18LHu8SNK8AvEur1mqSSPL0pDpcXxcbdDNgBnVol0G0gKGMAEm6a8pWvQC3ywWC1a6+m4L7zRxyxV0C1hjXGj1QfJh1wBO03FU+LoVoTkJXeqwXGJt9zLFlUZofFODGA1UNC6m2KsSA/QEw0ecgsOIqC0olAG3rLdy4bPEu8tiJOopdcMaYW9NoLTu1TGvSlHWnlS75stlyaFO8t8492fwb6PQKWjS5pyGx+P/4Ebbur3sfmlWevjmC7QMSEMc8wBfwuVfofEcIvNsXClcKaOkCOKL9l+lOBSnhdSH2xeC53wBkofioQsSveS4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6JqXlAS0MeZj7WNu4DCIXcL4WTXJOt0NNgTB+Uo0wI=;
 b=TSLkPJiTNp+Ddgt7Nq/MtZ9AkmLaLFygi6e3fCgqVGOH6mdVg5fnIFHMDxMU0QzAzLqcZFuz1MfAlv+fepqb6ory8VuMiFjfs3FFCy1M+Lbt9jpCDUmjMlciYEzqJRpAxPI8nww2LO8am0w3ijQIfA4+bCKlZEa3d3dTX6rZlT3EEMJWmmv1EPDjJfQaVS1oTj9qmZBGoZQhfR5smgadwfWUWaMqOFe+pLRT/qAMcsbkZu7WQxQLrlU1kssCgUdCrIv2i0xnmiJP9NpEm0bYjNc2nBOZyN0rnr+EOdibKTTgIq7xnwLQQA7tAxYEfET9Mq3l+7Hg64R/8YWBL0CpBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6JqXlAS0MeZj7WNu4DCIXcL4WTXJOt0NNgTB+Uo0wI=;
 b=HHIkwycywIV6cW7xIT0ZOFrLW9CxVZE1BnvDtICykhkQvw66tWHaisNnKuGlLQOrdSz8WNP1GLnvmxkPJLhY3jonnjp4VKv5aVC5W8flt2Squh5MXItvulbbUsOS2JPMC3iFgImm8uzRVQgj3GIb97KnGKpwWl91B9OxqfzdvLU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5317.eurprd08.prod.outlook.com (2603:10a6:20b:101::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Mon, 1 Jun
 2020 18:11:47 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 18:11:47 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 18/20] block/block-copy: drop unused argument of
 block_copy()
Date: Mon,  1 Jun 2020 21:11:16 +0300
Message-Id: <20200601181118.579-19-vsementsov@virtuozzo.com>
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
 15.20.3045.18 via Frontend Transport; Mon, 1 Jun 2020 18:11:46 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.170]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 951d1bb9-bc33-4162-de94-08d806573f8c
X-MS-TrafficTypeDiagnostic: AM7PR08MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53172096CB13671AFF267212C18A0@AM7PR08MB5317.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:30;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gliWib2cvJ7DV29UIMk8UrdWiRgobpiobAilA83LIXMJL8po34O701L1ETglgC7PxlMZTtgj6CvE8KjhxP0ROJKH76PTqSF0ze9y5TqZJLuXHMWMsOqnvOPv15zB+yehVzOtnlwob/te5OGWDQsW8ItbTQjSwGXG8oOkt+rSS2e8Jx2pESP54i2GOSA39Ao11t8RKl2pONsUmEvWTAPs5O7Ml55DFXi/ga0BAMqsErBWVVakXHKhZz8Mhnb1AqvbEU7ybVfFU1MCgQbUtm0SUr+EpIi/FvVkcTXCoqkbo/0bRPsvgoKgUmkBui3DNGJ2eLPl+cInDmjfiSwrwJXQOQ/nVopMNNner+n8+S3AOgtEqKTPTOrjQzjbNUFNyGBc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(39840400004)(346002)(366004)(186003)(16526019)(8936002)(2906002)(8676002)(26005)(107886003)(36756003)(316002)(6916009)(52116002)(2616005)(956004)(478600001)(4326008)(86362001)(6486002)(66946007)(66476007)(66556008)(6512007)(6666004)(1076003)(69590400007)(5660300002)(83380400001)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: T39CMsRE2qYQjtmuYbo1M8K2lwka0B1DDo55EUUEHRMxbBo3lBauvsdZhtlPkIRLtymOocw+uaDVJXZrZo1MQjht7iriCKV6qurrAYNCoCEPuX4s1CmwQ5CQdRgTeyHDOtvKeYop7EPvhEvXYfkWLY+4fZkXl6jo+xuM9wog/YPcoIoGRYG8SXDyFOUNuk9zIFrkWJoPma7b6VwrMPu2CpT40hDXxBZHEEKi1Bzm/8ujGZC8LVLW2wK/lfrpfe1MvuAosRUWBt34YLNTWc/Eb1uCQVF6IRTEjm6wi5dHSHxeXqFQxvxxtijEdwNgzsoK3euwslrhVBR5lxZMMGgUrUadlKSUcxtYtfvffQrjxJ6Ck76OlEehBOHvb6w5BbS66Qg5B5UVuUK7kSc4rk/hGXil68rIrFTh//Mop5+IiwSTqOMl9WH/n7Xkkv9j+2hgCDtzIjjyP4Ipl4pMTi26e8k1NhCuPLkojQ5IAP+mhn8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 951d1bb9-bc33-4162-de94-08d806573f8c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 18:11:47.2362 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q6jk4GbE3BV1CnjG16jRkAoP74IFCfC7p/Lah3W7EgOso2eK+GarG3jKfOSaZ4dsxEkrMb15FOV61lAfnERDl1S3qBJgtNVm3H1uq5NtWO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5317
Received-SPF: pass client-ip=40.107.7.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 14:11:32
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block-copy.h |  3 +--
 block/backup-top.c         |  2 +-
 block/block-copy.c         | 11 ++---------
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index a3e11d3fa2..760dfc9eae 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -35,8 +35,7 @@ void block_copy_state_free(BlockCopyState *s);
 int64_t block_copy_reset_unallocated(BlockCopyState *s,
                                      int64_t offset, int64_t *count);
 
-int coroutine_fn block_copy(BlockCopyState *s, int64_t offset, int64_t bytes,
-                            bool *error_is_read);
+int coroutine_fn block_copy(BlockCopyState *s, int64_t offset, int64_t bytes);
 
 /*
  * Run block-copy in a coroutine, return state pointer. If finished early
diff --git a/block/backup-top.c b/block/backup-top.c
index 0a09544c76..f4230aded4 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -61,7 +61,7 @@ static coroutine_fn int backup_top_cbw(BlockDriverState *bs, uint64_t offset,
     off = QEMU_ALIGN_DOWN(offset, s->cluster_size);
     end = QEMU_ALIGN_UP(offset + bytes, s->cluster_size);
 
-    return block_copy(s->bcs, off, end - off, NULL);
+    return block_copy(s->bcs, off, end - off);
 }
 
 static int coroutine_fn backup_top_co_pdiscard(BlockDriverState *bs,
diff --git a/block/block-copy.c b/block/block-copy.c
index 6a9d891b63..6cb721cc26 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -713,8 +713,7 @@ static int coroutine_fn block_copy_common(BlockCopyCallState *call_state)
     return ret;
 }
 
-int coroutine_fn block_copy(BlockCopyState *s, int64_t start, int64_t bytes,
-                            bool *error_is_read)
+int coroutine_fn block_copy(BlockCopyState *s, int64_t start, int64_t bytes)
 {
     BlockCopyCallState call_state = {
         .s = s,
@@ -723,13 +722,7 @@ int coroutine_fn block_copy(BlockCopyState *s, int64_t start, int64_t bytes,
         .max_workers = BLOCK_COPY_MAX_WORKERS,
     };
 
-    int ret = block_copy_common(&call_state);
-
-    if (error_is_read && ret < 0) {
-        *error_is_read = call_state.error_is_read;
-    }
-
-    return ret;
+    return block_copy_common(&call_state);
 }
 
 static void coroutine_fn block_copy_async_co_entry(void *opaque)
-- 
2.21.0


