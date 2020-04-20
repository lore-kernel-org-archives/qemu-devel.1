Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54EFC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:16:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CAFE2078E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJGO3FWc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CAFE2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQSXI-0002Iz-Mr
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 05:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36512 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <igotti@gmail.com>) id 1jQSVr-00012k-Aa
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:14:47 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <igotti@gmail.com>) id 1jQSVm-0001io-Fz
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:14:47 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:39848)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <igotti@gmail.com>) id 1jQSVm-0001gp-3X
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:14:42 -0400
Received: by mail-lj1-x242.google.com with SMTP id u6so9087552ljl.6
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 02:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=M23dGuolte4OKFci/2F1ujcn3PNLR40b6HiOobswFkI=;
 b=nJGO3FWcs56mEJbqpJKlVdgbSpNHSXG+GpL+FaFgo7Ic/eKKp9Ex2yV/CWU+EdZAlA
 OVLYIvOR3VDIU5udRTCr5edtnYkjWNVsb+9v9kiYiQGGKFtedaQCrELBMEMZgxZmU0kZ
 f5s//4xy97bB0AZo+XNMs7julDtLauCXbU5D7ITHTfSJlh1CJc/VsZUlnyIYSZbLxFcN
 Z/fPOVjv/EmX8Y5/TNXpV1h18Blzj7fmJREY8erE0woUbUPvpvKSRCD49HBs6Ljq5rrw
 /iWzOR6P0S6OyJd9b6JoFCbrZ0j/9p0iID8yCWwrNinIildyYn73rGrkbIJkD1hVjTd9
 vBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=M23dGuolte4OKFci/2F1ujcn3PNLR40b6HiOobswFkI=;
 b=RvOHYz0l0sbvrZpbfaQhkN6frr1BAd3jdnidvbzX3kojTey8j6R7ViVp2Ci9znUwGe
 ani0vha/SvgiiZPwQHmOjREcVgZjlSRc1CuPpH3JZ1MVtR+hffMDXXkuXdWj+pSZcmld
 SAEG45g3iFwYZDOw7nexp2Q0GU2H7rMcF3zVirNdurrfcxmCBunR4VrpvjqrYWlMKzOX
 1nlbcnzMldpF1dHU0PQ6Zq/JKpPA/8FJpXz2dwRPv2DnSNUUoBadokc0naWwu1QgvPef
 a70PS3caoA3Ny1YO4ZGk5bmvpEathtkFvORk4z2ntR5VtjMZfqsvwZz3JGSfrnivyahI
 u3Uw==
X-Gm-Message-State: AGi0PuZe1E3iVr7zDY2Ec8vlG1Y7uiOqr5YMb2/1u3Kaq96UuXFneF1M
 10DCS7u+Eu0Lm0zVIQyAvhIflUhcbJOy41zpIZs=
X-Google-Smtp-Source: APiQypJ1KYC2/WswZRGsCjbHL3DWjDO5PNhWUn8VlN65Am+QZ+ese26qK/vU3EqSbC2uZAryAiEu3AZVNCkDoUxGANM=
X-Received: by 2002:a2e:80cc:: with SMTP id r12mr1120618ljg.269.1587374080331; 
 Mon, 20 Apr 2020 02:14:40 -0700 (PDT)
MIME-Version: 1.0
From: Nikolay Igotti <igotti@gmail.com>
Date: Mon, 20 Apr 2020 12:14:29 +0300
Message-ID: <CAEme+7E6inE1xKzpPCGvAB=ynSqOOE-_hre=QNLy2NQxrwmPhg@mail.gmail.com>
Subject: [PATCH 2/3] linux-user: strace: better format mmap logs,
 support mremap
To: laurent@vivier.eu, riku.voipio@iki.fi
Content-Type: multipart/alternative; boundary="0000000000002f141b05a3b55438"
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=igotti@gmail.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::242
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002f141b05a3b55438
Content-Type: text/plain; charset="UTF-8"

On 64-bit platforms strace entries were not properly formatted, also some
addresses were printed as integers.
Also mremap syscall support is added.

Signed-off-by: Nikolay Igotti <igotti@gmail.com>
---
 linux-user/strace.c    | 31 +++++++++++++++++++++++++++----
 linux-user/strace.list |  2 +-
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 0d9095c674..3e65ffe356 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -969,6 +969,14 @@ UNUSED static struct flags mmap_flags[] = {
     FLAG_END,
 };

