Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385DFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 16:49:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E361D2076B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 16:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="QA22Cb6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E361D2076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5XSd-0007FH-8G
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 12:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k5XPl-0003qt-UR
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 12:46:17 -0400
Received: from mail-eopbgr50105.outbound.protection.outlook.com
 ([40.107.5.105]:15741 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k5XPj-0002xQ-JA
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 12:46:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+AlJdXZJRVL3UkqqO2h0eQY39kqJN0rDqGOjjTCtsy5OacGOUIYX7XmB+FpmD2pPixnaxQi4GAvcjKi/09vsLVspzddwX/PzIlCtSrtO0iiD+P9KWCHxZ61WYVUrWogjSo48ndOrSmrlfKrPBueSuud7LjRZ3qgKd4p5NWogcBz/kbMyHLXT+3AdNF6yND8bLcZWyV0qZJ71FoepY9ozEitZW4GvZL1KkjJS0w1BcVZnT01cwqENkx1KJR8VpPljRyGfnL0lZ4xd/vCf9cHIDBSRLDZs2xryHobPyj2+C1pq8a4pAfymrhTpW7kA7lLdFnjBCGIfr2x7BkRiI2iGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfBRNnPfhhFG5rLrehU8qCTuG7mo1D2I+kvG1h0VIfI=;
 b=YDOgiQFdCAUjpnmmIAEv92gH+hva8yzEHjGhz1KBH09GXA02BYOspEP9RSkyS91hI52AJENPvEDSYepdnEK6W3TI2Mj26ikB+Sq8n5uv8WR31DZaRlai96KC01zZ1cF6+zWU6SW7s615bELh9UhUNL3X9zSDjVzpSKjsIhIqkIkQBUFpBmb0Y8I3/efcjKnbvFzVZG/x965fxgz5mJZ5971rJX479CBpS/m6ru4k1CznY2wAACf/JMqpwmS0CKA4xTughWaNP9JmhtsgXR6BeVcwfULJknySv8DZ/QN/LLRSR1AHohrFi3SYDmFfroUaiC+Yk2lISm9GJGJrlW0G2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfBRNnPfhhFG5rLrehU8qCTuG7mo1D2I+kvG1h0VIfI=;
 b=QA22Cb6hRgXaNUeoLuugCQH/X1xCy+/c0K1uDxBiZZzlZPAia9x2SOXHLrpcjHuASp39QM6AqzsfbrO4lvGvcLWxZFwpd1ERUQGqbwduaeGEPhHxzo91xuzL8ipl5AygIz1uPyYduERi8/0vwbQN2EOUidO6E2K23/cTv+KvOx0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR03MB3662.eurprd03.prod.outlook.com (2603:10a6:803:3a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Tue, 11 Aug
 2020 16:46:09 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.024; Tue, 11 Aug 2020
 16:46:09 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 3/5] linux-user: Add strace support for printing arguments
 of syscalls used to lock and unlock memory
Date: Tue, 11 Aug 2020 18:45:51 +0200
Message-Id: <20200811164553.27713-4-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200811164553.27713-1-Filip.Bozuta@syrmia.com>
References: <20200811164553.27713-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::13) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.235) by
 LO3P123CA0008.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:ba::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.16 via Frontend Transport; Tue, 11 Aug 2020 16:46:08 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.235]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26810fa0-9fbe-4758-bdf4-08d83e160c78
