Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EC1C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 20:06:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 751B820825
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 20:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="bqWl2T0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751B820825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyL0A-0007Wc-M5
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 16:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jyKz9-0005tU-Cs
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 16:05:03 -0400
Received: from mail-eopbgr150133.outbound.protection.outlook.com
 ([40.107.15.133]:53875 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jyKz6-0002ER-Lc
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 16:05:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3SQ+ciCalUARz/4Sv8INuqeDyxuhA6a1fIKDCdekbJE9vGkhNS1P1CQBUBe7AzeLFroRS+iGfq23wgL8p8J53Tw3CkrGj/G/9qfh0C58SsuTQ2JTN+UA/8tTfU7/0reDNxJ8pPSO6VZwsWCfXxyhK7Ds09LRO+jLHilfthBkymHVs8tEZBIFfx6RL5pZl7MIxQuE7TmI3zZTul5Ips0fbPkIypdNgEyj19dbQWmpWOGwiR6Wx+cxASKXL+GZINBO4y646mHsUHqNQnDeks8FhNnABycX2ASpcYqOkvDhrDFkp6/i2mJmnV6IFfX/AsFRUjlI9a51BOHDMpQceGLog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfBRNnPfhhFG5rLrehU8qCTuG7mo1D2I+kvG1h0VIfI=;
 b=FkE/7+8tJ0ZD3Bc3e0oN7V5cLYJe3PVnQY7al3Pviuq/ppW61L8sXtWuoRNGMzq5b3/ZzS30M+PUB1Zrv0DSITAkJMIxIYBFRN1ZdTA45epjVNdr1BI65dB3JwAfHO4rCFpjI+3XGW8o0nZTIDtVrnn+9KxSxQn6G7ogMqgKzKaa2e4B17dU8Wo3U90WSCYNHQP1Ds+l4TMQWoR8o0x/ErIGUyVT1nmlWAxD/vrKCykg6VPO4F4M5lkBfSHGUsuoQ4cQbMP9D0L2NBaYuD6E9IR0XRbqRzz0KReD7zYyCFJj0XCfeMP7r3nsTfBYUmH78lAlfmQw0vWemFPp7ZWfag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfBRNnPfhhFG5rLrehU8qCTuG7mo1D2I+kvG1h0VIfI=;
 b=bqWl2T0WRmu64Fi+q2shSubb0Z6U1sdqH/5LUYgYrIWrpVikRN1aSDka1kSnb/MoIQjxgjhcYtSpuWaSSP1peC2dGpD7rcUIcNJ9xebvwz4+sfTx79Rb2RQQE8QUkRN3wH1shaLi3FRrXJpxiOO6Da8vC3aIwSAeA1MRG9sv1io=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM7PR03MB6563.eurprd03.prod.outlook.com (2603:10a6:20b:1c3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Wed, 22 Jul
 2020 20:04:55 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3216.022; Wed, 22 Jul 2020
 20:04:55 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/5] linux-user: Add strace support for printing arguments
 of syscalls used to lock and unlock memory
Date: Wed, 22 Jul 2020 22:04:35 +0200
Message-Id: <20200722200437.312767-4-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200722200437.312767-1-Filip.Bozuta@syrmia.com>
References: <20200722200437.312767-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0029.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::16) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.237) by
 ZR0P278CA0029.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23 via Frontend Transport; Wed, 22 Jul 2020 20:04:54 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.237]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 408346ba-80ed-4f27-dbc7-08d82e7a8074
X-MS-TrafficTypeDiagnostic: AM7PR03MB6563:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR03MB6563CB9C6535837327664AE0EB790@AM7PR03MB6563.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hijohjhKxNHwOMvFWOjUc6rEFcR6gxTg55mbEYPwRrcTNAvaXlQWEwd5LrG+fgNTcWsY7ZFpCRxlu+sH/9UwZvDY87sDzs6NTvR5amZ4e27Y+u7VFZeCE5EI+NwzgN9cRQWOd1tGwFxWPoQbK3WvN3lxYhqSR4UQtAA/EGusb3t4VCKulEOSOIkuOYx7JqTGfrRiTjGX7Tse6M14e7yzfv8xf5BcE/LizF/7f5RX3i6rCmf3cadn0khl1s02i7fdNv4gQkM5oMJUtSMbfshxNxGZo5c2gdKHdfF1AqnpfvuuXOZ8lO2gJGiGE2eRfpxhvWyQAKvcfb8ZQUQekItL28gfIcPnfPv4ADeLQWtnpD19g6S+qvJxej8c/VSY42n4AMQPdoy6y/8+F7i2RTi5fE2n8xiXMzRh+MDo5gESkcGZdkI1Y4V9oizFIqFX6I3vDy+AtqJSnrYD5mPl53WJzMnPqdUd5n+hnlv5aeQFbzc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(366004)(376002)(346002)(39830400003)(136003)(107886003)(956004)(54906003)(26005)(316002)(6666004)(2616005)(1076003)(69590400007)(8936002)(30864003)(2906002)(86362001)(5660300002)(4326008)(66556008)(6486002)(966005)(6916009)(36756003)(6512007)(8676002)(186003)(16526019)(66946007)(83380400001)(508600001)(52116002)(66476007)(6506007)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: IKKHEKEdcuUkxx5O41TwiLM++nzc5HH53O6goXfPF2C84jGKSEcqiAd8IL8nrej4o2CbeVUaEHUm6+OTTPREDr6y+f08GkIF2oOjJunCdX4eb9Bt6HtbMnknimA+IQuw/V8YyaStWweNMj7uS30MrQsRgqIVgDn+rrrLM3TkmCXGK0tJpGINNybxycnVXT237DXbcPewuVCEPdiNTS6SYPKrDQB31wj5KP8pP8eEvYo8UmsTRj6zpLiLxEMbg63O1fAAvzPnYtPXCq3JmKstCQKLDTDWWL3/TmAWY+EQDPU6rPCSGaZV14G9wZdH+SXgwPmXs7h7oGTvNhNPt4xHzIGZHYdhKPZJdj1AgUUW3AP37qs5SQDI+CpYVgTSTQR1yNAzSgwLZ4QcnceaS/KpqhAj0bXC4tBkf16zKznRiOQ3hztgLGcjVUZp/EWWF9OdWM74t0flKBdVfI8KDYrAofkcmMvwnE/t59ONxvrrDCY=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 408346ba-80ed-4f27-dbc7-08d82e7a8074
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 20:04:55.2183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q6+CtC5FJeRJ8FDxFnuGUfTfqz3vlgaxuC0nOwAXaEUFl6ZAZ8+cTQ3qBu2guutuvdZ3GaCCTqnD4GEPXV+Dig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6563
Received-SPF: pass client-ip=40.107.15.133;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 16:04:53
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


