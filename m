Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEEAC43464
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 20:01:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AABFD206CA
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 20:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="h8f1R55q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AABFD206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ06A-0000QX-LF
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 16:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJ00h-0002vj-OE; Thu, 17 Sep 2020 15:56:03 -0400
Received: from mail-eopbgr30122.outbound.protection.outlook.com
 ([40.107.3.122]:56995 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJ00c-0005tE-17; Thu, 17 Sep 2020 15:56:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5NweLejOXXH+4J2i8tZjwxrQY5jdf6B1zetWN45vZ1YcpArhRZIo/qHRaAtiDS8qDDuuNbE453eLS1zuYgMIp0BppdWmq6YP+kseOgfBwiU7kvoSLS2Q5kJPvZNEIUSRoHJgcoI34hCHqhICBnqVRX5nBaDgm4rOisjWvY5VMEpiwwNmfeimKnnmHGdjCoSgxApnMh6Ylz5iPNKgfOdCdyVbnecD0OENAzA3PykIbWvZv7MXqmMcuLFkYf2b2EHkF6arN3immWIG2KL6N9m7osPdHu2f/dmIEktaw5xMlYxVNXK2kEi2c51JkpiLp6Lp4CVs4nmbhkWJcSSWh/35A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7jSfM5fFUJgLtB7sfni8JewNTroG6CKzKQYJDhuoTw=;
 b=bu0wadUYGvrvwHHaoII+wo5DeSthkE4oo+Nn9J25KstSafTd96V7yFCSNlISyKZa1GsZY+BypmfERXrEr4nVCmuV1nA1+cXSng8QzM76kIaaVrhZR/CC8BVvNsqqOQSkbkURb+fQi/ts1pHeg1ois7vp7KMYuvaU9q1Vb4ZgOmgbp2fZiWtzYb+fdhejngh3tO5pXimc4bTZTFG0sEZzZBWVAjNdMNHSCjoEdZ4/tLlu0f4J78P6C+aMtetToKc0MfqaPc3KKD5DWrqPPORcqvAMvEGPgdIkdydEHw08itPk6YSuwpXXyOqQToj6lHOYWR9ReNqwD8iK4zugKrvhQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7jSfM5fFUJgLtB7sfni8JewNTroG6CKzKQYJDhuoTw=;
 b=h8f1R55q3BxaosvtmXRFFBo7bMjhrBTE8Ejt5cPc2z8eKq2NLC/HFlZKSOckfEoedDeDiN2FHEYhXtUw0On7DH0DPh7JFRVcJ0XBMD6nbaqZgvqXJoO6UW/2sE+lao1BJQsmIcxrDeqM4uga0vBxg+RUeY0VE1nhmXZcgz8Te2A=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5254.eurprd08.prod.outlook.com (2603:10a6:20b:d6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 17 Sep
 2020 19:55:46 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 19:55:46 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, groug@kaod.org
Subject: [PATCH v2 11/13] block/qcow2: read_cache_sizes: return status value
Date: Thu, 17 Sep 2020 22:55:17 +0300
Message-Id: <20200917195519.19589-12-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200917195519.19589-1-vsementsov@virtuozzo.com>
References: <20200917195519.19589-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0011.eurprd05.prod.outlook.com (2603:10a6:205::24)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.75) by
 AM4PR05CA0011.eurprd05.prod.outlook.com (2603:10a6:205::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11 via Frontend Transport; Thu, 17 Sep 2020 19:55:45 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3271868-6ce0-4e77-9c1c-08d85b43aae9
X-MS-TrafficTypeDiagnostic: AM6PR08MB5254:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5254853930E767CC394F667FC13E0@AM6PR08MB5254.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8V1LF0lnrEUYThBsTX3crZfjfHxI4W6mKmaNKCvKMVcN4jj3mmoa3ioA1tOoXguQehjhVmpv2WlXa7xN1dlfru2MUlb6j19G5geJYwDcunchhD1zJP4nJjaPPgEVN6JzfTpL+/YnowuN/9ZttSgHyuYIN1+BWlcW1WgFSZ/mjkV+D8x78F1xEPoDhGVaWi72oufI/4Pdi1FbEDuhoT3nT6X0PcVfhV9ceZX19cv28xpI4+n9isH5zn2Mza8HSBY+NXkctycrmNuhiDzlJyyPwvzkioKSq/UcOgzmTItqNdnWQBTsukh0fFDlkyKzUlKmfhuaCNwFtvRxagv2v89ifA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(346002)(376002)(366004)(396003)(136003)(6486002)(316002)(6666004)(16526019)(186003)(6916009)(8936002)(8676002)(26005)(2906002)(7416002)(52116002)(6506007)(478600001)(6512007)(4326008)(86362001)(66556008)(66476007)(36756003)(66946007)(956004)(2616005)(83380400001)(1076003)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: KRO3Z3btGQ3c3zEBqETbVBHtJIPtsZb+hm0D3S2tzPQ8s2bIDwoAI3T+WlhRGyq9ZEh17Eft/149x1Iqv1r3Ch+ZTihuFu/nYk8yumdyJxQlfyD1buw80aabSoNs5msKv0+mxDig36+IdldsMuSCKHqJbcE1e58JirESxusX2vA5/dNUlnTNw0r797K//NOeddW9CQPDgS8lMscMZG98JSTIcUR2nrBR3wbZ+yfss+podbtP3CeKtaO2cdLQzeAE++22KnD+J8u9gLvilIUbo2z7a5J2MmvK6fujmtkGWiEk4OgWJmS9qXppqoLKvobMxcWxp33Q5EVMr/WzAAVZmOSlDlOeTOBYIrBns473q0C1S3Iu3HZm5Z2RgGTlHGvbZGhFmxWdUNBi4kiGle1bh484gMrRX4VKqxt3HuyivkrkfEf/YVKPlt1j/d/9nylPnksyqeplaPLkRfE0znrGOw2gehWvaGOvdh+5Qpo9+xaSerfGi8S9EpX3AckmjHkzuLHeGZtYF7JX1EQxtfrVprQjw+MUzo8Ef0kNn7hFSCj3FNXPUjbO+H5D/Y/dSNwhLqRYYsmCK38wYiokKJeIYMHSquR9jVDbaJBSD1RUeOYyheAO2xYGEthNN9qV4CfNcZJz/vddukcBPOu7mG25fA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3271868-6ce0-4e77-9c1c-08d85b43aae9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 19:55:46.2612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URxJ/DheyRXhhG0fbgNgdH4ia/nnZvpRot1WzSRh7tR5S+OC+Ivdn18SM4CEOTzn1yvdtGd8G2swS8bwH3r3KSgxCGx63Upj86ZmYOKmhGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5254
Received-SPF: pass client-ip=40.107.3.122;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 15:55:46
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


