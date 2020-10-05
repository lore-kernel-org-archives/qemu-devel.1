Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C188CC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 05:02:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14BB820776
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 05:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rezrLhyf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14BB820776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPIdh-0001SI-1b
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 01:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgaluk@gmail.com>)
 id 1kPIcl-0000yE-Ea
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 01:01:23 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:38398)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pavel.dovgaluk@gmail.com>)
 id 1kPIci-0008Su-3b
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 01:01:22 -0400
Received: by mail-qt1-x844.google.com with SMTP id q26so3389520qtb.5
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 22:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BAiKAp26YCRUbJVBJ6VpwAiuB++x/Y7hd+yPxD/BSEQ=;
 b=rezrLhyfyKNZBsr9hP8b7vchihnkcZ45JC41O+WrtA1acs/T8g1dh8WIxuWgFS5TLF
 yf+6ZfwAY/pgaQUlvko4kvfyWv0WlBL0POF5AbnZajjSkkB8ArKXHohkBW3a+Hl1qdny
 4zcRuh12ZzJWmiyMvCVUYfvQRwxsnuPO2XethDCDiG/F3OOd5IjIF0rsDj9h7ZqRJ6KU
 tWzMRL+SP1vm4EvT2PhqfK8JWQiNzkstBAGsUNj64lkK6lsAI+qUprdvJ+3B9b+59X1S
 b4DNmtcXSfWwsCQeTQ6SyKPcZFI0y03A7oPUZZVu1f/y6myz87qkQlVKLhNN13iXXQQt
 WmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BAiKAp26YCRUbJVBJ6VpwAiuB++x/Y7hd+yPxD/BSEQ=;
 b=Ni4yx2SgOR/yn/gMU57rbINhGLQXrCYhPxVTYAgGbtsTZ21wJv+J1C0aQWqqJFl53r
 U76ZCjgcqbq5C9/V00yPLkJkh2M+ORUaQ4YY5zEMzWdN1Zj2I4MWazF7NGORWXaHsaDL
 hLddQiNEc5BYeYRb2XdfMtR7tdeKW3p9qy1XUo60HJfUIqbk4qwIuFrTfh+DXlSOZ/Yx
 tIBB5JW2H8fhZSuGzUsljm69cnE1WBkl3GqMcW9CA7QjV2vbs35vuVt2tYbyT4ZNsE3h
 H2r74MS14tEqG5UdyMMjg1KZ+uFX4QDroRlYQ8liPCyvjUBaNTf7C6QrBpRsWc+F65Qv
 tnOg==
X-Gm-Message-State: AOAM532q3LEMTa0u10EuphaKntIUbvDtOOCJzU9TIzMQVXs3slKl+jcY
 IDk7Tlr9JlwfpWYYKHzAWnu0+/m1j8yu1PMbFOs=
X-Google-Smtp-Source: ABdhPJz1yaSLR8DJ91dLKmYC2x4f8y1CnFsBneTjqEYCv+j0FX05GSja58z1QnHNkZE2B5sZOhO/TIp96Od2NGj0BOM=
X-Received: by 2002:ac8:6945:: with SMTP id n5mr12343679qtr.202.1601874076586; 
 Sun, 04 Oct 2020 22:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201004204010.2048608-1-f4bug@amsat.org>
 <20201004204010.2048608-2-f4bug@amsat.org>
In-Reply-To: <20201004204010.2048608-2-f4bug@amsat.org>
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
Date: Mon, 5 Oct 2020 08:01:05 +0300
Message-ID: <CAMgSi0Hg4b_6MuPopG5YD-NL1OkhMsG1rUPKuuTmJJCBKXdZ0w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] contrib/gitdm: Add more academic contributors
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="0000000000004f56d005b0e55fbd"
Received-SPF: pass client-ip=2607:f8b0:4864:20::844;
 envelope-from=pavel.dovgaluk@gmail.com; helo=mail-qt1-x844.google.com
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
Cc: Artem Pisarenko <artem.k.pisarenko@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004f56d005b0e55fbd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 4, 2020 at 11:40 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> These academic contributors have a number of contributions,
> add them to the 'academic' group map.
>
> Cc: Pavel Dovgaluk <pavel.dovgaluk@gmail.com>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Cc: Artem Pisarenko <artem.k.pisarenko@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> To the developers Cc'ed: If you agree with your entry, please
> reply with a Reviewed-by/Acked-by tag. If you disagree or doesn't
> care, please either reply with Nack-by or ignore this patch.
> I'll repost in 2 weeks as formal patch (not RFC) with only the
> entries acked by their author.
> ---
>  contrib/gitdm/group-map-academics | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/contrib/gitdm/group-map-academics
> b/contrib/gitdm/group-map-academics
> index 08f9d81d13..c7b0dd46a3 100644
> --- a/contrib/gitdm/group-map-academics
> +++ b/contrib/gitdm/group-map-academics
> @@ -8,7 +8,12 @@
>
>  # Institute for System Programming of Russian Academy of Science
>

