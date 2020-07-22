Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7084CC433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 20:06:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2842F20771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 20:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="WZZ7jiII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2842F20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyL06-0007N6-8S
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 16:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jyKz6-0005px-Dl
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 16:05:00 -0400
Received: from mail-eopbgr150133.outbound.protection.outlook.com
 ([40.107.15.133]:53875 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jyKz4-0002ER-7t
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 16:05:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwB6jE20gdFBKs+SYc2HzTAEPR17HfHkhjgJ/FFPR5xxWfuK1dPJM4xDs1+IUGZ1ralqfZZBW54S1TzRyd9HZnaBhiN/O6EpJOFwjKE0ZvzHWnf/+1NxFKFroG7qimddUMkHG9SmOui1ty0vsEb5WNWH7Q0+1GR5bP4dqy3WGBGP6mKXpUlJbd2Lh9op0CGplwxMS+kr89q7RNKKELionhBoV9WrlkIswqdXFoyjNbF40vHvP78ifJ3/DZt5d7aL7SD/uVF4zWS2hglfI1gzS/1hly98NeVidJYJehaHwDmqzCMFCNmPmtQdnshjStKsYl69H+ucopqJkNhp8V0HkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVAJorsml/0OXlxkEkuRvBk/Ii5+nXBGPfsPBLt1KRQ=;
 b=f6bEYKdtQ5XwbkMdQkjWKkaoXUdtBrUIBlwAdwidzqAunP5XIp/thoKhel7s425s17xKx2a/TF+gV4y+npgVJmd9DoHb7ODqj0A1Cc5kVAY/ryd74Aq8D0rRnc+LeQDBSvM1r5PoAWBQAMt05PDGARDbEvpXRbvRD+OTjoP0NAzCW3Uc+byiglKqCuz1rEbsVBJSqvG6maj1SUkitiuDSwbig1ggKQEszerX0vb++DGHQkymKI5+zuhsPCZI33CfKX6BCG5TFPQxN189v+lumTHeeTqjZfvz6MI7lu/JzhzDvEHunzjOKBWzmOTSmNrMJLG2PuO5NKh4WkBYLYX/gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVAJorsml/0OXlxkEkuRvBk/Ii5+nXBGPfsPBLt1KRQ=;
 b=WZZ7jiIIdDKK8Xfn8PF1m3uAv/ZOtT/C2fovgnzPuzeQr/fyAcIIjaD4Rjk2IXXLuAmzj1CmuZb1w6CBDIVIJBPUMwY8vjNAHE29rgxcUMcPtOji9f/MTmRW0TnzbkImJDESTcyNe+6gl1/V/hf2yBOcNKBfeQJ000H4FtaaHYY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM7PR03MB6563.eurprd03.prod.outlook.com (2603:10a6:20b:1c3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Wed, 22 Jul
 2020 20:04:54 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3216.022; Wed, 22 Jul 2020
 20:04:54 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/5] linux-user: Add strace support for printing arguments
 of truncate()/ftruncate() and getsid()
Date: Wed, 22 Jul 2020 22:04:34 +0200
Message-Id: <20200722200437.312767-3-Filip.Bozuta@syrmia.com>
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
 15.20.3216.23 via Frontend Transport; Wed, 22 Jul 2020 20:04:53 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.237]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26690955-fb83-426d-3a40-08d82e7a7ffc
