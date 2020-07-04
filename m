Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1549C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:35:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62F9520723
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F9520723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrl8v-00045E-L6
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 12:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jrkza-0005Y9-7H
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:26:18 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:51375)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jrkzV-0002QW-Da
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:26:17 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N6bo8-1kzVP223vq-0180Sl; Sat, 04 Jul 2020 18:26:02 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 11/12] linux-user: Add strace support for printing arguments of
 ioctl()
Date: Sat,  4 Jul 2020 18:25:44 +0200
Message-Id: <20200704162545.311133-12-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704162545.311133-1-laurent@vivier.eu>
References: <20200704162545.311133-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3jdLZ4I29TuXL7Hg0KMy9NfjIrXvdUxJ6Tr1OzjUxCT4M5ViJae
 IbNHAbWSm86VJoh99q2f6w8MXYFP6a8DmZR58apKJUHgSQXzc4r9JbGKXGcGfv3decWzCDl
 +W07cfND+6Ufx6Mn10C6/aQ8KjTD6axSDjyFPmRkkPe1I4Tas7ULYi4MUKztYsWZmoI5d2r
 /79q29a6EN3YMVAW8vYNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0z1CpmjPsDU=:eL0tPhuxd2NpB/kGUgFN0y
 D6u2B0bVLGNjjgaLgWYxvXDs2AkcXB1FrRUdt+9gud1LFdraWCnlvYB6zz55S9r7YiSOHTR5k
 JtoHwaSZKR4l5FlGP0QX3jDHo9LlHPCkDpGE5ji1ljfTf1i0C7x2iMqCKnpa/7FwPoZITGqNK
 XAkDMH94d7n0+xq4ohgiQ29trX3FInsQ9IULlZXGPW02nTVOoSuO4ecBll1ugMx5sEN8LA6VF
 lvXOpSv1ty5AL2EtyjyxxrzFYhN9TkVcdf/LThEKv0HGcfuX0CflQUZ0sq1giZzRbD2xAd0ZW
 UpNDaKU7vgToiUTZ3pRc7f1GM3h9jjLTaFQUCDyviwF4TPFdzYwNcod6VShnrp1zRmcjaFQQC
 XEt8mxW2ODz2Gv+N+LM79hh08NyTntPkbUqH+bSJNv+cEFe5/BEdh9OovowA6Z7eY/VJ4iBQM
 JqrACWMOIaU0OVm987uQ1fWqKj5S8/aYHI0LJONJdNESp8O4pi6X6zNem3eJJepG77dNURlpK
 b19VfU+7Rl6esywHWptEjb2PN8nVoQ6fiDub4LmLO2Gx3ks2ItRSJXoRvXOwh2NHdhRY0XsZf
 DD/Gr7GNF/Trn0NW4fHra5xEFs6oN4SsznYafCBCgqama/hR0/6ComR4/I0/34FHvLfo+bbCb
 FVdQNs+ik5uIzZArQF2vzt/vHfu1pEAcQ5yWhTjauwQLoN4W78Xzs34q2ibq3ZeIYzq+k9Ql/
 HZYLuv1YlBa79AWWaJ/NtbZjVyHfhmWSsFge+fL9xGZX3X1soG6MU1J4rtcsFTSO4qomVxsET
 FSKVIlwo8+EjU2Nwc7aDSYLOwlmBCUWZpx+PvJuixT8245kvrs=
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 12:26:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: Filip Bozuta <Filip.Bozuta@syrmia.com>, Riku Voipio <riku.voipio@iki.fi>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Artyom Tarasenko <atar4qemu@gmail.com>
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
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200619124727.18080-3-filip.bozuta@syrmia.com>
[lv: fix close-bracket]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/exec/user/thunk.h |   1 +
 linux-user/qemu.h         |  20 +++++
 linux-user/strace.c       | 107 ++++++++++++++++++++++++++
 linux-user/strace.list    |   3 +-
 linux-user/syscall.c      |  20 +----
 thunk.c                   | 154 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 285 insertions(+), 20 deletions(-)

diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h
index eae2c27f99da..7992475c9f8a 100644
--- a/include/exec/user/thunk.h
+++ b/include/exec/user/thunk.h
@@ -73,6 +73,7 @@ void thunk_register_struct_direct(int id, const char *name,
                                   const StructEntry *se1);
 const argtype *thunk_convert(void *dst, const void *src,
                              const argtype *type_ptr, int to_host);
+const argtype *thunk_print(void *arg, const argtype *type_ptr);
 
 extern StructEntry *struct_entries;
 
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index be67391ba49d..5c964389c101 100644
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
index 32e5e987acbb..5235b2260cdd 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -860,6 +860,44 @@ print_syscall_ret_listxattr(const struct syscallname *name, abi_long ret,
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
@@ -3026,6 +3064,75 @@ print_statx(const struct syscallname *name,
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
index ebb713252ce3..a04706a524ae 100644
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
index 506b94a12c1e..82afadcea0e2 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4481,24 +4481,6 @@ STRUCT_MAX
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
@@ -5374,7 +5356,7 @@ static abi_long do_ioctl_drm(const IOCTLEntry *ie, uint8_t *buf_temp,
 
 #endif
 
-static IOCTLEntry ioctl_entries[] = {
+IOCTLEntry ioctl_entries[] = {
 #define IOCTL(cmd, access, ...) \
     { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
 #define IOCTL_SPECIAL(cmd, access, dofn, ...)                      \
diff --git a/thunk.c b/thunk.c
index 7f31cffe0968..c5d971974783 100644
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
+        qemu_log("%" PRIu32, tswap32(*(uint32_t *)arg));
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
2.26.2


