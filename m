Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842C2C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:43:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18E202396E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wch56g8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E202396E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLX9n-0005Ep-8p
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLX6R-0002Fc-TJ; Thu, 24 Sep 2020 15:40:27 -0400
Received: from mail-eopbgr30115.outbound.protection.outlook.com
 ([40.107.3.115]:7591 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLX6P-0008DY-Rw; Thu, 24 Sep 2020 15:40:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=To5yruTbdR8jpELyiDQimxFW9IY51LlPRmmhTjHslIfljuu/QKOG29RqYl36J88oIip/E53p8PDQ0mVH0ic+/D6AfyRrRVFVjqlFjRDFaZSUTkaKO9TpXfZmgmEw8I5zFm4qV4PgELieWXWt2cFowErfWbILCIEbVRG+tgmwd6lfvSdvXNJkBi01btqy8Ds0iAJTq1IAV+j7UjmrOvjEodakU+FJbR0O1tn0NLhViUooSUfHljZhRXZiX5LrAGiZk0sREfg7K8an/BmjF01Ah6w92zQSMN/IfBSJ8jQ4f+hYutoc+AQigzatSk2WAdRz+co4GSwYKAGtPMthB2VpUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1aC4vFeszLZooBKESYqHp+t0NRkhpkuPdFReSBcd1A=;
 b=Unw3dFc+ZB1JUt/p4sf4dU/R8j7RZfu4JuiDc0L8Eu9ANGuRm+3LPn/HS7U6CXLlnur8FVpU/O6nWo6PfNEpFYvF/3mWSCyF8NvWUTnXEgpIslXS+fPst7CHYiWgRO03lwDfCKWCZyl00eByGRjnvSB0n8mSHv/7Hl7Otlp08mtf6Kv6dU2zq9UlC43FQr1xTVbbvtCSJQ15k/MwodjmBjz0zQcKlyfijPsotEwL64wb1fiuEaZL+sxgxfYUpUbW+ayAnGEtrJhZToxLzqT6n7YMKn8vB3YIX7R6mzTiAnp31FlByA+TSuo4cbQds+b2hJMP7qugxb7CnlsB8lM9QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1aC4vFeszLZooBKESYqHp+t0NRkhpkuPdFReSBcd1A=;
 b=wch56g8AvB4C8L0TwMty2YMOPKLnDGJeSPP6niewwbeMXvY7FUAS2p2PJS/gWcFNtL/Pc3mGVLEZuiMm9IQ8JDbUPKf9FWIExs2IgomXMWAlgFbnpgOx750FNyTHbFHo2JVIZ0zI181v9Pi4GNV8ERhd8Q5yW1qAzeTCfDrnx6E=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3288.eurprd08.prod.outlook.com (2603:10a6:209:47::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Thu, 24 Sep
 2020 19:40:18 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Thu, 24 Sep 2020
 19:40:18 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 mreitz@redhat.com, kwolf@redhat.com, den@openvz.org,
 vsementsov@virtuozzo.com, eblake@redhat.com,
 Alberto Garcia <berto@igalia.com>
Subject: [PATCH v7 4/5] block/io: fix bdrv_is_allocated_above
Date: Thu, 24 Sep 2020 22:40:02 +0300
Message-Id: <20200924194003.22080-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200924194003.22080-1-vsementsov@virtuozzo.com>
References: <20200924194003.22080-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0112.eurprd07.prod.outlook.com
 (2603:10a6:207:7::22) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.94) by
 AM3PR07CA0112.eurprd07.prod.outlook.com (2603:10a6:207:7::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.14 via Frontend Transport; Thu, 24 Sep 2020 19:40:17 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6316458-187e-4d2d-1609-08d860c1aa83
X-MS-TrafficTypeDiagnostic: AM6PR08MB3288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB328819B7250DD0686DCCB101C1390@AM6PR08MB3288.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DNaaNqzEy7WgaBeL/3vtmH8hOJqI1BjjlBB2hoqXUFXMmmBiljY+MyadZUhn0M+iOFFsxX1o0PD0YGDkf3pmWwskSyBnsispQlDggKhhihJhbjrRROacHlf4P+aDRJpMcep0c8RFuWtEEV7P894YOYBWd9Mc3MtaG8cEUJ/4DOwjzgJOEIOyevqaBnB2I1+PCSZVURPLB88dLvuigzZOLGLWGL6pV2fuo5Ut833LSdmzjkcUALxSqdhvJKg3HEPvfytcZOjyxsLHdoexgFUisLEDY9JbD6dLqI+3+0szCZwT3GZZVpy366Tf+bD44t1hDJshmHOmAhnN7r5iznp64g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(376002)(366004)(396003)(346002)(136003)(8676002)(66946007)(5660300002)(6916009)(8936002)(1076003)(26005)(66476007)(52116002)(478600001)(66556008)(4326008)(6666004)(186003)(6506007)(16526019)(6486002)(2616005)(6512007)(2906002)(36756003)(956004)(86362001)(83380400001)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: V3IW7NDeeE0pZ3/XHd5+ktOI/oaI4+oI2NqZtl8yZjadfyRsDiR6TJp77ve22rDoSs5/5P5JvD6GO6ypQONpr4z22tCjF6J9Gi2cEKPMvxgH31Pe9xH8SzOVVqHHHrEW4LeUTkUB1RhnTCTevP/F8bBEzMvBm3Dzc7iM/3LCA2lUyxMRrvSOKC8qKrk9FhVO69OvSD6Axe8jxtJnnnB64brc3D6SvVH2vUgT0F3o4YyOOMAPFhCEvrIKeweYMGv94UaqkF5tDkQrmcy4Twij5NqC0WGJpgOYvYlGjBd+pBjc/0DEXEaR6DIDJw5CzU8pfYxJDTg9GC+iAylqL35Oovj46N3oJ1us9X47YYs8hhAT+ln5h5iO3BmRNY8Rx71THQOdodohY8hrmyVFUa+Qn1xx23B4vel4vvF09rRW9kOAyc3sZ+OL1TOf7gHvIInKfACHFf5QyI5XyumpHQWonFvbbN024vBFkQSA3pH0XkuYyjAdeSEa66br/AhRlM7jumrRFgqb05UUvj7esc5cJ30wyULfDbZc+TPJesJqYBn/6nNxDgHzM/K4PLRpxpP0mUs+uPPAoIUaADq8B/gsl7qvzvuIlUcpUUwzbaA8yxKldyAPpXedgL1OYsC+Ax51vK0lD2UERBl8Qd5D64QxnQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6316458-187e-4d2d-1609-08d860c1aa83
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 19:40:18.0349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qskoEZ3oc8QHTaARJWHECfITrvwU7YGtKDF/EGicnkAl+O3V7udGeIn3K4vM+rk6+FgaAZlGpKgf475ZfdB2dQijGK5YtgiR1NStjuZFDz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3288
Received-SPF: pass client-ip=40.107.3.115;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 15:40:21
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

bdrv_is_allocated_above wrongly handles short backing files: it reports
after-EOF space as UNALLOCATED which is wrong, as on read the data is
generated on the level of short backing file (if all overlays has
unallocated area at that place).

Reusing bdrv_common_block_status_above fixes the issue and unifies code
path.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/io.c | 43 +++++--------------------------------------
 1 file changed, 5 insertions(+), 38 deletions(-)

diff --git a/block/io.c b/block/io.c
index 82a3afa3dc..36baf4fed4 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2477,52 +2477,19 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
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
-        intermediate = bdrv_filter_or_cow_bs(intermediate);
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
2.21.3


