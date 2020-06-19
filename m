Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A89C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:35:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E36D206F7
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="qhCfNX35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E36D206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmGEk-0000gz-6j
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 08:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jmGDh-00077a-3G
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:34:09 -0400
Received: from mail-eopbgr00110.outbound.protection.outlook.com
 ([40.107.0.110]:51142 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jmGDa-0003z4-Tc
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:34:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbz768SqelfO0L8iKF1oi+rAF3PypcoolNPtPtd1tnfQyrAEZG4zNtVIEE7u45w+peFUlMDd9ly6xO7Tid1uh4V5/tsIjZDRR1iOhR5K0N3AQ9HzI+md67q6niKOMTGcv6dJX7Zuyor/W55mtoz9JhJ4KID8dOFytXBtQq1kBX98GDbK/OfZX44bSS03IqKmozd0q3pyKHf9XM5JeixOb3zjkafPcF2UQ3QEks2xYReE+R/sJW15m/gPLgOAbfHzT9kP5h8CF4v7rDyXi+tAcNa9fUls/0Mr0HOnDeO8y7eq2E3KRSp3nOcnkP15xEOkiecGK/qB8VWVQTqrCSiBqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgnL2oQB81o4/gj0ijnO5s82h39gdQ2kcQNlxdyzD60=;
 b=E2qpcR5gsE1VxhzsJg3F2zfOY2a5IAmfE4/Y9n3v0j2jTkYPfWwoAOK/Pxcpr6cqjGZj3J6rOIU62xnZE6oxVka/mQojh56JuZnAqunrhgGRo8IVppilbEWopLUWZjAGGtVVBAsCAXerJRi474Q+TiURqXNT9/4Hv/1MY6jLtvvRjinTdYwqtFnm5cpTGyFOi3B7POPUp1ZWlQiKulbaLu7OyNMoY3Aq+0S0eoCubxxISkkxXacYQGk7VXx/MKis5XNhZOBTdBM1oCKBQnoCzuwk37YDBUzYKzJjB+E7P6s1jgZLrUYAI31z0r+2sbp+V58s5jVbMUbItQcXmUxcIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgnL2oQB81o4/gj0ijnO5s82h39gdQ2kcQNlxdyzD60=;
 b=qhCfNX35+sYsKG84X5XUEij/POuvSrVR0BDgqzy7Q/P/F4b0e7fofqmkipmaoiPrZbG7PXjbph0SXsKnfA/3gQ7YWU1REF+H7WTBTBEw65yevlpEYga0lHO7JPLgpAkriVnc5n2hNPypLOA9ibFFODpnInN103HLP3LFQpNNgIM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB5315.eurprd03.prod.outlook.com (2603:10a6:20b:d1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 12:33:46 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3109.023; Fri, 19 Jun 2020
 12:33:46 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 3/6] linux-user: Add strace support for printing argument
 of syscalls used for extended attributes
Date: Fri, 19 Jun 2020 14:33:28 +0200
Message-Id: <20200619123331.17387-4-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619123331.17387-1-filip.bozuta@syrmia.com>
References: <20200619123331.17387-1-filip.bozuta@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0023.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::10) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 ZR0P278CA0023.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21 via Frontend Transport; Fri, 19 Jun 2020 12:33:45 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3a8ce14-7317-4495-e093-08d8144d0282
X-MS-TrafficTypeDiagnostic: AM6PR03MB5315:
X-Microsoft-Antispam-PRVS: <AM6PR03MB53150FB98442CAD2FBB26586EB980@AM6PR03MB5315.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qgAXPIg68TKSny9HMj2KaTQNKBKqIzyOpFNWY7147m8+nnPo3v4bqdvxBF9wDV6N5xr12QeZNjtyFYRLrA3uvdwn+djMc0sZOmRDeBpS6GBG1rKGHf8b3yGSDPX9ECpQ3iZ/fswZE2lVHAhHv/m/GO3dM0BQiIQpwCb6iFJwwgDNMzrJk94iNkng4Nz4oaaMLp40pNMw2agJQ9rb06KQFXZ0AcBOqgTCpq1wNnfn44TqhYcglpyiYUCI7yjOnBj8uoaOdKLngvvkrPrvQJ8wzv7sHpC0vMrcejAu0gaS57eHLw2Fs6w/MemNf/LnT5b2Z7eRaWNhDtqqb2bmJOuJ6VJGGF9h3srKL2xfMHH6KAlS2kIjNPqvGurXVo6kOiAoslvUTjje+munLJs3WRI42vFe7vIBOGVP/OydwDn6NsQqhnyNw/O++XBbC0ZsFiEWTC4IkVeJwGU37iPV6zK9gA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(366004)(376002)(136003)(39830400003)(396003)(7696005)(52116002)(4326008)(186003)(36756003)(6916009)(2616005)(26005)(16526019)(66946007)(66476007)(316002)(956004)(66556008)(1076003)(83380400001)(2906002)(508600001)(6486002)(966005)(5660300002)(6666004)(8936002)(86362001)(44832011)(8676002)(334744003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Fy2GuUUarXFTNrslOd8mVPkcTyx0AiAfNTJX8p5MtGW3NzEoYYTUQSdGZf8hwBwCalXhA3rA5+X/SO4xQhYMYiSqCxLabllI83o078J4HHgPRhPkRXDpgtdLemoZaSdPj+uUzZfC95mvyHEJnoonG4cxBVXGuICkXvnuuVeI6MUxdKtT6ZPxCvRjORtxDLw6CBP50iiagt4MlzLQ6cIMW0aIYy20CaJ3q9bbt6Qz+mBcxA9tZRvUIQm49ncHv6seLmrJpeFTEnZuTkM6XXy6CRLCLWEFHzYWoCrCtkULwRri4CsZzsanVYPLqLKx/jy7V5rtnTpvsDSpNIPLnKRjYpPo5nduESCv+T4apuOEmwoggYxWe41wdUSDVmMnOb3oYLxHJ9kq6eFx8KoVaNJnOJiSHTnWpQKqRW1spyFf3DuZNn3wzsaK14mmGqPJ1seRKxljsOv/LGI1jLdfqPydcLjwY/PUZCq8ovAKVVha3ec=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a8ce14-7317-4495-e093-08d8144d0282
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 12:33:46.1733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRhS9xBxJ++P/i+N+XdkMSF1IAqdZwGzeWmXyJIHtUlcE+G5NEAucqT/VNQmXMUHSR7GSVPbadKiFa6ezgYmcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5315
Received-SPF: pass client-ip=40.107.0.110;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 08:33:52
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
Cc: riku.voipio@iki.fi, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

This patch implements strace argument printing functionality for following syscalls:

    *getxattr, lgetxattr, fgetxattr - retrieve an extended attribute value

        ssize_t getxattr(const char *path, const char *name, void *value, size_t size)
        ssize_t lgetxattr(const char *path, const char *name, void *value, size_t size)
        ssize_t fgetxattr(int fd, const char *name, void *value, size_t size)
        man page: https://www.man7.org/linux/man-pages/man2/getxattr.2.html

    *listxattr, llistxattr, flistxattr - list extended attribute names

        ssize_t listxattr(const char *path, char *list, size_t size)
        ssize_t llistxattr(const char *path, char *list, size_t size)
        ssize_t flistxattr(int fd, char *list, size_t size)
        man page: https://www.man7.org/linux/man-pages/man2/listxattr.2.html

    *removexattr, lremovexattr, fremovexattr - remove an extended attribute

         int removexattr(const char *path, const char *name)
         int lremovexattr(const char *path, const char *name)
         int fremovexattr(int fd, const char *name)
         man page: https://www.man7.org/linux/man-pages/man2/removexattr.2.html

Implementation notes:

    All of the syscalls have strings as argument types and thus a separate
    printing function was stated in file "strace.list" for every one of them.
    All of these printing functions were defined in "strace.c" using existing
    printing functions for appropriate argument types:
       "print_string()" - for (const char*) type
       "print_pointer()" - for (char*) and (void *) type
       "print_raw_param()" for (int) and (size_t) type
    Syscalls "getxattr()" and "lgetxattr()" have the same number and type of
    arguments and thus their print functions ("print_getxattr", "print_lgetxattr")
    share a same definition. The same statement applies to syscalls "listxattr()"
    and "llistxattr()".
    Function "print_syscall_ret_listxattr()" was added to print the returned list
    of extended attributes for syscalls "print_listxattr(), print_llistxattr() and
    print_flistxattr()".

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/strace.c    | 121 +++++++++++++++++++++++++++++++++++++++++
 linux-user/strace.list |  21 ++++---
 2 files changed, 133 insertions(+), 9 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 123e022c35..760020132b 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -826,6 +826,40 @@ print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret,
 }
 #endif
 
