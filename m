Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665C2C43457
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:29:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6DA920E65
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MG1twJSb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6DA920E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTTXr-0003ks-RX
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 13:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kTTGY-0003Vm-4T; Fri, 16 Oct 2020 13:11:43 -0400
Received: from mail-am6eur05on2128.outbound.protection.outlook.com
 ([40.107.22.128]:42592 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kTTGV-0007NG-Vx; Fri, 16 Oct 2020 13:11:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ytf1RrhFgeL2dh/TpPBlDXkAunmHJnvYPP1eqgxCxs2sGonyJ0nZp0xdN01ZCddfY7+acblqxyQ54+j1718wG8mt0jbppLqSvdZiruq3W6OXlSIv5cLt8R7psrw8cW4iS2T9dp8m2fFRIl0HqxYG0/W9miRsgnhxi21NXJag8li/lbyuhTvIe7hr8lXpKrDk6TEBttmouMkdWBW87ZdyxZcxOuCaEvBpF/9zdSdwl0QlgpadvdIQpHRRlKyPnKCvwe6F4TC7DCQVnbcg80Wudz+IJdz4n1bKa4gL60psZX+WPgCCUiuT6DF2ZoiD8FU8wFGhrakxlEZaXRn1H/d3Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7jSfM5fFUJgLtB7sfni8JewNTroG6CKzKQYJDhuoTw=;
 b=PLLfKmYSxpXavh7ZRl+eZaniC8l2THVoJGd3mLo8dNIl3gligFx+kNXPIOx/S0rbkejQOupQ0YCdznKyqoS4+gyjCRFN8JBJ6HmVjOqFQVil6doVqRR6zI93WpngQM0BqUpuc6AAFXwmWTVGSlihxP2T5W18+wPQlM+f9v+vFBn9wr7U1vHXj5P9EUtxAbwysgGJRp2OtraNy/f4M5rzfvynCMo6kpGOLzBy7BQQErxjp8EvsVlooCfW6Wa9Ij4l5FOlXeuYLhXDXa2/VKBAmnB7Ye003IxPEzT+BkGYTvhdLFsy3+v3AzJC4ccK1YAmsZK4rOZDD9YZOkNdU9g5aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7jSfM5fFUJgLtB7sfni8JewNTroG6CKzKQYJDhuoTw=;
 b=MG1twJSbwObb8bI6fCjstvpZachtE1YlLQ5n1AzlXP8Ii3MPXflHf43Wd8KLK4Ex56jKEylXsQKY8aD1GXBEP0i/yQH70SeH1/CDN1ehyqr2Q/pXNunPP0lf+eiaMKTF41ASeznvZPtqzG7qD2HOMf7mucJRNTR6U1aeUxVade4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Fri, 16 Oct
 2020 17:11:23 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3455.031; Fri, 16 Oct 2020
 17:11:23 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH v3 11/13] block/qcow2: read_cache_sizes: return status value
