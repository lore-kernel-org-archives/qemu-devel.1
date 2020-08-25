Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACB1C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E58320665
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+16MtHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E58320665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAZqO-0007DV-LX
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 10:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAZph-0006QJ-Ub
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:21:53 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b]:35027)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAZpe-0003Ss-Lu
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:21:53 -0400
Received: by mail-lf1-x12b.google.com with SMTP id y26so6252024lfe.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 07:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=aA/vb2nFqcCYu9TaNW9bKakzSusa3dUjxD6r4zcOZPs=;
 b=m+16MtHyOnT9V9Vc5LBBtlVc0IVLlXd4f+hNGDahQoSEQiS5PiGg4iCVuU5euKx3ED
 sqaqfGuTmOK+y4Lfc644XGEzNgu+A8xFGiRBxsq8jNOagFvtUqJKdDRTPV+0jTs8Ofg1
 9M//fWzmw2u1p7TP0TLsjRgRNgMZdwwqRZCK+ePva/j74wrK92oQWYvMKFdXu4cxlkFL
 GZO9ORPbbFYFfNDqnVsUgZCAfy+Ws4KB460CmjppUjfInFbLyt7vVYXueuCorHbrZTWK
 +RuBz2gaxqN/p2I2aQrhMWD60GJCZFxLiOsw3eYhN1kmFWTun2DETgdfp192jrffxm9E
 Am/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=aA/vb2nFqcCYu9TaNW9bKakzSusa3dUjxD6r4zcOZPs=;
 b=h6igSEKs5W9HJwEtg52FNaCB1LvXGrhes4Jtnb3K9prai3A3XDuKxjrlg/xrGR9LRo
 wmororE4rLQ4M7JwhthJzInmC60GeGRLeDJOWIZvGSsKSMT5vEb39ZVUzBWMMM4FbgOv
 nyxeg+wtU16WT5VPxotNt6SIchzFot7Dqv9GP0MMfy8DOf04EitUUua4RFHIdcQkMLyE
 JSbcGgxvkTMRd+htUpvymuJsGpUcdNiezReCCHRDzRHdRXx+XNGcOHulqpfDO0g/pXXH
 tIT/LuVofLxajE6XuUfgmwGUnmqbh3WLGumd8YWJPuVC0khhfSm8G32HVNeyx79T8bTW
 gcmw==
X-Gm-Message-State: AOAM533qbPQTwuQxLzJk09Pax01iCgUGHimjywUFlXqMNXEOQSAfpMKV
 gp/EiQoqFpMn3Eo/Sc8Gasm8XV64oc2HL12ktuU=
X-Google-Smtp-Source: ABdhPJz1SIjFNFUkK5nL6GoV3p7GKXVeNv+PAb4tqrqzNWMGxsIq/L8ioZ9MfdwBGfYXPGJlWv/ydbuSr2h6Pvb5Vxs=
X-Received: by 2002:ac2:4298:: with SMTP id m24mr2155341lfh.126.1598365308128; 
 Tue, 25 Aug 2020 07:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200825083500.359-1-luoyonggang@gmail.com>
 <20200825083500.359-4-luoyonggang@gmail.com>
 <20200825085949.GC107278@redhat.com>
 <CAE2XoE_jgZg8wjKZ5J5gPaR5VLORosJDv3+kr=re+LHqzbNoVg@mail.gmail.com>
 <146febe9-64ae-96de-e2df-4a65a320de9b@redhat.com>
In-Reply-To: <146febe9-64ae-96de-e2df-4a65a320de9b@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 25 Aug 2020 22:21:36 +0800
Message-ID: <CAE2XoE9XPZXzZAYtHQdq32zJL9fyG-4nU3uk4nBBg95AAuU8Ug@mail.gmail.com>
Subject: Re: [PATCH 4/5] meson: !/bin/sh are msys2 friendly.
To: Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000069937205adb46ceb"
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x12b.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000069937205adb46ceb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

OK, maybe convert this to python script would be a better option.
Then skip this first

On Tue, Aug 25, 2020 at 9:59 PM Eric Blake <eblake@redhat.com> wrote:

> On 8/25/20 4:11 AM, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> > Hi, works, msys2 sh compiled and run
>
> Top-formatting makes it harder to read, compared to interleaving your
> responses.
>
> msys2 sh _is_ bash, so that's not answering the question Dan asked.
>
>
> >>> +++ b/scripts/undefsym.sh
> >>> @@ -1,4 +1,4 @@
> >>> -#! /usr/bin/env bash
> >>> +#!/bin/sh
> >>
> >> Does this script actually work on non-bash shells ?  If not, then this
> >> change will likely break on plaforms where /bin/sh is not bash.
>
> A quick look at the script sees:
>
> comm -12 \
>    <( $NM -P -g $staticlib | awk '$2!=3D"U"{print "-Wl,-u," $1}' | sort -=
u) \
>    <( $NM -P -g "$@" | awk '$2=3D=3D"U"{print "-Wl,-u," $1}' | sort -u)
>
>
> <() is a bash'ism, so you _are_ breaking things on platforms like Debian
> where /bin/sh is dash rather than bash.
>
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000069937205adb46ceb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">OK, maybe convert this to python script would be a better =
option.<div>Then skip this first</div></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 25, 2020 at 9:59 PM Eric =
Blake &lt;<a href=3D"mailto:eblake@redhat.com">eblake@redhat.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 8/25/20 =
4:11 AM, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:<br>
&gt; Hi, works, msys2 sh compiled and run<br>
<br>
Top-formatting makes it harder to read, compared to interleaving your <br>
responses.<br>
<br>
msys2 sh _is_ bash, so that&#39;s not answering the question Dan asked.<br>
<br>
<br>
&gt;&gt;&gt; +++ b/scripts/undefsym.sh<br>
&gt;&gt;&gt; @@ -1,4 +1,4 @@<br>
&gt;&gt;&gt; -#! /usr/bin/env bash<br>
&gt;&gt;&gt; +#!/bin/sh<br>
&gt;&gt;<br>
&gt;&gt; Does this script actually work on non-bash shells ?=C2=A0 If not, =
then this<br>
&gt;&gt; change will likely break on plaforms where /bin/sh is not bash.<br=
>
<br>
A quick look at the script sees:<br>
<br>
comm -12 \<br>
=C2=A0 =C2=A0&lt;( $NM -P -g $staticlib | awk &#39;$2!=3D&quot;U&quot;{prin=
t &quot;-Wl,-u,&quot; $1}&#39; | sort -u) \<br>
=C2=A0 =C2=A0&lt;( $NM -P -g &quot;$@&quot; | awk &#39;$2=3D=3D&quot;U&quot=
;{print &quot;-Wl,-u,&quot; $1}&#39; | sort -u)<br>
<br>
<br>
&lt;() is a bash&#39;ism, so you _are_ breaking things on platforms like De=
bian <br>
where /bin/sh is dash rather than bash.<br>
<br>
<br>
-- <br>
Eric Blake, Principal Software Engineer<br>
Red Hat, Inc.=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+1-919-301-3226<br>
Virtualization:=C2=A0 <a href=3D"http://qemu.org" rel=3D"noreferrer" target=
=3D"_blank">qemu.org</a> | <a href=3D"http://libvirt.org" rel=3D"noreferrer=
" target=3D"_blank">libvirt.org</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div>

--00000000000069937205adb46ceb--

