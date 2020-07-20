Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF9CC433E8
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:04:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE80E208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rjZsFMWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE80E208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxRiW-0002mq-7M
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 05:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jxRfL-0007SH-Hr; Mon, 20 Jul 2020 05:00:55 -0400
Received: from mail-eopbgr80094.outbound.protection.outlook.com
 ([40.107.8.94]:22905 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jxRfJ-00076G-PQ; Mon, 20 Jul 2020 05:00:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBhSDGbcL5CX+mE48MMXWKpRN/h+GM7nMvMaLek2V625zFTm4VhZYXVkQ6gSeHD3MYyrigLQRoj7fpxXoZY0AUAoSHlqE0WcV4YO80xc60WGKcP1saBBayyGli/1qBpe05KE/23Vzo011fI05vHf9mQUblGdnOjGzQmZqwi1MbvCf3MsDhzyjW91hglaA1DqpkDMGgRo5IOe6pJnui1r69s65H+OkHABdltOkFjdPCnwnybAf1jVwWJkfqXXENgz2V0oQTtoXEf2upTCW8NxsrLM0T6lGGSCpru17zaTZ5dcLGHgzwKUv5vGaX9oyi+z6mHQ/LoqpMHntCyIC/J3eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnlIBhwOPeuvYKpRLux1PRhqBEBZprefd4CW6AU5dJg=;
 b=i8oPt7uvk5qF0io88ws3BI7meVpI71covnyxNHs0nSvaTX8d+tDa0u9MYhJ6phRJcnfyosgMI8KloxhanCC24O/nNDmIJvILcjaqIqPQQH+vOPE7YIZMu2hK9G4+b15kVw36UU6WpcdBrUznRam7Dch20jLb3jwT1U/WZRqU89VStdPy+1K4MvoJE8Ag33KYMKqoFhkEsGoWgp0mUEYP0qprHmIhRR7xxvI6N1XQehWvFjR6eZGxU3Z8E6cX+cdekk3LJN643Lr6+xJsedrBkI3qDIoaei4MMsAz1/5Qcw5YyrzcXOcpoGSA7SVD5Gu/GcgU+FdywDEg/j/xE6//vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnlIBhwOPeuvYKpRLux1PRhqBEBZprefd4CW6AU5dJg=;
 b=rjZsFMWjI181ux6xwx5yKrWhBUFopC+8zj9jjP61byG0brag3nVICgqjN/SHtfH6cCtYZb7IwaVHwn+1U7tI8TVMAp3WUuqqwhH6Kh+sB8u0yZ7xNmX0Lt8qApEG14cwYp7MvB9FKgYxt3S/hmiYIz4arvU00fYfRQhuNJ954Ho=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3767.eurprd08.prod.outlook.com (2603:10a6:20b:84::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Mon, 20 Jul
 2020 09:00:44 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 09:00:44 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 3/3] block/nbd: nbd_co_reconnect_loop(): don't sleep if drained
Date: Mon, 20 Jul 2020 12:00:24 +0300
Message-Id: <20200720090024.18186-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200720090024.18186-1-vsementsov@virtuozzo.com>
References: <20200720090024.18186-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0097.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.179) by
 AM0PR10CA0097.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Mon, 20 Jul 2020 09:00:43 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.179]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7386a24e-9eda-43b3-7be0-08d82c8b628d
