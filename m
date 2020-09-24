Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56FAC4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:02:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 363AC23741
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cv2gVVQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363AC23741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLN8y-0003TJ-AB
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 05:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kele.hwang@gmail.com>)
 id 1kLN6U-0001kT-Rl
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 04:59:50 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:37158)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kele.hwang@gmail.com>)
 id 1kLN6Q-0002fB-Kv
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 04:59:50 -0400
Received: by mail-ej1-x641.google.com with SMTP id nw23so3404860ejb.4
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 01:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=RBUWQ+nmzPdo6eHK2VvDs7mQuY8ddbjG671cWQOldJM=;
 b=cv2gVVQk/ieym6LxjaEN4F9WT6TTxnQaW3wC007UG4ldFJ2ZooFEFu1fWJC3Z805mN
 Egj8r2RZaqgQuJuHVlMQ3674TFQjx9RPKyhfCex3ShCDYPeCwxgXjbebmvF1nVHkZZ3w
 EKO4PZPvtIAvq9XCPaTgH6ZPXkIQz7GCA5XpqFe/CbsPc5sRxQ/prL/JcmP0Uj6EQTcF
 b50WHJHYsXDpeQ62o7lJx4aX/MnDtsdAMRRahSMYCDJz/f+jslbU/NtmY8b9g34IfuSh
 N4XeXQLy0Vnz4yuhFARzgutDVMV2B2euICI1JVFhytyzX9Wk40w9kt3AIYF4sLAfZsZy
 BPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=RBUWQ+nmzPdo6eHK2VvDs7mQuY8ddbjG671cWQOldJM=;
 b=pZJSWMJbiqP4GPWd4qvvHeJlmYRIT6mFydpeMfdYcWqmaBbd7cm4Ai2j4W0AC7crpV
 DxuUxy/+iqwpM74xdMyXmvLLFWcGB0boDjlHI+2XNLUhMS9VFWN+4uQUkcMHwLjmcMJv
 eeDyvhzuMLsQK4RjRhRQtOd+meNOxwkh5pUA5E3t2c74X3txiKgT3fa04lZi4PanpIrH
 URbCqVoPa4l89vCrvI7vrEprP5cmUkftJ+p6/fPA5UsLG3SeV3dJj1vPcu0J8HXdg4J1
 ZZw5wSZJP8b2DES1xQh4O3alQWWPMEscF/AvYdanccRDolKcguHh5wfpF5UV3LnOduV0
 tWeg==
X-Gm-Message-State: AOAM530zvnniO5aVLo8vbdWY7VTx39gpzpFRCgLSXujLR2Ch219eWzAw
 bg1HZg3Yc2d79YSFlNIIRMbcV/QiSE+fHBZ7TcI=
X-Google-Smtp-Source: ABdhPJy6mjpNbZoiPUHV4+Opgfe1qURYg327BlbuR2pkOMwvovd/gnGPNxFeeKttHuxFjexg9dVrOTFojz3VP6hEhIU=
X-Received: by 2002:a17:907:374:: with SMTP id
 rs20mr3668855ejb.135.1600937982779; 
 Thu, 24 Sep 2020 01:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200910074342.20421-1-kele.hwang@gmail.com>
 <20200910074342.20421-2-kele.hwang@gmail.com>
 <7da49458-f8d7-d05a-457a-450ccda28040@linaro.org>
In-Reply-To: <7da49458-f8d7-d05a-457a-450ccda28040@linaro.org>
From: Kele Huang <kele.hwang@gmail.com>
Date: Thu, 24 Sep 2020 16:59:31 +0800
Message-ID: <CA+FBGNdAqzyj5dW8yQEitJerKRQEy1S5UW3weqKqs40zYbGWCg@mail.gmail.com>
Subject: Re: [PATCH 1/1] accel/tcg: Fix computing is_write for mips
To: Richard Henderson <richard.henderson@linaro.org>, peter.maydell@linaro.org,
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, 
 Xu Zou <iwatchnima@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000c5850705b00b6b73"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=kele.hwang@gmail.com; helo=mail-ej1-x641.google.com
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

--000000000000c5850705b00b6b73
Content-Type: text/plain; charset="UTF-8"

Sorry for the late reply. We make a new version submit as below.

Subject: [PATCH v2 1/1] accel/tcg: Fix computing of is_write for mips

Detect mips store instructions in cpu_signal_handler for all MIPS
versions, and set is_write if encountering such store instructions.

This fixed the error while dealing with self-modified code for MIPS.

