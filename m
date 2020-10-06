Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19551C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 18:47:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38DFF206B5
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 18:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtVhwS4s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DFF206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPs03-0004cC-4x
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 14:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgaluk@gmail.com>)
 id 1kPrub-000667-2l
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 14:42:10 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:34708)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pavel.dovgaluk@gmail.com>)
 id 1kPruY-0007Xm-OZ
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 14:42:08 -0400
Received: by mail-qk1-x743.google.com with SMTP id c62so17834175qke.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 11:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c3P5fjarlc4QlOtN+CQTDZyYSzhD9SDhm8ClOaPXRC8=;
 b=jtVhwS4seqgKc6MNiMBMFktwhCPe6jPMD+JmUrl2OQxy1eNFAwLJrj/TwuRacWnUv4
 C2u15ryzuHHEY7KAmvL2912SldVJhZhL/t8oRlm54WOZQx/js486XdQXJYZACf9ngnI2
 sFxFHNJG817EANqyUIxRBKhGyzRhMnlq4LbeOrWZcEjWQH5L8zM2A69s2/nJAj/QdDP8
 JoZKK/6K4V4OohQAcxViFC9joZPbDa3NPTYx3Y9OQiqWVl7abgDpDXwztekNmgBeprrS
 lzay08tbSfERcy/a9AWol0g2MPer+SMvGk1eDQHqRT+E8jVFH6pb/4JxO6K5cpws8y+p
 IWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c3P5fjarlc4QlOtN+CQTDZyYSzhD9SDhm8ClOaPXRC8=;
 b=onPH/gb6mkdu8SmGX2VS6G/uqfBTZP1zes3niefGeNqBznAXzj6EmUoncqmyrQzQw3
 QQ3+eU9rgzSnsjxwZWVIMB7wf6Bvof+ywXaLLbTEcQG/+pS5iLjKBiNx3yK29Qd3k6YI
 LwrMlgfAJkuBLKLTdHvk6neAEBxnjLni1TPUwIBWyaG3ecotrv6GjWoCliWhmwtX71Cp
 lg+VlHOEeX7eCc+8DQx/rgMxghoTkp0DwONaBOmx3sofUsvlU69yGSyTfgao6RhDqh8X
 tcUJA0owU343R18qbrToLwtwB/s8SC7NDdKJ4YzZHkurHVAcVMUxkpwB6EKL3guFDU+/
 Ey0Q==
X-Gm-Message-State: AOAM531Dws+hPvUrovpJbngy8WOntkODV7cv4DKP8OxMjQpJV4m4KgRn
 n4sMVUXnCIvTLRZsXI+/oWiE+d4pgQl39EqCyuw=
X-Google-Smtp-Source: ABdhPJwp0sMH6GuzdrZb6D7XhD+oxZYuRDqbzvX3fKKvoAaXb+ox67Ldi0zKRn/G0GyClPGZPimXIsKkfPbMJyGjdiw=
X-Received: by 2002:a37:401:: with SMTP id 1mr7010738qke.285.1602009723616;
 Tue, 06 Oct 2020 11:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201004204010.2048608-1-f4bug@amsat.org>
 <20201004204010.2048608-2-f4bug@amsat.org>
 <CAMgSi0Hg4b_6MuPopG5YD-NL1OkhMsG1rUPKuuTmJJCBKXdZ0w@mail.gmail.com>
 <b272745a-7803-5cdd-23b9-142e9ad5ef60@amsat.org>
In-Reply-To: <b272745a-7803-5cdd-23b9-142e9ad5ef60@amsat.org>
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
Date: Tue, 6 Oct 2020 21:41:52 +0300
Message-ID: <CAMgSi0FsbitYRocQNNgXAE2G+55C9i992rzzydk4zsa4t6+W=g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] contrib/gitdm: Add more academic contributors
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="00000000000080c38f05b104f49a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::743;
 envelope-from=pavel.dovgaluk@gmail.com; helo=mail-qk1-x743.google.com
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Artem Pisarenko <artem.k.pisarenko@gmail.com>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000080c38f05b104f49a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2020 at 6:39 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
wrote:

