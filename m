Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A79AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 11:50:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3630220768
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 11:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="cL6r4iTj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3630220768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Snr-0002Iq-FA
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 07:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k5Sjg-00052L-Hk
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 07:46:32 -0400
Received: from mail-am6eur05on20703.outbound.protection.outlook.com
 ([2a01:111:f400:7e1b::703]:54464
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k5Sje-0000GY-82
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 07:46:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAsoX/b8YHDs/mi9y3QuXnsmDbW+5zLHVxSm9zd0VJj6tR6lZfsCJ2FwptWM9plgPN+5BEW8L9GHPFhftJMF2Z6HewgcSfEuDwt3CobkZgG39Yjns9slTuOFvoJi8ts+9Xh5TvaVt1HUpUDEWChAGknSiA7svwn1OEo4c/HnSkRq7FSPCwYEZwzVTcdfwBaO8mV59jHn80wcg2NbBRRXP6lcjDDYqnN/PATtLNDza9KEmqZ8LJWAu9cfkStv0H3fkut3qPaffG6c3PG84Nhn6BZ90KK03BII8kYe1Wg+R18mytE5f5ESrHqt66G8qr8ZqQCRAOB/8xA9hCrSfk3nwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwk0M7pHL5mfA9fBHFTHdG1x3DF59iPg1ZWLEWXKaao=;
 b=HjkjKylhUKhvqS/Q7yOb2kfsFfLKUsWPUAqiKL+xmhrQnuFQ1JcAFQL6NP1nCIRgD3wXwY9GD8dhGWSuBDIxiA0cbo1Q/MM1I8je9S3Anx0ID8EZce0b4YvIydtO9x0x480G5AFpUimyn3Sey9hZDe+STSniAYG4FAB76xwi032ACwixfuCgkccAYcoRhyHL4fjmqE5RHt3SJB/bJjt8gdxpEidnTTC7T/E//Tqigl60lB8gBubQMxpN4gnPXJhIGbYpZ0IN6GFMGrUMbffQ6C2E8lmIL/zwIZIdkFXH8A/Z2D5R3g+QwlGDm8AepraZIAwde+ryEOf2UmvUARccAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwk0M7pHL5mfA9fBHFTHdG1x3DF59iPg1ZWLEWXKaao=;
 b=cL6r4iTjMcxGqtQ1iHehu3viV2SEikodqMOg25jkOCcym/3rSJJSMzCmHGxrMKFKTiu5p4JZdRPnqoxC2erLDbrL1pM28NXHPkWLAaLz9Xi1RjA7MRk1dz1gLaJz64/UFs74O7/8CW6ObPDwH6yupq3Vh4xUEBVMxIIgQlwG4UA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR03MB3054.eurprd03.prod.outlook.com (2603:10a6:802:2f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Tue, 11 Aug
 2020 11:31:16 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.024; Tue, 11 Aug 2020
 11:31:16 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user: Fix 'utimensat()' implementation
Date: Tue, 11 Aug 2020 13:31:01 +0200
Message-Id: <20200811113101.6636-1-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:26::20) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.242) by
 GV0P278CA0010.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:26::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19 via Frontend Transport; Tue, 11 Aug 2020 11:31:15 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa68dffa-975f-4247-ad2f-08d83dea0f0a
