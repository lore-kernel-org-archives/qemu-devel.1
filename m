Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D01C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:53:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B85D20776
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="C/9JInd+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B85D20776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl9Da-00023v-H5
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jl9CP-0000lR-AO
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:52:13 -0400
Received: from mail-db8eur05on2129.outbound.protection.outlook.com
 ([40.107.20.129]:5441 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jl9CN-0004s0-89
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:52:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOk3MqQcEpABaxPMPcaN9vmmWuoVunwkFnfgHPC1bfKfh2B32V1e4CRFKOf0F6VzBDh2r8oU5P/+r+lnfwuYgcgsKhC+n2dzU3Yc0azinmkHSu5mKMoV38y1oylWGr5A8HdCITU3p4I9pOkN5H9t45T0nTSZxFi6f3tyaiuliyLOUlrPHHvPUwperOJWS/ua3Kf/kdyR0t+P4mxv/D8fSNgCKh6OyE0bYupgIM8TlK4yEnY5oyyR8BdIsOoA8u8XszW2CsKZ237mFeLc3HOYNAgKmiTIsexD3kMf74gVKOhY+SKrxMJwpvZ4G7RBnILtYnGQ7Mx0XN3CuQvAOz0XQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8x4hiS1Zb1hO9x/gAtTBdtKKMgCNNvgnBskyjEKFHjs=;
 b=nx6fCjj/bEvZV5lkO8A8PLhvRHYUiaBtVX8/I8Hw3bLEz95RrDAGa7eh6Q7XsDmFExTr8DJ/f297Hly205r2BKgCpF0yaBdDwiXEKz/+q3hYTmr3Wki/v7MtoH+aaGRZVii7SDrPxiyr/Y9ljWebKCK17oFhuzXsLx/7wHqyHgjqK2JiMSE2cL7jkk8DLzBxk444gLYSXZOviKaS8b0Qlns6MPcZJJpjmcGTlND6BALrsJEynaPIoT9Mi/djsEpGtYIzTLOkXV+StUV1bKwmCu2/bPQ5cc4H567kzWyo5hHpOhF3bX+eEjDAcZ5pX94ZzfLUHvRgeqlpLGr/ZuP7Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8x4hiS1Zb1hO9x/gAtTBdtKKMgCNNvgnBskyjEKFHjs=;
 b=C/9JInd+X+8wndxL1xQFdFHudd9VaNDeeRmn7Mry4WU+anC0X8ddtmDNQ9GQU3kWVdqfrRmpaP0Rqj1BPlo2APY3dtv1DQs4cgwxeGiOdn1YtH6PytswuJ0QZ01PbSqSXsx6ybCCUjhnyR7qRJuWrGuVYgK0bsnloD0IZIeY36E=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB5014.eurprd03.prod.outlook.com (2603:10a6:20b:87::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Tue, 16 Jun
 2020 10:52:01 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 10:52:01 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] linux-user: Add strace support for printing arguments
 of ioctl()
Date: Tue, 16 Jun 2020 12:51:47 +0200
Message-Id: <20200616105147.21736-3-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616105147.21736-1-filip.bozuta@syrmia.com>
References: <20200616105147.21736-1-filip.bozuta@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::16) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 FR2P281CA0029.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.21 via Frontend Transport; Tue, 16 Jun 2020 10:52:00 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88ab924f-71fb-4bd5-ac39-08d811e34c5a
X-MS-TrafficTypeDiagnostic: AM6PR03MB5014:
X-Microsoft-Antispam-PRVS: <AM6PR03MB5014C49FAAEF255D24BE8020EB9D0@AM6PR03MB5014.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kiERT1oC3vF1WBavcdr6mqFTE/op8NjPc0X2zALesCMknBYCf3UQS5xnh3wXR+etSRbljNKInOxvZLb3RaLUs1hoIK5JNb3+tUcpwYdNQgkiUZmEoM1uUxXFTI9qka7hx7KjSJ2auq02z9fRX2iyn2C+5S7u3uYkVr+p8aLfZIFKj17c3sreJM7Hq0mdaIPwTjGrN3+awoMMGmC//a23djZPmQWrYfc7B9syA4XFqAxFLdeRTs2wS57h+rgUDVqsFfMft4hbZ4IDSZyaHseUdnufmMbDnMR0mECuQHxphZ7oJfxkZVivBf1olkX+WmPQTNETR1MHRf3INcQOlyZOFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(396003)(366004)(39840400004)(376002)(346002)(8676002)(8936002)(2906002)(6486002)(5660300002)(508600001)(4326008)(44832011)(2616005)(956004)(6916009)(66946007)(186003)(66556008)(26005)(16526019)(83380400001)(30864003)(6666004)(66476007)(7696005)(86362001)(316002)(52116002)(36756003)(1076003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: EcUfAYQpTdkY0MO+gTTC0XaqOJI3ENCAPF8xgPsqmjzeRV/R79Y/7kSSPGhy2TkGqMr7zvnXPfm58heK2vcblVVO3BsB0OObxnBFIVHlkckjUYd4nu757gZII0tApuGZ3CWwgSFh9gW6fKnI0ew9R7IpXpMa74nSUO0WIlktXPBzqnuZz29tUJUMThrz74+NCeTyKQk4UbM0YUOswmR/WtvxMaD459AvzSiNwykqQKtFF7P32gVPTDA2u8ZCWeZCg1m0lytujrI3zC0h1CP2rPLgwXZNUbJ55PxP7caZW5HEPKf+vwCPtmeWx16hJcwJD5Dtq4n2+IljxwyHxOlet5KWW/6LiZaY7tAeykPhQ59OSQZd0iawWnCiSLOJLMrt9xspSuMFuus/OEAJXWnSbC7l3LvHbbhEy00yiXRuFBr8/o11rQ1cHFw+2V3FN/KsFk5My3ouJ49RX9KjXyvqJ3Hl7+CsAU3/wZumysFYPhk=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ab924f-71fb-4bd5-ac39-08d811e34c5a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 10:52:01.1123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4H9DY65njno0xibTzErm+Xah6933lcHQphT498u3zKFGmOEPnZOzdWTeiSeW0yZm7otCJUqyqpAXLeVtDsr8gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5014
Received-SPF: pass client-ip=40.107.20.129;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 06:52:00
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

