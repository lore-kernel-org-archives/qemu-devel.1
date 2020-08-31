Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A347BC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:42:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E1172083E
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E1172083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrZK-0005Fp-KI
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrEO-0004ym-9G
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:20:48 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:44403)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrEJ-0001dD-Po
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:20:45 -0400
Received: by mail-qv1-f67.google.com with SMTP id j10so3331875qvk.11
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 14:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kHfl62pj9DSTAmXOKYpkKn+3gaeqtkwVPxj8YvsQnvo=;
 b=WVd0FlN273mGL4mii9kmdDWRJI4EgvVd06c7kvB4Rq/vAMS2p9kyB2+23kY/wOb76c
 rWAz431OkgkvbEdnYoI4achF5O6biTlDd/XZOBfrXTMxGbAuQWktLAROAnAviowI2So7
 wFkue3Iw6WBSJatiOO6zrgWy1uwv0oLUzE+YqcYxsOvtNUHgV1zKiFt4RbNznSYp1aYi
 33CsgqhJcn0UW5tuOMkoILwcqzTF28iv6/GPpYLuY+99GGiI8UbzSk9QgNDYi9g3ghcf
 G396/SgSbPGulWFL/7HKb/z2c7cqsieihpp5cN1E6x8PUVspmYsTQQs2SBMe0SL1NxE/
 R2Cg==
X-Gm-Message-State: AOAM532pd4uaTO+xMoJe1JkwLXagon0T4DO+8djSzKy7WiTboZpEgBoT
 ZzH3v+AzmVTVZsfWdjbqOj3knwkamD0W4q6yNgE=
X-Google-Smtp-Source: ABdhPJyf2MwtN4Sir+x7bCmJUowhRw/X7prd9UcZbCrOUofzHSr+j+tT56u58BEVj7/bDfJ+ZTRSZUpRCjEYssOcFKE=
X-Received: by 2002:a0c:dc90:: with SMTP id n16mr3023546qvk.168.1598908843027; 
 Mon, 31 Aug 2020 14:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200828141929.77854-1-richard.henderson@linaro.org>
 <20200828141929.77854-33-richard.henderson@linaro.org>
In-Reply-To: <20200828141929.77854-33-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 31 Aug 2020 23:14:01 +0200
Message-ID: <CAAdtpL5hsUcLU5OEZH+=dMzUL3ZofiGYiQ1nLB3_i7af+qvdxQ@mail.gmail.com>
Subject: Re: [PATCH v2 32/76] target/microblaze: Remove empty D macros
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000009df00a05ae32f953"
Received-SPF: pass client-ip=209.85.219.67;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-qv1-f67.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 17:15:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009df00a05ae32f953
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 28 ao=C3=BBt 2020 16:32, Richard Henderson <richard.henderson@linar=
o.org>
a =C3=A9crit :

> This is never used in op_helper.c and translate.c.  There are
> two trivial uses in helper.c which can be improved by always
> logging MMU_EXCP to CPU_LOG_INT.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