X-MS-TrafficTypeDiagnostic: AM6PR08MB3767:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB376704CF614A9F9D3E6A5E84C17B0@AM6PR08MB3767.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:517;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nbRisPANNsK/TlrwjiIoGHV9sotLsT6TF60a5ovFMmDeFGCK8M4D1FmC7zl+GO2YJ4NpZf/OgKZBiYm6KH+r1aAHBNuohmgv4ByQWKYSQhmNTLsG62Qk1I4vC0Ozk+YIlNA8VFL2HdbjNAfyj/wzkYJZYu6h/TCHYuKCpTp5B46ATb3RUf+ZTnzBpSF6dvA1K1OJBvyCxB9ecnLhpHeJ6tantT4hWuP6+JEuvjmL2sLBZC7Rr95vBXXdHTTo3FKehj+W94GQhjOk9nY/wXHbtQ06tdd2cgJCJcmLbGLxqYVqaSEbNPGo3vZ97+fsPyFsy3nJRIj0lyWN3nNp8l6ml8PWnDGWOKSfExU6OAqqQfzD3u2bnnO0ENrLACAs04KZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39830400003)(366004)(376002)(346002)(396003)(136003)(316002)(52116002)(107886003)(83380400001)(186003)(16526019)(4326008)(956004)(2616005)(1076003)(69590400007)(8676002)(66946007)(66476007)(66556008)(6486002)(26005)(6916009)(36756003)(478600001)(2906002)(8936002)(6666004)(6512007)(86362001)(6506007)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: hfQk2YSc1NTTirH7yNMpXRBcf2yx4qHdtFAwvenDv67IwirTfk0/+hTREXl8HOSMKpv/e+i4gWPHI6fNt0d54F4YBASMnnya+IgcDq/gxrvyVKgBBrSuLwIll19UtJwKzFkmkbnXz/JxJgUO30dsjzpeCz1njvg87CT6pz2DiyQZHvlJqv0Gn9pTt6iDzyHerVt3xdMLEguDG1TbgUrvsD8kzipM0RHQZUcErlO9Zg9X+dKpmHxGMcy16dBMerqS1ZxROrY0eGMSBTSJrFy+QP+OY60JtQPdSA2l0kke3KecFThKGm1MNLA5UhVf90tFaDZvpyGypygv1alIWXq6mRM7bGJs8ZVpvpSvlb96vPHPAVfB6G2qPxy19XvLkpugUWZfNSVKWyvdPuYPLs4WNoi1rfd1OPzI/wMGetMVcp27tOiBa6dv0hHs2nw1RokOZO1j3Fh+Yc71NPdt5eYxJ2FvM746flgcnGo2x6gm7WQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7386a24e-9eda-43b3-7be0-08d82c8b628d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 09:00:43.9526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kNzVPfvdLFCUvLMYgTLK0RNDXLspxSA9ffS50OiVs15v/dvlG86SzxEpZMtKC2OAcFnlqVV2sS1oSkfUMq364Phb/UP8YinwluUEeJQzKR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3767
Received-SPF: pass client-ip=40.107.8.94;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 05:00:42
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We try to go to wakeable sleep, so that, if drain begins it will break
the sleep. But what if nbd_client_co_drain_begin() already called and
s->drained is already true? We'll go to sleep, and drain will have to
wait for the whole timeout. Let's improve it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 42146a26f7..d9cde30457 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -327,8 +327,6 @@ static coroutine_fn void nbd_co_reconnect_loop(BDRVNBDState *s)
             qemu_co_queue_restart_all(&s->free_sema);
         }
 
-        qemu_co_sleep_ns_wakeable(QEMU_CLOCK_REALTIME, timeout,
-                                  &s->connection_co_sleep_ns_state);
         if (s->drained) {
             bdrv_dec_in_flight(s->bs);
             s->wait_drained_end = true;
@@ -340,9 +338,12 @@ static coroutine_fn void nbd_co_reconnect_loop(BDRVNBDState *s)
                 qemu_coroutine_yield();
             }
             bdrv_inc_in_flight(s->bs);
-        }
-        if (timeout < max_timeout) {
-            timeout *= 2;
+        } else {
+            qemu_co_sleep_ns_wakeable(QEMU_CLOCK_REALTIME, timeout,
+                                      &s->connection_co_sleep_ns_state);
+            if (timeout < max_timeout) {
+                timeout *= 2;
+            }
         }
 
         nbd_reconnect_attempt(s);
-- 
2.21.0


