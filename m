Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA3EC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:18:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7335920678
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7335920678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrCJ-00027u-87
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCr9X-0007D1-TB
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:15:47 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:34353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCr9W-00017k-7z
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:15:47 -0400
Received: by mail-ej1-f65.google.com with SMTP id d26so10445812ejr.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 14:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pH4AN0J1S8rxUY7tvtPyaKEI4oM9DyYokKXvKdxRSLo=;
 b=P1Cj6CHINBenQCuAO+yFpeQKilv5ZvMAuqeCb+9vaWH0L7rYdkdbHZyr6oo82FFJVn
 nND7uIPQbWpYTdx657IugsxibOFygJSzueQVR1pSztLOLwc7MrIv7C8ZrdbWwxsoFzKE
 VbCA/qoqM2XQ67bufgmxjstDc+gnv+VPZcHRSLu8+Y+WgSPmELgX+lq7cm/08RpBXeBZ
 s3zzrCN7Qck65m33Oetb3SHihsRdsJ9e78guLgUqIIGl6GQUp/wvGqgd9L8GILEi0Eya
 DmXgRkFS9m434g5xd3k/1TB/0L3w73fdfenEHXCJPZWwFe01sV/R9al1qdu4u3ijxddq
 NSWg==
X-Gm-Message-State: AOAM533/TJ7Mc+7gKxnX9AnKku5th20RQULiZ2f63VLhQ1c7INV/d6Is
 9LNSO0E/jWn91A2O6wjjvBtMz9eTDLnE8qi033M=
X-Google-Smtp-Source: ABdhPJxd94qNtlZM2xg6CGYJw+JaWr6DhybmdhMnI86xN1t+RoedsppLA6GHb5MRaxYictD1VRsZlTl2Evrcit6ZNlg=
X-Received: by 2002:a17:906:24d2:: with SMTP id
 f18mr191055ejb.510.1598908544361; 
 Mon, 31 Aug 2020 14:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200828180243.443016-1-richard.henderson@linaro.org>
 <20200828180243.443016-3-richard.henderson@linaro.org>
In-Reply-To: <20200828180243.443016-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 31 Aug 2020 19:18:26 +0200
Message-ID: <CAAdtpL4dG6PeuOconfpnzSjq3u+s2H8ODTEny5viB4RULxi=4g@mail.gmail.com>
Subject: Re: [PATCH 2/3] tcg: Eliminate one store for in-place 128-bit dup_mem
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000d0a72b05ae32e77e"
Received-SPF: pass client-ip=209.85.218.65;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-f65.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 17:15:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 FREEMAIL_FORGED_FROMDOMAIN=0.25, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d0a72b05ae32e77e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 28 ao=C3=BBt 2020 20:04, Richard Henderson <richard.henderson@linar=
o.org>
a =C3=A9crit :

> Do not store back to the exact memory from which we just loaded.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

---
>  tcg/tcg-op-gvec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index 793d4ba64c..fcc25b04e6 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -1581,7 +1581,7 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t
> dofs, uint32_t aofs,
>              TCGv_vec in =3D tcg_temp_new_vec(TCG_TYPE_V128);
>
>              tcg_gen_ld_vec(in, cpu_env, aofs);
> -            for (i =3D 0; i < oprsz; i +=3D 16) {
> +            for (i =3D (aofs =3D=3D dofs) * 16; i < oprsz; i +=3D 16) {
>                  tcg_gen_st_vec(in, cpu_env, dofs + i);
>              }
>              tcg_temp_free_vec(in);
> @@ -1591,7 +1591,7 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t
> dofs, uint32_t aofs,
>
>              tcg_gen_ld_i64(in0, cpu_env, aofs);
>              tcg_gen_ld_i64(in1, cpu_env, aofs + 8);
> -            for (i =3D 0; i < oprsz; i +=3D 16) {
> +            for (i =3D (aofs =3D=3D dofs) * 16; i < oprsz; i +=3D 16) {
>                  tcg_gen_st_i64(in0, cpu_env, dofs + i);
>                  tcg_gen_st_i64(in1, cpu_env, dofs + i + 8);
>              }
> --
> 2.25.1
>
>
>

--000000000000d0a72b05ae32e77e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">Le ven. 28 ao=C3=BBt 2020 20:04, Richard Henderson &lt;<a =
href=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.org</=
a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Do not s=
tore back to the exact memory from which we just loaded.<br>
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
=C2=A0tcg/tcg-op-gvec.c | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c<br>
index 793d4ba64c..fcc25b04e6 100644<br>
--- a/tcg/tcg-op-gvec.c<br>
+++ b/tcg/tcg-op-gvec.c<br>
@@ -1581,7 +1581,7 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dof=
s, uint32_t aofs,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv_vec in =3D tcg_temp_ne=
w_vec(TCG_TYPE_V128);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_ld_vec(in, cpu_env,=
 aofs);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; oprsz; i +=
=3D 16) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D (aofs =3D=3D dofs) * =
16; i &lt; oprsz; i +=3D 16) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_st_ve=
c(in, cpu_env, dofs + i);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_temp_free_vec(in);<br>
@@ -1591,7 +1591,7 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dof=
s, uint32_t aofs,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_ld_i64(in0, cpu_env=
, aofs);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_ld_i64(in1, cpu_env=
, aofs + 8);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; oprsz; i +=
=3D 16) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D (aofs =3D=3D dofs) * =
16; i &lt; oprsz; i +=3D 16) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_st_i6=
4(in0, cpu_env, dofs + i);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_st_i6=
4(in1, cpu_env, dofs + i + 8);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-- <br>
2.25.1<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000d0a72b05ae32e77e--

