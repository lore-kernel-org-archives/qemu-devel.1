Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9032AC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 17:34:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDA5622243
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 17:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxElYJJo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA5622243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT79G-000655-OS
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 13:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kT77x-0004ia-Ch; Thu, 15 Oct 2020 13:33:21 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232]:43740)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kT77v-000706-Ix; Thu, 15 Oct 2020 13:33:21 -0400
Received: by mail-lj1-x232.google.com with SMTP id d24so3961924ljg.10;
 Thu, 15 Oct 2020 10:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/XtkU6L2HwjsHy/Ql1KlFvdGZQRwGBNm2Yg8zUczf7I=;
 b=lxElYJJojq6SyRxahuxJswleFPe8CJf+zuF6H/qlpexOuPFSNqhWXVp4gTCzW+VLW8
 Vb9X9Uq17VaJa7oOCzh5wWHQK3a+D7jmws2AAVu8MyF7kVm9yG6+8rPVlRqnFfXx4w8o
 ETNuMqW87WHlAkIJefWJGHtbq+mH4YdJgV4V0xUbgLQ2GnM6q7tYwmErdckLwHgLwcVQ
 tbEyxsGCJKP268x3IbzfJ5KuWV1JlmXOy6z9GZ1rYCoh0utiAjDJEheqWeadRJzUvnaf
 bHd6+dDsa/jfo7kvLOoyej8BDWdHJy1BhCQ3vfax+T9XyWZVzNu/RThXwGWYLHPH3dkP
 a2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/XtkU6L2HwjsHy/Ql1KlFvdGZQRwGBNm2Yg8zUczf7I=;
 b=loPwj7QGgVnlvCMkJD4nR1gblLr51uDUEqBqa/jBC5iiJ33ZzO9iiHS/x+ejwm+nr2
 MqZA48buOX9m10gFBSK4Obb57PXWehrW0svm3Wc4Gt4D8u2OAiuPg75BhxuzFUOCkU3/
 gydL40gXI6VuarOhUOpnJWGywuOAr+kY7iM/6Tl5fSi0JFwJOrAo5XANuLZRmLoo4XbK
 PnlNDkQDA+/CYs3QRcoWSUtGN8XFBK0qTGxuza1FQZb8edQfDCquX8tYG/S9a08DQZvZ
 CzYsUBi0mAEJLzRN8Wc5Aopsvtvfp43ksZB3vYVXN4kG7r0XMKkXsOHr8mHJnvF558Sx
 SWuA==
X-Gm-Message-State: AOAM532wIzjsdroiehLZaEE6FQ2nMrVK3U71mDLBgNkBgmPNRMrgv0cO
 6gIof8yu4HyEO1K8em9JfCGfMIZpIgePjIsRNo8=
X-Google-Smtp-Source: ABdhPJzMxFFkzoQC6IVxYse6Cc9cGSfki1ryY6h7W0a29EA6ri9y4WYtxJmuE90pQJrXe+fkW3PoOULcEDq7RTCUhWs=
X-Received: by 2002:a2e:3309:: with SMTP id d9mr1555237ljc.79.1602783197567;
 Thu, 15 Oct 2020 10:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201015152139.28903-1-space.monkey.delivers@gmail.com>
 <20201015152139.28903-5-space.monkey.delivers@gmail.com>
 <3975e121-fb59-ffaa-456b-13e1a1b871be@linaro.org>
In-Reply-To: <3975e121-fb59-ffaa-456b-13e1a1b871be@linaro.org>
From: Alexey Baturo <baturo.alexey@gmail.com>
Date: Thu, 15 Oct 2020 20:33:06 +0300
Message-ID: <CAFukJ-CBdO=EWs2F3SWG7nGvzKsKkeW-iYNvEZw+aaZaqWbi3A@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] [RISCV_PM] Implement address masking functions
 required for RISC-V Pointer Masking extension
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000024a65005b1b90bea"
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lj1-x232.google.com
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
Cc: "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "space.monkey.delivers@gmail.com" <space.monkey.delivers@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Dave Smith <kupokupokupopo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000024a65005b1b90bea
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> g_assert_not_reached();
Would fix, thanks.

> bool
Would fix.

>!s->pm_enabled
Same.

> Don't need the if.
Would remove, thanks.

