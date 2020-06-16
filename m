Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77699C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:42:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F16320767
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="sr61xicK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F16320767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl93S-0003TH-Ef
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jl90V-000716-5v
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:39:55 -0400
Received: from mail-db8eur05on2134.outbound.protection.outlook.com
 ([40.107.20.134]:62689 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jl90T-0002xj-Ba
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:39:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acBqf6qHFzFjVCvaY1//V+YqbHRTrey3vrlbMm963f5MOT22dfgPaS2lLmF6sC1GAavihPgLn1QJSfsGV9FiNMxfaILuhAGQW2d0zM32b7M6eWoymKpHRyfnhUrAbqhFnGzOSplnaYSSERKhOJnxuuZZE+8OiZAxBMamWHY2UZIwiAGyEbQSUASkM5cCalezJuBijDf8tcwUM34AgIDTIe+07yL6sb0PB+I/zEoAHThllZLGPaRY5DD/jAnYDWtrC9vTo+7osYKC49DXxFqXD2PiS0rxu6X4LwT4Eo248VjUZr85p2g1NW8FBZOCkEo9RUHSaryYy/D+kQHfsfBFEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67LdaiN587Renf4rYoPnW0TLdnPQtv9yDNhnssDtlHY=;
 b=HL/mh+TwOers8Q+2rTWG8OLe1ziLpWGs73i8jN8qfnOA5OMF8Wsccd4T+1F+gqsxt2nr7ux3sPL7otk0vLdJySGN04WtbXs9nd6wV+yqCuVAmugojB19JX12xqFVm2Bysboorcokwp62s0G5KDG9CkEwctjnWSTneuNL1YAttKK3Q5WzYbr1RMSGdfo9XigGnyGAOHoiwA12b6ek5J0DH7ZmeyVQ0yIXgTB/ZqbADPePl/WjDJ2YM+LbnUQTuQhLt+Eyd5RdRbEytIQbxcDbnq2c3PZaGVNWZUbcfLQXBsgB2ZgW5tiLu0NmkjoHySASRsPSCtkp5QEy6N75GXd6HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67LdaiN587Renf4rYoPnW0TLdnPQtv9yDNhnssDtlHY=;
 b=sr61xicKa0cxITZZBLVA9sZm2y4kz0NLB+qOqtE7c/uYFvoB8d/0WTsbv6nYs5YY6W21JLx/3plcWMfJBRi/o6sUTAAWjZTMl1X7DcZnW4lBcbYuNVhPA/6xvH2BY7B9gMyqVoqeOZFIM05l252wGo+E4sya61DTrvScfThme5E=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB3960.eurprd03.prod.outlook.com (2603:10a6:20b:25::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Tue, 16 Jun
 2020 10:39:43 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 10:39:43 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 5/6] linux-user: Add strace support for printing arguments
 of chown()/lchown()
Date: Tue, 16 Jun 2020 12:39:26 +0200
Message-Id: <20200616103927.20222-6-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616103927.20222-1-filip.bozuta@syrmia.com>
References: <20200616103927.20222-1-filip.bozuta@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0046.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::15) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 ZR0P278CA0046.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.19 via Frontend Transport; Tue, 16 Jun 2020 10:39:43 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1435393-1655-440f-46d5-08d811e194a8
X-MS-TrafficTypeDiagnostic: AM6PR03MB3960:
X-Microsoft-Antispam-PRVS: <AM6PR03MB3960BCCD2A8B68C5FA4719BAEB9D0@AM6PR03MB3960.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u+cgeP+aa26Mlwe6ays7rx4TDbFlYcXLzZ5mW+TA0fd/9CmjEPebDLc5ZG2Oqg120bEb1E8e26Rzdp5jGGJu341sl8BLbobJJOPGZjWD80PVIUW9khhPPMsff1L8PiZF06FdS+2+qL7L+hhnWXW6dbb9wKiHrtXkfIvHEJidJ9AN39jrFfk0G9zmgsLW8G64k/kHtf2hBv0o88wI2ydDxrl/lqYdq49ScerQGQMaTczmyZLEXJ/bWWkxiqhZPS+p5WhEhdFNT6aHF7O7zEvSbeyKOIk9UZ+7G9o8yr7qk79WUTxOxWr9vVUY34cRI16SKKLU3ZRxKd4Wx0zMaotNCXBDUIfnCwkctg9TfEvzPsSobbH8wc6LD30C2jTdAgrUg2HsF74flwxQX7VyZ0Mdvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(346002)(366004)(39840400004)(376002)(136003)(966005)(5660300002)(83380400001)(86362001)(508600001)(8936002)(316002)(6666004)(66476007)(6916009)(7696005)(36756003)(2616005)(52116002)(66946007)(66556008)(956004)(44832011)(26005)(1076003)(2906002)(4326008)(16526019)(6486002)(186003)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ABZoTdsP0Uk9s6rFUZ3gE1kzAzkHQ2l7uZ7v61aCQXNOUgORWN0Y3Yetbii6vzQaynQmkb3TNoowJ0gPwfU6RFO3d+c2aariZEMZzoQ1015QS3qgZ/2+BdXw14IRQpytH72r5pKLmv1bgXNZ135M9jCjZHMNjM/zRkn0xamSDI9T91emz/wCQjotVenMs+OEY2nrwgFhmDo6SwUrATwjX/67OMDrxtVJBEuXjnwTQ6fz2kpD47+BrI+IBJsXHSQFrs3/LQg/ynYBS8G8VuBms09BOt9Uhlsrvt5KlsWTIaJzTOqD4pPzWBYCur5EnLm5z4ngj1gvOYbuLNJ+NHmZid+KP2tdpvdtXZLD4d0vvy8MVnUol/V3LNA9yiTHnQsEWi/tMXbe0FuimYrUWnBZLSYtxVoAWQSG24vexOdq/Xk4TZB9JSgayQNAQGwOuy3IMHlmQVEKjq6oTSGGi4O9kVR0bQYBEgUcqXz4sTTZeUU=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1435393-1655-440f-46d5-08d811e194a8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 10:39:43.3534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6XcRBug7CexFDuU1moBiCqPf1a9Szy13hQEcJAE2pU9RmWUAIOH9qMiB1UzyfNpxXXX+rlhKnKaQdal6ae74Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB3960
Received-SPF: pass client-ip=40.107.20.134;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 06:39:47
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