Signed-off-by: Kele Huang <kele.hwang@gmail.com>
Signed-off-by: Xu Zou <iwatchnima@gmail.com>
---
 accel/tcg/user-exec.c | 51 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index bb039eb32d..18784516e5 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -710,11 +710,60 @@ int cpu_signal_handler(int host_signum, void *pinfo,
     greg_t pc = uc->uc_mcontext.pc;
     int is_write;

-    /* XXX: compute is_write */
     is_write = 0;
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
+            is_write = 1;
+        }
+        break;
+    case 0x7:
+        switch((insn>>26) & 0x7) {
+        case 0x0: /* SC */
+        case 0x1: /* SWC1 */
+        case 0x4: /* SCD */
+        case 0x5: /* SDC1 */
+        case 0x7: /* SD */
+#if !defined(__mips_isa_rev) || __mips_isa_rev < 6
+        case 0x2: /* SWC2 */
+        case 0x6: /* SDC2 */
+#endif
+            is_write = 1;
+        }
+        break;
+    }
+
+    /*
+     * Required in all versions of MIPS64 since MIPS64r1. Not available
+     * in MIPS32r1. Required by MIPS32r2 and subsequent versions of MIPS32.
+     */
+    switch ((insn >> 3) & 0x7) {
+    case 0x1:
+        switch (insn & 0x7) {
+        case 0x0: /* SWXC1 */
+        case 0x1: /* SDXC1 */
+            is_write = 1;
+        }
+        break;
+    }
+
     return handle_cpu_signal(pc, info, is_write, &uc->uc_sigmask);
 }

