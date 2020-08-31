Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8B8C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:40:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B6D92083E
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6D92083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrXD-0001fU-KH
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrEE-0004pP-Ul
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:20:39 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33114)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrED-0001c9-BL
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:20:38 -0400
Received: by mail-qk1-f193.google.com with SMTP id p4so7641040qkf.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 14:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BTkulXqWMOty7usHhPPwL2Mq34Xp9HbgKxRu0QqN0uA=;
 b=DTo6x/D94d5ltSw5zPi5razsoUzgSbmf8E3mmFhXQOlCk59e81VnKG5d8NK5a0s875
 M5nvVk4xjWinB60UW4w9P64o3JXLsRQW5PvX2prRnnMThdPSakPssLLEjgOw6vlZXr55
 pm8L3tvlIx+7Mb+dXXIRnGO341oKs0F0dPCkAqW1As4KZ/1tsNAgRxUMpoUVUE81W8wc
 xIgm3tdkniT5jNnxvGOd/1z8U5Hk2wyDO4qVbfLQs4unEMt/I6YNwPKx+Fd/kA99wLrb
 MMjrFPv013/N4PuZe6ljO0M7gZilVt46/FtKfPzKMLCTZ4s9lUoBAk+tgoaUZmgMaEyB
 qmow==
X-Gm-Message-State: AOAM533+dTtDOQMY+Lludz3DbZfi04ZoL+lBOsIpLiG2hL/4A8r6QCgJ
 lVDEGIXWoj0122Y8MovEDpDb4ZZv1b3UPh9PwoM=
X-Google-Smtp-Source: ABdhPJwasPwFsQ5pTN/A7hFR9uJSm5zs/o1RArO+UXQ+Uuc1mEGTgVRuyW4mgqOYxIeTHeQ23HQwMOGg85TGNMbDVHE=
X-Received: by 2002:a37:498e:: with SMTP id w136mr2800140qka.187.1598908836587; 
 Mon, 31 Aug 2020 14:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200828141929.77854-1-richard.henderson@linaro.org>
 <20200828141929.77854-51-richard.henderson@linaro.org>
In-Reply-To: <20200828141929.77854-51-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 31 Aug 2020 23:09:31 +0200
Message-ID: <CAAdtpL7Xc=H8TBsOHi104iff5=b0pm6NJWEa+HAxQx8n3JMwmQ@mail.gmail.com>
Subject: Re: [PATCH v2 50/76] target/microblaze: Replace MSR_EE_FLAG with
 MSR_EE
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000003bab7f05ae32f9f4"
Received-SPF: pass client-ip=209.85.222.193;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-qk1-f193.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 17:16:08
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

--0000000000003bab7f05ae32f9f4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 28 ao=C3=BBt 2020 16:42, Richard Henderson <richard.henderson@linar=
o.org>
a =C3=A9crit :

> There's no reason to define MSR_EE_FLAG; we can just use the
> original MSR_EE define.  Document the other flags copied into
> tb_flags with iflag to reserve those bits.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