X-MS-TrafficTypeDiagnostic: AM7PR03MB6563:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR03MB6563033FDF6F762F85A2000DEB790@AM7PR03MB6563.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: irApa5lYHDM+IboT1guq3svR3aFAEkjGKG5Kon4ycQd5Q39HLTVBtNDYcsVaW62aZj9he5CUTU6A0z1GDwQtsbFHSbqBzocm67Oc33gtpNfc/XGUkhbfI48SU9O6q1Nbr37y8fL29HPTUgCiaUP8I55cHPu5RX5YywFjsxRLX8JnQt3Qlqk8Q9NB4pYgrLYq8Wvwdqudf10OQKsNDH26D8rQmfP8kfRITA2FWCsyHxZlyxXKwUyWKxNN9PZvdADePaF5hsJXrjKMO53WJb3gsLrS52EgPXNkmido0+AGfld9Xdl78I+0JLOySRYGnNa+PqlDW+eCcNR9B/Oz8oxAdth7A0SHGzf69pUPpld59oTaDgLT08MyWiCFUvAJwcvDl5SiyFzuXE6iQzJNcrQ8iaI0LolUWoOvHePzFUeAIIYDFxvWRSBXDntwyO9VK0ChgKRuMXrnZDSrw/YCkucqzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(366004)(376002)(346002)(39830400003)(136003)(107886003)(956004)(54906003)(26005)(316002)(6666004)(2616005)(1076003)(69590400007)(8936002)(2906002)(86362001)(5660300002)(4326008)(66556008)(6486002)(966005)(6916009)(36756003)(6512007)(8676002)(186003)(16526019)(66946007)(83380400001)(508600001)(52116002)(66476007)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 7MI/NiHf3KEfloulnoSRaIIHu6tYkpvXTxI33Kgg8/nS3SRPIRDu6tc/yMaBEv4YT8vqsZbL+fUTVMka6Pvtz5IHBldJ+5BJJNyb0ltkhDozyg+XHAaMD8+Co2F1m40K0TU65yO3c2Tr1UW18NGHSQRko6MYd1wqBftcY5tcLHJuhoBRNMusvJRvTFfvLcafcfXhniconzSUBv8l3FJiil6g4U4uU03RWnwKoIuhFwGvQOCxq+V8Jk39TOEDJobe1NZD5EiID480LI5loOrETr7yEYPRb6BTxFmp/+btKBY60I+xrdo+tj+SGG/vS0rYjddBlvjtP8WtlsIaVD82GhoY0Ca1+R5Ci4MXZIzGCFX9FpCdlYyLSp1dQMOf0GBbPzGCcwib2+xyoo0rzv/ZGzSvJ1NZAcxbkol+VMGj2FHZNRDxl+ZzS1aRriU9sK9TU/Qy8A66ygRqZlQw5FzwD3XQK+4oUuwM9gPa8nydktQ=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26690955-fb83-426d-3a40-08d82e7a7ffc
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 20:04:54.2738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bVpnwMBtgpJoV3NIk4N1TG+/EGbeAd/q3Bo34OSpxaayqEolMViGGmNaTs8OOuC+hgWhqSCAnWnQCHa+enK40w==
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

    * truncate, ftruncate - truncate a file to a specified length

        int truncate/truncate64(const char *path, off_t length)
        int ftruncate/ftruncate64(int fd, off_t length)
        man page: https://man7.org/linux/man-pages/man2/truncate.2.html

    * getsid - get session ID

        pid_t getsid(pid_t pid)
        man page: https://man7.org/linux/man-pages/man2/getsid.2.html

Implementation notes:

    Syscalls truncate/truncate64 take string argument types and thus a
    separate print function "print_truncate/print_truncate64" is stated in
    file "strace.list". This function is defined and implemented in "strace.c"
    by using an existing function used to print string arguments: "print_string()".
    For syscall ftruncate64, a separate printing function was also stated in
    "strace.c" as it requires a special kind of handling.
    The other syscalls have only primitive argument types, so the rest of the
    implementation was handled by stating an appropriate printing format in file
    "strace.list".
    Function "regpairs_aligned()" was cut & pasted from "syscall.c" to "qemu.h"
    as it is used by functions "print_truncate64()" and "print_ftruncate64()"
    to print the offset arguments of "truncate64()" and "ftruncate64()".

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/qemu.h      | 35 +++++++++++++++++++++++++++++++
 linux-user/strace.c    | 47 ++++++++++++++++++++++++++++++++++++++++++
 linux-user/strace.list | 10 ++++-----
 linux-user/syscall.c   | 32 ----------------------------
 4 files changed, 87 insertions(+), 37 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 63ddfe86fd..f431805e57 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -706,6 +706,41 @@ static inline uint64_t target_offset64(uint64_t word0, uint64_t word1)
 }
 #endif /* TARGET_ABI_BITS != 32 */
 
