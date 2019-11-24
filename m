Return-Path: <SRS0=aI0a=ZQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFD2C432C0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 12:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C1B02067D
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 12:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="N1jYCojq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1B02067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYqgO-0001Cz-E9
	for qemu-devel@archiver.kernel.org; Sun, 24 Nov 2019 07:08:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1iYqVi-00060a-FH
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 06:57:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1iYqVg-0008B6-S0
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 06:57:02 -0500
Received: from mout.gmx.net ([212.227.15.19]:53101)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1iYqVg-0008Ai-HM
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 06:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1574596618;
 bh=ZyL1b42Yaf5LhdiEtBQI0X4PkkGsWWYDCJsEADffJZc=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=N1jYCojqAUDMRpoSI39ERg05pjhV9ngY7fL4GXWnlps1qSjWLJ7/av3KeBm/ESoP6
 VH40ZlQVsS80B7aRyybR8N9A3BkP5yml1BIoYiUz3ydZXn2AhyaT1dPuNdFT/NrS9i
 0HoqyXJQW6+5d/kUrtf8q3JTmOUkgX2nAR0SvWiw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.140.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7R1T-1hlekR2QF3-017jlC; Sun, 24
 Nov 2019 12:56:58 +0100
Date: Sun, 24 Nov 2019 12:56:56 +0100
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] linux-user/strace: Improve strace output for read() and
 getcwd()
Message-ID: <20191124115656.GA23850@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Provags-ID: V03:K1:sG3b5ajc2St3LGTd9jPbAQNLSyn35hAwDUZn3o/Mcz59DluQFpt
 o7uIcKB+XbmGVYINdvbOxqS49jJrIbGwOgDijqE/XAQOdxbR/9lpLKasahNQZ9eTwhBWnh7
 WKFzjJDCQEDQH2qP3dixFsXpNhvoouo2TYcAnSk2Dw5p73fvK88mnPG6jhrOZX4NV7YyFtH
 igN3keHJMAFb+wBem9jWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LkZoogdD6NU=:X8GHrzDGiYrFIa3zCshePg
 nXkgOOsBkmXCTEYhwOYN7vIfIjmBM+frgg/jVF5Lxmd13DL64fBwwTFBW6zD448Nqg8SPEjfx
 wGedMCOr6Bi6pdkrJM7T1q3+gvLGcEGcXqVpyiKrXUVU9ml9hJH1Fn9s1ZtYABc89bqhcdibq
 tENPnROPJkXcARaEpJ1KEVjWbW22SOEz/l1t7DEVg/fbZtwiNp2e+zTtDKwDPUKai8/rexLJ+
 6tFf6sDGEKeM0urbepbCJPZgAJoHyBs4mdZLXu9d2xHCOmp9TzZnGQr8uQFUaU8xTr0BrMIL4
 ViLG8YhmjlHyy/Ku92O9Eg5wSBOqhGyqRoZyPRTRnHNJJDGi33FG496NszglseNCCEHq+/hfB
 OqXZe63RA1l+kv6lmKmjy+rz32t5hjxCvYqrxV8rXChAlbI50iV8qk9G6xU6jmnE2Hw4LvJqL
 BJcImgz5aj4c8xKtG/N+yXHplKu+nIgtutJpAg1CVFAAciC0f0X3yCNj9To//LsAfcL442sgZ
 MYSYN/9lrojDTnRQzxcpmqnXG4eMoNoGJXcsfDXvoESLhSNa9ihOoou9Ys2Xm+blXqGvf1jaf
 3JWougfPlNhtIdje6Q4dWOZTtfDh+r1J90+6d5SNkcjYran3KGWV5OfG5+LMK5wjYADqAfydT
 Mvo2Tc1/C5r4ohoWOu0ajkylgQDXp2KddTySzjex7YM7KtfDmteWwV7jraDdvPuLrsdPH3bbr
 hiL4WDAJW5henmXRY4NgNmG9JedvKKmwOE94QdsUoZftGPh61tchvCiQPhTIJL+z5+BZCshmT
 aJJ7tzDC1BgRD3yB1OJ+f3NWoCVqDke4UxothvOfsbZ2Sce9qvehdoJP/UncwdAs2m5CZjbSv
 XFbcY2StwO4NIbjY2y08JP0c2ae5pZr6eFBPwoKShOhgb4SqRJQ/s3x+ztEjqnFCbHun9LNz4
 EhtvMpELYIlQRRSKwsoB0ZupP2YEVIcKkCojby4gxeOh85Xyd/Ts9OFA6nVu4zPSJO37Zws4p
 For8Kswv80glC8e3oBV+xQ6svAJhbTw+oiQTJNBFGuInOAQFKLq3iNcyDS7qqWMcImAQBYTMC
 qM8iJs+DnCWkStR0kKQ342aTlgSm/IjgVeAd/iu24bQO4S545tJSSnkIt7oqs6X2MPJGRBv3K
 6MvRxIHzLn0xjmZE3qAiZsfaGx2Mn8/dFlXp4FrdDdkOo/0fP7nH1TA3c0vS+BNFmyC8a+SNZ
 tTHuSVB0ai4o08Y++gS+QKZLY43CPkDPXWVdxew==
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.19
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
Cc: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
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
=2D--
Changes v2 to v1:
- Print syscall name, e.g. "read(" before calling the syscall. In case of
  crash people will then be able to see that it crashed in this "late" cal=