+#if defined(TARGET_NR_listxattr) || defined(TARGET_NR_llistxattr) \
+ || defined(TARGGET_NR_flistxattr)
+static void
+print_syscall_ret_listxattr(const struct syscallname *name, abi_long ret,
+                            abi_long arg0, abi_long arg1, abi_long arg2,
+                            abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_err(ret);
+
+    if (ret >= 0) {
+        qemu_log(TARGET_ABI_FMT_ld, ret);
+        qemu_log(" (list = ");
+        if (arg1 != 0) {
+            abi_long attr = arg1;
+            while (ret) {
+                if (attr != arg1) {
+                    qemu_log(",");
+                }
+                print_string(attr, 1);
+                ret -= target_strlen(attr) + 1;
+                attr += target_strlen(attr) + 1;
+            }
+        } else {
+            qemu_log("NULL");
+        }
+        qemu_log(")");
+    }
+
+    qemu_log("\n");
+}
+#define print_syscall_ret_llistxattr     print_syscall_ret_listxattr
+#define print_syscall_ret_flistxattr     print_syscall_ret_listxattr
+#endif
+
 UNUSED static struct flags access_flags[] = {
     FLAG_GENERIC(F_OK),
     FLAG_GENERIC(R_OK),
@@ -1633,6 +1667,93 @@ print_fcntl(const struct syscallname *name,
 #define print_fcntl64   print_fcntl
 #endif
 
+#ifdef TARGET_NR_fgetxattr
+static void
+print_fgetxattr(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_raw_param("%d", arg0, 0);
+    print_string(arg1, 0);
+    print_pointer(arg2, 0);
+    print_raw_param(TARGET_FMT_lu, arg3, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
+#ifdef TARGET_NR_flistxattr
+static void
+print_flistxattr(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_raw_param("%d", arg0, 0);
+    print_pointer(arg1, 0);
+    print_raw_param(TARGET_FMT_lu, arg2, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
+#if defined(TARGET_NR_getxattr) || defined(TARGET_NR_lgetxattr)
+static void
+print_getxattr(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_string(arg0, 0);
+    print_string(arg1, 0);
+    print_pointer(arg2, 0);
+    print_raw_param(TARGET_FMT_lu, arg3, 1);
+    print_syscall_epilogue(name);
+}
+#define print_lgetxattr     print_getxattr
+#endif
+
+#if defined(TARGET_NR_listxattr) || defined(TARGET_NR_llistxattr)
+static void
+print_listxattr(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_string(arg0, 0);
+    print_pointer(arg1, 0);
+    print_raw_param(TARGET_FMT_lu, arg2, 1);
+    print_syscall_epilogue(name);
+}
+#define print_llistxattr     print_listxattr
+#endif
+
+#if defined(TARGET_NR_fremovexattr)
+static void
+print_fremovexattr(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_raw_param("%d", arg0, 0);
+    print_string(arg1, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
+#if defined(TARGET_NR_removexattr) || defined(TARGET_NR_lremovexattr)
+static void
+print_removexattr(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_string(arg0, 0);
+    print_string(arg1, 1);
+    print_syscall_epilogue(name);
+}
+#define print_lremovexattr     print_removexattr
+#endif
+
 #ifdef TARGET_NR_futimesat
 static void
 print_futimesat(const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index fb9799e7e6..af12b23276 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -218,13 +218,14 @@
 { TARGET_NR_fdatasync, "fdatasync" , "%s(%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_fgetxattr
-{ TARGET_NR_fgetxattr, "fgetxattr" , NULL, NULL, NULL },
+{ TARGET_NR_fgetxattr, "fgetxattr" , NULL, print_fgetxattr, NULL },
 #endif
 #ifdef TARGET_NR_finit_module
 { TARGET_NR_finit_module, "finit_module" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_flistxattr
-{ TARGET_NR_flistxattr, "flistxattr" , NULL, NULL, NULL },
+{ TARGET_NR_flistxattr, "flistxattr" , NULL, print_flistxattr,
+                        print_syscall_ret_flistxattr},
 #endif
 #ifdef TARGET_NR_flock
 { TARGET_NR_flock, "flock" , NULL, NULL, NULL },
@@ -233,7 +234,7 @@
 { TARGET_NR_fork, "fork" , "%s()", NULL, NULL },
 #endif
 #ifdef TARGET_NR_fremovexattr
-{ TARGET_NR_fremovexattr, "fremovexattr" , NULL, NULL, NULL },
+{ TARGET_NR_fremovexattr, "fremovexattr" , NULL, print_fremovexattr, NULL },
 #endif
 #ifdef TARGET_NR_fsetxattr
 { TARGET_NR_fsetxattr, "fsetxattr" , NULL, NULL, NULL },
@@ -396,7 +397,7 @@
 { TARGET_NR_getuid32, "getuid32" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_getxattr
-{ TARGET_NR_getxattr, "getxattr" , NULL, NULL, NULL },
+{ TARGET_NR_getxattr, "getxattr" , NULL, print_getxattr, NULL },
 #endif
 #ifdef TARGET_NR_getxgid
 { TARGET_NR_getxgid, "getxgid" , NULL, NULL, NULL },
@@ -480,7 +481,7 @@
 { TARGET_NR_lchown32, "lchown32" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_lgetxattr
-{ TARGET_NR_lgetxattr, "lgetxattr" , NULL, NULL, NULL },
+{ TARGET_NR_lgetxattr, "lgetxattr" , NULL, print_lgetxattr, NULL },
 #endif
 #ifdef TARGET_NR_link
 { TARGET_NR_link, "link" , NULL, print_link, NULL },
@@ -495,10 +496,12 @@
 { TARGET_NR_listen, "listen" , "%s(%d,%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_listxattr
-{ TARGET_NR_listxattr, "listxattr" , NULL, NULL, NULL },
+{ TARGET_NR_listxattr, "listxattr" , NULL, print_listxattr,
+                       print_syscall_ret_listxattr},
 #endif
 #ifdef TARGET_NR_llistxattr
-{ TARGET_NR_llistxattr, "llistxattr" , NULL, NULL, NULL },
+{ TARGET_NR_llistxattr, "llistxattr" , NULL, print_llistxattr,
+                        print_syscall_ret_llistxattr},
 #endif
 #ifdef TARGET_NR__llseek
 { TARGET_NR__llseek, "_llseek" , NULL, print__llseek, NULL },
@@ -510,7 +513,7 @@
 { TARGET_NR_lookup_dcookie, "lookup_dcookie" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_lremovexattr
-{ TARGET_NR_lremovexattr, "lremovexattr" , NULL, NULL, NULL },
+{ TARGET_NR_lremovexattr, "lremovexattr" , NULL, print_lremovexattr, NULL },
 #endif
 #ifdef TARGET_NR_lseek
 { TARGET_NR_lseek, "lseek" , NULL, NULL, NULL },
@@ -1116,7 +1119,7 @@
 { TARGET_NR_remap_file_pages, "remap_file_pages" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_removexattr
-{ TARGET_NR_removexattr, "removexattr" , NULL, NULL, NULL },
+{ TARGET_NR_removexattr, "removexattr" , NULL, print_removexattr, NULL },
 #endif
 #ifdef TARGET_NR_rename
 { TARGET_NR_rename, "rename" , NULL, print_rename, NULL },
-- 
2.17.1