---
>  target/microblaze/cpu.h       | 4 +++-
>  target/microblaze/translate.c | 4 ++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 013858b8e0..594501e4e7 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -254,7 +254,9 @@ struct CPUMBState {
>
>      /* Internal flags.  */
>  #define IMM_FLAG       4
> -#define MSR_EE_FLAG     (1 << 8)
> +/* MSR_EE               (1 << 8)  */
> +/* MSR_UM               (1 << 11) */
> +/* MSR_VM               (1 << 13) */
>  #define DRTI_FLAG      (1 << 16)
>  #define DRTE_FLAG      (1 << 17)
>  #define DRTB_FLAG      (1 << 18)
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.=
c
> index 72541905ec..1f6731e0af 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -162,7 +162,7 @@ static void gen_goto_tb(DisasContext *dc, int n,
> target_ulong dest)
>   */
>  static bool trap_illegal(DisasContext *dc, bool cond)
>  {
> -    if (cond && (dc->tb_flags & MSR_EE_FLAG)
> +    if (cond && (dc->tb_flags & MSR_EE)
>          && dc->cpu->cfg.illegal_opcode_exception) {
>          gen_raise_hw_excp(dc, ESR_EC_ILLEGAL_OP);
>      }
> @@ -178,7 +178,7 @@ static bool trap_userspace(DisasContext *dc, bool con=
d)
>      int mem_index =3D cpu_mmu_index(&dc->cpu->env, false);
>      bool cond_user =3D cond && mem_index =3D=3D MMU_USER_IDX;
>
> -    if (cond_user && (dc->tb_flags & MSR_EE_FLAG)) {
> +    if (cond_user && (dc->tb_flags & MSR_EE)) {
>          gen_raise_hw_excp(dc, ESR_EC_PRIVINSN);
>      }
>      return cond_user;
> --
> 2.25.1
>
>
>

--0000000000003bab7f05ae32f9f4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Le ven. 28 ao=C3=BBt 2020 16:42, Richard Henderson &lt=
;<a href=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.o=
rg</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Ther=
e&#39;s no reason to define MSR_EE_FLAG; we can just use the<br>
original MSR_EE define.=C2=A0 Document the other flags copied into<br>
tb_flags with iflag to reserve those bits.<br>
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
=C2=A0target/microblaze/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 4 +++-<br>
=C2=A0target/microblaze/translate.c | 4 ++--<br>
=C2=A02 files changed, 5 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h<br>
index 013858b8e0..594501e4e7 100644<br>
--- a/target/microblaze/cpu.h<br>
+++ b/target/microblaze/cpu.h<br>
@@ -254,7 +254,9 @@ struct CPUMBState {<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Internal flags.=C2=A0 */<br>
=C2=A0#define IMM_FLAG=C2=A0 =C2=A0 =C2=A0 =C2=A04<br>
-#define MSR_EE_FLAG=C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 8)<br>
+/* MSR_EE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt=
; 8)=C2=A0 */<br>
+/* MSR_UM=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt=
; 11) */<br>
+/* MSR_VM=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt=
; 13) */<br>
=C2=A0#define DRTI_FLAG=C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 16)<br>
=C2=A0#define DRTE_FLAG=C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 17)<br>
=C2=A0#define DRTB_FLAG=C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 18)<br>
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c<=
br>
index 72541905ec..1f6731e0af 100644<br>
--- a/target/microblaze/translate.c<br>
+++ b/target/microblaze/translate.c<br>
@@ -162,7 +162,7 @@ static void gen_goto_tb(DisasContext *dc, int n, target=
_ulong dest)<br>
=C2=A0 */<br>
=C2=A0static bool trap_illegal(DisasContext *dc, bool cond)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 if (cond &amp;&amp; (dc-&gt;tb_flags &amp; MSR_EE_FLAG)<br>
+=C2=A0 =C2=A0 if (cond &amp;&amp; (dc-&gt;tb_flags &amp; MSR_EE)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;&amp; dc-&gt;cpu-&gt;cfg.illegal_opc=
ode_exception) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_raise_hw_excp(dc, ESR_EC_ILLEGAL_OP);=
<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -178,7 +178,7 @@ static bool trap_userspace(DisasContext *dc, bool cond)=
<br>
=C2=A0 =C2=A0 =C2=A0int mem_index =3D cpu_mmu_index(&amp;dc-&gt;cpu-&gt;env=
, false);<br>
=C2=A0 =C2=A0 =C2=A0bool cond_user =3D cond &amp;&amp; mem_index =3D=3D MMU=
_USER_IDX;<br>
<br>
-=C2=A0 =C2=A0 if (cond_user &amp;&amp; (dc-&gt;tb_flags &amp; MSR_EE_FLAG)=
) {<br>
+=C2=A0 =C2=A0 if (cond_user &amp;&amp; (dc-&gt;tb_flags &amp; MSR_EE)) {<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_raise_hw_excp(dc, ESR_EC_PRIVINSN);<b=
r>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0return cond_user;<br>
-- <br>
2.25.1<br>
<br>
<br>
</blockquote></div></div></div>

--0000000000003bab7f05ae32f9f4--

