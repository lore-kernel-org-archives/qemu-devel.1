Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B65CC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 20:20:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D27292068F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 20:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Eiilo0xl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27292068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXswS-0004v3-OP
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 15:20:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1iXsqw-0002T0-AM
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 15:14:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1iXsqu-0002vA-My
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 15:14:58 -0500
Received: from mout.gmx.net ([212.227.17.22]:46091)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1iXsqu-0002rb-9Q
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 15:14:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1574367292;
 bh=BxGwXue3mx5PYApgJKRMyV68/JlGP3imRypv2WwDmNk=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=Eiilo0xlZXHNq/XYvClxmjI+IiNBOB28OMgICwLBgbyEpazhlJ1c/nIfM9JK0DGkY
 bT6kqurGpkHorPwi/YF+EvC7kWCg2lwLHCJXTz7ZtkbxSEU5fTsOvFG6Sql++OWSgv
 e06cV7zs4hfyQVF89nCn3G84c0z96Om0w2LrJ7oQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.156.18]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTABT-1iPp2p0TGR-00UZYx; Thu, 21
 Nov 2019 21:14:52 +0100
Date: Thu, 21 Nov 2019 21:14:48 +0100
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user: Improve strace output for read() and getcwd()
Message-ID: <20191121201448.GA3133@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Provags-ID: V03:K1:tPlFNFo2P28qNB/B5IiTyW9rV8DlnrIzAEXnaUL4H0H+OCoIeHX
 be3HzR100BXjUr7VjripIo890FT0ma4nvLXjuz5+l4mde9IFAocyQdJm6WKCZ+Vm/PioZ39
 sDgOwbTfRsapC9EFu4oPjTvWTEd5kEpNca1X9GxgVr5iS2mDqMvzwDtjrsFZuxBKpfeum8y
 W5dqCUvQFfIip2MX3RckQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ORX9egcNy2M=:zOW1GB9/sl9RV37tx+rtqc
 6P2tEl6lRv4AKV57JiEAGLrtS6pESd4pAWxI5GM27ahzT9sHtU7aAsjviwzbkokNfSSaNYY9n
 1SNL8bRxkTzXsN+lQfhe/5zpfNdBtEIYi2tDGhJNAWXT3/QvmBMhzo9RVygOcA0xwWJ7C8/3k
 Vt7qpjDHAD7cuOGagFn9to2482bgQ/PghjUbvsfmzygOi3102xThUoNMcoqNtO3dKmb+rY57P
 lOMfqJxJ7Vq/KbTNZ2dbY0W8wr7+d9a/ljdE/3SQqCTc1FhLmDXH3SAhoYLHuniYxu/Vkc9v7
 WUVMyWG0wb9X31NImvUKPIiKUyud1fuMdDL1qgwom6+ZcWk5NNq5Du0HwE5cr/X1r9NFM3O+2
 qQX+TJVPVHHQU4XJXp30mAhDVGNcN0nN8jFcqNv9cBlpsvGMmKkDTpdFasn/t7XZp+HdRPbDC
 jOBVAseHHWf+iWnGJRIPc5djKO9Xgm9MJa8vsF+UqxDmgu4eH134mbcH4L7n/EDsboRuTLxy0
 MFVgnGzRRtHfIwyLS1sOFAdkftTdZUb3iSXCdbMeEfDbf6TH2Zir2WDuiLVCYLlyL8+Xv941R
 DY0/IlX9UxAintswLSxrBQxu1kVCut2qot3LtyNZKBgTHoKiO9QoDPqmcHP+TcwASYrwgJQDy
 iYPSws78miUZzuwfT81NqofA04dVGhTElUijomM4Vn/taY13RHJNeLKHLKzez3wl/sKJ1RIBi
 cbJljO37zSc573YiRV1HNEdy891lavvtymThVLZ18UddaQ9oeIYFGwSXHl5cm8ov1eOVDTde0
 sGlpZ5ZyjtAvSz4TrDuLoBBNuDcdIb3xm6RID1RE4uy9bkD3IpVaZAAtKr9vT/ZRRBA6hAL8T
 UU+z5sFKYvKJS74FK5VX7GGmb4V129NCMHvj5Uo5LdaGZp+E5+TSgwwo8JkQrSG6Xd96LrTmS
 8nDLbHUh2i+9Pr/m9mkYcNJKHW/NTcB4mpYVfQKv3mStCn1wW+lUzeGa4jvA6JWs40uZTFRN5
 ziCG7BhBBpjsOO+G+LwBUkAXeo9LIV6lfO2mWcvsOmP18lnXW/4OjOq70+4i34xLcQ95Hk8ec
 HkWkadMnrGYZ3fIpSDs7ymrsChXTBB3RuAb7V9Wgej8kMFndSfyO9nd6xzJxQCt6ErkoZ1/dh
 xLL0uwBXzoKFcrOFzKd6XSEhZhuVCmJV5MBNNoMW0OwH1aIRmfwaNrFEJTD7GSouAY7s5voeg
 iL63arI3i0NZ2ZtBFY0EbUAFN4w0BvZ/fs+aDig==
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.22
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The strace functionality in qemu-user lacks the possibility to trace
which real values get returned to pointers in userspace by syscalls.

For example, the read() and getcwd() syscalls currently only show the
destination address where the syscalls should put the return values:
2532 read(3,0xff80038c,512) =3D 512
2532 getcwd(0x18180,4096) =3D 9