> Hi Pavel,
>
> On 10/5/20 7:01 AM, Pavel Dovgalyuk wrote:
> > On Sun, Oct 4, 2020 at 11:40 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsa=
t.org
> > <mailto:f4bug@amsat.org>> wrote:
> >
> >     These academic contributors have a number of contributions,
> >     add them to the 'academic' group map.
> >
> >     Cc: Pavel Dovgaluk <pavel.dovgaluk@gmail.com
> >     <mailto:pavel.dovgaluk@gmail.com>>
> >     Cc: Jiaxun Yang <jiaxun.yang@flygoat.com
> >     <mailto:jiaxun.yang@flygoat.com>>
> >     Cc: Artem Pisarenko <artem.k.pisarenko@gmail.com
> >     <mailto:artem.k.pisarenko@gmail.com>>
> >     Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org
> >     <mailto:f4bug@amsat.org>>
> >     ---
> >     To the developers Cc'ed: If you agree with your entry, please
> >     reply with a Reviewed-by/Acked-by tag. If you disagree or doesn't
> >     care, please either reply with Nack-by or ignore this patch.
> >     I'll repost in 2 weeks as formal patch (not RFC) with only the
> >     entries acked by their author.
> >     ---
> >      contrib/gitdm/group-map-academics | 5 +++++
> >      1 file changed, 5 insertions(+)
> >
> >     diff --git a/contrib/gitdm/group-map-academics
> >     b/contrib/gitdm/group-map-academics
> >     index 08f9d81d13..c7b0dd46a3 100644
> >     --- a/contrib/gitdm/group-map-academics
> >     +++ b/contrib/gitdm/group-map-academics
> >     @@ -8,7 +8,12 @@
> >
> >      # Institute for System Programming of Russian Academy of Science
> >
> >
> > It's full name is: The Ivannikov Institute for System Programming of th=
e
> > Russian Academy of Sciences (ISP RAS)
>
> OK.
>
> >
> >
> >      ispras.ru <http://ispras.ru>
> >     +pavel.dovgaluk@gmail.com <mailto:pavel.dovgaluk@gmail.com>
> >
> >
> > Please change to pavel.dovgalyuk@ispras.ru
> > <mailto:pavel.dovgalyuk@ispras.ru>
>
> This is not to redirect your email, this is to count
> the following commit as academic (I guess remember you
> were having a problem with your pavel.dovgalyuk@ispras.ru
> email at that time so you posted from GMail):
>
>
Ok.


> $ git log --oneline --author=3Dpavel.dovgaluk@gmail.com
> 5fb0a6b5e7 icount: make dma reads deterministic
> 878ec29b9c replay: record and replay random number sources
> fc6b2dbac1 replay: check other timers for icount limit
> 35e32d9e2e qapi: add support for blkreplay driver
> 86cf9e1546 replay: don't synchronize memory operations in replay mode
> 9e9b10c649 icount: remove unnecessary gen_io_end calls
> 89a44a1033 i386: Save EFER for 32-bit targets
>
> >      # Columbia University
> >      cs.columbia.edu <http://cs.columbia.edu>
> >      cota@braap.org <mailto:cota@braap.org>
> >     +
> >     +jiaxun.yang@flygoat.com <mailto:jiaxun.yang@flygoat.com>
> >     +
> >     +artem.k.pisarenko@gmail.com <mailto:artem.k.pisarenko@gmail.com>
> >     --
> >     2.26.2
> >
> >
> >
> > --
> > Pavel Dovgalyuk
>


--=20
Pavel Dovgalyuk

--00000000000080c38f05b104f49a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 6, 2020 at 6:39 PM Philip=
pe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.or=
g</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>Hi Pavel,<br>
<br>
On 10/5/20 7:01 AM, Pavel Dovgalyuk wrote:<br>
&gt; On Sun, Oct 4, 2020 at 11:40 PM Philippe Mathieu-Daud=C3=A9 &lt;<a hre=
f=3D"mailto:f4bug@amsat.org" target=3D"_blank">f4bug@amsat.org</a><br>
&gt; &lt;mailto:<a href=3D"mailto:f4bug@amsat.org" target=3D"_blank">f4bug@=
amsat.org</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0These academic contributors have a number of contri=
butions,<br>
&gt;=C2=A0 =C2=A0 =C2=A0add them to the &#39;academic&#39; group map.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Cc: Pavel Dovgaluk &lt;<a href=3D"mailto:pavel.dovg=
aluk@gmail.com" target=3D"_blank">pavel.dovgaluk@gmail.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:pavel.dovgaluk@gmail.c=
om" target=3D"_blank">pavel.dovgaluk@gmail.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Cc: Jiaxun Yang &lt;<a href=3D"mailto:jiaxun.yang@f=
lygoat.com" target=3D"_blank">jiaxun.yang@flygoat.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:jiaxun.yang@flygoat.co=
m" target=3D"_blank">jiaxun.yang@flygoat.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Cc: Artem Pisarenko &lt;<a href=3D"mailto:artem.k.p=
isarenko@gmail.com" target=3D"_blank">artem.k.pisarenko@gmail.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:artem.k.pisarenko@gmai=
l.com" target=3D"_blank">artem.k.pisarenko@gmail.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a h=
ref=3D"mailto:f4bug@amsat.org" target=3D"_blank">f4bug@amsat.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:f4bug@amsat.org" targe=
t=3D"_blank">f4bug@amsat.org</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0To the developers Cc&#39;ed: If you agree with your=
 entry, please<br>
