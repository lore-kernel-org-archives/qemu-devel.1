Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660E0C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 01:13:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0B802083B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 01:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJykHANL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B802083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGXdP-0003m8-MY
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 21:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iwatchnima@gmail.com>)
 id 1kGXcb-0002sc-Ks
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 21:13:01 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:44226)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <iwatchnima@gmail.com>)
 id 1kGXcZ-0007Ol-Rj
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 21:13:01 -0400
Received: by mail-wr1-x430.google.com with SMTP id s12so9668314wrw.11
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 18:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=xjjfcLp/S/DgiOyjX0IQjWV/kOCJXMeNKU/CADeSptg=;
 b=uJykHANL5uzh/L0O6eji3tu1EdCXiTKOx+Nfxa90x7TrS/c4Xef3dPTygZR7kwvI5S
 4Ix22/ArujtZAN5xPDWQjuA+cVoHMBFKj7Y/fZRpD9g2kqO0V4t46sljWNJ5FSYJCc9B
 YNNNPWsz0CoKPkqYfKOTtAKIoBgSclGRlJSTOCl601noIil0hydz6iKLdd0KHbd8aGrx
 WVi+g+3qdBC4GJS8IreB7tHfZkAzui8jKlXn5g+3tRONlK1XicVmQp7vuUS/R81prNhp
 iZoxV8Jcsr7RGSAyyIheTLKwEcqxrwnL+HNTL9Tu2jpenIbxgvWwuZp555G5TCvse0bD
 wTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=xjjfcLp/S/DgiOyjX0IQjWV/kOCJXMeNKU/CADeSptg=;
 b=fFYpYZAFtChBRI+IS8Nqo4ROkmDMwqbXFlyI6yrQLVPi0N0Idfi01yKPhkJEVNnqUH
 0G2vpK7EESqI0au3tcwGcfnDtRfbI0/HEzjnxQ3Fc/A5AHHfuKKc4xg2J3DJhVGvfJTX
 LbTE0h2O/mnEs2t2so4AMFysI1DJRnrv2eOSKbjCSmy+A/fss3kt2u9Jz1rWomIw+OK2
 cSpRRUFq3ilgVontbUwp0xNKRKJrWUD5DaFw1pwl+MJB2M643nELk57oQWMBMKIDsXzS
 csLgpvbsVX3geEQB+dCbot54WaoJJ1f0DSvp/FVZ0ergAk02CYZCD8goObUsM804Xi6W
 WBsg==
X-Gm-Message-State: AOAM5308NN0V0YVDgaxng6s+y/xujco2vm6Qkkq5k7uH/bxcEp0GzlvR
 PaMB8I0pS/JBL9yo7/9TOt7Dq9VU0vnUcFegxAL3g0t7uVq8Rs1H
X-Google-Smtp-Source: ABdhPJzYbp7F2N6OwHaRcbDsOOJyQtTS7eD6zb3t3/VhGh4/VdYa/l/xm/ixuOXiTQv9EvOOa5+KYvaEyZCf/OTdgjA=
X-Received: by 2002:a5d:5042:: with SMTP id h2mr11752297wrt.409.1599786777617; 
 Thu, 10 Sep 2020 18:12:57 -0700 (PDT)
MIME-Version: 1.0
From: zou xu <iwatchnima@gmail.com>
Date: Fri, 11 Sep 2020 09:12:41 +0800
Message-ID: <CA+Lzsy=o9yshAAAacuTwcs3Hfr4MfWiX-SiUf5A2Fds3vGOrAQ@mail.gmail.com>
Subject: [PATCH 1/1] accel/tcg/user-exec: support computing is_write for mips32
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000098aa3305aeff62d5"
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=iwatchnima@gmail.com; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000098aa3305aeff62d5
Content-Type: text/plain; charset="UTF-8"

From 533ed02427bdaf0265f62fcb4f961854a41b7037 Mon Sep 17 00:00:00 2001
From: ZouXu <iwatchnima@gmail.com>
Date: Wed, 9 Sep 2020 21:59:13 +0800
Subject: [PATCH 1/1] accel/tcg/user-exec: support computing is_write for
 mips32

