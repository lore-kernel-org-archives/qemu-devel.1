Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD357C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D40F20658
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pG4fu7zQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D40F20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJG5C-00023E-7q
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 09:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kJG1u-0000b2-0q
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:02:22 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229]:34506)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kJG1q-0007TU-VT
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:02:21 -0400
Received: by mail-lj1-x229.google.com with SMTP id v23so5053735ljd.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 06:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=/EFwHhm7whkv6+hZwGDd49b4hwfuH7U0n6jiFuF16ZE=;
 b=pG4fu7zQQo6GKZlYa5NBpA7RWa5slMEF86Hb8+cFU9VzuwbUkBrk0bxFjzV4mIxDgU
 4rXIudnndTGQ+wks3cDEHJM9k4l1NG00od5KS8bftZmuZC1tL+z08+JIejclr0Du6SHE
 9Me2MFOcmh94Hw6/WpB1BulfD5N9nXvp3/HtnN1Z1eA6Qi2JFPYbIfxlpuXof8Rvvmi6
 mgiaB3eYtayzIl2hIzYxlRNYUICohpSl6C6kJBWXr1leLaTrLHrQnIiE3UWZMDGIZgU8
 QRQcInZw+bOD7I9CzVuhn5Sv2zi0uywcm/GHz2uPTKZcOsfmtSEeE1kPMpvEJfXG+A69
 VZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=/EFwHhm7whkv6+hZwGDd49b4hwfuH7U0n6jiFuF16ZE=;
 b=lhd1FcOMwvs5BbTIcaeWDCvq5egxHtOl1uPbaqROdhIPmrTd+PnjUO13NKCpUKeYwj
 i978uJBYSFBHOv9yDvy94xJgUa8YqglTJTboJLYZUUYZblVCBX59toxiSUMdGWR/AjLN
 AqffVdQ7s7i9xf5c42smDEpt1mz4RU0CrMxWxp7RWl+q0My6+VuM5De1ffjkIZDy1JEI
 w6bRYlUIyYWdjNfrUl9oEIH9u5uUnqCev0LtOzj6kTvDmprgQ0RVAOYLvhTaSi2DUSy+
 hn07WhgMZ9WpAIn010zYgHAQktny3Vg3a04eJ4Ljc7k6HOO3FjVlBAYEOnHhXu3S8ski
 uMWQ==
X-Gm-Message-State: AOAM531Dx1QgAfNH0amHE0A9UG8TszvaZdaUZ0kqW41sOYURaqHxUT1n
 ++DoVp9PuumsfTvkbcXCR2JULHO+xgpLhXrgDLk=
X-Google-Smtp-Source: ABdhPJxa34Ow5XZpJS8tEI5MqDDA/UvuW2qAzt2z1Sy3JageUewj4f/4693LGMNGGZy/x4hIeF+WZr0b619GYMFzwkY=
X-Received: by 2002:a2e:89d6:: with SMTP id c22mr12555145ljk.242.1600434136567; 
 Fri, 18 Sep 2020 06:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200917235720.2685978-1-richard.henderson@linaro.org>
 <20200917235720.2685978-2-richard.henderson@linaro.org>
 <047ad15d-e847-a53d-d0ef-443196085e10@redhat.com>
 <CAE2XoE_Dk-h1hyZSBDuf-TZS1i+p2fMtsk5P9ugHpQPARSvmdA@mail.gmail.com>
 <b10357f4-3d0c-9c8a-5f3a-dda3a7706399@redhat.com>
In-Reply-To: <b10357f4-3d0c-9c8a-5f3a-dda3a7706399@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 18 Sep 2020 21:02:05 +0800
Message-ID: <CAE2XoE-hVvHcepqvTyyqr5-D=s2kdydGDCCfMeLSi31bL76nOg@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] capstone: Convert Makefile bits to meson bits
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000003255d905af961cce"
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x229.google.com
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
Reply-To: luoyonggang@gmail.com
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003255d905af961cce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2020 at 8:58 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 18/09/20 10:42, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> > I also have a question that how about convert
> >   --disable-capstone) capstone=3D"no"
> >   ;;
> >   --enable-capstone) capstone=3D"yes"
> >   ;;
> > to
> >     --disable-capstone) capstone=3D"disabled"
> >   ;;
> >   --enable-capstone) capstone=3D"enabled"
> >   ;;
> >
> > for consistence with meson
>
> We can do it but it need not hold this series IMHO.
Fine with that, I am trying to convert iconv and curses from configure to
meson
waiting for this series.
>
> Paolo
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000003255d905af961cce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Fri, Sep 18, 2020 at 8:58 PM Paolo Bonzini &lt;=
<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<b=
r>&gt;<br>&gt; On 18/09/20 10:42, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo)=
 wrote:<br>&gt; &gt; I also have a question that how about convert<br>&gt; =
&gt; =C2=A0 --disable-capstone) capstone=3D&quot;no&quot;<br>&gt; &gt; =C2=
=A0 ;;<br>&gt; &gt; =C2=A0 --enable-capstone) capstone=3D&quot;yes&quot;<br=
>&gt; &gt; =C2=A0 ;;<br>&gt; &gt; to <br>&gt; &gt; =C2=A0 =C2=A0 --disable-=
capstone) capstone=3D&quot;disabled&quot;<br>&gt; &gt; =C2=A0 ;;<br>&gt; &g=
t; =C2=A0 --enable-capstone) capstone=3D&quot;enabled&quot;<br>&gt; &gt; =
=C2=A0 ;;<br>&gt; &gt;<br>&gt; &gt; for consistence with meson<br>&gt;<br>&=
gt; We can do it but it need not hold this series IMHO.<div>Fine with that,=
 I am trying to convert iconv and curses from configure to meson</div><div>=
waiting for this series.<br>&gt;<br>&gt; Paolo<br>&gt;<br><br><br>--<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=
=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</di=
v></div>

--0000000000003255d905af961cce--