With the patch below, one now can specify in print_syscall_late() which
syscalls should be executed first, before they get printed.
After adding the read() and getcwd() syscalls, we now get this output in
with strace instead:
1708 read(3,"\177ELF\1\2\1\3\0\0\0\0\0\0\0\0\0\3\0\17\0\0\0\1\0\2bl\0\0\04=
"...,512) =3D 512
1708 getcwd("/usr/bin",4096) =3D 9

This patch adds just the framework with the respective implemenations for
read() and getcwd(). If applied, more functions can be added easily later.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/linux-user/strace.c b/linux-user/strace.c
index de43238fa4..ff254732af 100644
=2D-- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -61,6 +61,7 @@ UNUSED static void print_open_flags(abi_long, int);
 UNUSED static void print_syscall_prologue(const struct syscallname *);
 UNUSED static void print_syscall_epilogue(const struct syscallname *);
 UNUSED static void print_string(abi_long, int);
+UNUSED static void print_encoded_string(abi_long addr, unsigned int maxle=
n, int last);
 UNUSED static void print_buf(abi_long addr, abi_long len, int last);
 UNUSED static void print_raw_param(const char *, abi_long, int);
 UNUSED static void print_timeval(abi_ulong, int);
@@ -1204,6 +1205,37 @@ print_syscall_epilogue(const struct syscallname *sc=
)
     gemu_log(")");
 }

+#define MAX_ENCODED_CHARS 32
+static void
+print_encoded_string(abi_long addr, unsigned int maxlen, int last)
+{
+    unsigned int maxout;
+    char *s, *str;
+
+    s =3D lock_user_string(addr);
+    if (s =3D=3D NULL) {
+        /* can't get string out of it, so print it as pointer */
+        print_pointer(addr, last);
+        return;
+    }
+
+    str =3D s;
+    gemu_log("\"");
+    maxout =3D MIN(maxlen, MAX_ENCODED_CHARS);
+    while (maxout--) {
+        unsigned char c =3D *str++;
+        if (isprint(c)) {
+            gemu_log("%c", c);
+        } else {
+            gemu_log("\\%o", (unsigned int) c);
+        }
+    }
+    unlock_user(s, addr, 0);
+
+    gemu_log("\"%s%s", maxlen > MAX_ENCODED_CHARS ? "..." : "",
+                    get_comma(last));
+}
+
 static void
 print_string(abi_long addr, int last)
 {
@@ -1633,6 +1665,19 @@ print_futimesat(const struct syscallname *name,
 }
 #endif

+#ifdef TARGET_NR_getcwd
+static void
+print_getcwd(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_string(arg0, 0);
+    print_raw_param("%u", arg1, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #ifdef TARGET_NR_settimeofday
 static void
 print_settimeofday(const struct syscallname *name,
@@ -2428,6 +2473,20 @@ print_fstatat64(const struct syscallname *name,
 #define print_newfstatat    print_fstatat64
 #endif

+#ifdef TARGET_NR_read
+static void
+print_read(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_raw_param("%d", arg0, 0);
+    print_encoded_string(arg1, arg2, 0);
+    print_raw_param("%u", arg2, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #ifdef TARGET_NR_readlink
 static void
 print_readlink(const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index d49a1e92a8..220b1f4c46 100644
=2D-- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -272,7 +272,7 @@
 { TARGET_NR_getcpu, "getcpu" , "%s(%p,%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_getcwd
-{ TARGET_NR_getcwd, "getcwd" , "%s(%p,%d)", NULL, NULL },
+{ TARGET_NR_getcwd, "getcwd" , NULL, print_getcwd, NULL },
 #endif
 #ifdef TARGET_NR_getdents
 { TARGET_NR_getdents, "getdents" , NULL, NULL, NULL },
@@ -1080,7 +1080,7 @@
 { TARGET_NR_quotactl, "quotactl" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_read
-{ TARGET_NR_read, "read" , "%s(%d,%#x,%d)", NULL, NULL },
+{ TARGET_NR_read, "read" , NULL, print_read, NULL },
 #endif
 #ifdef TARGET_NR_readahead
 { TARGET_NR_readahead, "readahead" , NULL, NULL, NULL },
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ce399a55f0..c0079ca2b7 100644
=2D-- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12069,6 +12069,21 @@ static abi_long do_syscall1(void *cpu_env, int nu=
m, abi_long arg1,
     return ret;
 }

+/*
+ * True if this syscall should be printed after having called the native
+ * syscall, so that values which are fed back to userspace gets printed.
+ */
+static int print_syscall_late(int syscall)
+{
+    switch (syscall) {
+    case TARGET_NR_getcwd:
+    case TARGET_NR_read:
+        return 1;
+    default:
+        return 0;
+    }
+}
+
 abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                     abi_long arg2, abi_long arg3, abi_long arg4,
                     abi_long arg5, abi_long arg6, abi_long arg7,
@@ -12095,9 +12110,16 @@ abi_long do_syscall(void *cpu_env, int num, abi_l=
ong arg1,
                          arg2, arg3, arg4, arg5, arg6, arg7, arg8);

     if (unlikely(do_strace)) {
-        print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
+        int late_printing;
+        late_printing =3D print_syscall_late(num);
+        if (!late_printing) {
+            print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
+        }
         ret =3D do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
                           arg5, arg6, arg7, arg8);
+        if (late_printing) {
+            print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
+        }
         print_syscall_ret(num, ret);
     } else {
         ret =3D do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,