X-MS-TrafficTypeDiagnostic: VI1PR03MB3662:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR03MB36624748AC2AD1C163809E2EEB450@VI1PR03MB3662.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bl41HcSzq62wogOMrC9iXntbE38cO2Yk+4Hy1EoREBuNqT7dpKidMn9LQWtGBOsBP9/dMbllOli2scWppUCqvZ0m3lyfYM1zWxHGs54sH7otifIl1gbipiLIZNhepQorqUCSRG+8coryx41uHSCBnFkvUZBBrJ9v3gZoyzpQG2/Ft/jtJzBadp9dEC4AkmNq7xrZFIvPSUhooS76KTJCIPVVDz/YXw54q7ANy4wko6qqS6ZhWEWQkgVH9sP3cQeFtwTZDE/fGeKzk/NMhv6ynT5qUE5ES9dleMbbiwH+3FBvkPgIOohvGfEH36sib+XmgKkms+/t8C0sWFqK1vimUi6fTJobDZz/DYFJWod+T+JM7sh5jnYuO0WGZS5gX/mHQ6CWnjQzkFinXx6cmuqHU6nj+OaWlZX5LlUGVXZAnrWcJiyRYvN84pDIjRTUJ/d7OAReEFa7p17bCrMdDEfLXRzxeEU/J7kaZG6Kuw9PJX4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(376002)(396003)(366004)(39830400003)(136003)(956004)(2906002)(508600001)(6512007)(186003)(52116002)(16526019)(66556008)(66946007)(26005)(83380400001)(6666004)(1076003)(30864003)(66476007)(6506007)(86362001)(54906003)(8936002)(4326008)(107886003)(966005)(36756003)(316002)(6916009)(5660300002)(8676002)(6486002)(69590400007)(2616005)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: q0/z7gGJX41oiqAZeC7pTCZpbJAxiNYz7DDB0s9rsEp88W1B+8ikC9bVI5X3V+Xe3v9OGW3A8JQ+uMYS/IWMd3+AM+dM3UHg20U6oUHbI8fw60U9lcWyx63wHCnYY+nMIbOoQT44qtQ3gCvXMI3Bc44Nzo5OesSX6XmiEPsTaZhOEHBmf2TghkpYHtVcjP1ILkPzfXnKFFLHki7jYP4wfszPWKwfdlyuyr4G71RO4dxkgotO2/Xz0yd99E2wFuMlojDN+PRPyYEuhvRjMP45DJYhSNX+1djHETChnDAYp83OpA8yHLPxcG3AcRnM/WRNwmDhjRudMUFDzL9PAF9/A2nfOHtF2poybqG8e+JRkPf5MYxsn6sqRjZdd+Y48a2lv81teZhMHR46bjbq9u54KNl3CP8oCkNbwqf1mZSKqCDUMJ/0NoCtsg45hec25nOj99iAqGQFrWvgOUwMMieeBjUMAf/KNvvXleqOAyxKuEXPlYTSMGNir9FqXejU9fQi9IFyE9xNCnEKwYeRRCwmMPVRJ9ECMAsDjgLVPu12oqkW+YXgqDlYnqQl6FPhrEFXUiCthzj5SwyEz42YgNaHrlzPBlHJ9n3mueKWOuVF9V8psRYwKGZ7TnvqG0SPpmVke4cFB1UWeHv+Gw9ZweGUlQ==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26810fa0-9fbe-4758-bdf4-08d83e160c78
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 16:46:09.6165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImfBCjeDiRVsGjHOBKKI7o9K0iwJe8g2U67Du0EdE1UmLPXkkn82EwD3qujG9Pqgwoc5QC/NZcGZw1RYhmkSGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB3662
Received-SPF: pass client-ip=40.107.5.105;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 12:46:08
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch implements strace argument printing functionality for following syscalls:

    * mlock, munlock, mlockall, munlockall - lock and unlock memory

       int mlock(const void *addr, size_t len)
       int munlock(const void *addr, size_t len)
       int mlockall(int flags)
       int munlockall(void)
       man page: https://man7.org/linux/man-pages/man2/mlock.2.html