---
>  target/microblaze/helper.c    | 11 ++++-------
>  target/microblaze/op_helper.c |  2 --
>  target/microblaze/translate.c |  2 --
>  3 files changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
> index 9a95456401..f8e2ca12a9 100644
> --- a/target/microblaze/helper.c
> +++ b/target/microblaze/helper.c
> @@ -24,8 +24,6 @@
>  #include "qemu/host-utils.h"
>  #include "exec/log.h"
>
> -#define D(x)
> -
>  #if defined(CONFIG_USER_ONLY)
>
>  void mb_cpu_do_interrupt(CPUState *cs)
> @@ -155,10 +153,13 @@ void mb_cpu_do_interrupt(CPUState *cs)
>          case EXCP_MMU:
>              env->regs[17] =3D env->pc;
>
> +            qemu_log_mask(CPU_LOG_INT,
> +                          "MMU exception at pc=3D%x iflags=3D%x ear=3D%"=
 PRIx64
> "\n",
> +                          env->pc, env->iflags, env->ear);
> +
>              env->esr &=3D ~(1 << 12);
>              /* Exception breaks branch + dslot sequence?  */
>              if (env->iflags & D_FLAG) {
> -                D(qemu_log("D_FLAG set at exception bimm=3D%d\n",
> env->bimm));
>                  env->esr |=3D 1 << 12 ;
>                  env->btr =3D env->btarget;
>
> @@ -166,14 +167,10 @@ void mb_cpu_do_interrupt(CPUState *cs)
>                  env->regs[17] -=3D 4;
>                  /* was the branch immprefixed?.  */
>                  if (env->bimm) {
> -                    qemu_log_mask(CPU_LOG_INT,
> -                                  "bimm exception at pc=3D%x iflags=3D%x=
\n",
> -                                  env->pc, env->iflags);
>                      env->regs[17] -=3D 4;
>                      log_cpu_state_mask(CPU_LOG_INT, cs, 0);
>                  }
>              } else if (env->iflags & IMM_FLAG) {
> -                D(qemu_log("IMM_FLAG set at exception\n"));
>                  env->regs[17] -=3D 4;
>              }
>
> diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.=
c
> index d79202c3f8..decdca0fd8 100644
> --- a/target/microblaze/op_helper.c
> +++ b/target/microblaze/op_helper.c
> @@ -26,8 +26,6 @@
>  #include "exec/cpu_ldst.h"
>  #include "fpu/softfloat.h"
>
> -#define D(x)
> -
>  void helper_put(uint32_t id, uint32_t ctrl, uint32_t data)
>  {
>      int test =3D ctrl & STREAM_TEST;
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.=
c
> index 6757720776..860859324a 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -41,8 +41,6 @@
>  #  define LOG_DIS(...) do { } while (0)
>  #endif
>
> -#define D(x)
> -
>  #define EXTRACT_FIELD(src, start, end) \
>              (((src) >> start) & ((1 << (end - start + 1)) - 1))
>
> --
> 2.25.1
>
>
>

--0000000000009df00a05ae32f953
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Le ven. 28 ao=C3=BBt 2020 16:32, Richard Henderson &lt=
;<a href=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.o=
rg</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">This=
 is never used in op_helper.c and translate.c.=C2=A0 There are<br>
two trivial uses in helper.c which can be improved by always<br>
logging MMU_EXCP to CPU_LOG_INT.<br>
<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank" rel=3D"noreferrer">richard.henderson@linaro.org=
</a>&gt;<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><span style=3D"font-family:sans-serif;font-size:13.696px">Reviewe=
d-by: Philippe Mathieu-Daud=C3=A9 &lt;</span><a href=3D"mailto:f4bug@amsat.=
org" style=3D"text-decoration:none;color:rgb(66,133,244);font-family:sans-s=
erif;font-size:13.696px">f4bug@amsat.org</a><span style=3D"font-family:sans=
-serif;font-size:13.696px">&gt;</span><br></div><div dir=3D"auto"><br></div=
><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">
---<br>
=C2=A0target/microblaze/helper.c=C2=A0 =C2=A0 | 11 ++++-------<br>
=C2=A0target/microblaze/op_helper.c |=C2=A0 2 --<br>
=C2=A0target/microblaze/translate.c |=C2=A0 2 --<br>
=C2=A03 files changed, 4 insertions(+), 11 deletions(-)<br>
<br>
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c<br>
index 9a95456401..f8e2ca12a9 100644<br>
--- a/target/microblaze/helper.c<br>
+++ b/target/microblaze/helper.c<br>
@@ -24,8 +24,6 @@<br>
=C2=A0#include &quot;qemu/host-utils.h&quot;<br>
=C2=A0#include &quot;exec/log.h&quot;<br>
<br>
-#define D(x)<br>
-<br>
=C2=A0#if defined(CONFIG_USER_ONLY)<br>
<br>
=C2=A0void mb_cpu_do_interrupt(CPUState *cs)<br>
@@ -155,10 +153,13 @@ void mb_cpu_do_interrupt(CPUState *cs)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case EXCP_MMU:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;regs[17] =3D env-&g=
t;pc;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(CPU_LOG_INT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;MMU exception at pc=3D%x iflags=3D%x ear=3D%&quot; =
PRIx64 &quot;\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 env-&gt;pc, env-&gt;iflags, env-&gt;ear);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;esr &amp;=3D ~(1 &l=
t;&lt; 12);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Exception breaks branch =
+ dslot sequence?=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (env-&gt;iflags &amp; D_=
FLAG) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 D(qemu_log(&quot;D=
_FLAG set at exception bimm=3D%d\n&quot;, env-&gt;bimm));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;esr |=
=3D 1 &lt;&lt; 12 ;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;btr =
=3D env-&gt;btarget;<br>
<br>
@@ -166,14 +167,10 @@ void mb_cpu_do_interrupt(CPUState *cs)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;regs[=
17] -=3D 4;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* was the br=
anch immprefixed?.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (env-&gt;b=
imm) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu=
_log_mask(CPU_LOG_INT,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;bimm exception at pc=3D=
%x iflags=3D%x\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;pc, env-&gt;iflags);<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0env-&gt;regs[17] -=3D 4;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0log_cpu_state_mask(CPU_LOG_INT, cs, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (env-&gt;iflags &=
amp; IMM_FLAG) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 D(qemu_log(&quot;I=
MM_FLAG set at exception\n&quot;));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;regs[=
17] -=3D 4;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c<=
br>
index d79202c3f8..decdca0fd8 100644<br>
--- a/target/microblaze/op_helper.c<br>
+++ b/target/microblaze/op_helper.c<br>
@@ -26,8 +26,6 @@<br>
=C2=A0#include &quot;exec/cpu_ldst.h&quot;<br>
=C2=A0#include &quot;fpu/softfloat.h&quot;<br>
<br>
-#define D(x)<br>
-<br>
=C2=A0void helper_put(uint32_t id, uint32_t ctrl, uint32_t data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int test =3D ctrl &amp; STREAM_TEST;<br>
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c<=
br>
index 6757720776..860859324a 100644<br>
--- a/target/microblaze/translate.c<br>
+++ b/target/microblaze/translate.c<br>
@@ -41,8 +41,6 @@<br>
=C2=A0#=C2=A0 define LOG_DIS(...) do { } while (0)<br>
=C2=A0#endif<br>
<br>
-#define D(x)<br>
-<br>
=C2=A0#define EXTRACT_FIELD(src, start, end) \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(((src) &gt;&gt; start) &am=
p; ((1 &lt;&lt; (end - start + 1)) - 1))<br>
<br>
-- <br>
2.25.1<br>
<br>
<br>
</blockquote></div></div></div>

--0000000000009df00a05ae32f953--