l.
  Based on feedback by Aleksandar Markovic <aleksandar.m.mail@gmail.com>


diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index f6f5fe5fbb..65557660a9 100644
=2D-- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -371,6 +371,10 @@ extern long safe_syscall_base(int *pending, long numb=
er, ...);
 int host_to_target_waitstatus(int status);

 /* strace.c */
+const struct syscallname *print_syscall_prologue_num(int num);
+void print_syscall_late(const struct syscallname *sc,
+              abi_long arg1, abi_long arg2, abi_long arg3,
+              abi_long arg4, abi_long arg5, abi_long arg6);
 void print_syscall(int num,
                    abi_long arg1, abi_long arg2, abi_long arg3,
                    abi_long arg4, abi_long arg5, abi_long arg6);
diff --git a/linux-user/strace.c b/linux-user/strace.c
index de43238fa4..dc963accd5 100644
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
@@ -1196,6 +1197,26 @@ print_syscall_prologue(const struct syscallname *sc=
)
     gemu_log("%s(", sc->name);
 }

+void
+print_syscall_late(const struct syscallname *sc,
+              abi_long arg1, abi_long arg2, abi_long arg3,
+              abi_long arg4, abi_long arg5, abi_long arg6)
+{
+    const char *format =3D TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld ","
+                    TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld ","
+                    TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld ")";
+
+    if (sc->call !=3D NULL) {
+        sc->call(sc, arg1, arg2, arg3, arg4, arg5, arg6);
+    } else {
+        if (sc->format !=3D NULL) {
+            format =3D sc->format;
+        }
+        gemu_log(format, arg1, arg2, arg3, arg4, arg5, arg6);
+    }
+}
+
+
 /*ARGSUSED*/
 static void
 print_syscall_epilogue(const struct syscallname *sc)
@@ -1204,6 +1225,37 @@ print_syscall_epilogue(const struct syscallname *sc=
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
@@ -1633,6 +1685,18 @@ print_futimesat(const struct syscallname *name,
 }
 #endif

+#ifdef TARGET_NR_getcwd
+static void
+print_getcwd(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_string(arg0, 0);
+    print_raw_param("%u", arg1, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #ifdef TARGET_NR_settimeofday
 static void
 print_settimeofday(const struct syscallname *name,
@@ -2428,6 +2492,19 @@ print_fstatat64(const struct syscallname *name,
 #define print_newfstatat    print_fstatat64
 #endif

+#ifdef TARGET_NR_read
+static void
+print_read(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
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
@@ -2817,6 +2894,22 @@ static int nsyscalls =3D ARRAY_SIZE(scnames);
 /*
  * The public interface to this module.
  */
+
+const struct syscallname *print_syscall_prologue_num(int num)
+{
+    int i;
+
+    gemu_log("%d ", getpid());
+
+    for (i =3D 0; i < nsyscalls; i++)
+        if (scnames[i].nr =3D=3D num) {
+            print_syscall_prologue(&scnames[i]);
+            return &scnames[i];
+        }
+    gemu_log("Unknown syscall %d\n", num);
+    return NULL; /* will crash qemu */
+}
+
 void
 print_syscall(int num,
               abi_long arg1, abi_long arg2, abi_long arg3,
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
index ce399a55f0..7207826137 100644
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
+static int is_print_syscall_late(int syscall)
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
@@ -12095,9 +12110,20 @@ abi_long do_syscall(void *cpu_env, int num, abi_l=
ong arg1,
                          arg2, arg3, arg4, arg5, arg6, arg7, arg8);

     if (unlikely(do_strace)) {
-        print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
+        const struct syscallname *sc;
+        int late_printing;
+
+        late_printing =3D is_print_syscall_late(num);
+        if (late_printing) {
+            sc =3D print_syscall_prologue_num(num);
+        } else {
+            print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
+        }
         ret =3D do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
                           arg5, arg6, arg7, arg8);
+        if (late_printing) {
+            print_syscall_late(sc, arg1, arg2, arg3, arg4, arg5, arg6);
+        }
         print_syscall_ret(num, ret);
     } else {
         ret =3D do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,