+#elif defined(__misp16) || defined(__mips_micromips)
+
+#error "Unsupported encoding"
+
 #elif defined(__riscv)

 int cpu_signal_handler(int host_signum, void *pinfo,
-- 
2.17.1

On Fri, 11 Sep 2020 at 01:18, Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 9/10/20 12:43 AM, Kele Huang wrote:
> > Detect mips store instructions SWXC1 and SDXC1 for MIPS64 since
> > MIPS64r1, and MIPS32 since MIPS32r2.
> >
> > Signed-off-by: Kele Huang <kele.hwang@gmail.com>
> > ---
> >  accel/tcg/user-exec.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> > index bb039eb32d..e69b4d8780 100644
> > --- a/accel/tcg/user-exec.c
> > +++ b/accel/tcg/user-exec.c
> > @@ -712,6 +712,27 @@ int cpu_signal_handler(int host_signum, void *pinfo,
> >
> >      /* XXX: compute is_write */
> >      is_write = 0;
> > +
> > +    /*
> > +     * Detect store instructions. Required in all versions of MIPS64
> > +     * since MIPS64r1. Not available in MIPS32r1. Required by MIPS32r2
> > +     * and subsequent versions of MIPS32.
> > +     */
> > +    switch ((insn >> 3) & 0x7) {
> > +        case 0x1:
> > +            switch (insn & 0x7) {
> > +            case 0x0: /* SWXC1 */
> > +            case 0x1: /* SDXC1 */
> > +                is_write = 1;
> > +                break;
> > +            default:
> > +                break;
> > +            }
> > +            break;
> > +        default:
> > +            break;
>
>
> You should detect all of the store instructions, not just the coprocessor
> ones.
>  Compare, for example, the Sparc version around line 485.
>
> Once done, you can also remove that /* XXX */ comment just above, which
> indicates that there is work that needs doing.
>
>
> r~
>

--000000000000c5850705b00b6b73
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Sorry for the late reply. We make a new version submi=
t as below.</div><div><br></div>Subject: [PATCH v2 1/1] accel/tcg: Fix comp=
uting of is_write for mips<br><br>Detect mips store instructions in cpu_sig=
nal_handler for all MIPS<br>versions, and set is_write if encountering such=
 store instructions.<br><br>This fixed the error while dealing with self-mo=
dified code for MIPS.<br><br>Signed-off-by: Kele Huang &lt;<a href=3D"mailt=
o:kele.hwang@gmail.com">kele.hwang@gmail.com</a>&gt;<br>Signed-off-by: Xu Z=
ou &lt;<a href=3D"mailto:iwatchnima@gmail.com">iwatchnima@gmail.com</a>&gt;=
<br>---<br>=C2=A0accel/tcg/user-exec.c | 51 +++++++++++++++++++++++++++++++=
+++++++++++-<br>=C2=A01 file changed, 50 insertions(+), 1 deletion(-)<br><b=
r>diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c<br>index bb039=
eb32d..18784516e5 100644<br>--- a/accel/tcg/user-exec.c<br>+++ b/accel/tcg/=
user-exec.c<br>@@ -710,11 +710,60 @@ int cpu_signal_handler(int host_signum=
, void *pinfo,<br>=C2=A0 =C2=A0 =C2=A0greg_t pc =3D uc-&gt;uc_mcontext.pc;<=
br>=C2=A0 =C2=A0 =C2=A0int is_write;<br>=C2=A0<br>- =C2=A0 =C2=A0/* XXX: co=
mpute is_write */<br>=C2=A0 =C2=A0 =C2=A0is_write =3D 0;<br>+<br>+ =C2=A0 =
=C2=A0/* Detect store by reading the instruction at the program counter. */=
<br>+ =C2=A0 =C2=A0uint32_t insn =3D *(uint32_t *)pc;<br>+ =C2=A0 =C2=A0swi=
tch(insn&gt;&gt;29) {<br>+ =C2=A0 =C2=A0case 0x5:<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0switch((insn&gt;&gt;26) &amp; 0x7) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0case 0x0: /* SB */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0case 0x1: /* SH */<br=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0case 0x2: /* SWL */<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0case 0x3: /* SW */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0case 0x4: /* SDL =
*/<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0case 0x5: /* SDR */<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0case 0x6: /* SWR */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0is_write =3D 1;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>+ =C2=A0 =C2=A0case 0x7:<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0switch((insn&gt;&gt;26) &amp; 0x7) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
case 0x0: /* SC */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0case 0x1: /* SWC1 */<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0case 0x4: /* SCD */<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0case 0x5: /* SDC1 */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0case 0x7: /* SD =
*/<br>+#if !defined(__mips_isa_rev) || __mips_isa_rev &lt; 6<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0case 0x2: /* SWC2 */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0ca=
se 0x6: /* SDC2 */<br>+#endif<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0is_write =3D 1;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>+ =C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0/*<br>+ =C2=A0 =
=C2=A0 * Required in all versions of MIPS64 since MIPS64r1. Not available<b=
r>+ =C2=A0 =C2=A0 * in MIPS32r1. Required by MIPS32r2 and subsequent versio=
ns of MIPS32.<br>+ =C2=A0 =C2=A0 */<br>+ =C2=A0 =C2=A0switch ((insn &gt;&gt=
; 3) &amp; 0x7) {<br>+ =C2=A0 =C2=A0case 0x1:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0switch (insn &amp; 0x7) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0case 0x0: /* S=
WXC1 */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0case 0x1: /* SDXC1 */<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0is_write =3D 1;<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>+ =C2=A0 =C2=A0}<br>+<br=
>=C2=A0 =C2=A0 =C2=A0return handle_cpu_signal(pc, info, is_write, &amp;uc-&=
gt;uc_sigmask);<br>=C2=A0}<br>=C2=A0<br>+#elif defined(__misp16) || defined=
(__mips_micromips)<br>+<br>+#error &quot;Unsupported encoding&quot;<br>+<br=
>=C2=A0#elif defined(__riscv)<br>=C2=A0<br>=C2=A0int cpu_signal_handler(int=
 host_signum, void *pinfo,<br>-- <br>2.17.1<br></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 11 Sep 2020 at 01:18=
, Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ric=
hard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On 9/10/20 12:43 AM, Kele Huang wrote:<br>
&gt; Detect mips store instructions SWXC1 and SDXC1 for MIPS64 since<br>
&gt; MIPS64r1, and MIPS32 since MIPS32r2.<br>
&gt; <br>
&gt; Signed-off-by: Kele Huang &lt;<a href=3D"mailto:kele.hwang@gmail.com" =
target=3D"_blank">kele.hwang@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 accel/tcg/user-exec.c | 21 +++++++++++++++++++++<br>
&gt;=C2=A0 1 file changed, 21 insertions(+)<br>
&gt; <br>
&gt; diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c<br>
&gt; index bb039eb32d..e69b4d8780 100644<br>
&gt; --- a/accel/tcg/user-exec.c<br>
&gt; +++ b/accel/tcg/user-exec.c<br>
&gt; @@ -712,6 +712,27 @@ int cpu_signal_handler(int host_signum, void *pin=
fo,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* XXX: compute is_write */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 is_write =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Detect store instructions. Required in all vers=
ions of MIPS64<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* since MIPS64r1. Not available in MIPS32r1. Requ=
ired by MIPS32r2<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* and subsequent versions of MIPS32.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 switch ((insn &gt;&gt; 3) &amp; 0x7) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x1:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (insn &amp; 0x7) {<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x0: /* SWXC1 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x1: /* SDXC1 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_write =3D =
1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
<br>
<br>
You should detect all of the store instructions, not just the coprocessor o=
nes.<br>
=C2=A0Compare, for example, the Sparc version around line 485.<br>
<br>
Once done, you can also remove that /* XXX */ comment just above, which<br>
indicates that there is work that needs doing.<br>
<br>
<br>
r~<br>
</blockquote></div>

--000000000000c5850705b00b6b73--

