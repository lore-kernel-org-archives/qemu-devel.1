Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12AAC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A7B72177B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rd51iBV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7B72177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVFwG-0000Dy-UZ
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 11:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaQ-00069t-1W; Wed, 21 Oct 2020 10:59:34 -0400
Received: from mail-am6eur05on2139.outbound.protection.outlook.com
 ([40.107.22.139]:50030 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaM-00087A-Im; Wed, 21 Oct 2020 10:59:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k83p6CvJuwC6EI5pFwbSM127VIwhZd8aHGxdHFbO2hmThT8NJ4VhweQ3WLza9UMyTuSTPgvlNcFtQS64w9zqhD/LmBmLw0sJgHqw1hb0w/E2V6ZomOyXy3I25la8rGVczL+my8ZnNEHtZwA/0oNqwP7fLszyrkXe3J3AmK6p2nd9q2bIP50VEXQqGa6/XwfplyYMTlI6u50YyUFZ2+AoW8U7Y+FgIU9+IeaVqIj/7vqT3CJhJjrSYp2RricLuMtOogNch/xYPaTubHvbkoflI3nPQSLLP3QHgR+hsAVq6AQ5vySEPu6ElVjbzt8/rod3N/WmF5BoT0e5QShh6BAE6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MBLroa6hqWyXf7peZ0E4uC9dZbhJl9w2aTdum25V3o=;
 b=IgxG1/58UlLi7OVBiKKV943iOIIOkGb+vaEF5ohCgBWteRUr2ComicQYzZEXuVSnv42zYyhazKa15slMwsRDYufDeec7JtHqjcbfa1Yko0gk/lf0jOPn3/Z6TRYT/x8g3NR6hlD6ACs9P+FbsWEgU11Zqcya7WvqLO0lcyxNLrMMd+Bz9d0N/xcBUB86GL+s6xfqdZNhYvnS8XBucHUXDTi2+LlCPYr1GovRlW3riECQnsC/q6L9JFtvIn41L+omhVDvsdTx+upigwiF9OQwW8evY6WLln1uaf4Cm0cUYt2pgjclUc9QINhKRKXlAjnZR1id5DuMPJHtrQgPFvEnEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MBLroa6hqWyXf7peZ0E4uC9dZbhJl9w2aTdum25V3o=;
 b=rd51iBV66YO9Zjm8ozt+HiVPhBD84spAo8M0KZORNmquMEz49Asn37KyW+wHvzV9B3rrpZnR2zqD29uMv82rrEHlDZsVVTB450TfSK7CnJj+Y/+YNN/r0DGnDKcoy/ozu29//WiB0znMnI5/uBe6Q268cPGK1Qe/u8co1Xc1B2M=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3541.eurprd08.prod.outlook.com (2603:10a6:20b:51::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 21 Oct
 2020 14:59:25 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Wed, 21 Oct 2020
 14:59:25 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@virtuozzo.com
Subject: [PATCH v7 15/21] scripts/simplebench: use standard deviation for +-
 error
Date: Wed, 21 Oct 2020 17:58:53 +0300
Message-Id: <20201021145859.11201-16-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201021145859.11201-1-vsementsov@virtuozzo.com>
References: <20201021145859.11201-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: AM0PR03CA0091.eurprd03.prod.outlook.com
 (2603:10a6:208:69::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.82) by
 AM0PR03CA0091.eurprd03.prod.outlook.com (2603:10a6:208:69::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:59:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cf882a9-7f4a-4069-1d3e-08d875d1e6e9
X-MS-TrafficTypeDiagnostic: AM6PR08MB3541:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB354182EC979EC11B4997A8D6C11C0@AM6PR08MB3541.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j2iF6TRjlEk1gWk04TEu4tc63MlFKDQRt4lQhY/pzbbXkHEDkSIUCuUGbbCFtlXG3Rw3xa5BZI2+MqPTmdidqfsw4o6QjwdmRrSaRi7JHtHnhHoqVli6hk6lJ6w4aCmrJUQOl1laFjGajmXHnPPd0FxCg0jX3ilG+uaq6xdUhE5dkt9Koa433WXUbxwuqEww1+5c7KSRsaSANFf5RBWccyf0PmrZjxTKtflXoQzvLfr4jn1IptttDhN4BEKTqDrcRr5GM8e2N1CdskovnwMqGNwb8PsvPFUNU2Uu1xIFKp3FcNFMBZnZ48TEIZ2lzAsgxisEzoitd5kJC83bwJE6KxuAHNgMeRy/WT+yT9cbM6hbavkIjCHqDiDATQxJNC0m47j+3/gLnmTpL8qrbpEF2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39850400004)(376002)(396003)(136003)(6512007)(8936002)(83380400001)(52116002)(4326008)(478600001)(6486002)(6506007)(8676002)(186003)(16526019)(107886003)(2616005)(956004)(66946007)(66556008)(66476007)(6916009)(36756003)(26005)(2906002)(86362001)(1076003)(5660300002)(6666004)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 8M66nRrFUYgiymgKDHcxpy8sJNlEAdf8dQ3IXltxT+5MlM0G2/ASh1cM4Z8h9JtugGUAS+cWU24WWyuquJINMlhLR3v5hY12dnHTZs1xRtKpO4kVPHWGTXvSb3PjWTicWUka2mKywwA9EM7r3UYFFkcmxCxxYMYX0MtXOr4CsTQLQxCSC1NIXwPiWeLPeTnaFqBfh/sbzrF9OO2vE4YKEuz+ska4Oq7pKfAJuwgotl61LNgYml/nUK1euYOXQEdbLN8Hnu+J3VreqH2x9vGZxVJJ2xYzCPCKyCs1iYicDMRTWm4R2ExwdCkrYyXXZzjxqIWrhtoLKsibR8vcnBex7XVmx7Ihmw+kYS+Y0qGSrN5vCnHc6k7sNxNHLsolC8n+jd7Es2xdcAbFBBko1FEjFKl3mgE5LIOtD2TPw/5WAI/osX+6x/rngaIp89WK2rmJU8O1qRqk4YNmtv4McEPR+x+TNm2wVVYUPfbi29x6+pPMjWiPGadh2q9N2fCnFPXvLduWDMSL3PQdAEjzRYjcICe61C90ucKUu9MX4bvtmAbb6mRV/WylvQtI1mhoIBTBLFPKlEYP7AodWDEMYRj6B4EYX7IEVbcdrDRhEcR+lZA6/5rynq4MJQt2lNswjsFU68ILcCxQdmpZf2tUjewT5w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf882a9-7f4a-4069-1d3e-08d875d1e6e9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:59:25.7080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kBoGB2xOT9xN3Qy7pddJTa99nkL2vQ/XY3ZV1WYlOr1muone890hbBnhiOAqssdcBfOOtEZWYITSzD9piW9ESRwk7p8J4TYD4VRlaCCZ4JY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3541
Received-SPF: pass client-ip=40.107.22.139;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 10:59:25
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

Standard deviation is more usual to see after +- than current maximum
of deviations.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 scripts/simplebench/simplebench.py | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/scripts/simplebench/simplebench.py b/scripts/simplebench/simplebench.py
index 2251cd34ea..55ec1ad5db 100644
--- a/scripts/simplebench/simplebench.py
+++ b/scripts/simplebench/simplebench.py
@@ -18,6 +18,8 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
+import statistics
+
 
 def bench_one(test_func, test_env, test_case, count=5, initial_run=True):
     """Benchmark one test-case
@@ -40,7 +42,7 @@ def bench_one(test_func, test_env, test_case, count=5, initial_run=True):
         'dimension': dimension of results, may be 'seconds' or 'iops'
         'average':  average value (iops or seconds) per run (exists only if at
                     least one run succeeded)
-        'delta':    maximum delta between test_func result and the average
+        'stdev':    standard deviation of results
                     (exists only if at least one run succeeded)
         'n-failed': number of failed runs (exists only if at least one run
                     failed)
@@ -67,10 +69,9 @@ def bench_one(test_func, test_env, test_case, count=5, initial_run=True):
             assert all('seconds' in r for r in succeeded)
             assert all('iops' not in r for r in succeeded)
             dim = 'seconds'
-        avg = sum(r[dim] for r in succeeded) / len(succeeded)
         result['dimension'] = dim
-        result['average'] = avg
-        result['delta'] = max(abs(r[dim] - avg) for r in succeeded)
+        result['average'] = statistics.mean(r[dim] for r in succeeded)
+        result['stdev'] = statistics.stdev(r[dim] for r in succeeded)
 
     if len(succeeded) < count:
         result['n-failed'] = count - len(succeeded)
@@ -81,7 +82,7 @@ def bench_one(test_func, test_env, test_case, count=5, initial_run=True):
 def ascii_one(result):
     """Return ASCII representation of bench_one() returned dict."""
     if 'average' in result:
-        s = '{:.2f} +- {:.2f}'.format(result['average'], result['delta'])
+        s = '{:.2f} +- {:.2f}'.format(result['average'], result['stdev'])
         if 'n-failed' in result:
             s += '\n({} failed)'.format(result['n-failed'])
         return s
-- 
2.21.3


