Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B53C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:55:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B85C2067C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B85C2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAs9e-0000CJ-Pe
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 05:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kAs90-00087v-Vn; Wed, 26 Aug 2020 05:55:03 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:37029)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kAs8z-00023B-Gj; Wed, 26 Aug 2020 05:55:02 -0400
Received: by mail-ej1-f67.google.com with SMTP id e23so1216205ejb.4;
 Wed, 26 Aug 2020 02:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FzAXxHtJClfOAhmHQDc0jbByEzcdsccc5pKIkKHBStE=;
 b=CFvcfnT2o+uKHzGOcXwKLV5becYSAWLdQy1zHcGW/bKFMKo8cu08gnMFgm5d3cvO1/
 v0a+yp9EVHV3pWXG/r6XkWWspX0GXquVKRtWftcPAyQ7ZiFlaAlCOJGNtPA0vofUJRbj
 Eby6Y9g6gvK3aMJjD6PuLTrK1/rgQ1rr677RPAcpwo3yB3GGYcKp2bV7fUZbvHZ/+B/K
 FVKmr5U+Y4DCBwOvHPmiNX7sMQ6Ebp0yH+WSKswPLBp9sYyktef4lheGqbqnnFzGu4BB
 VfNA8aEnGx9xR1MFDNro3FYn/7rnRllwpdpdPYjGTDMKFT9/LiRmT5CjTxoJWK2RjDfN
 J02w==
X-Gm-Message-State: AOAM532c6ujCKncxuong+JmDTRg3DVHIUKvVhlzovkkYk5IF6DShsKnk
 DKsctMeEDolzo6woHApuazbqLyWRL2/41QBdMQ16bNyf
X-Google-Smtp-Source: ABdhPJxTU68mLxpa/I9VQ1aVOCNkQlcBOhy7Gyo0b7GRK26t4r3wsW2CFNUtuQAzSr6B8PPuwWoGJi40jZDUIR8XcNs=
X-Received: by 2002:a17:906:c1c3:: with SMTP id
 bw3mr15578114ejb.8.1598435699760; 
 Wed, 26 Aug 2020 02:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200812190206.31595-1-f4bug@amsat.org>
 <1ccf070b-7abd-ebfd-2788-92a81b4fc8fe@amsat.org>
 <CAFEAcA-nLLM3dqC=71JSfu9+8=xsnpfavD0Wk4Lkuf+EOytgQA@mail.gmail.com>
In-Reply-To: <CAFEAcA-nLLM3dqC=71JSfu9+8=xsnpfavD0Wk4Lkuf+EOytgQA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 26 Aug 2020 11:54:47 +0200
Message-ID: <CAAdtpL6_dxhkoBS2hK8O_8Qj9s-MAtRnrBOTQZyTAEkW5Xwz1A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] hw/misc/unimp: Improve how offset/value are
 displayed
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000014a21905adc4d07d"
Received-SPF: pass client-ip=209.85.218.67;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-f67.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 05:54:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.248, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, HTML_MESSAGE=0.001,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000014a21905adc4d07d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

Le lun. 24 ao=C3=BBt 2020 17:01, Peter Maydell <peter.maydell@linaro.org> a
=C3=A9crit :

> On Sat, 22 Aug 2020 at 21:02, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
> wrote:
> >
> > On 8/12/20 9:02 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > > This series aims to ease looking at the '-d unimp' output reported
> > > by the UnimplementedDevice.
> > >
> > > - read/write accesses are now aligned
> > > - the value format width uses the access size
> > > - the offset (address) uses the size of the memory region it belongs
> > >
> > > Series fully reviewed.
> >
> > ping?
>
> What tree were you expecting these to go in via? Probably worth
> being specific about who you're pinging in this kind of case ;-)
>

Ok understood for the next time. In this case you are listed as maintainer
:) Maybe you can Ack the series and then I'll ask to merge it via the
trivial or misc trees.


> -- PMM
>

--00000000000014a21905adc4d07d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Peter,=C2=A0<div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">Le lun. 24 ao=C3=BBt 2020 17:01, Peter Mayd=
ell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.or=
g</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Sa=
t, 22 Aug 2020 at 21:02, Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:=
f4bug@amsat.org" target=3D"_blank" rel=3D"noreferrer">f4bug@amsat.org</a>&g=
t; wrote:<br>
&gt;<br>
&gt; On 8/12/20 9:02 PM, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt; &gt; This series aims to ease looking at the &#39;-d unimp&#39; output=
 reported<br>
&gt; &gt; by the UnimplementedDevice.<br>
&gt; &gt;<br>
&gt; &gt; - read/write accesses are now aligned<br>
&gt; &gt; - the value format width uses the access size<br>
&gt; &gt; - the offset (address) uses the size of the memory region it belo=
ngs<br>
&gt; &gt;<br>
&gt; &gt; Series fully reviewed.<br>
&gt;<br>
&gt; ping?<br>
<br>
What tree were you expecting these to go in via? Probably worth<br>
being specific about who you&#39;re pinging in this kind of case ;-)<br></b=
lockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Ok unde=
rstood for the next time. In this case you are listed as maintainer :) Mayb=
e you can Ack the series and then I&#39;ll ask to merge it via the trivial =
or misc trees.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div clas=
s=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
-- PMM<br>
</blockquote></div></div></div>

--00000000000014a21905adc4d07d--

