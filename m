Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75981C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 00:08:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BB55206D8
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 00:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="O5/1WVw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB55206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzqgw-0005yX-EZ
	for qemu-devel@archiver.kernel.org; Sun, 26 Jul 2020 20:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jzqgE-0005Xa-CG
 for qemu-devel@nongnu.org; Sun, 26 Jul 2020 20:07:46 -0400
Received: from mail-vi1eur05on2105.outbound.protection.outlook.com
 ([40.107.21.105]:59969 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jzqgC-0005V0-9f
 for qemu-devel@nongnu.org; Sun, 26 Jul 2020 20:07:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jv3YMRPPfmauX2Dl9A1iJpTwqPkcMwPSVWzrJaN6r5nIo4ATqJJDKhVw4f1ChoBXbeqgK0UB80kf91XK4omQ9+gcX/LEZ7YSz/msESJej/yvSTz1pJfuXhZ+EHlfiCM7DJj5Zm3QMRQhP7AkxD8Vd4MNP+aB1piV31uJ8fFdwarHkCmtfSqEFLOBvHHjFUqa5cUvhh9VGT4GTvUPOpUT1IqdZKVUAU7jYbzXlyW3BgOFM4ZNE99Pfrao9pY1CtaxmiZEcZ8zPsGIC79awW4pFNd6u3bcj8M2pS36XlV4f4Lk1TxZIPUByLBJu6Edpo4WiPKP7h6Rem6GsLLfdAVbzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQ9NRao0QBBUYv6HyKM6LgqyAY0fl8NikoY14fk63gw=;
 b=J6CUPRWa5NWQCedlPfZavIAivTuF8vR24Idb1cXGKZa7h7xU/2tdRJHZWNNy4JQ7Ngiop0rjFa9l9TYDJbDyVRdOFw6XWzZt8Uo3Q2PrpnXyVFQT7HAWOrwqwuxmCtwRO4aNn5uw4lzu36W5eCp4sQM6TXQD6KFSpd7Kv2CVx1VLmhPo4RftafMwvhxN5jIFJIp5ZDaJ/gTLu1pUzzsMJMW49ji8hpg/EQZKn9yp+ZkL715J5LdHGR9rkE9LsDDAg9axTzYambvfyimRQroDFbGEZJ4AN4vqom3OqKjGaMM8QWQCPoyeCxTiZeS5Yo0g7eP5cwQ9yMurSry6oSBa4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQ9NRao0QBBUYv6HyKM6LgqyAY0fl8NikoY14fk63gw=;
 b=O5/1WVw4WLR0ZqKwsUaixk+44f88wYGSd9RcP/chAt4HJTwF4jGeku5zGpjz6GUYjHwY58GjXrwqg1UDe2wRkDHIjx/Fj+SAwB5h1uO4zYSZVlXR2F4GpwSGPnh+EsVLHcirnzCsaMWOBSDWk1pKna1tFWjn+YBauq2xcZeLKdU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR03MB2925.eurprd03.prod.outlook.com (2603:10a6:802:2e::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Sun, 26 Jul
 2020 23:52:37 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3216.033; Sun, 26 Jul 2020
 23:52:37 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] linux-user: Fix 'mq_timedsend()' and
 'mq_timedreceive()'
Date: Mon, 27 Jul 2020 01:52:20 +0200
Message-Id: <20200726235221.337529-2-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200726235221.337529-1-Filip.Bozuta@syrmia.com>
References: <20200726235221.337529-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::25) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.239) by
 LO2P123CA0013.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:a6::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.22 via Frontend Transport; Sun, 26 Jul 2020 23:52:36 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.239]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5298ad8d-0aa0-4912-c9fc-08d831bef9ae
