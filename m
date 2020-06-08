Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E8CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:52:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9164020760
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="rchFkiGd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9164020760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiL0F-0004kn-Qx
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jiKsw-0003U3-WE
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:44:31 -0400
Received: from mail-eopbgr80091.outbound.protection.outlook.com
 ([40.107.8.91]:62103 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jiKsv-0007Fd-Kp
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:44:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiEU9vyoSrcZ9ixI5XRnPM8nQxeuKxVLbVDcb+v8TOYED7MRWY/NvIzLRE50G8Tznoi07GFP1v05KtlKSYtaVQVicBth7jL0OmW23MkP+4bNCKByLC/oYzOzm8XTRaOAP2x60P3l3zcQtzJLPM8mJ30opkXxUmQ3bajnQoPoNI5rG6hn++OFE4vtEjkRBBeSPz54Pl+Ck40bEzyTlHEVfna98sJiRhZUU18bzhz/OFJ01ZUsyNXCOr421Wv7auTza5XG3ATMrCDHbiKcjI8JWCm/WN+RrFZbZVMD9DMZok+tRdULAtzhJfrxBhqx9+idkb/e/A8hc1plQAGn9lXh1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXWU+yTepNlGIC6dbCR9w9v+RvXWPj8e6rPijVzFTQU=;
 b=LnRS7NcZixtkUW0EK54d1QU6VFuclBSxtwUv3Ztq5H5pNZlh78f4X+Y+UpT9kLpDYXnCQ8MmcfpgzbwGTypC/4koNnDotAO4lGQuyQBEA6VoVLYtU4969ISvakT+kVXMMwldYfG9eW37EHDZRC6Nzp6WY/1ymcW7P27AP68fPHdta6nA4xjLkEZR/p4JwlvkrFYFWGV9vaWMGW368SaOo+7rgsTO50tsqL3FAOzryLOIvjkhRQMQLYCb/wPg5APn4BLu8AS41O6XMvmLLKKBDio+YcgzWRK/5VRp0+NYv+lQIziJ+tNR3BuE+D+XFliUfUpsEt5P7Sc+8xuyRZibCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXWU+yTepNlGIC6dbCR9w9v+RvXWPj8e6rPijVzFTQU=;
 b=rchFkiGdoKHcpuxvkF8uB4+rNrWU2D5U8r7/ZIJRWjaxV89Fva4daaR/o+PZPHHPvkGSJIL9YdBIJICXijpkFmV/Fcid7jDDDSASaoaouzG3rQ2a2+jTSjOB7vlSVbrrCM4zgGdekiXJsWo42iBPCNZle6b+ExJJvOWLVXzPqco=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB3798.eurprd03.prod.outlook.com (2603:10a6:20b:1f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Mon, 8 Jun
 2020 16:44:13 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 16:44:13 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/6] linux-user: Add strace support for printing arguments
 of chown()/lchown()
Date: Mon,  8 Jun 2020 18:43:56 +0200
Message-Id: <20200608164357.25065-6-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608164357.25065-1-filip.bozuta@syrmia.com>
References: <20200608164357.25065-1-filip.bozuta@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::26) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 ZR0P278CA0016.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 16:44:12 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbe233a8-9420-4b9a-8f8e-08d80bcb2cbb
X-MS-TrafficTypeDiagnostic: AM6PR03MB3798:
X-Microsoft-Antispam-PRVS: <AM6PR03MB3798294015172DD3CC2AF5A8EB850@AM6PR03MB3798.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: odOrOp96GmqOtTbqdUWxw9XJ5BpdTE/3PpNG7WHxz+CuxpeGTPAWr0bD6YN6XyLfqSJiq1j5n3lLhi0xJQjFov2KCm/LpwISXqtHlbtKr/XLQvXpxgoKe0be8/OGdhmzDDW1sQgsvD3bHEidtF0ZvKAHyPOINKe8PX6ZzRvXLrM3p2vCHTBj/6zHuIT8PEyt4tx5LvVhXjmqdif3U98IZMZqqaVMCrKQQnJ4TEM2VoBq2VOC6BOVMTsYsJ771Bfhd/bh9gVVrMWY8V1nybHuL91t+Q26cDj8xA6STVD7W+PcimMAgPDBEvi23RFdGdX34539fgsSNwmRxH4b1xQBSrQ2Jz3RJXah0jkkllj1IApTFT/jLboBZuUyhblPW7s60XCFpaBBXHxepNpKx4wOzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39830400003)(376002)(396003)(346002)(136003)(366004)(508600001)(4326008)(8676002)(8936002)(966005)(1076003)(66556008)(6916009)(66476007)(5660300002)(66946007)(86362001)(316002)(36756003)(16526019)(26005)(2906002)(52116002)(83380400001)(2616005)(956004)(44832011)(6486002)(7696005)(186003)(6666004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: LrUoNcXA+xHDxqQLj0lJLxh6yzGt0JOkybohDzq6JP7xlXPST+FqLgw/DOhnZ9AjuF0jD1JfyrUdMSeirItEgebaPbdFvlpGaNg3CXG13geYXSlA1LcwkkdWZE8/tnMfoxWVBz3UDG+rCIfgg+c/pswnsDmiZX6VKXEY0tupltFw2jgWVrbY2b7MTZXm+stLEwkOlKBIBUGaabsS7UZbZuxyFIR0UUb7yDmPFehDD6sFQinx0joTrHfZpjYI29AYs+BRXPnSXLW24ergP01+lVCpkYc0pX2L4mx3/9ZMMgKj59odVtRI2aNimMQyWBY6X3pysuOcZUdhSkjLQujObSJ/RrdZNUo/WN+mSwt6/sxyyJAxsmJ76G76iBhFdOc7grw+S4lLiJ+fwgTseRC0jgaYmPPXwicwmY/xy2Sp+5dNLEpHu2njSXv5AF8mlmbQ5QREMBSar/7ON83ca+fN1jldIZd5xImReGhJXQfQChU=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe233a8-9420-4b9a-8f8e-08d80bcb2cbb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 16:44:13.1550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iumBzLMB7d2bhefHKOrUXDyORhHkvZWxXWFLukRx4Zl3z1q051ehQjHYlkJGsiqOhqSY8bKL7Xjk62Gt0RSSIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB3798
Received-SPF: pass client-ip=40.107.8.91; envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 12:44:17
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
index adf9a47465..cd6a2b8e3f 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1461,6 +1461,21 @@ print_chmod(const struct syscallname *name,
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
index bd04596c50..44eb515ca4 100644
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