&gt;=C2=A0 =C2=A0 =C2=A0reply with a Reviewed-by/Acked-by tag. If you disag=
ree or doesn&#39;t<br>
&gt;=C2=A0 =C2=A0 =C2=A0care, please either reply with Nack-by or ignore th=
is patch.<br>
&gt;=C2=A0 =C2=A0 =C2=A0I&#39;ll repost in 2 weeks as formal patch (not RFC=
) with only the<br>
&gt;=C2=A0 =C2=A0 =C2=A0entries acked by their author.<br>
&gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0contrib/gitdm/group-map-academics | 5 +++++<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A01 file changed, 5 insertions(+)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/contrib/gitdm/group-map-academics<br>
&gt;=C2=A0 =C2=A0 =C2=A0b/contrib/gitdm/group-map-academics<br>
&gt;=C2=A0 =C2=A0 =C2=A0index 08f9d81d13..c7b0dd46a3 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/contrib/gitdm/group-map-academics<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/contrib/gitdm/group-map-academics<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -8,7 +8,12 @@<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0# Institute for System Programming of Russian=
 Academy of Science<br>
&gt; <br>
&gt; <br>
&gt; It&#39;s full name is:=C2=A0The Ivannikov Institute for System Program=
ming of the<br>
&gt; Russian Academy of Sciences (ISP RAS)<br>
<br>
OK.<br>
<br>
&gt; =C2=A0<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0<a href=3D"http://ispras.ru" rel=3D"noreferre=
r" target=3D"_blank">ispras.ru</a> &lt;<a href=3D"http://ispras.ru" rel=3D"=
noreferrer" target=3D"_blank">http://ispras.ru</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<a href=3D"mailto:pavel.dovgaluk@gmail.com" target=
=3D"_blank">pavel.dovgaluk@gmail.com</a> &lt;mailto:<a href=3D"mailto:pavel=
.dovgaluk@gmail.com" target=3D"_blank">pavel.dovgaluk@gmail.com</a>&gt;<br>
&gt; <br>
&gt; <br>
&gt; Please change to <a href=3D"mailto:pavel.dovgalyuk@ispras.ru" target=
=3D"_blank">pavel.dovgalyuk@ispras.ru</a><br>
&gt; &lt;mailto:<a href=3D"mailto:pavel.dovgalyuk@ispras.ru" target=3D"_bla=
nk">pavel.dovgalyuk@ispras.ru</a>&gt;<br>
<br>
This is not to redirect your email, this is to count<br>
the following commit as academic (I guess remember you<br>
were having a problem with your <a href=3D"mailto:pavel.dovgalyuk@ispras.ru=
" target=3D"_blank">pavel.dovgalyuk@ispras.ru</a><br>
email at that time so you posted from GMail):<br>
<br></blockquote><div><br></div><div>Ok.</div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
$ git log --oneline --author=3D<a href=3D"mailto:pavel.dovgaluk@gmail.com" =
target=3D"_blank">pavel.dovgaluk@gmail.com</a><br>
5fb0a6b5e7 icount: make dma reads deterministic<br>
878ec29b9c replay: record and replay random number sources<br>
fc6b2dbac1 replay: check other timers for icount limit<br>
35e32d9e2e qapi: add support for blkreplay driver<br>
86cf9e1546 replay: don&#39;t synchronize memory operations in replay mode<b=
r>
9e9b10c649 icount: remove unnecessary gen_io_end calls<br>
89a44a1033 i386: Save EFER for 32-bit targets<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0# Columbia University<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0<a href=3D"http://cs.columbia.edu" rel=3D"nor=
eferrer" target=3D"_blank">cs.columbia.edu</a> &lt;<a href=3D"http://cs.col=
umbia.edu" rel=3D"noreferrer" target=3D"_blank">http://cs.columbia.edu</a>&=
gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0<a href=3D"mailto:cota@braap.org" target=3D"_=
blank">cota@braap.org</a> &lt;mailto:<a href=3D"mailto:cota@braap.org" targ=
et=3D"_blank">cota@braap.org</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<a href=3D"mailto:jiaxun.yang@flygoat.com" target=
=3D"_blank">jiaxun.yang@flygoat.com</a> &lt;mailto:<a href=3D"mailto:jiaxun=
.yang@flygoat.com" target=3D"_blank">jiaxun.yang@flygoat.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<a href=3D"mailto:artem.k.pisarenko@gmail.com" tar=
get=3D"_blank">artem.k.pisarenko@gmail.com</a> &lt;mailto:<a href=3D"mailto=
:artem.k.pisarenko@gmail.com" target=3D"_blank">artem.k.pisarenko@gmail.com=
</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0-- <br>
&gt;=C2=A0 =C2=A0 =C2=A02.26.2<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; -- <br>
&gt; Pavel Dovgalyuk<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr">Pavel Dovgalyuk</div></div></di=
v>

--00000000000080c38f05b104f49a--