> And should it in fact be placed outside the ifdef?
Sure, you're right.

Richard, thank you for your time and effort reviewing these changes!

=D1=87=D1=82, 15 =D0=BE=D0=BA=D1=82. 2020 =D0=B3. =D0=B2 20:07, Richard Hen=
derson <richard.henderson@linaro.org
>:

> On 10/15/20 8:21 AM, Alexey Baturo wrote:
> > +        switch (priv) {
> > +        case PRV_U:
> > +            pm_enabled =3D env->mmte & U_PM_ENABLE;
> > +            break;
> > +        case PRV_S:
> > +            pm_enabled =3D env->mmte & S_PM_ENABLE;
> > +            break;
> > +        case PRV_M:
> > +            pm_enabled =3D env->mmte & M_PM_ENABLE;
> > +            break;
> > +        default:
> > +            assert(0 && "Unreachable");
>
> g_assert_not_reached();
>
> > +    /* PointerMasking extension */
> > +    uint8_t pm_enabled;
>
> bool
>
> > +    if (s->pm_enabled =3D=3D 0) {
>
> !s->pm_enabled
>
> > +    if (riscv_has_ext(env, RVJ)) {
> > +        ctx->pm_enabled =3D FIELD_EX32(tb_flags, TB_FLAGS, PM_ENABLED)=
;
> > +        int priv =3D cpu_mmu_index(env, false);
> > +        ctx->pm_mask =3D pm_mask[priv];
> > +        ctx->pm_base =3D pm_base[priv];
> > +    } else {
> > +        ctx->pm_enabled =3D 0;
> > +    }
>
> Don't need the if.  And should it in fact be placed outside the ifdef?
> This
> shouldn't be related to !CONFIG_USER_ONLY here and nowhere else.
>
>
> r~
>

--00000000000024a65005b1b90bea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt; g_assert_not_reached();<div>Would fix, thanks.</div><=
div><br></div><div>&gt; bool</div><div>Would fix.</div><div><br></div><div>=
&gt;!s-&gt;pm_enabled</div><div>Same.</div><div><br></div><div>&gt; Don&#39=
;t need the if.=C2=A0</div><div>Would remove, thanks.</div><div><br></div><=
div>&gt; And should it in fact be placed outside the ifdef?=C2=A0</div><div=
>Sure, you&#39;re right.</div><div><br></div><div>Richard, thank you for yo=
ur time and effort reviewing these changes!</div></div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D1=87=D1=82, 15 =D0=BE=D0=
=BA=D1=82. 2020 =D0=B3. =D0=B2 20:07, Richard Henderson &lt;<a href=3D"mail=
to:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&gt;:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">On 10/15/20 8:21 AM,=
 Alexey Baturo wrote:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (priv) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case PRV_U:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pm_enabled =3D env-&gt;mmte=
 &amp; U_PM_ENABLE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case PRV_S:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pm_enabled =3D env-&gt;mmte=
 &amp; S_PM_ENABLE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case PRV_M:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pm_enabled =3D env-&gt;mmte=
 &amp; M_PM_ENABLE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(0 &amp;&amp; &quot;U=
nreachable&quot;);<br>
<br>
g_assert_not_reached();<br>
<br>
&gt; +=C2=A0 =C2=A0 /* PointerMasking extension */<br>
&gt; +=C2=A0 =C2=A0 uint8_t pm_enabled;<br>
<br>
bool<br>
<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;pm_enabled =3D=3D 0) {<br>
<br>
!s-&gt;pm_enabled<br>
<br>
&gt; +=C2=A0 =C2=A0 if (riscv_has_ext(env, RVJ)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;pm_enabled =3D FIELD_EX32(tb_flag=
s, TB_FLAGS, PM_ENABLED);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int priv =3D cpu_mmu_index(env, false);<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;pm_mask =3D pm_mask[priv];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;pm_base =3D pm_base[priv];<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;pm_enabled =3D 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
Don&#39;t need the if.=C2=A0 And should it in fact be placed outside the if=
def?=C2=A0 This<br>
shouldn&#39;t be related to !CONFIG_USER_ONLY here and nowhere else.<br>
<br>
<br>
r~<br>
</blockquote></div>

--00000000000024a65005b1b90bea--

