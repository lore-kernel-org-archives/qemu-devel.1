Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDE2C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 04:22:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF8D921775
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 04:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+tVYzat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8D921775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF8fp-0001nq-U3
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 00:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kF8ea-0007KC-Hq; Mon, 07 Sep 2020 00:21:16 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:46230)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kF8eT-00073S-QA; Mon, 07 Sep 2020 00:21:16 -0400
Received: by mail-lf1-x142.google.com with SMTP id u27so6744193lfm.13;
 Sun, 06 Sep 2020 21:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=uAWCekkydZn1lOHe45YNp0uVn0gd0Kd5AXukfWwTbNU=;
 b=V+tVYzatmSgNhcaxQb2axzvLPl9BuO2NLq1eowymap6H4N5XRd54KYeLprTczx/wCe
 wkGQyJYTL8wFi0Jxx8L1ZxOI3qV5DmSv8HFu2sUhO5AqB1+TJv5y13cHEKa6AFrEiDTr
 1Y9zetTUrK+zpPZ0vFRtge8rhfvUg447WBAZkVJ1Z8r0TK/yverD4o4Ek6ZSwiH58DZ5
 /ocvqXua51pEcxl/RegnbWw/palSDBBoAb7Sjx8dRrOzuaBClHdjL2KJjRhCDNyXq/0t
 000qcqVC04MzIC5pd3eu6fjiEQ5QDrGg6nG+XPBHq3hD3u6BAE1c+U9vtcuqTsJdlNFf
 dNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=uAWCekkydZn1lOHe45YNp0uVn0gd0Kd5AXukfWwTbNU=;
 b=d1OwWz9CRzbiiTi5fjsZCA/GaoJ9DLu9TSIGgt3RqUa1dhQ2jiE4vU5Wp6JZPwIZWG
 aq3zgxGM7ENTc/Ce/nh/3VJn27646+DFAxEEruDKiVH+PQEcphodxGTNVJba0QF8LqaA
 7XDrU+q6Sej5riH2pz7d9rGunKGg9/Fvg2iILI9aQsFyhjciIFrbIRG45+p/PbuqyCls
 G5Lhfw9/JyVkQlPOtdsaHx5/wOhih1B2/O6SSrkam0RdIIgg8nBSYO/TqFiwGzbKUzwU
 pVgy2dXxHL3Adl+fOIt0GR21iimtoyxyPMwdzBCOyDX917nwII534w6mhrB0e6LvvL64
 rKsA==
X-Gm-Message-State: AOAM533VHlAj6/Sx+B6HC5E+ifitCp7gVGsI1cJ/pc6Uckn1nJKL0WB6
 vI9Qh28HhP92BitgkydSPXqt43e2xhoYUG7fcMU=
X-Google-Smtp-Source: ABdhPJxhcyunMsMtBHpPQqWD9+SiWuUF7KNz9vvE1ROZuMUHvqHZ0U2sEI/6FlrSW4q4wOiuktf9/VqJcD44OuMQuqc=
X-Received: by 2002:a19:b83:: with SMTP id 125mr5057367lfl.126.1599452435806; 
 Sun, 06 Sep 2020 21:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200905204236.1508-1-luoyonggang@gmail.com>
 <b40c03d0-99bc-eb94-200f-7cf9a7734797@linaro.org>
In-Reply-To: <b40c03d0-99bc-eb94-200f-7cf9a7734797@linaro.org>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Mon, 7 Sep 2020 12:20:24 +0800
Message-ID: <CAE2XoE9qajeCRoVBZYBSYycdB-+j0fL2atfUjP-vkhXHhjp9tg@mail.gmail.com>
Subject: Re: [PATCH] configure: Fixes ncursesw detection under msys2/mingw and
 enable curses
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000457c8405aeb18af3"
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x142.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-level <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000457c8405aeb18af3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2020 at 11:28 AM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 9/5/20 1:42 PM, Yonggang Luo wrote:
> > +    nativecharset_to_ucs2 =3D iconv_open("UCS-2", g_get_codeset());
>
> g_get_codeset():
> "a newly allocated string containing the name of the character set. This
> string
> must be freed with g_free()."
>
> You need to plug the memory leak.
>
> It's probably worth fixing the mistake in which we call this function fou=
r
> times from the same function.
>
Done with autofree

>
>
> r~
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000457c8405aeb18af3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Sep 6, 2020 at 11:28 AM Richa=
rd Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.he=
nderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">On 9/5/20 1:42 PM, Yonggang Luo wrote:<br>
&gt; +=C2=A0 =C2=A0 nativecharset_to_ucs2 =3D iconv_open(&quot;UCS-2&quot;,=
 g_get_codeset());<br>
<br>
g_get_codeset():<br>
&quot;a newly allocated string containing the name of the character set. Th=
is string<br>
must be freed with g_free().&quot;<br>
<br>
You need to plug the memory leak.<br>
<br>
It&#39;s probably worth fixing the mistake in which we call this function f=
our<br>
times from the same function.<br></blockquote><div>Done with autofree=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
r~<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000457c8405aeb18af3--