X-MS-TrafficTypeDiagnostic: VI1PR03MB3054:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR03MB30544D77A7D17B036550DF20EB450@VI1PR03MB3054.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PiqzmPAve/jvKYdsdcROkykgn59bAKX1Ybb0TlESPnhTwe2I763DU270sEos3KEaJu0yfX3jnyJFtWFrqFHIAGjzRMrbfug8I1RD8dZxjVMhGR0q0khcdDvvc/XFJ0jrTz+rJgLQph0c+PzcZf0vUVnwOpmYxAv0UFgswoAIQ2TvEtUER3r+s0neDKM8cZSryrWYRIquWlSnxvzp2xOcPwUv4lcYzpCoF7rYUqdAAA3kppm1PjvV5tDyZldnlzT68wqAJdos1RYSC3s4Leueilw1a/DdKI7j+N4QPl1HFSkW+sXE7IfjH+HOxR2W4nObJyR4TxHZs0gQtNkiw5lqfXXw16EBzGo5H55qjP9Iwhr48/oFGU8EVo83vsSsqim3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(396003)(136003)(39830400003)(346002)(366004)(66476007)(6506007)(66946007)(66556008)(26005)(186003)(16526019)(107886003)(4326008)(6916009)(2906002)(508600001)(8936002)(6512007)(52116002)(54906003)(6486002)(8676002)(36756003)(316002)(1076003)(2616005)(956004)(5660300002)(86362001)(6666004)(69590400007)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: UsYeyRKixm92dJ6kstW4uWPmyn87xgy5tjU+m6ysULuzOzJGivughvyQvPzGaiKo2IrE2DX5UEzkrxjUdIMAptmgBK8+cH3JmyjWNt8Ly+mb6M5Pnks2Mvs/hzcJQQUSGKLGzzov8WWSJEK8O3fvApxKacdiCbqHqdE+STQfAdPYJPml+vLijEC0ynBVwwxy+GS10Kfj8hsF6qTgHQaiFmGh/4k3Jm47gMlr/qL22jBMmHMf8aSjFn1qTttynVi+ZwrKO9qHJC7B0ikOBwKujEKvNlDNmbDtYWaHQ76DGmkIPFn6zn07LMz6+3V0/TfBxjI8yE+evj3YwABTNfZ2027M/ysvDoKEQc0BZL9GwcrUwFSFmOAIDTUKLynVgEPpAhuCb7t9/eoMwOW1IHd3efWxCq0219FKlBVWhOFlef0fKAMzLybxeRuL8qB3gV6CZHaJ2HFyjMQbUsqhiXwrywUARBMRXHQiYASzLm2SZdT3HaAL84p3C9/bxOszzAOOJjftulTiOdtMSBxhBP/mQDBx2aqz3IexXVdKSDxfg2Gno28lETcg1XdY3QoaTcyOHu/0RIIXfXvKH7zN9iKJmqGh+QV4E2oXx9Kwu9632P7EDfY4GmTCekNnjzJ7DGtOe91pNtyaouHcWqu9Q6K6rQ==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa68dffa-975f-4247-ad2f-08d83dea0f0a
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 11:31:15.9743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPSP+/h9mQarg8IgVLQAMcyV4G/dvK0Vzqd0Cx4StiY8buoXmIMc5RU+oqz39NvuW8lamOZUEF0lTWBU4G1hgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB3054
Received-SPF: pass client-ip=2a01:111:f400:7e1b::703;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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

Implementation of syscall 'utimensat()' in 'syscall.c' uses functions
target_to_host/host_to_target_timespec() to convert values of
'struct timespec' between host and target. However, the implementation
doesn't check whether the conversion succeeds and thus can cause an
inappropriate error or succeed unappropriately instead of setting errno
EFAULT ('Bad address') which is supposed to be set in these cases.

This was confirmed with the LTP test for utimensat ('testcases/utimensat')
which fails for test cases when the errno EFAULT is expected. After changes
from this patch, the test passes for all test cases.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/syscall.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 05f03919ff..920656191b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11722,8 +11722,13 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             if (!arg3) {
                 tsp = NULL;
             } else {
-                target_to_host_timespec(ts, arg3);
-                target_to_host_timespec(ts+1, arg3+sizeof(struct target_timespec));
+                if (target_to_host_timespec(ts, arg3)) {
+                    return -TARGET_EFAULT;
+                }
+                if (target_to_host_timespec(ts + 1, arg3 +
+                                            sizeof(struct target_timespec))) {
+                    return -TARGET_EFAULT;
+                }
                 tsp = ts;
             }
             if (!arg2)
-- 
2.25.1


