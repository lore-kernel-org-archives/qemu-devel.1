Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637B7C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 22:26:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E64A207EA
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 22:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E64A207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCsFf-0003Ef-7H
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 18:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCsF9-0002p4-JF
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 18:25:39 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:46283)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCsF8-0000aD-2K
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 18:25:39 -0400
Received: by mail-ej1-f67.google.com with SMTP id d11so10531686ejt.13
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 15:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GiITunImWLxF+Mg4B7y1Vfcbq3Z9nzKDf9U3Q+aas0s=;
 b=auTb/ddz3TRm+Q9cVIf+wELu+ldjVNoRllIQBD+xZDnyaqYIi56exh7vbB1GU3Zmh8
 xVJ53PS63Ld2ug5mL7+ByCTO7aVcoJAwMabz10PTZs4OcTQ8Q39qNqR8x3ynLtcjsTZk
 IWpDpQsaoL2IHpdehUsCM/TDJQF0+0C3MywYnpQFJ480vure9mQYOqXYA886UeDVZII4
 M4NFmpBdd9TmWrYxMEkGkGZuD6qgAfUDkITMILCalnE9jDId/KH9u+MEKzcs7MH3Q037
 QQ5zhpm1kxFvfVLMcP7Tsd1tumZZS/ilsmS2VgO4RbTXHYcD8Nhr7vazVsUuNNGRE92f
 6cPA==
X-Gm-Message-State: AOAM532K2PtxNSsPS0cC8nyGRlwiiEO1UnB091ZwMVwkWjiV373gIu8S
 bIiaZqOIBIgnDTr2WmGLVc2wxk90rSe/YzZOhDA=
X-Google-Smtp-Source: ABdhPJx6A+BjOzVd2mSYnRq5gYEXRvEnhoMFAOMAIAsCiRDpl+FUoszY3f8BT2Sw565GDhAVSxpgbRzxH8vitjBpSAk=
X-Received: by 2002:a17:906:7715:: with SMTP id
 q21mr2865480ejm.251.1598912736628; 
 Mon, 31 Aug 2020 15:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200828141929.77854-1-richard.henderson@linaro.org>
 <20200828141929.77854-63-richard.henderson@linaro.org>
 <CAAdtpL5PueR0ezHJ7ATH-qD6K+8OaSGqqd4jBSy+D6+9CCaSaw@mail.gmail.com>
 <bede313e-37ab-8f66-194c-7efd46fa0954@linaro.org>
In-Reply-To: <bede313e-37ab-8f66-194c-7efd46fa0954@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 1 Sep 2020 00:25:24 +0200
Message-ID: <CAAdtpL4aZSDDP8JU_Jv37D+XU11Ad1zNi6ff-g6o2pjUAV77Hw@mail.gmail.com>
Subject: Re: [PATCH v2 62/76] target/microblaze: Tidy mb_cpu_dump_state
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000b192d405ae33e166"
Received-SPF: pass client-ip=209.85.218.67;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-f67.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 17:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_MESSAGE=0.001,
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

--000000000000b192d405ae33e166
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 1 sept. 2020 00:16, Richard Henderson <richard.henderson@linaro.org=
>
a =C3=A9crit :

> On 8/31/20 2:08 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi Richard,
> >
> > Le ven. 28 ao=C3=BBt 2020 16:46, Richard Henderson <
> richard.henderson@linaro.org
> > <mailto:richard.henderson@linaro.org>> a =C3=A9crit :
> >
> >     Using lookup_symbol is quite slow; remove that.  Decode the
> >
> >
> > Can we add some runtime option to enable its use instead?
>
> We do the lookup with -d in_asm.
> Do we really need it with -d cpu as well?
>
> The -d cpu can be called many millions of times more than -d in_asm, and
> the
> two are relatively easy to correlate.
>

Ah I missed that. This is fine then!

Thanks,

Phil.


>
> r~
>

--000000000000b192d405ae33e166
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">Le mar. 1 sept. 2020 00:16, Richard Henderson &lt;<a href=3D"m=
ailto:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&gt; a =
=C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 8/31/20 2:08 P=
M, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt; Hi Richard,=C2=A0<br>
&gt; <br>
&gt; Le ven. 28 ao=C3=BBt 2020 16:46, Richard Henderson &lt;<a href=3D"mail=
to:richard.henderson@linaro.org" target=3D"_blank" rel=3D"noreferrer">richa=
rd.henderson@linaro.org</a><br>
&gt; &lt;mailto:<a href=3D"mailto:richard.henderson@linaro.org" target=3D"_=
blank" rel=3D"noreferrer">richard.henderson@linaro.org</a>&gt;&gt; a =C3=A9=
crit=C2=A0:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Using lookup_symbol is quite slow; remove that.=C2=
=A0 Decode the<br>
&gt; <br>
&gt; <br>
&gt; Can we add some runtime option to enable its use instead?<br>
<br>
We do the lookup with -d in_asm.<br>
Do we really need it with -d cpu as well?<br>
<br>
The -d cpu can be called many millions of times more than -d in_asm, and th=
e<br>
two are relatively easy to correlate.<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Ah I missed that. This is fine then!<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks,=C2=A0</div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Phil.</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">
<br>
<br>
r~<br>
</blockquote></div></div></div>

--000000000000b192d405ae33e166--