+#ifdef TARGET_NR_mremap
+UNUSED static struct flags mremap_flags[] = {
+    FLAG_GENERIC(MREMAP_MAYMOVE),
+    FLAG_GENERIC(MREMAP_FIXED),
+    FLAG_END,
+};
+#endif
+
 UNUSED static struct flags clone_flags[] = {
     FLAG_GENERIC(CLONE_VM),
     FLAG_GENERIC(CLONE_FS),
@@ -2654,11 +2662,11 @@ print_mmap(const struct syscallname *name,
 {
     print_syscall_prologue(name);
     print_pointer(arg0, 0);
-    print_raw_param("%d", arg1, 0);
+    print_raw_param("%lld", (long long)arg1, 0);
     print_flags(mmap_prot_flags, arg2, 0);
     print_flags(mmap_flags, arg3, 0);
     print_raw_param("%d", arg4, 0);
-    print_raw_param("%#x", arg5, 1);
+    print_raw_param("%#llx", (long long)arg5, 1);
     print_syscall_epilogue(name);
 }
 #define print_mmap2     print_mmap
@@ -2672,12 +2680,27 @@ print_mprotect(const struct syscallname *name,
 {
     print_syscall_prologue(name);
     print_pointer(arg0, 0);
-    print_raw_param("%d", arg1, 0);
+    print_raw_param("%lld", (long long)arg1, 0);
     print_flags(mmap_prot_flags, arg2, 1);
     print_syscall_epilogue(name);
 }
 #endif

+#ifdef TARGET_NR_mremap
+static void
+print_mremap(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_pointer(arg0, 0);
+    print_raw_param("%lld", (long long)arg1, 0);
+    print_raw_param("%lld", (long long)arg2, 0);
+    print_flags(mremap_flags, arg3, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #ifdef TARGET_NR_munmap
 static void
 print_munmap(const struct syscallname *name,
@@ -2686,7 +2709,7 @@ print_munmap(const struct syscallname *name,
 {
     print_syscall_prologue(name);
     print_pointer(arg0, 0);
-    print_raw_param("%d", arg1, 1);
+    print_raw_param("%lld", (long long)arg1, 1);
     print_syscall_epilogue(name);
 }
 #endif
diff --git a/linux-user/strace.list b/linux-user/strace.list
index d49a1e92a8..b3bd1c6229 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -612,7 +612,7 @@
 { TARGET_NR_mq_unlink, "mq_unlink" , NULL, print_mq_unlink, NULL },
 #endif
 #ifdef TARGET_NR_mremap
-{ TARGET_NR_mremap, "mremap" , NULL, NULL, NULL },
+{ TARGET_NR_mremap, "mremap" , NULL, print_mremap, print_syscall_ret_addr
},
 #endif
 #ifdef TARGET_NR_msgctl
 { TARGET_NR_msgctl, "msgctl" , NULL, NULL, NULL },
-- 
2.24.2 (Apple Git-127)

--0000000000002f141b05a3b55438
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On 64-bit platforms strace entries were not properly forma=
tted, also some addresses were printed as integers.<br>Also mremap syscall =
support is added.<br><br>Signed-off-by: Nikolay Igotti &lt;<a href=3D"mailt=
o:igotti@gmail.com">igotti@gmail.com</a>&gt;<br>---<br>=C2=A0linux-user/str=
ace.c =C2=A0 =C2=A0| 31 +++++++++++++++++++++++++++----<br>=C2=A0linux-user=
/strace.list | =C2=A02 +-<br>=C2=A02 files changed, 28 insertions(+), 5 del=
etions(-)<br><br>diff --git a/linux-user/strace.c b/linux-user/strace.c<br>=
index 0d9095c674..3e65ffe356 100644<br>--- a/linux-user/strace.c<br>+++ b/l=
inux-user/strace.c<br>@@ -969,6 +969,14 @@ UNUSED static struct flags mmap_=
flags[] =3D {<br>=C2=A0 =C2=A0 =C2=A0FLAG_END,<br>=C2=A0};<br>=C2=A0<br>+#i=
fdef TARGET_NR_mremap<br>+UNUSED static struct flags mremap_flags[] =3D {<b=
r>+ =C2=A0 =C2=A0FLAG_GENERIC(MREMAP_MAYMOVE),<br>+ =C2=A0 =C2=A0FLAG_GENER=
IC(MREMAP_FIXED),<br>+ =C2=A0 =C2=A0FLAG_END,<br>+};<br>+#endif<br>+<br>=C2=
=A0UNUSED static struct flags clone_flags[] =3D {<br>=C2=A0 =C2=A0 =C2=A0FL=
AG_GENERIC(CLONE_VM),<br>=C2=A0 =C2=A0 =C2=A0FLAG_GENERIC(CLONE_FS),<br>@@ =
-2654,11 +2662,11 @@ print_mmap(const struct syscallname *name,<br>=C2=A0{<=
br>=C2=A0 =C2=A0 =C2=A0print_syscall_prologue(name);<br>=C2=A0 =C2=A0 =C2=
=A0print_pointer(arg0, 0);<br>- =C2=A0 =C2=A0print_raw_param(&quot;%d&quot;=
, arg1, 0);<br>+ =C2=A0 =C2=A0print_raw_param(&quot;%lld&quot;, (long long)=
arg1, 0);<br>=C2=A0 =C2=A0 =C2=A0print_flags(mmap_prot_flags, arg2, 0);<br>=
=C2=A0 =C2=A0 =C2=A0print_flags(mmap_flags, arg3, 0);<br>=C2=A0 =C2=A0 =C2=
=A0print_raw_param(&quot;%d&quot;, arg4, 0);<br>- =C2=A0 =C2=A0print_raw_pa=
ram(&quot;%#x&quot;, arg5, 1);<br>+ =C2=A0 =C2=A0print_raw_param(&quot;%#ll=
x&quot;, (long long)arg5, 1);<br>=C2=A0 =C2=A0 =C2=A0print_syscall_epilogue=
(name);<br>=C2=A0}<br>=C2=A0#define print_mmap2 =C2=A0 =C2=A0 print_mmap<br=
>@@ -2672,12 +2680,27 @@ print_mprotect(const struct syscallname *name,<br>=
=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0print_syscall_prologue(name);<br>=C2=A0 =C2=
=A0 =C2=A0print_pointer(arg0, 0);<br>- =C2=A0 =C2=A0print_raw_param(&quot;%=
d&quot;, arg1, 0);<br>+ =C2=A0 =C2=A0print_raw_param(&quot;%lld&quot;, (lon=
g long)arg1, 0);<br>=C2=A0 =C2=A0 =C2=A0print_flags(mmap_prot_flags, arg2, =
1);<br>=C2=A0 =C2=A0 =C2=A0print_syscall_epilogue(name);<br>=C2=A0}<br>=C2=
=A0#endif<br>=C2=A0<br>+#ifdef TARGET_NR_mremap<br>+static void<br>+print_m=
remap(const struct syscallname *name,<br>+ =C2=A0 =C2=A0abi_long arg0, abi_=
long arg1, abi_long arg2,<br>+ =C2=A0 =C2=A0abi_long arg3, abi_long arg4, a=
bi_long arg5)<br>+{<br>+ =C2=A0 =C2=A0print_syscall_prologue(name);<br>+ =
=C2=A0 =C2=A0print_pointer(arg0, 0);<br>+ =C2=A0 =C2=A0print_raw_param(&quo=
t;%lld&quot;, (long long)arg1, 0);<br>+ =C2=A0 =C2=A0print_raw_param(&quot;=
%lld&quot;, (long long)arg2, 0);<br>+ =C2=A0 =C2=A0print_flags(mremap_flags=
, arg3, 1);<br>+ =C2=A0 =C2=A0print_syscall_epilogue(name);<br>+}<br>+#endi=
f<br>+<br>=C2=A0#ifdef TARGET_NR_munmap<br>=C2=A0static void<br>=C2=A0print=
_munmap(const struct syscallname *name,<br>@@ -2686,7 +2709,7 @@ print_munm=
ap(const struct syscallname *name,<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0print_=
syscall_prologue(name);<br>=C2=A0 =C2=A0 =C2=A0print_pointer(arg0, 0);<br>-=
 =C2=A0 =C2=A0print_raw_param(&quot;%d&quot;, arg1, 1);<br>+ =C2=A0 =C2=A0p=
rint_raw_param(&quot;%lld&quot;, (long long)arg1, 1);<br>=C2=A0 =C2=A0 =C2=
=A0print_syscall_epilogue(name);<br>=C2=A0}<br>=C2=A0#endif<br>diff --git a=
/linux-user/strace.list b/linux-user/strace.list<br>index d49a1e92a8..b3bd1=
c6229 100644<br>--- a/linux-user/strace.list<br>+++ b/linux-user/strace.lis=
t<br>@@ -612,7 +612,7 @@<br>=C2=A0{ TARGET_NR_mq_unlink, &quot;mq_unlink&qu=
ot; , NULL, print_mq_unlink, NULL },<br>=C2=A0#endif<br>=C2=A0#ifdef TARGET=
_NR_mremap<br>-{ TARGET_NR_mremap, &quot;mremap&quot; , NULL, NULL, NULL },=
<br>+{ TARGET_NR_mremap, &quot;mremap&quot; , NULL, print_mremap, print_sys=
call_ret_addr },<br>=C2=A0#endif<br>=C2=A0#ifdef TARGET_NR_msgctl<br>=C2=A0=
{ TARGET_NR_msgctl, &quot;msgctl&quot; , NULL, NULL, NULL },<br>-- <br>2.24=
.2 (Apple Git-127)<br><br></div>

--0000000000002f141b05a3b55438--

