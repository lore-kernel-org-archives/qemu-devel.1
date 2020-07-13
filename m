Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979B9C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 02:05:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57D22206D9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 02:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="E+zfVvjg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D22206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1junqv-0003Bs-MO
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 22:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1junqA-0002fY-TT
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 22:05:10 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:37469)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1junq9-0007JB-5U
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 22:05:10 -0400
Received: by mail-ot1-x32f.google.com with SMTP id w17so8429888otl.4
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2020 19:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hUVel/xU/BOej0nYVdF1QFva42QIH8kA/EPuRaK071M=;
 b=E+zfVvjg1Weef4qqpqLq+8deXufDOy3GG9DMfE8OXqQWRs7nzC8BdA15TRCYsqgBmI
 t4S9iHmyHJGR3ViUxhfQ6IrbYcU7+tUeaQaUxxOD6YyEI2qq024B+VqdY6ZXpnwRTojd
 dWwChwYOwz/b+ipOnAuLmhYDIz6M7Gup8zKtVTGxgSy0upc1In2hMfXPKhmWwHJNiECI
 jtTznYjh1clKOd0JP3LjLQhS9slF9zXhTUZ/97600sNWjoMy/weP+OUvcWqtfHAuf/GY
 +yRiS1m8gAZGOgo7LjXhOmvs9uL9wNgJy3njuBHgC4obJr6tImvjt4I1mq0lVNDZu5MS
 mRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hUVel/xU/BOej0nYVdF1QFva42QIH8kA/EPuRaK071M=;
 b=sgp3bD0mVPzTZnJhUe+LSqC23xugAAJmGswSZ4o0S7tvhf5dtE4utaNyjDV+exEXUv
 j+FmfEdMDoYKmf2mKJYxX0W0igK5osV4VdEOp+iF6r/MdkAwjD7REp7x6rQ3cKPOrt+p
 kxTUFxadbu7/Y5JmmiijqO9p64IPbbaSCvfgWBFHFhvDDusvAhGP3JbokyvYXoCucz9A
 /D8cxNawPCZ5ml+LLAUKWI50spsfb29fRYShb2w4xqveKoQQOzpEXjdmnEa1AQzPOENw
 1w6Qsv9cufQbcyKm/yxD44y5b/y6iqZYDtDV6BpPbs6vOvOYO+SNl3+dhL+dLkLaov8G
 FL0g==
X-Gm-Message-State: AOAM533REy/aD429VDPMWyJIj714Kmlia0+aZC7W7sRGMgPUN0FQpqFv
 sot3d3PUrlo7WlckuzUdfpFXnzAVHKlegWgIEzy91g==
X-Google-Smtp-Source: ABdhPJwmT2anp+GkqzwGqkx3sYwCqTZ+fQn8ctRJa0bxm4w/YxR0Xr2ggALqAaSmklOmbZHssrePC05/6XxjNEv1tEE=
X-Received: by 2002:a9d:5e93:: with SMTP id f19mr5236512otl.175.1594605908003; 
 Sun, 12 Jul 2020 19:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200710104920.13550-1-frank.chang@sifive.com>
 <20200710104920.13550-15-frank.chang@sifive.com>
 <0dc40d00-a89d-9818-9fd3-2bce4141eca7@linaro.org>
In-Reply-To: <0dc40d00-a89d-9818-9fd3-2bce4141eca7@linaro.org>
From: Frank Chang <frank.chang@sifive.com>
Date: Mon, 13 Jul 2020 10:04:57 +0800
Message-ID: <CAE_xrPjb2RRd8BTg+1FSYBUVnV6DSSQrot0Z33NE9ej10C-uRg@mail.gmail.com>
Subject: Re: [RFC 14/65] target/riscv: rvv-0.9: stride load and store
 instructions
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000b423d305aa491e7b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=frank.chang@sifive.com; helo=mail-ot1-x32f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-riscv@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b423d305aa491e7b
Content-Type: text/plain; charset="UTF-8"

On Sat, Jul 11, 2020 at 2:15 AM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 7/10/20 3:48 AM, frank.chang@sifive.com wrote:
> >  # *** Vector loads and stores are encoded within LOADFP/STORE-FP ***
> > -vlb_v      ... 100 . 00000 ..... 000 ..... 0000111 @r2_nfvm
> > -vlh_v      ... 100 . 00000 ..... 101 ..... 0000111 @r2_nfvm
> > -vlw_v      ... 100 . 00000 ..... 110 ..... 0000111 @r2_nfvm
>
> Again, something you can't do until 0.7.1 is not supported.
>
> If you don't want to simultaneously support 0.7.1 and 0.9/1.0, then you
> should
> simply remove 0.7.1 in the first patch, so that there's no confusion.
>
> Is the rest of it mostly renaming?  You should definitely expand on what
> you're
> doing within each patch description.  A description of what has changed in
> the
> spec since 0.7.1 will help the reviewer validate that you've gotten all of
> the
> corner cases.
>
> I am going to stop reviewing this patch series now, as I expect that most
> of
> the remaining patches will have similar comments.
>
>
> r~
>

Thanks for the reviews.

I will rearrange my commits as what you suggest and add more comments in my
next patchset.

--
Frank Chang

--000000000000b423d305aa491e7b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Sat, Jul 11, 2020 at 2:15 AM Richard H=
enderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.hender=
son@linaro.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">On 7/10/20 3:48 AM, <a href=3D"mai=
lto:frank.chang@sifive.com" target=3D"_blank">frank.chang@sifive.com</a> wr=
ote:<br>
&gt;=C2=A0 # *** Vector loads and stores are encoded within LOADFP/STORE-FP=
 ***<br>
&gt; -vlb_v=C2=A0 =C2=A0 =C2=A0 ... 100 . 00000 ..... 000 ..... 0000111 @r2=
_nfvm<br>
&gt; -vlh_v=C2=A0 =C2=A0 =C2=A0 ... 100 . 00000 ..... 101 ..... 0000111 @r2=
_nfvm<br>
&gt; -vlw_v=C2=A0 =C2=A0 =C2=A0 ... 100 . 00000 ..... 110 ..... 0000111 @r2=
_nfvm<br>
<br>
Again, something you can&#39;t do until 0.7.1 is not supported.<br>
<br>
If you don&#39;t want to simultaneously support 0.7.1 and 0.9/1.0, then you=
 should<br>
simply remove 0.7.1 in the first patch, so that there&#39;s no confusion.<b=
r>
<br>
Is the rest of it mostly renaming?=C2=A0 You should definitely expand on wh=
at you&#39;re<br>
doing within each patch description.=C2=A0 A description of what has change=
d in the<br>
spec since 0.7.1 will help the reviewer validate that you&#39;ve gotten all=
 of the<br>
corner cases.<br>
<br>
I am going to stop reviewing this patch series now, as I expect that most o=
f<br>
the remaining patches will have similar comments.<br>
<br>
<br>
r~<br></blockquote><div><br></div><div>Thanks for the reviews.</div><div><b=
r></div><div>I will rearrange my commits as what you suggest and add more c=
omments in my next patchset.</div><div><br></div><div>--</div><div>Frank Ch=
ang</div></div></div>

--000000000000b423d305aa491e7b--