Implementation notes:

    Syscall mlockall() takes an argument that is composed of predefined values
    which represent flags that determine the type of locking operation that is
    to be performed. For that reason, a printing function "print_mlockall" was
    stated in file "strace.list". This printing function uses an already existing
    function "print_flags()" to print the "flags" argument.  These flags are stated
    inside an array "mlockall_flags" that contains values of type "struct flags".
    These values are instantiated using an existing macro "FLAG_TARGET()" that
    crates aproppriate target flag values based on those defined in files
    '/target_syscall.h'. These target flag values were changed from
    "TARGET_MLOCKALL_MCL*" to "TARGET_MCL_*" so that they can be aproppriately set
    and recognised in "strace.c" with "FLAG_TARGET()". Value for "MCL_ONFAULT"
    was added in this patch. This value was also added in "syscall.c" in function
    "target_to_host_mlockall_arg()". Because this flag value was added in kernel
    version 4.4, it is enwrapped in an #ifdef directive (both in "syscall.c" and
    in "strace.c") as to support older kernel versions.
    The other syscalls have only primitive argument types, so the
    rest of the implementation was handled by stating an appropriate
    printing format in file "strace.list". Syscall mlock2() is not implemented in
    "syscall.c" and thus it's argument printing is not implemented in this patch.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/aarch64/target_syscall.h    |  5 +++--
 linux-user/alpha/target_syscall.h      |  5 +++--
 linux-user/arm/target_syscall.h        |  6 ++++--
 linux-user/cris/target_syscall.h       |  5 +++--
 linux-user/hppa/target_syscall.h       |  5 +++--
 linux-user/i386/target_syscall.h       |  5 +++--
 linux-user/m68k/target_syscall.h       |  6 +++---
 linux-user/microblaze/target_syscall.h |  5 +++--
 linux-user/mips/target_syscall.h       |  5 +++--
 linux-user/mips64/target_syscall.h     |  5 +++--
 linux-user/nios2/target_syscall.h      |  5 +++--
 linux-user/openrisc/target_syscall.h   |  5 +++--
 linux-user/ppc/target_syscall.h        |  5 +++--
 linux-user/riscv/target_syscall.h      |  5 +++--
 linux-user/s390x/target_syscall.h      |  5 +++--
 linux-user/sh4/target_syscall.h        |  5 +++--
 linux-user/sparc/target_syscall.h      |  5 +++--
 linux-user/sparc64/target_syscall.h    |  5 +++--
 linux-user/strace.c                    | 21 +++++++++++++++++++++
 linux-user/strace.list                 |  8 ++++----
 linux-user/syscall.c                   | 10 ++++++++--
 linux-user/tilegx/target_syscall.h     |  5 +++--
 linux-user/x86_64/target_syscall.h     |  5 +++--
 linux-user/xtensa/target_syscall.h     |  5 +++--
 24 files changed, 97 insertions(+), 49 deletions(-)