It's full name is: The Ivannikov Institute for System Programming of the
Russian Academy of Sciences (ISP RAS)


>  ispras.ru
> +pavel.dovgaluk@gmail.com


Please change to pavel.dovgalyuk@ispras.ru


>
>
>  # Columbia University
>  cs.columbia.edu
>  cota@braap.org
> +
> +jiaxun.yang@flygoat.com
> +
> +artem.k.pisarenko@gmail.com
> --
> 2.26.2
>
>

--=20
Pavel Dovgalyuk

--0000000000004f56d005b0e55fbd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Oct 4, 2020 at 11:40 PM Phili=
ppe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.o=
rg</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">These academic contributors have a number of contributions,<br>
add them to the &#39;academic&#39; group map.<br>
<br>
Cc: Pavel Dovgaluk &lt;<a href=3D"mailto:pavel.dovgaluk@gmail.com" target=
=3D"_blank">pavel.dovgaluk@gmail.com</a>&gt;<br>
Cc: Jiaxun Yang &lt;<a href=3D"mailto:jiaxun.yang@flygoat.com" target=3D"_b=
lank">jiaxun.yang@flygoat.com</a>&gt;<br>
Cc: Artem Pisarenko &lt;<a href=3D"mailto:artem.k.pisarenko@gmail.com" targ=
et=3D"_blank">artem.k.pisarenko@gmail.com</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
---<br>
To the developers Cc&#39;ed: If you agree with your entry, please<br>
reply with a Reviewed-by/Acked-by tag. If you disagree or doesn&#39;t<br>
care, please either reply with Nack-by or ignore this patch.<br>
I&#39;ll repost in 2 weeks as formal patch (not RFC) with only the<br>
entries acked by their author.<br>
---<br>
=C2=A0contrib/gitdm/group-map-academics | 5 +++++<br>
=C2=A01 file changed, 5 insertions(+)<br>
<br>
diff --git a/contrib/gitdm/group-map-academics b/contrib/gitdm/group-map-ac=
ademics<br>
index 08f9d81d13..c7b0dd46a3 100644<br>
--- a/contrib/gitdm/group-map-academics<br>
+++ b/contrib/gitdm/group-map-academics<br>
@@ -8,7 +8,12 @@<br>
<br>
=C2=A0# Institute for System Programming of Russian Academy of Science<br><=
/blockquote><div><br></div><div>It&#39;s full name is:=C2=A0The Ivannikov I=
nstitute for System Programming of the Russian Academy of Sciences (ISP RAS=
)</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0<a href=3D"http://ispras.ru" rel=3D"noreferrer" target=3D"_blank">isp=
ras.ru</a><br>
+<a href=3D"mailto:pavel.dovgaluk@gmail.com" target=3D"_blank">pavel.dovgal=
uk@gmail.com</a></blockquote><div><br></div><div>Please change to <a href=
=3D"mailto:pavel.dovgalyuk@ispras.ru">pavel.dovgalyuk@ispras.ru</a></div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
=C2=A0# Columbia University<br>
=C2=A0<a href=3D"http://cs.columbia.edu" rel=3D"noreferrer" target=3D"_blan=
k">cs.columbia.edu</a><br>
=C2=A0<a href=3D"mailto:cota@braap.org" target=3D"_blank">cota@braap.org</a=
><br>
+<br>
+<a href=3D"mailto:jiaxun.yang@flygoat.com" target=3D"_blank">jiaxun.yang@f=
lygoat.com</a><br>
+<br>
+<a href=3D"mailto:artem.k.pisarenko@gmail.com" target=3D"_blank">artem.k.p=
isarenko@gmail.com</a><br>
-- <br>
2.26.2<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr">Pavel Dovgalyuk</div></div></di=
v>

--0000000000004f56d005b0e55fbd--