This patch implements functionality for strace argument printing for ioctls.
When running ioctls through qemu with "-strace", they get printed in format:

    "ioctl(fd_num,0x*,0x*) = ret_value"

where the request code an the ioctl's third argument get printed in a hexadicemal
format. This patch changes that by enabling strace to print both the request code
name and the contents of the third argument. For example, when running ioctl
RTC_SET_TIME with "-strace", with changes from this patch, it gets printed in
this way:

    "ioctl(3,RTC_SET_TIME,{12,13,15,20,10,119,0,0,0}) = 0"

In case of IOC_R type ioctls, the contents of the third argument get printed
after the return value, and the argument inside the ioctl call gets printed
as pointer in hexadecimal format. For example, when running RTC_RD_TIME with
"-strace", with changes from this patch, it gets printed in this way:

    "ioctl(3,RTC_RD_TIME,0x40800374) = 0 ({22,9,13,11,5,120,0,0,0})"

In case of IOC_RW type ioctls, the contents of the third argument get printed
both inside the ioctl call and after the return value.

Implementation notes:

    Functions "print_ioctl()" and "print_syscall_ret_ioctl()", that are defined
    in "strace.c", are listed in file "strace.list" as "call" and "result"
    value for ioctl. Structure definition "IOCTLEntry" as well as predefined
    values for IOC_R, IOC_W and IOC_RW were cut and pasted from file "syscall.c"
    to file "qemu.h" so that they can be used by these functions to print the
    contents of the third ioctl argument. Also, the "static" identifier for array
    "ioctl_entries[]" was removed and this array was declared as "extern" in "qemu.h"
    so that it can also be used by these functions. To decode the structure type
    of the ioctl third argument, function "thunk_print()" was defined in file
    "thunk.c" and its definition is somewhat simillar to that of function
    "thunk_convert()".

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Based-on: <20200616103927.20222-1-filip.bozuta@syrmia.com>
---
 include/exec/user/thunk.h |   1 +
 linux-user/qemu.h         |  20 +++++
 linux-user/strace.c       | 107 ++++++++++++++++++++++++++
 linux-user/strace.list    |   3 +-
 linux-user/syscall.c      |  20 +----
 thunk.c                   | 154 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 285 insertions(+), 20 deletions(-)

diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h
index eae2c27f99..7992475c9f 100644
--- a/include/exec/user/thunk.h
+++ b/include/exec/user/thunk.h
@@ -73,6 +73,7 @@ void thunk_register_struct_direct(int id, const char *name,
                                   const StructEntry *se1);
 const argtype *thunk_convert(void *dst, const void *src,
                              const argtype *type_ptr, int to_host);
+const argtype *thunk_print(void *arg, const argtype *type_ptr);
 
 extern StructEntry *struct_entries;
 
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index be67391ba4..5c964389c1 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -184,6 +184,26 @@ struct linux_binprm {
         int (*core_dump)(int, const CPUArchState *); /* coredump routine */
 };
 
+typedef struct IOCTLEntry IOCTLEntry;
+
+typedef abi_long do_ioctl_fn(const IOCTLEntry *ie, uint8_t *buf_temp,
+                             int fd, int cmd, abi_long arg);
+
+struct IOCTLEntry {
+    int target_cmd;
+    unsigned int host_cmd;
+    const char *name;
+    int access;
+    do_ioctl_fn *do_ioctl;
+    const argtype arg_type[5];
+};
+
+extern IOCTLEntry ioctl_entries[];
+
+#define IOC_R 0x0001
+#define IOC_W 0x0002
+#define IOC_RW (IOC_R | IOC_W)
+
 void do_init_thread(struct target_pt_regs *regs, struct image_info *infop);
 abi_ulong loader_build_argptr(int envc, int argc, abi_ulong sp,
                               abi_ulong stringp, int push_ptr);
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 6044c66954..6671711e7b 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -866,6 +866,44 @@ print_syscall_ret_listxattr(const struct syscallname *name, abi_long ret,
 #define print_syscall_ret_flistxattr     print_syscall_ret_listxattr
 #endif
 
+#ifdef TARGET_NR_ioctl
+static void
+print_syscall_ret_ioctl(const struct syscallname *name, abi_long ret,
+                        abi_long arg0, abi_long arg1, abi_long arg2,
+                        abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_err(ret);
+
+    if (ret >= 0) {
+        qemu_log(TARGET_ABI_FMT_ld, ret);
+
+        const IOCTLEntry *ie;
+        const argtype *arg_type;
+        void *argptr;
+        int target_size;
+
+        for (ie = ioctl_entries; ie->target_cmd != 0; ie++) {
+            if (ie->target_cmd == arg1) {
+                break;
+            }
+        }
+
+        if (ie->target_cmd == arg1 &&
+           (ie->access == IOC_R || ie->access == IOC_RW)) {
+            arg_type = ie->arg_type;
+            qemu_log(" (");
+            arg_type++;
+            target_size = thunk_type_size(arg_type, 0);
+            argptr = lock_user(VERIFY_READ, arg2, target_size, 1);
+            thunk_print(argptr, arg_type);
+            unlock_user(argptr, arg2, target_size);
+            qemu_log(")");
+        }
+    }
+    qemu_log("\n");
+}
+#endif
+
 UNUSED static struct flags access_flags[] = {
     FLAG_GENERIC(F_OK),
     FLAG_GENERIC(R_OK),
@@ -3032,6 +3070,75 @@ print_statx(const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_ioctl
+static void
+print_ioctl(const struct syscallname *name,
+            abi_long arg0, abi_long arg1, abi_long arg2,
+            abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_raw_param("%d", arg0, 0);
+
+    const IOCTLEntry *ie;
+    const argtype *arg_type;
+    void *argptr;
+    int target_size;
+
+    for (ie = ioctl_entries; ie->target_cmd != 0; ie++) {
+        if (ie->target_cmd == arg1) {
+            break;
+        }
+    }
+
+    if (ie->target_cmd == 0) {
+        print_raw_param("%#x", arg1, 0);
+        print_raw_param("%#x", arg2, 1);
+    } else {
+        qemu_log("%s", ie->name);
+        arg_type = ie->arg_type;
+
+        if (arg_type[0] != TYPE_NULL) {
+            qemu_log(",");
+
+            switch (arg_type[0]) {
+            case TYPE_PTRVOID:
+                print_pointer(arg2, 1);
+                break;
+            case TYPE_CHAR:
+            case TYPE_SHORT:
+            case TYPE_INT:
+                print_raw_param("%d", arg2, 1);
+                break;
+            case TYPE_LONG:
+                print_raw_param(TARGET_ABI_FMT_ld, arg2, 1);
+                break;
+            case TYPE_ULONG:
+                print_raw_param(TARGET_ABI_FMT_lu, arg2, 1);
+                break;
+            case TYPE_PTR:
+                switch (ie->access) {
+                case IOC_R:
+                    print_pointer(arg2, 1);
+                    break;
+                case IOC_W:
+                case IOC_RW:
+                    arg_type++;
+                    target_size = thunk_type_size(arg_type, 0);
+                    argptr = lock_user(VERIFY_READ, arg2, target_size, 1);
+                    thunk_print(argptr, arg_type);
+                    unlock_user(argptr, arg2, target_size);
+                    break;
+                }
+                break;
+            default:
+                g_assert_not_reached();
+            }
+        }
+    }
+    print_syscall_epilogue(name);
+}
+#endif
+
 /*
  * An array of all of the syscalls we know about
  */
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 10e3e4a814..2dd2c9df42 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -433,7 +433,8 @@
 { TARGET_NR_io_cancel, "io_cancel" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_ioctl
-{ TARGET_NR_ioctl, "ioctl" , "%s(%d,%#x,%#x)", NULL, NULL },
+{ TARGET_NR_ioctl, "ioctl" , NULL, print_ioctl,
+                   print_syscall_ret_ioctl},
 #endif
 #ifdef TARGET_NR_io_destroy
 { TARGET_NR_io_destroy, "io_destroy" , NULL, NULL, NULL },
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 7cc5a65b4f..007febed08 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4478,24 +4478,6 @@ STRUCT_MAX
 #undef STRUCT
 #undef STRUCT_SPECIAL
 
-typedef struct IOCTLEntry IOCTLEntry;
-
-typedef abi_long do_ioctl_fn(const IOCTLEntry *ie, uint8_t *buf_temp,
-                             int fd, int cmd, abi_long arg);
-
-struct IOCTLEntry {
-    int target_cmd;
-    unsigned int host_cmd;
-    const char *name;
-    int access;
-    do_ioctl_fn *do_ioctl;
-    const argtype arg_type[5];
-};
-
-#define IOC_R 0x0001
-#define IOC_W 0x0002
-#define IOC_RW (IOC_R | IOC_W)
-
 #define MAX_STRUCT_SIZE 4096
 
 #ifdef CONFIG_FIEMAP
@@ -5276,7 +5258,7 @@ static abi_long do_ioctl_tiocgptpeer(const IOCTLEntry *ie, uint8_t *buf_temp,
 }
 #endif
 
-static IOCTLEntry ioctl_entries[] = {
+IOCTLEntry ioctl_entries[] = {
 #define IOCTL(cmd, access, ...) \
     { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
 #define IOCTL_SPECIAL(cmd, access, dofn, ...)                      \
diff --git a/thunk.c b/thunk.c
index 7f31cffe09..992a19b1c9 100644
--- a/thunk.c
+++ b/thunk.c
@@ -271,6 +271,160 @@ const argtype *thunk_convert(void *dst, const void *src,
     return type_ptr;
 }
 
+const argtype *thunk_print(void *arg, const argtype *type_ptr)
+{
+    int type;
+
+    type = *type_ptr++;
+
+    switch (type) {
+    case TYPE_CHAR:
+        qemu_log("%c", *(uint8_t *)arg);
+        break;
+    case TYPE_SHORT:
+        qemu_log("%" PRId16, tswap16(*(uint16_t *)arg));
+        break;
+    case TYPE_INT:
+        qemu_log("%" PRId32, tswap32(*(uint32_t *)arg));
+        break;
+    case TYPE_LONGLONG:
+        qemu_log("%" PRId64, tswap64(*(uint64_t *)arg));
+        break;
+    case TYPE_ULONGLONG:
+        qemu_log("%" PRIu64, tswap64(*(uint64_t *)arg));
+        break;
+#if HOST_LONG_BITS == 32 && TARGET_ABI_BITS == 32
+    case TYPE_PTRVOID:
+        qemu_log("0x%" PRIx32, tswap32(*(uint32_t *)arg));
+        break;
+    case TYPE_LONG:
+        qemu_log("%" PRId32, tswap32(*(uint32_t *)arg));
+        break;
+    case TYPE_ULONG:
+        qemu_log("%" PRIu32, tswap32(*(uint32_t *))arg);
+        break;
+#elif HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 32
+    case TYPE_PTRVOID:
+        qemu_log("0x%" PRIx32, tswap32(*(uint64_t *)arg & 0xffffffff));
+        break;
+    case TYPE_LONG:
+        qemu_log("%" PRId32, tswap32(*(uint64_t *)arg & 0xffffffff));
+        break;
+    case TYPE_ULONG:
+        qemu_log("%" PRIu32, tswap32(*(uint64_t *)arg & 0xffffffff));
+        break;
+#elif HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 64
+    case TYPE_PTRVOID:
+        qemu_log("0x%" PRIx64, tswap64(*(uint64_t *)arg));
+        break;
+    case TYPE_LONG:
+        qemu_log("%" PRId64, tswap64(*(uint64_t *)arg));
+        break;
+    case TYPE_ULONG:
+        qemu_log("%" PRIu64, tswap64(*(uint64_t *)arg));
+        break;
+#else
+    case TYPE_PTRVOID:
+        qemu_log("0x%" PRIx64, tswap64(*(uint64_t *)arg));
+        break;
+    case TYPE_LONG:
+        qemu_log("%" PRId64, tswap64(*(uint64_t *)arg));
+        break;
+    case TYPE_ULONG:
+        qemu_log("%" PRIu64, tswap64(*(uint64_t *)arg));
+        break;
+#endif
+    case TYPE_OLDDEVT:
+    {
+        uint64_t val = 0;
+        switch (thunk_type_size(type_ptr - 1, 1)) {
+        case 2:
+            val = *(uint16_t *)arg;
+            break;
+        case 4:
+            val = *(uint32_t *)arg;
+            break;
+        case 8:
+            val = *(uint64_t *)arg;
+            break;
+        }
+        switch (thunk_type_size(type_ptr - 1, 0)) {
+        case 2:
+            qemu_log("%" PRIu16, tswap16(val));
+            break;
+        case 4:
+            qemu_log("%" PRIu32, tswap32(val));
+            break;
+        case 8:
+            qemu_log("%" PRIu64, tswap64(val));
+            break;
+        }
+    }
+    break;
+    case TYPE_ARRAY:
+        {
+            int i, array_length, arg_size;
+            uint8_t *a;
+            int is_string = 0;
+
+            array_length = *type_ptr++;
+            arg_size = thunk_type_size(type_ptr, 0);
+            a = arg;
+
+            if (*type_ptr == TYPE_CHAR) {
+                qemu_log("\"");
+                is_string = 1;
+            } else {
+                qemu_log("[");
+            }
+
+            for (i = 0; i < array_length; i++) {
+                if (i > 0 && !is_string) {
+                    qemu_log(",");
+                }
+                thunk_print(a, type_ptr);
+                a += arg_size;
+            }
+
+            if (is_string) {
+                qemu_log("\"");
+            } else {
+                qemu_log("]");
+            }
+
+            type_ptr = thunk_type_next(type_ptr);
+        }
+        break;
+    case TYPE_STRUCT:
+        {
+            int i;
+            const StructEntry *se;
+            uint8_t  *a;
+            const argtype *field_types;
+            const int *arg_offsets;
+
+            se = struct_entries + *type_ptr++;
+            a = arg;
+
+            field_types = se->field_types;
+            arg_offsets = se->field_offsets[0];
+
+            qemu_log("{");
+            for (i = 0; i < se->nb_fields; i++) {
+                if (i > 0) {
+                    qemu_log(",");
+                }
+                field_types = thunk_print(a + arg_offsets[i], field_types);
+            }
+            qemu_log("}");
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return type_ptr;
+}
+
 /* from em86 */
 
 /* Utility function: Table-driven functions to translate bitmasks
-- 
2.17.1


