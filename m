Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEA5C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:27:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F7F120719
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7F120719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrKe-0005Ml-J5
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCr9c-0007Np-Mo
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:15:52 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37977)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCr9a-000194-VW
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:15:52 -0400
Received: by mail-qt1-f195.google.com with SMTP id e5so5865337qth.5
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 14:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+hesfGwEK/+a5X4ELA7ADh3xp1XKsiCTQm3rde/w1qo=;
 b=gXUUtjdzoIIMgR0uordDNKACKOxiRrzS0e4iCp/PUpXBIioL9oRF1ss6ueoldNhpUW
 ccQhTJ9ODMVckYzx+YORxLtNFABcnLbbjlqT/6xf649wD6tLpAa6bTGKdUlZjfAsMGsf
 P6nrwxK62oGqnBp5snEX4IcvWvfsoN0r6AL3BIEC5J4OjKkp4GMX72GbWgfcB+4zlTPS
 dU+plu6Culd0D5e9pNp5qd4yRLBwMtUJVTGgaw72sCUpuY4uL3ri+ysoxtrzRaCxwxpP
 Ms4GVstLJeGGwRNaf4NrERAxSeHvGFuW57aD7F2WO+stwz7srgwNeJSNtycX9YaLGOL6
 jMLA==
X-Gm-Message-State: AOAM531TWgbLgYyNmfNbdfSNGAIfiQAJg4f7CulIBPh5bsHc5vOmZuT9
 MRpAC6lg+2jCM76iqH4dnwUWgjM/bRHQsQ2G9Pw=
X-Google-Smtp-Source: ABdhPJx0ntSzw7D7wgUJiV5Uqr62zjRVB/JbWYghqcHChvflQTToLku/0wkARmJ0h6kBImibCihqBwJSo6os4CP7rAw=
X-Received: by 2002:ac8:7455:: with SMTP id h21mr3267497qtr.201.1598908550099; 
 Mon, 31 Aug 2020 14:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200828141929.77854-1-richard.henderson@linaro.org>
 <20200828141929.77854-3-richard.henderson@linaro.org>
In-Reply-To: <20200828141929.77854-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 31 Aug 2020 19:31:12 +0200
Message-ID: <CAAdtpL7PtexnAPsLLFaiuFsVouSAqyyyTVozgdkek5PA_Nk4Dg@mail.gmail.com>
Subject: Re: [PATCH v2 02/76] tests/tcg: Do not require FE_TOWARDZERO
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000002837ee05ae32e800"
Received-SPF: pass client-ip=209.85.160.195;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-qt1-f195.google.com
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

--0000000000002837ee05ae32e800
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 28 ao=C3=BBt 2020 16:22, Richard Henderson <richard.henderson@linar=
o.org>
a =C3=A9crit :

> This is optional in ISO C, and not all cpus provide it.
>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

---
>  tests/tcg/multiarch/float_convs.c | 2 ++
>  tests/tcg/multiarch/float_madds.c | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/tests/tcg/multiarch/float_convs.c
> b/tests/tcg/multiarch/float_convs.c
> index 47e24b8b16..e9be75c2d5 100644
> --- a/tests/tcg/multiarch/float_convs.c
> +++ b/tests/tcg/multiarch/float_convs.c
> @@ -30,7 +30,9 @@ float_mapping round_flags[] =3D {
>  #ifdef FE_DOWNWARD
>      { FE_DOWNWARD, "downwards" },
>  #endif
> +#ifdef FE_TOWARDZERO
>      { FE_TOWARDZERO, "to zero" }
> +#endif
>  };
>
>  static void print_input(float input)
> diff --git a/tests/tcg/multiarch/float_madds.c
> b/tests/tcg/multiarch/float_madds.c
> index eceb4ae38b..e422608ccd 100644
> --- a/tests/tcg/multiarch/float_madds.c
> +++ b/tests/tcg/multiarch/float_madds.c
> @@ -29,7 +29,9 @@ float_mapping round_flags[] =3D {
>  #ifdef FE_DOWNWARD
>      { FE_DOWNWARD, "downwards" },
>  #endif
> +#ifdef FE_TOWARDZERO
>      { FE_TOWARDZERO, "to zero" }
> +#endif
>  };
>
>
> --
> 2.25.1
>
>
>

--0000000000002837ee05ae32e800
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">Le ven. 28 ao=C3=BBt 2020 16:22, Richard Henderson &lt;<a =
href=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.org</=
a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">This is =
optional in ISO C, and not all cpus provide it.<br>
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
=C2=A0tests/tcg/multiarch/float_convs.c | 2 ++<br>
=C2=A0tests/tcg/multiarch/float_madds.c | 2 ++<br>
=C2=A02 files changed, 4 insertions(+)<br>
<br>
diff --git a/tests/tcg/multiarch/float_convs.c b/tests/tcg/multiarch/float_=
convs.c<br>
index 47e24b8b16..e9be75c2d5 100644<br>
--- a/tests/tcg/multiarch/float_convs.c<br>
+++ b/tests/tcg/multiarch/float_convs.c<br>
@@ -30,7 +30,9 @@ float_mapping round_flags[] =3D {<br>
=C2=A0#ifdef FE_DOWNWARD<br>
=C2=A0 =C2=A0 =C2=A0{ FE_DOWNWARD, &quot;downwards&quot; },<br>
=C2=A0#endif<br>
+#ifdef FE_TOWARDZERO<br>
=C2=A0 =C2=A0 =C2=A0{ FE_TOWARDZERO, &quot;to zero&quot; }<br>
+#endif<br>
=C2=A0};<br>
<br>
=C2=A0static void print_input(float input)<br>
diff --git a/tests/tcg/multiarch/float_madds.c b/tests/tcg/multiarch/float_=
madds.c<br>
index eceb4ae38b..e422608ccd 100644<br>
--- a/tests/tcg/multiarch/float_madds.c<br>
+++ b/tests/tcg/multiarch/float_madds.c<br>
@@ -29,7 +29,9 @@ float_mapping round_flags[] =3D {<br>
=C2=A0#ifdef FE_DOWNWARD<br>
=C2=A0 =C2=A0 =C2=A0{ FE_DOWNWARD, &quot;downwards&quot; },<br>
=C2=A0#endif<br>
+#ifdef FE_TOWARDZERO<br>
=C2=A0 =C2=A0 =C2=A0{ FE_TOWARDZERO, &quot;to zero&quot; }<br>
+#endif<br>
=C2=A0};<br>
<br>
<br>
-- <br>
2.25.1<br>
<br>
<br>
</blockquote></div></div></div>

--0000000000002837ee05ae32e800--