+
+/* ARM EABI and MIPS expect 64bit types aligned even on pairs or registers */
+#ifdef TARGET_ARM
+static inline int regpairs_aligned(void *cpu_env, int num)
+{
+    return ((((CPUARMState *)cpu_env)->eabi) == 1) ;
+}
+#elif defined(TARGET_MIPS) && (TARGET_ABI_BITS == 32)
+static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
+#elif defined(TARGET_PPC) && !defined(TARGET_PPC64)
+/*
+ * SysV AVI for PPC32 expects 64bit parameters to be passed on odd/even pairs
+ * of registers which translates to the same as ARM/MIPS, because we start with
+ * r3 as arg1
+ */
+static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
+#elif defined(TARGET_SH4)
+/* SH4 doesn't align register pairs, except for p{read,write}64 */
+static inline int regpairs_aligned(void *cpu_env, int num)
+{
+    switch (num) {
+    case TARGET_NR_pread64:
+    case TARGET_NR_pwrite64:
+        return 1;
+
+    default:
+        return 0;
+    }
+}
+#elif defined(TARGET_XTENSA)
+static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
+#else
+static inline int regpairs_aligned(void *cpu_env, int num) { return 0; }
+#endif
+
 /**
  * preexit_cleanup: housekeeping before the guest exits
  *
diff --git a/linux-user/strace.c b/linux-user/strace.c
index f0624b6206..7dc239b9f1 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1958,6 +1958,53 @@ print_lseek(void *cpu_env, const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_truncate
+static void
+print_truncate(void *cpu_env, const struct syscallname *name,
+               abi_long arg0, abi_long arg1, abi_long arg2,
+               abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_string(arg0, 0);
+    print_raw_param(TARGET_ABI_FMT_ld, arg1, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
+#ifdef TARGET_NR_truncate64
+static void
+print_truncate64(void *cpu_env, const struct syscallname *name,
+                 abi_long arg0, abi_long arg1, abi_long arg2,
+                 abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_string(arg0, 0);
+    if (regpairs_aligned(cpu_env, TARGET_NR_truncate64)) {
+        arg1 = arg2;
+        arg2 = arg3;
+    }
+    print_raw_param("%" PRIu64, target_offset64(arg1, arg2), 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
+#ifdef TARGET_NR_ftruncate64
+static void
+print_ftruncate64(void *cpu_env, const struct syscallname *name,
+                  abi_long arg0, abi_long arg1, abi_long arg2,
+                  abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_raw_param("%d", arg0, 0);
+    if (regpairs_aligned(cpu_env, TARGET_NR_ftruncate64)) {
+        arg1 = arg2;
+        arg2 = arg3;
+    }
+    print_raw_param("%" PRIu64, target_offset64(arg1, arg2), 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #if defined(TARGET_NR_socket)
 static void
 print_socket(void *cpu_env, const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index a04706a524..8e5303d035 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -258,10 +258,10 @@
 { TARGET_NR_ftime, "ftime" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_ftruncate
-{ TARGET_NR_ftruncate, "ftruncate" , NULL, NULL, NULL },
+{ TARGET_NR_ftruncate, "ftruncate" , "%s(%d," TARGET_ABI_FMT_ld ")", NULL, NULL },
 #endif
 #ifdef TARGET_NR_ftruncate64
-{ TARGET_NR_ftruncate64, "ftruncate64" , NULL, NULL, NULL },
+{ TARGET_NR_ftruncate64, "ftruncate64" , NULL, print_ftruncate64, NULL },
 #endif
 #ifdef TARGET_NR_futex
 { TARGET_NR_futex, "futex" , NULL, print_futex, NULL },
@@ -372,7 +372,7 @@
 { TARGET_NR_getrusage, "getrusage" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_getsid
-{ TARGET_NR_getsid, "getsid" , NULL, NULL, NULL },
+{ TARGET_NR_getsid, "getsid" , "%s(%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_getsockname
 { TARGET_NR_getsockname, "getsockname" , NULL, NULL, NULL },
@@ -1535,10 +1535,10 @@
 { TARGET_NR_tkill, "tkill" , NULL, print_tkill, NULL },
 #endif
 #ifdef TARGET_NR_truncate
-{ TARGET_NR_truncate, "truncate" , NULL, NULL, NULL },
+{ TARGET_NR_truncate, "truncate" , NULL, print_truncate, NULL },
 #endif
 #ifdef TARGET_NR_truncate64
-{ TARGET_NR_truncate64, "truncate64" , NULL, NULL, NULL },
+{ TARGET_NR_truncate64, "truncate64" , NULL, print_truncate64, NULL },
 #endif
 #ifdef TARGET_NR_tuxcall
 { TARGET_NR_tuxcall, "tuxcall" , NULL, NULL, NULL },
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index cc76ac61ba..1517096a9b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -501,38 +501,6 @@ static inline int next_free_host_timer(void)
 }
 #endif
 
-/* ARM EABI and MIPS expect 64bit types aligned even on pairs or registers */
-#ifdef TARGET_ARM
-static inline int regpairs_aligned(void *cpu_env, int num)
-{
-    return ((((CPUARMState *)cpu_env)->eabi) == 1) ;
-}
-#elif defined(TARGET_MIPS) && (TARGET_ABI_BITS == 32)
-static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
-#elif defined(TARGET_PPC) && !defined(TARGET_PPC64)
-/* SysV AVI for PPC32 expects 64bit parameters to be passed on odd/even pairs
- * of registers which translates to the same as ARM/MIPS, because we start with
- * r3 as arg1 */
-static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
-#elif defined(TARGET_SH4)
-/* SH4 doesn't align register pairs, except for p{read,write}64 */
-static inline int regpairs_aligned(void *cpu_env, int num)
-{
-    switch (num) {
-    case TARGET_NR_pread64:
-    case TARGET_NR_pwrite64:
-        return 1;
-
-    default:
-        return 0;
-    }
-}
-#elif defined(TARGET_XTENSA)
-static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
-#else
-static inline int regpairs_aligned(void *cpu_env, int num) { return 0; }
-#endif
-
 #define ERRNO_TABLE_SIZE 1200
 
 /* target_to_host_errno_table[] is initialized from
-- 
2.25.1


