Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80497C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:22:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DDF4206FA
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DDF4206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrFu-0006Y3-BD
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCr9c-0007Ni-ND
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:15:52 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35298)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCr9a-000192-VI
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:15:52 -0400
Received: by mail-qt1-f194.google.com with SMTP id p65so5889712qtd.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 14:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xWyvVdZky9Qv2jjfumWc2Uyaq0fWEqGgZVNopR5iiHs=;
 b=oSX2ElvXUrn2Bi9lc7zfO6v29YYQnWHumVINljO2L7CJomZI2xNow6Tjuo25dIH/s9
 yzFu2W3gj0qpOPzIg7K4KlRjYEthEmtbeu6NesLQ3ZLPlBz2Mdg6x/Ley29yy4qCgYR0
 IH/KLsQhGX+V6maT2mhZFcp7tCMeePJS1mq5WV3kG9ucQNM1qiRIM4lv8IIiG7qi7Y9i
 PSW0AJMtSwMj2kHptqB6+DRl47Omo/8nCuYxMPNmyrNtoScmdGgRgRDcVkB41+vGlzDz
 KpUBYRjeZp04dQWxT7Zbqm3FLJEW80NNmqVAhA0azzB7NkXQ5OJrdD9gv5sU3pObiQwE
 qH2g==
X-Gm-Message-State: AOAM5313gdmvAhwiYpmX3IDhtu5WFWhkH7jRH/ZlBZeGAeRiTjq8Om2k
 HBLYf0CLOKkW4d9ZG5vo7kZmIl94b9BIB6ombBY=
X-Google-Smtp-Source: ABdhPJzp/mATFfSUNpbp8Lq6WoiQdMTVs3LDYbmcCszjka8/zii7yH7WsBlhGVqLkHKlj/FY8Vhd2K21Kid0FpoGyek=
X-Received: by 2002:ac8:660f:: with SMTP id c15mr3340119qtp.34.1598908549971; 
 Mon, 31 Aug 2020 14:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200828141929.77854-1-richard.henderson@linaro.org>
 <20200828141929.77854-4-richard.henderson@linaro.org>
In-Reply-To: <20200828141929.77854-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 31 Aug 2020 19:30:28 +0200
Message-ID: <CAAdtpL68otRME2p8X1NQBA3uwNXSUKgA6suVE+uyZ+UbMutU7w@mail.gmail.com>
Subject: Re: [PATCH v2 03/76] tests/tcg: Do not require FE_* exception bits
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000026432305ae32e856"
Received-SPF: pass client-ip=209.85.160.194;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-qt1-f194.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 17:15:50
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000026432305ae32e856
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 28 ao=C3=BBt 2020 16:22, Richard Henderson <richard.henderson@linar=
o.org>
a =C3=A9crit :

> Define anything that is missing as 0, so that flags & FE_FOO
> is false for any missing FOO.
>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

---
>  tests/tcg/multiarch/float_helpers.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/tests/tcg/multiarch/float_helpers.h
> b/tests/tcg/multiarch/float_helpers.h
> index 6337bc66c1..309f3f4bf1 100644
> --- a/tests/tcg/multiarch/float_helpers.h
> +++ b/tests/tcg/multiarch/float_helpers.h
> @@ -8,6 +8,23 @@
>
>  #include <inttypes.h>
>
> +/* Some hosts do not have support for all of these; not required by ISO
> C. */
> +#ifndef FE_OVERFLOW
> +#define FE_OVERFLOW 0
> +#endif
> +#ifndef FE_UNDERFLOW
> +#define FE_UNDERFLOW 0
> +#endif
> +#ifndef FE_DIVBYZERO
> +#define FE_DIVBYZERO 0
> +#endif
> +#ifndef FE_INEXACT
> +#define FE_INEXACT 0
> +#endif
> +#ifndef FE_INVALID
> +#define FE_INVALID 0
> +#endif
> +
>  /* Number of constants in each table */
>  int get_num_f16(void);
>  int get_num_f32(void);
> --
> 2.25.1
>
>
>

--00000000000026432305ae32e856
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">Le ven. 28 ao=C3=BBt 2020 16:22, Richard Henderson &lt;<a =
href=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.org</=
a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Define a=
nything that is missing as 0, so that flags &amp; FE_FOO<br>
is false for any missing FOO.<br>
<br>
Reviewed-by: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@xilinx.=
com" target=3D"_blank" rel=3D"noreferrer">edgar.iglesias@xilinx.com</a>&gt;=
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
=C2=A0tests/tcg/multiarch/float_helpers.h | 17 +++++++++++++++++<br>
=C2=A01 file changed, 17 insertions(+)<br>
<br>
diff --git a/tests/tcg/multiarch/float_helpers.h b/tests/tcg/multiarch/floa=
t_helpers.h<br>
index 6337bc66c1..309f3f4bf1 100644<br>
--- a/tests/tcg/multiarch/float_helpers.h<br>
+++ b/tests/tcg/multiarch/float_helpers.h<br>
@@ -8,6 +8,23 @@<br>
<br>
=C2=A0#include &lt;inttypes.h&gt;<br>
<br>
+/* Some hosts do not have support for all of these; not required by ISO C.=
 */<br>
+#ifndef FE_OVERFLOW<br>
+#define FE_OVERFLOW 0<br>
+#endif<br>
+#ifndef FE_UNDERFLOW<br>
+#define FE_UNDERFLOW 0<br>
+#endif<br>
+#ifndef FE_DIVBYZERO<br>
+#define FE_DIVBYZERO 0<br>
+#endif<br>
+#ifndef FE_INEXACT<br>
+#define FE_INEXACT 0<br>
+#endif<br>
+#ifndef FE_INVALID<br>
+#define FE_INVALID 0<br>
+#endif<br>
+<br>
=C2=A0/* Number of constants in each table */<br>
=C2=A0int get_num_f16(void);<br>
=C2=A0int get_num_f32(void);<br>
-- <br>
2.25.1<br>
<br>
<br>
</blockquote></div></div></div>

--00000000000026432305ae32e856--