X-MS-TrafficTypeDiagnostic: VI1PR03MB2925:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR03MB2925470A13645668876C9BA0EB750@VI1PR03MB2925.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eDNNewLRdOG0uK8pE7YVuodYJFSM2kDvqzLLLyzrBIGtwwNUXapRWwWsJ/9RAnttHnXQsmXPsGeEXKbxDe+RaS12wJll/npjkKD2T+3GvF/vBwO6qXoZcmm1Mxc9BkhfsLjn1hgt47eTEfm5KCpvq8kfuqsGQtpu2SbPcpY+VNTJ6IFXhFCvbLohGZ6lshxqMmt5xeVHGMS/YE528JDlboajHQlpXusmsCPPEtIUsSYSXPUPmsAdz8kalYBS7xrczIfMVGfltVEdakcZxuGDJ17Y9D1wZSEOQI7P/6vy1XS490ZQfUgpkTK2j/gk2VMQBArgjS/ua7WKnE6B4e1thrgQ8GtQc+3bvgMQNmeMkHfE1eicxVtR4zmEAFan+jWyQy55fKEyXBU72mengIH5KSJrTBNfkwe+P/5nyYHiZTbtGpZ7TvhDYUYVEJ2Rl9zOxq9hV5vwwEpTlW9AzUq/WQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39830400003)(376002)(366004)(136003)(396003)(346002)(1076003)(83380400001)(69590400007)(2616005)(956004)(316002)(2906002)(54906003)(6486002)(36756003)(16526019)(4326008)(6512007)(107886003)(66556008)(66476007)(186003)(966005)(6916009)(66946007)(26005)(508600001)(6506007)(86362001)(6666004)(8676002)(52116002)(5660300002)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: bz2baVpog+8/fEK0rqcY6Zf+ZIzeR+JXOGoYgyBvZOnYb10LE6ciKmeO9QwMO+m8Ea3s177Lrl7yGAlXWlZZa1rk7an9cWCUK6SD8nV4VcefXG1Z7V0YtsDo19K939a8pvuVbQZK73kZmnDBpOMtbZhR1Z99a7RIY4KLVcUse5PKC+y4QB4X5h1YmvF6ST9bF+7tpUsBk/kaeQQCHHC517+G/6L93WGIp6hJ5pZVzyFP2fYWm6UKPiihuSNGrCkRTYGqu/amsPjSuR4CAQvAeoq3UaMtTDfScgr8CJQvNvj6fEDxcLUXz5XuFrhoepmUrky+xiZlK96Fv+DaeFiDVryNhi7eEAz45MpquitT6R0iamRRFqKnp1hN/1i9rrOIuqj1ZydHxje7JUiLhXOL3Y+lPrblp9uBCzgQO4a2MTXAOGPfTPOPjzcGy8MLugdcVMCq1uRneiftiZoLEQEIPp2NGfKbO6L/956rajbAqmw=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5298ad8d-0aa0-4912-c9fc-08d831bef9ae
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2020 23:52:37.8392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OoFAaM+HG4V/Ym/oVyp/JutBLj6pC21lz0WFhbZssRWHPE2DlQxm/O3DKZo0TSvsI8sIVlRNL+EKWvMzslQmgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB2925
Received-SPF: pass client-ip=40.107.21.105;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/26 20:07:42
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implementations of syscalls 'mq_timedsend()' and 'mq_timedreceive()'
in 'syscall.c' use functions 'target_to_host_timespec()' and
'host_to_target_timespec()' to transfer the value of 'struct timespec'
between target and host. However, the implementations don't check whether
this conversion succeeds and thus can cause an unaproppriate error instead
of the 'EFAULT (Bad address)' which is supposed to be set if the conversion
from target to host fails. This was confirmed with the modified LTP
test suite where test cases with a bad adress for 'timespec' were
added. This modified test suite can be found at:
https://github.com/bozutaf/ltp

Without the changes from this patch the bad adress testcase for 'mq_timedsend()'
succeds unexpectedly, while the test returns errno 'ETIMEOUT' for
'mq_timedreceive()':

mq_timedsend01.c:190: FAIL: mq_timedsend() returned 0, expected -1: SUCCESS (0)
mq_timedreceive01.c:178: FAIL: mq_timedreceive() failed unexpectedly,
expected EFAULT: ETIMEDOUT (110)

After the changes from this patch, testcases for both syscalls fail with EFAULT
as expected, which is the same test result that is received with native execution:

mq_timedsend01.c:187: PASS: mq_timedsend() failed expectedly: EFAULT (14)
mq_timedreceive01.c:180: PASS: mq_timedreceive() failed expectedly: EFAULT (14)

(Patch with this new test case will be sent to LTP mailing list soon)

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/syscall.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 05f03919ff..1f8d04934a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11817,9 +11817,13 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 
             p = lock_user (VERIFY_READ, arg2, arg3, 1);
             if (arg5 != 0) {
-                target_to_host_timespec(&ts, arg5);
+                if (target_to_host_timespec(&ts, arg5)) {
+                    return -TARGET_EFAULT;
+                }
                 ret = get_errno(safe_mq_timedsend(arg1, p, arg3, arg4, &ts));
-                host_to_target_timespec(arg5, &ts);
+                if (host_to_target_timespec(arg5, &ts)) {
+                    return -TARGET_EFAULT;
+                }
             } else {
                 ret = get_errno(safe_mq_timedsend(arg1, p, arg3, arg4, NULL));
             }
@@ -11836,10 +11840,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 
             p = lock_user (VERIFY_READ, arg2, arg3, 1);
             if (arg5 != 0) {
-                target_to_host_timespec(&ts, arg5);
+                if (target_to_host_timespec(&ts, arg5)) {
+                    return -TARGET_EFAULT;
+                }
                 ret = get_errno(safe_mq_timedreceive(arg1, p, arg3,
                                                      &prio, &ts));
-                host_to_target_timespec(arg5, &ts);
+                if (host_to_target_timespec(arg5, &ts)) {
+                    return -TARGET_EFAULT;
+                }
             } else {
                 ret = get_errno(safe_mq_timedreceive(arg1, p, arg3,
                                                      &prio, NULL));
-- 
2.25.1