diff --git a/linux-user/aarch64/target_syscall.h b/linux-user/aarch64/target_syscall.h
index 995e475c73..3194e6b009 100644
--- a/linux-user/aarch64/target_syscall.h
+++ b/linux-user/aarch64/target_syscall.h
@@ -16,8 +16,9 @@ struct target_pt_regs {
 #define UNAME_MINIMUM_RELEASE "3.8.0"
 #define TARGET_CLONE_BACKWARDS
 #define TARGET_MINSIGSTKSZ       2048
-#define TARGET_MLOCKALL_MCL_CURRENT 1
-#define TARGET_MLOCKALL_MCL_FUTURE  2
+#define TARGET_MCL_CURRENT 1
+#define TARGET_MCL_FUTURE  2
+#define TARGET_MCL_ONFAULT 4
 
 #define TARGET_PR_SVE_SET_VL  50
 #define TARGET_PR_SVE_GET_VL  51
diff --git a/linux-user/alpha/target_syscall.h b/linux-user/alpha/target_syscall.h
index 3426cc5b4e..fd389422e3 100644
--- a/linux-user/alpha/target_syscall.h
+++ b/linux-user/alpha/target_syscall.h
@@ -258,7 +258,8 @@ struct target_pt_regs {
 #define TARGET_UAC_NOFIX		2
 #define TARGET_UAC_SIGBUS		4
 #define TARGET_MINSIGSTKSZ              4096
-#define TARGET_MLOCKALL_MCL_CURRENT     0x2000
-#define TARGET_MLOCKALL_MCL_FUTURE      0x4000
+#define TARGET_MCL_CURRENT     0x2000
+#define TARGET_MCL_FUTURE      0x4000
+#define TARGET_MCL_ONFAULT     0x8000
 
 #endif /* ALPHA_TARGET_SYSCALL_H */
diff --git a/linux-user/arm/target_syscall.h b/linux-user/arm/target_syscall.h
index f85cbdaf56..e870ed7a54 100644
--- a/linux-user/arm/target_syscall.h
+++ b/linux-user/arm/target_syscall.h
@@ -28,8 +28,10 @@ struct target_pt_regs {
 #define TARGET_CLONE_BACKWARDS
 
 #define TARGET_MINSIGSTKSZ 2048
-#define TARGET_MLOCKALL_MCL_CURRENT 1
-#define TARGET_MLOCKALL_MCL_FUTURE  2
+#define TARGET_MCL_CURRENT 1
+#define TARGET_MCL_FUTURE  2
+#define TARGET_MCL_ONFAULT 4
+
 #define TARGET_WANT_OLD_SYS_SELECT
 
 #define TARGET_FORCE_SHMLBA
diff --git a/linux-user/cris/target_syscall.h b/linux-user/cris/target_syscall.h
index 29d69009ff..d109a6b42a 100644
--- a/linux-user/cris/target_syscall.h
+++ b/linux-user/cris/target_syscall.h
@@ -40,7 +40,8 @@ struct target_pt_regs {
 
 #define TARGET_CLONE_BACKWARDS2
 #define TARGET_MINSIGSTKSZ 2048
-#define TARGET_MLOCKALL_MCL_CURRENT 1
-#define TARGET_MLOCKALL_MCL_FUTURE  2
+#define TARGET_MCL_CURRENT 1
+#define TARGET_MCL_FUTURE  2
+#define TARGET_MCL_ONFAULT 4
 
 #endif
diff --git a/linux-user/hppa/target_syscall.h b/linux-user/hppa/target_syscall.h
index e2f366839d..f34e05edb5 100644
--- a/linux-user/hppa/target_syscall.h
+++ b/linux-user/hppa/target_syscall.h
@@ -23,8 +23,9 @@ struct target_pt_regs {
 #define UNAME_MINIMUM_RELEASE "2.6.32"
 #define TARGET_CLONE_BACKWARDS
 #define TARGET_MINSIGSTKSZ       2048
-#define TARGET_MLOCKALL_MCL_CURRENT 1
-#define TARGET_MLOCKALL_MCL_FUTURE  2
+#define TARGET_MCL_CURRENT 1
+#define TARGET_MCL_FUTURE  2
+#define TARGET_MCL_ONFAULT 4
 
 #undef  TARGET_ENOMSG
 #define TARGET_ENOMSG          35
diff --git a/linux-user/i386/target_syscall.h b/linux-user/i386/target_syscall.h
index 2854758134..ed356b3908 100644
--- a/linux-user/i386/target_syscall.h
+++ b/linux-user/i386/target_syscall.h
@@ -151,8 +151,9 @@ struct target_vm86plus_struct {
 
 #define TARGET_CLONE_BACKWARDS
 #define TARGET_MINSIGSTKSZ 2048
-#define TARGET_MLOCKALL_MCL_CURRENT 1
-#define TARGET_MLOCKALL_MCL_FUTURE  2
+#define TARGET_MCL_CURRENT 1
+#define TARGET_MCL_FUTURE  2
+#define TARGET_MCL_ONFAULT 4
 #define TARGET_WANT_OLD_SYS_SELECT
 
 #endif /* I386_TARGET_SYSCALL_H */
diff --git a/linux-user/m68k/target_syscall.h b/linux-user/m68k/target_syscall.h
index c0366b1c62..23359a6299 100644
--- a/linux-user/m68k/target_syscall.h
+++ b/linux-user/m68k/target_syscall.h
@@ -21,9 +21,9 @@ struct target_pt_regs {
 #define UNAME_MINIMUM_RELEASE "2.6.32"
 
 #define TARGET_MINSIGSTKSZ 2048
-#define TARGET_MLOCKALL_MCL_CURRENT 1
-#define TARGET_MLOCKALL_MCL_FUTURE  2
-
+#define TARGET_MCL_CURRENT 1
+#define TARGET_MCL_FUTURE  2
+#define TARGET_MCL_ONFAULT 4
 #define TARGET_WANT_OLD_SYS_SELECT
 
 #endif /* M68K_TARGET_SYSCALL_H */
diff --git a/linux-user/microblaze/target_syscall.h b/linux-user/microblaze/target_syscall.h
index 4141cbaa5e..7f653db34f 100644
--- a/linux-user/microblaze/target_syscall.h
+++ b/linux-user/microblaze/target_syscall.h
@@ -50,8 +50,9 @@ struct target_pt_regs {
 
 #define TARGET_CLONE_BACKWARDS
 #define TARGET_MINSIGSTKSZ      2048
-#define TARGET_MLOCKALL_MCL_CURRENT 1
-#define TARGET_MLOCKALL_MCL_FUTURE  2
+#define TARGET_MCL_CURRENT 1
+#define TARGET_MCL_FUTURE  2
+#define TARGET_MCL_ONFAULT 4
 
 #define TARGET_WANT_NI_OLD_SELECT
 
diff --git a/linux-user/mips/target_syscall.h b/linux-user/mips/target_syscall.h
index d5509a34a7..dd6fd7af8e 100644
--- a/linux-user/mips/target_syscall.h
+++ b/linux-user/mips/target_syscall.h
@@ -234,8 +234,9 @@ struct target_pt_regs {
 
 #define TARGET_CLONE_BACKWARDS
 #define TARGET_MINSIGSTKSZ 2048
-#define TARGET_MLOCKALL_MCL_CURRENT 1
-#define TARGET_MLOCKALL_MCL_FUTURE  2
+#define TARGET_MCL_CURRENT 1
+#define TARGET_MCL_FUTURE  2
+#define TARGET_MCL_ONFAULT 4
 
 #define TARGET_FORCE_SHMLBA
 
diff --git a/linux-user/mips64/target_syscall.h b/linux-user/mips64/target_syscall.h
index 8ccc46822c..8594955eec 100644
--- a/linux-user/mips64/target_syscall.h
+++ b/linux-user/mips64/target_syscall.h
@@ -231,8 +231,9 @@ struct target_pt_regs {
 
 #define TARGET_CLONE_BACKWARDS
 #define TARGET_MINSIGSTKSZ      2048
-#define TARGET_MLOCKALL_MCL_CURRENT 1
-#define TARGET_MLOCKALL_MCL_FUTURE  2
+#define TARGET_MCL_CURRENT 1
+#define TARGET_MCL_FUTURE  2
+#define TARGET_MCL_ONFAULT 4
 
 #define TARGET_FORCE_SHMLBA
 
diff --git a/linux-user/nios2/target_syscall.h b/linux-user/nios2/target_syscall.h
index f3b2a500f4..78006c24d4 100644
--- a/linux-user/nios2/target_syscall.h
+++ b/linux-user/nios2/target_syscall.h
@@ -31,7 +31,8 @@ struct target_pt_regs {
 };
 
 #define TARGET_MINSIGSTKSZ 2048
-#define TARGET_MLOCKALL_MCL_CURRENT 1
-#define TARGET_MLOCKALL_MCL_FUTURE  2
+#define TARGET_MCL_CURRENT 1
+#define TARGET_MCL_FUTURE  2
+#define TARGET_MCL_ONFAULT 4
 
 #endif /* NIOS2_TARGET_SYSCALL_H */
diff --git a/linux-user/openrisc/target_syscall.h b/linux-user/openrisc/target_syscall.h
index d586d2a018..ef0d89a551 100644
--- a/linux-user/openrisc/target_syscall.h
+++ b/linux-user/openrisc/target_syscall.h
@@ -16,8 +16,9 @@ struct target_pt_regs {
 #define UNAME_MINIMUM_RELEASE "2.6.32"
 
 #define TARGET_MINSIGSTKSZ 2048
-#define TARGET_MLOCKALL_MCL_CURRENT 1
-#define TARGET_MLOCKALL_MCL_FUTURE  2
+#define TARGET_MCL_CURRENT 1
+#define TARGET_MCL_FUTURE  2
+#define TARGET_MCL_ONFAULT 4
 
 #define MMAP_SHIFT TARGET_PAGE_BITS
 
diff --git a/linux-user/ppc/target_syscall.h b/linux-user/ppc/target_syscall.h
index afc0570410..c461f878f2 100644
--- a/linux-user/ppc/target_syscall.h
+++ b/linux-user/ppc/target_syscall.h
@@ -72,8 +72,9 @@ struct target_revectored_struct {
 #define TARGET_CLONE_BACKWARDS
 
 #define TARGET_MINSIGSTKSZ 2048
-#define TARGET_MLOCKALL_MCL_CURRENT 0x2000
-#define TARGET_MLOCKALL_MCL_FUTURE  0x4000
+#define TARGET_MCL_CURRENT 0x2000
+#define TARGET_MCL_FUTURE  0x4000
+#define TARGET_MCL_ONFAULT 0x8000
 #define TARGET_WANT_NI_OLD_SELECT
 
 #endif /* PPC_TARGET_SYSCALL_H */
diff --git a/linux-user/riscv/target_syscall.h b/linux-user/riscv/target_syscall.h
index a88e821f73..dc597c8972 100644
--- a/linux-user/riscv/target_syscall.h
+++ b/linux-user/riscv/target_syscall.h
@@ -51,8 +51,9 @@ struct target_pt_regs {
 #define UNAME_MINIMUM_RELEASE "4.15.0"
 
 #define TARGET_MINSIGSTKSZ 2048
-#define TARGET_MLOCKALL_MCL_CURRENT 1
-#define TARGET_MLOCKALL_MCL_FUTURE  2
+#define TARGET_MCL_CURRENT 1
+#define TARGET_MCL_FUTURE  2
+#define TARGET_MCL_ONFAULT 4
 
 /* clone(flags, newsp, ptidptr, tls, ctidptr) for RISC-V */
 /* This comes from linux/kernel/fork.c, CONFIG_CLONE_BACKWARDS */
diff --git a/linux-user/s390x/target_syscall.h b/linux-user/s390x/target_syscall.h
index 8d4f609eaa..94f84178db 100644
--- a/linux-user/s390x/target_syscall.h
+++ b/linux-user/s390x/target_syscall.h
@@ -28,7 +28,8 @@ struct target_pt_regs {
 
 #define TARGET_CLONE_BACKWARDS2
 #define TARGET_MINSIGSTKSZ        2048
-#define TARGET_MLOCKALL_MCL_CURRENT 1
-#define TARGET_MLOCKALL_MCL_FUTURE  2
+#define TARGET_MCL_CURRENT 1
+#define TARGET_MCL_FUTURE  2
+#define TARGET_MCL_ONFAULT 4
 
 #endif /* S390X_TARGET_SYSCALL_H */
diff --git a/linux-user/sh4/target_syscall.h b/linux-user/sh4/target_syscall.h
index 2b5f75be13..c1437adafe 100644
--- a/linux-user/sh4/target_syscall.h
+++ b/linux-user/sh4/target_syscall.h
@@ -16,8 +16,9 @@ struct target_pt_regs {
 #define UNAME_MINIMUM_RELEASE "2.6.32"
 
 #define TARGET_MINSIGSTKSZ 2048
-#define TARGET_MLOCKALL_MCL_CURRENT 1
-#define TARGET_MLOCKALL_MCL_FUTURE  2
+#define TARGET_MCL_CURRENT 1
+#define TARGET_MCL_FUTURE  2
+#define TARGET_MCL_ONFAULT 4
 
 #define TARGET_FORCE_SHMLBA
 
diff --git a/linux-user/sparc/target_syscall.h b/linux-user/sparc/target_syscall.h
index b9160a771b..d8ea04ea83 100644
--- a/linux-user/sparc/target_syscall.h
+++ b/linux-user/sparc/target_syscall.h
@@ -21,8 +21,9 @@ struct target_pt_regs {
  */
 #define TARGET_CLONE_BACKWARDS
 #define TARGET_MINSIGSTKSZ      4096
-#define TARGET_MLOCKALL_MCL_CURRENT 0x2000
-#define TARGET_MLOCKALL_MCL_FUTURE  0x4000
+#define TARGET_MCL_CURRENT 0x2000
+#define TARGET_MCL_FUTURE  0x4000
+#define TARGET_MCL_ONFAULT 0x8000
 
 /* For SPARC SHMLBA is determined at runtime in the kernel, and
  * libc has to runtime-detect it using the hwcaps (see glibc
diff --git a/linux-user/sparc64/target_syscall.h b/linux-user/sparc64/target_syscall.h
index 3073a23e03..696a68b1ed 100644
--- a/linux-user/sparc64/target_syscall.h
+++ b/linux-user/sparc64/target_syscall.h
@@ -22,8 +22,9 @@ struct target_pt_regs {
  */
 #define TARGET_CLONE_BACKWARDS
 #define TARGET_MINSIGSTKSZ      4096
-#define TARGET_MLOCKALL_MCL_CURRENT 0x2000
-#define TARGET_MLOCKALL_MCL_FUTURE  0x4000
+#define TARGET_MCL_CURRENT 0x2000
+#define TARGET_MCL_FUTURE  0x4000
+#define TARGET_MCL_ONFAULT 0x8000
 
 #define TARGET_FORCE_SHMLBA
 
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 7dc239b9f1..40f863c6e2 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1194,6 +1194,15 @@ UNUSED static struct flags falloc_flags[] = {
 #endif
 };
 
+UNUSED static struct flags mlockall_flags[] = {
+    FLAG_TARGET(MCL_CURRENT),
+    FLAG_TARGET(MCL_FUTURE),
+#ifdef MCL_ONFAULT
+    FLAG_TARGET(MCL_ONFAULT),
+#endif
+    FLAG_END,
+};
+
 /*
  * print_xxx utility functions.  These are used to print syscall
  * parameters in certain format.  All of these have parameter
@@ -2005,6 +2014,18 @@ print_ftruncate64(void *cpu_env, const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_mlockall
+static void
+print_mlockall(void *cpu_env, const struct syscallname *name,
+               abi_long arg0, abi_long arg1, abi_long arg2,
+               abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_flags(mlockall_flags, arg0, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #if defined(TARGET_NR_socket)
 static void
 print_socket(void *cpu_env, const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 8e5303d035..d0ea7f3464 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -568,13 +568,13 @@
 { TARGET_NR_mknodat, "mknodat" , NULL, print_mknodat, NULL },
 #endif
 #ifdef TARGET_NR_mlock
-{ TARGET_NR_mlock, "mlock" , NULL, NULL, NULL },
+{ TARGET_NR_mlock, "mlock" , "%s(%p," TARGET_FMT_lu ")", NULL, NULL },
 #endif
 #ifdef TARGET_NR_mlock2
 { TARGET_NR_mlock2, "mlock2" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_mlockall
-{ TARGET_NR_mlockall, "mlockall" , NULL, NULL, NULL },
+{ TARGET_NR_mlockall, "mlockall" , NULL, print_mlockall, NULL },
 #endif
 #ifdef TARGET_NR_mmap
 { TARGET_NR_mmap, "mmap" , NULL, print_mmap, print_syscall_ret_addr },
@@ -637,10 +637,10 @@
 { TARGET_NR_multiplexer, "multiplexer" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_munlock
-{ TARGET_NR_munlock, "munlock" , NULL, NULL, NULL },
+{ TARGET_NR_munlock, "munlock" , "%s(%p," TARGET_FMT_lu ")", NULL, NULL },
 #endif
 #ifdef TARGET_NR_munlockall
-{ TARGET_NR_munlockall, "munlockall" , NULL, NULL, NULL },
+{ TARGET_NR_munlockall, "munlockall" , "%s()", NULL, NULL },
 #endif
 #ifdef TARGET_NR_munmap
 { TARGET_NR_munmap, "munmap" , NULL, print_munmap, NULL },
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1517096a9b..24d915f0ff 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6906,12 +6906,18 @@ static inline int target_to_host_mlockall_arg(int arg)
 {
     int result = 0;
 
-    if (arg & TARGET_MLOCKALL_MCL_CURRENT) {
+    if (arg & TARGET_MCL_CURRENT) {
         result |= MCL_CURRENT;
     }
-    if (arg & TARGET_MLOCKALL_MCL_FUTURE) {
+    if (arg & TARGET_MCL_FUTURE) {
         result |= MCL_FUTURE;
     }
+#ifdef MCL_ONFAULT
+    if (arg & TARGET_MCL_ONFAULT) {
+        result |= MCL_ONFAULT;
+    }
+#endif
+
     return result;
 }
 #endif
diff --git a/linux-user/tilegx/target_syscall.h b/linux-user/tilegx/target_syscall.h
index d731acdafa..8e9db734b8 100644
--- a/linux-user/tilegx/target_syscall.h
+++ b/linux-user/tilegx/target_syscall.h
@@ -34,8 +34,9 @@ struct target_pt_regs {
     tilegx_reg_t pad[2];
 };
 
-#define TARGET_MLOCKALL_MCL_CURRENT 1
-#define TARGET_MLOCKALL_MCL_FUTURE  2
+#define TARGET_MCL_CURRENT 1
+#define TARGET_MCL_FUTURE  2
+#define TARGET_MCL_ONFAULT 4
 
 /* For faultnum */
 #define TARGET_INT_SWINT_1            14
diff --git a/linux-user/x86_64/target_syscall.h b/linux-user/x86_64/target_syscall.h
index 5e221e1d9d..3ecccb72be 100644
--- a/linux-user/x86_64/target_syscall.h
+++ b/linux-user/x86_64/target_syscall.h
@@ -101,7 +101,8 @@ struct target_msqid64_ds {
 #define TARGET_ARCH_GET_FS 0x1003
 #define TARGET_ARCH_GET_GS 0x1004
 #define TARGET_MINSIGSTKSZ 2048
-#define TARGET_MLOCKALL_MCL_CURRENT 1
-#define TARGET_MLOCKALL_MCL_FUTURE  2
+#define TARGET_MCL_CURRENT 1
+#define TARGET_MCL_FUTURE  2
+#define TARGET_MCL_ONFAULT 4
 
 #endif /* X86_64_TARGET_SYSCALL_H */
diff --git a/linux-user/xtensa/target_syscall.h b/linux-user/xtensa/target_syscall.h
index 3866dad849..afc86a153f 100644
--- a/linux-user/xtensa/target_syscall.h
+++ b/linux-user/xtensa/target_syscall.h
@@ -43,7 +43,8 @@ struct target_pt_regs {
     xtensa_reg_t areg[16];
 };
 
-#define TARGET_MLOCKALL_MCL_CURRENT 1
-#define TARGET_MLOCKALL_MCL_FUTURE  2
+#define TARGET_MCL_CURRENT 1
+#define TARGET_MCL_FUTURE  2
+#define TARGET_MCL_ONFAULT 4
 
 #endif
-- 
2.25.1


