Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA250C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 19:20:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8209420760
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 19:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFED6ow7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8209420760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqiHm-0005Lz-Qc
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 15:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jqiGT-0004tX-7i
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 15:19:25 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:45225)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jqiGQ-0007ex-Bu
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 15:19:24 -0400
Received: by mail-il1-x142.google.com with SMTP id o3so4670366ilo.12
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 12:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=79mc7L1AKxfwXdLQWWGJAPJxubmcsBTtklOtonR/w7k=;
 b=CFED6ow7oZEKb5HXOD+gIDj48lfB5e+Sq2Yy78XIqdBav53tQy4a7D8ch3JmdUFjWe
 ZQorcx0LP45mzvxWfr8tA2YZ+LkMuel/AuE8nl0F1EVQDyLjLiEjjzVvLCTp4MnEq/1y
 BRJFprdeGfLrEeUuwlJFcm74HTyg1+/if4FThS0K2BB1G7vfPAgVX67kQw0Q7QB1rD1b
 EwhiTPfoSXP0yQPTft/KPOJp9HhlIjY25QEeurC/6N53XGGXtguan1UxuoHhdYL7GQMn
 LmLmhJO8FCXMNIpXN+Be4mssOaIlHqYmm8Kv7IMKiJ3fxJVx/8xptutFhxcJlqLBTWLn
 /pSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=79mc7L1AKxfwXdLQWWGJAPJxubmcsBTtklOtonR/w7k=;
 b=GOA7fJWI5wR3PBTOLxeZns9FLK306kNmaAKUjqXbtvOws5CqfCbkjgP2VVLiqrRe8S
 nh5lJqzAvpcQ+ODwRT7b5PUI0R9rQDDlMHbBt4sUKEfSj8E8FIo9WeRoOqsGWdBpqRfK
 AXYr4PA/PgrEMaEyw5Ti+jgpx0ceH7VSIk7jxcPxpX/i5LYTt/cAGV/4fZEkP4ZHL95Z
 FsuqLm29JsPruXyOYgJgG9jUwjD/ehxH70Dd2QetejlYlJgbMxETJYWub1xqvayw6d6p
 8NNkrFk3ddoxFZYmOgwzHomWl80K7zbB6+4NVT9xFqsu9DurCigS9v0t5b5U7ZQ7s8lh
 KkWw==
X-Gm-Message-State: AOAM533aS0Qm5ds1Z5M3Wn0yzuHitv1iXSnxlrr/JT+iwFkmLo3ie38p
 yDi4ETKrTkyC2gVitH9VDfJO2AwsfmBfR016CJM=
X-Google-Smtp-Source: ABdhPJxtY43n0DYnW12+IHEUqsUf49S89L9BF7iwRzsaOPCKd7gV1HN0UqUJMnwjCC0Ibvt4uUFfr5ueFdzCJktEUoU=
X-Received: by 2002:a05:6e02:48e:: with SMTP id
 b14mr8956259ils.143.1593631160520; 
 Wed, 01 Jul 2020 12:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200520235349.21215-1-pauldzim@gmail.com>
 <20200701182956.upx7jq3av2u2lleh@sirius.home.kraxel.org>
In-Reply-To: <20200701182956.upx7jq3av2u2lleh@sirius.home.kraxel.org>
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Wed, 1 Jul 2020 12:19:09 -0700
Message-ID: <CADBGO7_ugct2VceKBYcUkzTXODWVScvqLVnyJp0Vgt-A=m9xVg@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] dwc-hsotg (aka dwc2) USB host controller emulation
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000039df3005a9662bf6"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=pauldzim@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000039df3005a9662bf6
Content-Type: text/plain; charset="UTF-8"

On Wed, Jul 1, 2020 at 11:30 AM Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
>
> > This patch series adds emulation for the dwc-hsotg USB controller,
> > which is used on the Raspberry Pi 3 and earlier, as well as a number
> > of other development boards. The main benefit for Raspberry Pi is that
> > this enables networking on these boards, since the network adapter is
> > attached via USB.
>
> Doesn't apply cleanly to master.  Either some conflict due to other rpi3
> changes merged meanwhile, or a dependency on unmerged patches.  Can you
> check and resend?
>
> thanks,
>   Gerd
>
> Hi Gerd,

Peter already applied this series to master.

Thanks,
Paul

--00000000000039df3005a9662bf6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Wed, Jul 1, 2020 at 11:30 AM Gerd Hoffmann &lt;<a href=
=3D"mailto:kraxel@redhat.com">kraxel@redhat.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">=C2=A0 Hi,<br>
<br>
&gt; This patch series adds emulation for the dwc-hsotg USB controller,<br>
&gt; which is used on the Raspberry Pi 3 and earlier, as well as a number<b=
r>
&gt; of other development boards. The main benefit for Raspberry Pi is that=
<br>
&gt; this enables networking on these boards, since the network adapter is<=
br>
&gt; attached via USB.<br>
<br>
Doesn&#39;t apply cleanly to master.=C2=A0 Either some conflict due to othe=
r rpi3<br>
changes merged meanwhile, or a dependency on unmerged patches.=C2=A0 Can yo=
u<br>
check and resend?<br>
<br>
thanks,<br>
=C2=A0 Gerd<br>
<br>
</blockquote></div></div><div dir=3D"auto">Hi Gerd,</div><div dir=3D"auto">=
<br></div><div dir=3D"auto">Peter already applied this series to master.</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks,</div><div dir=3D"a=
uto">Paul</div>

--00000000000039df3005a9662bf6--