This patch implements strace argument printing functionality for syscalls:

    *chown, lchown - change ownership of a file

        int chown(const char *pathname, uid_t owner, gid_t group)
        int lchown(const char *pathname, uid_t owner, gid_t group)
        man page: https://www.man7.org/linux/man-pages/man2/lchown.2.html

Implementation notes:

    Both syscalls use strings as arguments and thus a separate
    printing function was stated in "strace.list" for them.
    Both syscalls share the same number and types of arguments
    and thus share a same definition in file "syscall.c".
    This defintion uses existing functions "print_string()" to
    print the string argument and "print_raw_param()" to print
    other two arguments that are of basic types.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c    | 15 +++++++++++++++
 linux-user/strace.list |  4 ++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index db561dc4c9..f44ab0ab84 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1460,6 +1460,21 @@ print_chmod(const struct syscallname *name,
 }
 #endif
 
+#if defined(TARGET_NR_chown) || defined(TARGET_NR_lchown)
+static void
+print_chown(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_string(arg0, 0);
+    print_raw_param("%d", arg1, 0);
+    print_raw_param("%d", arg2, 1);
+    print_syscall_epilogue(name);
+}
+#define print_lchown     print_chown
+#endif
+
 #ifdef TARGET_NR_clock_adjtime
 static void
 print_clock_adjtime(const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 905a9c395c..633f43f490 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -71,7 +71,7 @@
 { TARGET_NR_chmod, "chmod" , NULL, print_chmod, NULL },
 #endif
 #ifdef TARGET_NR_chown
-{ TARGET_NR_chown, "chown" , NULL, NULL, NULL },
+{ TARGET_NR_chown, "chown" , NULL, print_chown, NULL },
 #endif
 #ifdef TARGET_NR_chown32
 { TARGET_NR_chown32, "chown32" , NULL, NULL, NULL },
@@ -475,7 +475,7 @@
 { TARGET_NR_kill, "kill", NULL, print_kill, NULL },
 #endif
 #ifdef TARGET_NR_lchown
-{ TARGET_NR_lchown, "lchown" , NULL, NULL, NULL },
+{ TARGET_NR_lchown, "lchown" , NULL, print_lchown, NULL },
 #endif
 #ifdef TARGET_NR_lchown32
 { TARGET_NR_lchown32, "lchown32" , NULL, NULL, NULL },
-- 
2.17.1