Those MIPS32 instructions can cause store operation:
SB/SH/SW/SD/SWL/SWR/SDL/SDR/CACHE
SC/SCD/SWC1/SWC2/SDC1/SDC2
---
 accel/tcg/user-exec.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index bb039eb32d..b5ad721aa5 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -708,10 +708,38 @@ int cpu_signal_handler(int host_signum, void *pinfo,
     siginfo_t *info = pinfo;
     ucontext_t *uc = puc;
     greg_t pc = uc->uc_mcontext.pc;
-    int is_write;
+    int is_write = 0;
+
+    /* Detect store by reading the instruction at the program counter. */
+    uint32_t insn = *(uint32_t *)pc;
+    switch(insn>>29) {
+    case 0x5:
+        switch((insn>>26) & 0x7) {
+        case 0x0: /* SB */
+        case 0x1: /* SH */
+        case 0x2: /* SWL */
+        case 0x3: /* SW */
+        case 0x4: /* SDL */
+        case 0x5: /* SDR */
+        case 0x6: /* SWR */
+        case 0x7: /* CACHE */
+            is_write = 1;
+        }
+        break;
+    case 0x7:
+        switch((insn>>26) & 0x7) {
+        case 0x0: /* SC */
+        case 0x1: /* SWC1 */
+        case 0x2: /* SWC2 */
+        case 0x4: /* SCD */
+        case 0x5: /* SDC1 */
+        case 0x6: /* SDC2 */
+        case 0x7: /* SD */
+            is_write = 1;
+        }
+        break;
+    }

-    /* XXX: compute is_write */
-    is_write = 0;
     return handle_cpu_signal(pc, info, is_write, &uc->uc_sigmask);
 }

-- 
2.25.1

--00000000000098aa3305aeff62d5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">From 533ed02427bdaf0265f62fcb4f961854a41b7037 Mon Sep 17 0=
0:00:00 2001<br>From: ZouXu &lt;<a href=3D"mailto:iwatchnima@gmail.com">iwa=
tchnima@gmail.com</a>&gt;<br>Date: Wed, 9 Sep 2020 21:59:13 +0800<br>Subjec=
t: [PATCH 1/1] accel/tcg/user-exec: support computing is_write for<br>=C2=
=A0mips32<br><br>Those MIPS32 instructions can cause store operation:<br>SB=
/SH/SW/SD/SWL/SWR/SDL/SDR/CACHE<br>SC/SCD/SWC1/SWC2/SDC1/SDC2<br>---<br>=C2=
=A0accel/tcg/user-exec.c | 34 +++++++++++++++++++++++++++++++---<br>=C2=A01=
 file changed, 31 insertions(+), 3 deletions(-)<br><br>diff --git a/accel/t=
cg/user-exec.c b/accel/tcg/user-exec.c<br>index bb039eb32d..b5ad721aa5 1006=
44<br>--- a/accel/tcg/user-exec.c<br>+++ b/accel/tcg/user-exec.c<br>@@ -708=
,10 +708,38 @@ int cpu_signal_handler(int host_signum, void *pinfo,<br>=C2=
=A0 =C2=A0 =C2=A0siginfo_t *info =3D pinfo;<br>=C2=A0 =C2=A0 =C2=A0ucontext=
_t *uc =3D puc;<br>=C2=A0 =C2=A0 =C2=A0greg_t pc =3D uc-&gt;uc_mcontext.pc;=
<br>- =C2=A0 =C2=A0int is_write;<br>+ =C2=A0 =C2=A0int is_write =3D 0;<br>+=
 =C2=A0 <br>+ =C2=A0 =C2=A0/* Detect store by reading the instruction at th=
e program counter. */<br>+ =C2=A0 =C2=A0uint32_t insn =3D *(uint32_t *)pc;<=
br>+ =C2=A0 =C2=A0switch(insn&gt;&gt;29) {<br>+ =C2=A0 =C2=A0case 0x5:<br>+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch((insn&gt;&gt;26) &amp; 0x7) {<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0case 0x0: /* SB */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
case 0x1: /* SH */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0case 0x2: /* SWL */<br>+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 0x3: /* SW */<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0case 0x4: /* SDL */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0case 0x5: /* SDR =
*/<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0case 0x6: /* SWR */<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0case 0x7: /* CACHE */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0is_write =3D 1;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>+ =C2=A0 =C2=A0case 0x7:<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0switch((insn&gt;&gt;26) &amp; 0x7) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
case 0x0: /* SC */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0case 0x1: /* SWC1 */<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0case 0x2: /* SWC2 */<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0case 0x4: /* SCD */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0case 0x5: /* SDC=
1 */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0case 0x6: /* SDC2 */<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0case 0x7: /* SD */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0is_write =3D 1;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;<br>+ =C2=A0 =C2=A0}<br>=C2=A0<br>- =C2=A0 =C2=A0/* XXX=
: compute is_write */<br>- =C2=A0 =C2=A0is_write =3D 0;<br>=C2=A0 =C2=A0 =
=C2=A0return handle_cpu_signal(pc, info, is_write, &amp;uc-&gt;uc_sigmask);=
<br>=C2=A0}<br>=C2=A0<br>-- <br>2.25.1<br><br></div>

--00000000000098aa3305aeff62d5--

