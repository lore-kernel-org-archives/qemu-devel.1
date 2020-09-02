Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F95AC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:16:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEAC8207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFt80J5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEAC8207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDYFR-0006Xy-56
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 15:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDYEl-0005js-P9
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:16:03 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:38417)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDYEk-0000qU-36
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:16:03 -0400
Received: by mail-lj1-x241.google.com with SMTP id w3so507596ljo.5
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 12:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=IHDoRdUrc7xKRd+yxrsT0yElMCxki3lw454XpUEvQlk=;
 b=LFt80J5rIjD2dYpFoIgK+UNcLTu03mf1+384nRph7AFHpQc77bmG7/8KvBwWzyVh8n
 vctvJCOWCbgpEVvZxLBNYxbbpiXzud2AwHAdF2ozGjwRCPdAkfvw5EkTbL91Rwjufd0F
 tSuMb3n5J/FiQc6UiwsOKxDYonsFBWLEJRXm7BNuYSdUadCHWXk6X347HyoVTQscnQJz
 tK74nd4BBH4pW6Car+k10Ze/VOr8nXm/ltAQVEl7LLrTje/9b0sKIMt7dDnkrEQIKo8q
 /ETTxmcEiE+5m8CEkUpha10xIDpZu6cdc+g3Oh0MublCZbjxpShnXWM+CaxHVR753XYS
 9hBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=IHDoRdUrc7xKRd+yxrsT0yElMCxki3lw454XpUEvQlk=;
 b=EU7OH5XdGt2jTFrZn5pRcUGmf+dR5uecY0btnUsUH3R0DWeYxyaEnihyUKsApJhP1K
 YzoJar8hiRNJ6RH81Ti0ucYV4S+XaMRh1RV/DQawe984NL/ZvN3onPMYvLqSa+TiYaHw
 gPQYqK2s3Eg7fPs8V48yFC3VQnTvvQ6FUkRN8BL/ixAL9ftfRM/vw2dx1Tz1EK8nJBvA
 MvK97YZRwZfjtxurvrObS7w7JM0cvgWcwMJpkbPnvbUpuv+dHACc++IW00prK/UiyGHT
 Mc5qvHwok7zs2EWfLlV79fcd3kjgN4QeatYxuCkPrbAV5qXhIF8kS77LuhNC78inLuIO
 ZCww==
X-Gm-Message-State: AOAM531J0Kzm2D663VVhjxfUPPj/sE92SKAgh05hDV+40FSIrNdXGUaI
 vGB2zbtxkeUBNWso1+Jn8Ay2XSM6rwafIOE3Lj5lsZhydskXRg==
X-Google-Smtp-Source: ABdhPJy/U1kfOZ/3Ox9crZ8JBSC6vnypRBAT/Mu6UTXgcP7dor3BMVUraG4ei0PoQ+jwijT9p2jm6MfNRUIRPXwkHdQ=
X-Received: by 2002:a2e:87d9:: with SMTP id v25mr4100946ljj.171.1599074159342; 
 Wed, 02 Sep 2020 12:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200902170054.810-1-luoyonggang@gmail.com>
 <20200902170054.810-4-luoyonggang@gmail.com>
 <5cde63a0-46fe-2944-f96e-1f3268e49af8@amsat.org>
 <CAE2XoE8bsq7jzbw6FMW3TybhQGiNEJ-F_NKPm3LHzkHm69hSdw@mail.gmail.com>
 <19b8d23c-c2e7-2d8e-50de-a4e977bae786@ilande.co.uk>
 <CAE2XoE_yO5kkQBFzJk+FzspJG-3gHD0Xvf7BSkOk45qhp1h4PA@mail.gmail.com>
 <0b52fa43-fa48-0add-40e2-cf3f06983c0c@ilande.co.uk>
 <CAE2XoE-DyKcYMDR2KsZA=1-7zr4jXOMh9ZMSA7OA=tbo4tr0PQ@mail.gmail.com>
 <5347d8f6-4caf-dffd-8677-a70d78808d21@ilande.co.uk>
In-Reply-To: <5347d8f6-4caf-dffd-8677-a70d78808d21@ilande.co.uk>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 3 Sep 2020 03:15:47 +0800
Message-ID: <CAE2XoE9Uz6ZPszK90zYBAo6bXNiPyRkhVmDkKDnE3mH5+=O1jA@mail.gmail.com>
Subject: Re: [PATCH 3/6] ci: Install msys2 in a proper way refer to
 https://github.com/cirruslabs/cirrus-ci-docs/issues/699 Enable msys2 ci in
 cirrus
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: multipart/alternative; boundary="0000000000003cb7b905ae597780"
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x241.google.com
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003cb7b905ae597780
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2020 at 3:13 AM Mark Cave-Ayland <
mark.cave-ayland@ilande.co.uk> wrote:

> On 02/09/2020 20:01, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
>
> >     Yes indeed, it looks like a very comprehensive build :)  Note that
> with the meson
> >     build I no longer have to copy/rename toolchain exes compared to
> your .cirrus.yml
> >     file so maybe that issue is now fixed?
> >
> > That's not fixed, I am building a full build, so I will use any possibl=
e
> toolchain,
> > and you may not use it at all.
>
> Hmmm. I'd expect meson to detect the toolchain once and use it throughout
> the build,
> so perhaps this is still using some Makefile logic? I think Paolo's lates=
t
> PR should
> help improve this.
>
> Yeap, improved but not done, I think once configure are gone, then the
tricky are gone

>
> ATB,
>
> Mark.
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000003cb7b905ae597780
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 3, 2020 at 3:13 AM Mark C=
ave-Ayland &lt;<a href=3D"mailto:mark.cave-ayland@ilande.co.uk">mark.cave-a=
yland@ilande.co.uk</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">On 02/09/2020 20:01, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang=
 Luo) wrote:<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0Yes indeed, it looks like a very comprehensive buil=
d :)=C2=A0 Note that with the meson<br>
&gt;=C2=A0 =C2=A0 =C2=A0build I no longer have to copy/rename toolchain exe=
s compared to your .cirrus.yml<br>
&gt;=C2=A0 =C2=A0 =C2=A0file so maybe that issue is now fixed?<br>
&gt; <br>
&gt; That&#39;s not fixed, I am building a full build, so I will use any po=
ssible toolchain,<br>
&gt; and you may not use it at all.=C2=A0<br>
<br>
Hmmm. I&#39;d expect meson to detect the toolchain once and use it througho=
ut the build,<br>
so perhaps this is still using some Makefile logic? I think Paolo&#39;s lat=
est PR should<br>
help improve this.<br>
<br></blockquote><div>Yeap, improved but not done, I think once configure a=
re gone, then the tricky are gone=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
<br>
ATB,<br>
<br>
Mark.<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--0000000000003cb7b905ae597780--

