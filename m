Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7EFC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 12:28:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 684F3206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 12:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="B1qKWqkA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684F3206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jizqa-0004Kh-MI
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 08:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jizTQ-0000JY-OP; Wed, 10 Jun 2020 08:04:52 -0400
Received: from mail-eopbgr150135.outbound.protection.outlook.com
 ([40.107.15.135]:4365 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jizTP-0004Tg-M6; Wed, 10 Jun 2020 08:04:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KaWZB2ohCHSSryfQlsQSwA7e1lDcjS6lqQlkyTS+p+06npc7uqN7x69vsGMVrIDQuT9I7A9uNCaJN71Z3eoDP7f8pOVJMByPNcYb2RVWa9baX7UvowOu1bfld0cbgGgdMClNoJwJ4+w1SNwMofPk9oqQbXZjMVuDu40ZcVKW8KolTU2ED7KiR1gtxr5OAXAe43IvV8NaUOYVV7nNfenoPA66QuKWwp9CuJH4l1dARcurMpyNoQSIEnnm4cSDObQAbqe17Q0Y/9NjQi82To64EujUKCs77MeE4TtlaxfQvowA29Jm7UnQfIGIOVE1ZQrshevsEeQK/79pRe91mvJn2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNhLCI1j5JoW/OXtyZ6Sg2hnJWRnqqxJ2k72egXH0ok=;
 b=VXEU81vRuonpBQxcBRfEKbjfjSVSsjmgUbMCSElXsiZ8LKtHR8rTbGLAiLn0MnI/5GNrsTUSt1SpxS/VCoqxiyAKxH9O11McsepsglGAXZbzL2YU5b3Xk7+eHuBpOsAeLlrhpXWMtd4btLG0TnDq/znW4GiiCJcDsXbNRhGpLYKMkhtsMP8k+4JWV/UQp+iYYr1mNjAV+nf2dhis3HDBCx5A4gTnutr15u1ESrSzk45d8yU7EYiuT8rKsstGMTOaHFQLS6rwrGNzulVX++oeDoWywWmUZmdVBgaL7lfzEw3s9XS9n2QSLsebfFil7lCD6ub1ENyzoUkZVVeVbfMSQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNhLCI1j5JoW/OXtyZ6Sg2hnJWRnqqxJ2k72egXH0ok=;
 b=B1qKWqkAeF3FaIm+x8kZ3q80RCWWcHh+fOfwiD/kVCvFlZfdutFgqYK07LtNflUTIPXuwcMleVRGb2FUID05SSMAshxLYafnpZkJLyoG3rjoU9Pcw+0Hg8g5+Xg35/CvM77rmw423RiWq/O220TZ4TMkqZuI3bpwaNmtqMKD8Pc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 10 Jun
 2020 12:04:45 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 12:04:45 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 4/5] block/io: fix bdrv_is_allocated_above