Date: Fri, 16 Oct 2020 20:10:55 +0300
Message-Id: <20201016171057.6182-12-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201016171057.6182-1-vsementsov@virtuozzo.com>
References: <20201016171057.6182-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.69]
X-ClientProxiedBy: FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.69) by
 FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.9 via Frontend Transport; Fri, 16 Oct 2020 17:11:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8063c9a-cb5d-410e-fba4-08d871f68230
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB549513B29D896461481E9BD6C1030@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QyEKKHfS1wIyuQpWSx93o1ec7uSFcPScuJffBOayNBPdMx56czFs6Wbg9oY0taqCn5GGGt6ulif7YbxpRKkGaQ9pAN6MtUBWtVz4KmTqxTFh/GiqrA2UBBla9t5jdmhTxzSkPQbHLa1+35V0bEao8kvt92LqQuLMUXX9/8VvVe4DvKIIFdnfx9GoqRydXY9YnOh6KegAxBhiaNqEIXs0oWhaeH0fsuiUUWHgJ9LBVxsc/tWEH6JgQsoOBHu0WRI15+kTKfmtNr4vzHVbHNNKuo8VxWgTkovMQe2nv1rxlimJnDKqEvzUucA4TpmMpa43cSfq+Vo+Au7FMXY4BYpo8LYzdLFw+znPbwvcI7JrjS3qWIKf0Ic9psgTssN+dm3R
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39840400004)(376002)(346002)(136003)(66556008)(316002)(8936002)(36756003)(26005)(5660300002)(2616005)(6506007)(66946007)(86362001)(16526019)(7416002)(6916009)(66476007)(478600001)(34490700002)(6666004)(186003)(6486002)(2906002)(52116002)(956004)(83380400001)(1076003)(4326008)(8676002)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 9gn/d6sEZrtZk+nbW/xJ/ANpPmMg0NG6vCjzG5JV7BNH/qleexE7D6/rpHEgJVFVrlkDCeq1ZfME0xzTUNXhQ3UK+S/Wls/ckePfQtEi+jU4hVDFvHEuc1VhUB34SlWvbvn6KwBoCZOqR2UhJbktJOxf2mYfyTaGSbXXZsBenpf1wbgcl6ljgiqEKFK4UpCX45LK/kl4XmwdbBo99qqimDVPlhfxWhrs8PMvqHD0JU124aqk2f/6GgaFVApvcKtHZxjDC6RPLaS06dPt8MptvS8E5Fvp0JwNEttSS6nYl7WvvOWw9wq3zPURzDFevs5Cv6Ye0Ponv/qMjjVOIcdEVo48aCVjgEWeQfx4DnAShAiFHnJaMkEfGk0z9HVKtSXUv+c8w/M7yic7lr0zRCNXbdunVJ9P3t03sSRJfqip7UT23WxUeszbE2myLYxnDBhoK5oWSDVmuOhSaagGqlNRnMxCi89zWViVP/Ilg7GgWklK3oCWbz/eoSOLvGl+m1/uVicvQArMsmnCFZkaeAzoIxPJrIevs7z2RkSjw+CLrbudkDeadR1Jfk5TOqO2LYJQ3aJW4WIcL6MJE1+CP/yyS3NU6BR/fMexjSwYAWK0IdUjOyROhqqaC5UFo5+Y0XRoUOGXXPlQbgfEFX3moafT9g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8063c9a-cb5d-410e-fba4-08d871f68230
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 17:11:23.4500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tYl+yu3gkk6iwwTFfS+davpPJpeOcpU9Ei2T9PzDU+Fm5f+UFgpFoQxDiS6mEV6HEbhlmjZJkeBqUx9zviq9NpmDaisAlIcI5gkGszE1g8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.22.128;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 13:11:16
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

It's better to return status together with setting errp. It allows to
reduce error propagation.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index c4b86df7c0..2b6ec4b757 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -869,7 +869,7 @@ static void qcow2_attach_aio_context(BlockDriverState *bs,
     cache_clean_timer_init(bs, new_context);
 }
 
-static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
+static bool read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
                              uint64_t *l2_cache_size,
                              uint64_t *l2_cache_entry_size,
                              uint64_t *refcount_cache_size, Error **errp)
@@ -907,16 +907,16 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
             error_setg(errp, QCOW2_OPT_CACHE_SIZE ", " QCOW2_OPT_L2_CACHE_SIZE
                        " and " QCOW2_OPT_REFCOUNT_CACHE_SIZE " may not be set "
                        "at the same time");
-            return;
+            return false;
         } else if (l2_cache_size_set &&
                    (l2_cache_max_setting > combined_cache_size)) {
             error_setg(errp, QCOW2_OPT_L2_CACHE_SIZE " may not exceed "
                        QCOW2_OPT_CACHE_SIZE);
-            return;
+            return false;
         } else if (*refcount_cache_size > combined_cache_size) {
             error_setg(errp, QCOW2_OPT_REFCOUNT_CACHE_SIZE " may not exceed "
                        QCOW2_OPT_CACHE_SIZE);
-            return;
+            return false;
         }
 
         if (l2_cache_size_set) {
@@ -955,8 +955,10 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
         error_setg(errp, "L2 cache entry size must be a power of two "
                    "between %d and the cluster size (%d)",
                    1 << MIN_CLUSTER_BITS, s->cluster_size);
-        return;
+        return false;
     }
+
+    return true;
 }
 
 typedef struct Qcow2ReopenState {
@@ -983,7 +985,6 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
     int i;
     const char *encryptfmt;
     QDict *encryptopts = NULL;
-    Error *local_err = NULL;
     int ret;
 
     qdict_extract_subqdict(options, &encryptopts, "encrypt.");
@@ -996,10 +997,8 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
     }
 
     /* get L2 table/refcount block cache size from command line options */
-    read_cache_sizes(bs, opts, &l2_cache_size, &l2_cache_entry_size,
-                     &refcount_cache_size, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!read_cache_sizes(bs, opts, &l2_cache_size, &l2_cache_entry_size,
+                          &refcount_cache_size, errp)) {
         ret = -EINVAL;
         goto fail;
     }
-- 
2.21.3