Date: Wed, 10 Jun 2020 15:04:25 +0300
Message-Id: <20200610120426.12826-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200610120426.12826-1-vsementsov@virtuozzo.com>
References: <20200610120426.12826-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0104.eurprd05.prod.outlook.com
 (2603:10a6:207:1::30) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.166) by
 AM3PR05CA0104.eurprd05.prod.outlook.com (2603:10a6:207:1::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Wed, 10 Jun 2020 12:04:44 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6fcee0a-c646-47ae-15ae-08d80d367715
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5495FA99FC325BCC4E07D734C1830@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dtwCR5vXQetVWm5VifGMHEcBBSdQ/LYCMuCU6pKP4cwd+Mu7AaQwHwS7PExyCDyHcbpzxIy8U/nmWwm4sJnocG/YCSRxCSqEQEkOcfiEI3EvfZKwzcOV0YFBxLZXCvJQEe2gHgZhhPVEXQxut48B8/wH4dPheYCecOTWq6lGN60q8bAfLu+IaNqJoXJ8QK8EhKtf4nhDRce68443AHdpUTIpLcfNwROKt9yXMns9vdu6XBT2t6CzQgoaNF9AGTBXfVgG0nyMQTXqZKBA8O5U1As4tTsLZRj9eA6pPt/04rChXBxXHHSvJwN+BuMwJDZK9s2Vy7X0wqMvN+wsHI/6DQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39840400004)(366004)(86362001)(8676002)(478600001)(2616005)(107886003)(8936002)(4326008)(956004)(52116002)(83380400001)(1076003)(36756003)(66476007)(5660300002)(6506007)(2906002)(316002)(26005)(6666004)(66946007)(16526019)(6486002)(66556008)(6512007)(6916009)(186003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 41tj4T6R7RokW9sRLZWebQS5DtM+Knnwd0yT2hak6zYQtihtI2tmaFv8KFL7ioBTgt6UiG7xZPpXiqFJbjqoDxABBDjkrLr+fDn7/vtt3Se6FAa/+OML9Vm0De/g06jbn9SNNKGfr+NkIaOeRH9wSUxZr8xoUei0L5Ep+KBdrwklI4PFN0b9owXx/cYbEFS+Aa6tMHk2OF+i2an7fDe9N/ojbOjLK48lKJZv1hFtyLKorru1T5o2xeqkx6iVgLtrDoj/iLyb6IQaH6HqbMJwXiPgoSog+Ck119N1I2dqv7F1Fzt5VK/UyIh8JypbpAHXq9LWsMBir9BtZbCF0ST9V41hou61+gC/oh9HJGy57JCqzoBKt0ucIctb42CeD6VoGP4Jmhj5rlA7CJdvivukcMbf5K6eo9POOljFGtGXQo4BL85rwAn9mMBbuAPUbYFLmzV4ZvDcQQrDHmI3lRZeCcXmfu1GVwj+Abw+yjsB7D/gNl6P8c1jh0OVmiDDSlzx
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6fcee0a-c646-47ae-15ae-08d80d367715
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 12:04:45.1962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHJL3BWz6SGblfrRFYdtkCND2DXYdpYSTlBsdJX2wT8IVu5elwtJxn79t5LE/en+kQ7peZPQASPwp1jsauwXNDzLGOm0/vnLXERHZUJ8z9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.15.135;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 08:04:42
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bdrv_is_allocated_above wrongly handles short backing files: it reports
after-EOF space as UNALLOCATED which is wrong, as on read the data is
generated on the level of short backing file (if all overlays has
unallocated area at that place).

Reusing bdrv_common_block_status_above fixes the issue and unifies code
path.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/io.c | 43 +++++--------------------------------------
 1 file changed, 5 insertions(+), 38 deletions(-)

diff --git a/block/io.c b/block/io.c
index 3df3a5b8ee..e80f7ad527 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2471,52 +2471,19 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
  * at 'offset + *pnum' may return the same allocation status (in other
  * words, the result is not necessarily the maximum possible range);
  * but 'pnum' will only be 0 when end of file is reached.
- *
  */
 int bdrv_is_allocated_above(BlockDriverState *top,
                             BlockDriverState *base,
                             bool include_base, int64_t offset,
                             int64_t bytes, int64_t *pnum)
 {
-    BlockDriverState *intermediate;
-    int ret;
-    int64_t n = bytes;
-
-    assert(base || !include_base);
-
-    intermediate = top;
-    while (include_base || intermediate != base) {
-        int64_t pnum_inter;
-        int64_t size_inter;
-
-        assert(intermediate);
-        ret = bdrv_is_allocated(intermediate, offset, bytes, &pnum_inter);
-        if (ret < 0) {
-            return ret;
-        }
-        if (ret) {
-            *pnum = pnum_inter;
-            return 1;
-        }
-
-        size_inter = bdrv_getlength(intermediate);
-        if (size_inter < 0) {
-            return size_inter;
-        }
-        if (n > pnum_inter &&
-            (intermediate == top || offset + pnum_inter < size_inter)) {
-            n = pnum_inter;
-        }
-
-        if (intermediate == base) {
-            break;
-        }
-
-        intermediate = backing_bs(intermediate);
+    int ret = bdrv_common_block_status_above(top, base, include_base, false,
+                                             offset, bytes, pnum, NULL, NULL);
+    if (ret < 0) {
+        return ret;
     }
 
-    *pnum = n;
-    return 0;
+    return !!(ret & BDRV_BLOCK_ALLOCATED);
 }
 
 int coroutine_fn
-- 
2.21.0


