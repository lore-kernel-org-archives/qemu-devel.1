Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A130CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 19:16:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0648820663
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 19:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SgXkvors"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0648820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNM74-0005pu-BK
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 15:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36249)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNL1d-00048c-5S
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 14:06:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNL1b-0001aB-Py
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 14:06:25 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35016)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNL1b-0001Zg-HG
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 14:06:23 -0400
Received: by mail-wm1-x342.google.com with SMTP id v6so3572418wmj.0
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 11:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EKFh6acBp9Wc8h1YCwiVKmh6XqoXcCYgET15wPbnLk8=;
 b=SgXkvorskh6gPRqw7J2evZi6u23902WqlxQLFnprg8LuHiK4CONx0pRNb/UyZUxBOd
 wxIiYdR+3PqKOW19380xhIrMuAtLLm3mMaZhy2NrEmslDtEBrNrp7Wb1Rf/s0RJySE2Y
 VGKZLVHAsaTYzVLiLKquoLNootwVeT+VOcNde+/yT4ss4MJD49Br7EdQiRQ1kSy0zTlc
 vm46r8TgyNVmriKHuwCIBkeG8pSiea/JExXpG23Cuku2/AcGa0gCdxjzsCL4LPjObfwF
 A+r8D5LDXZkYYgW2InJhv4m1kpukPCqkBJMsCc5AzURrTxGBP0sd3EvffhSxyHRH+SqZ
 vgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EKFh6acBp9Wc8h1YCwiVKmh6XqoXcCYgET15wPbnLk8=;
 b=InW9DDRvKLhmp+F898QazUgPqi1cmlB9SWW6OE/JoXpVogdIPBUOkGF1MeScmcPTDb
 +kq8YQQCt6qumu6B9dCMzNbsRyc60hC+1WqCJfXlfNj5W4Ba4WpPP1BRU22zqRCN/tQr
 6icM74hIXgd06TneHUvzRyButKkuzMxiA9MYwmSqCwrr/ZbCMA2Q/ekdSBwrrYcq5+ox
 2kD8dAruteaTEASq0razmr787P0N1RPekk3Vbkix5Trp6bbNW7ktJAd2RUISdwTf7pyL
 k/r6P4VIsYVe1GaRsFnrmuQHz16pUUh2I+hG0H8oLP+htMF+HmIgyWiPMcvu0N7Ti3Vm
 HSfg==
X-Gm-Message-State: APjAAAXTRo7xhEk6kgIpyPpqMGEQ3oy0MqDqeY8DUrj9zFznwvkE2QJ5
 8/tuu/PnsI+i0uOnJcbGESe7kDesBzWAg/QtLo/GZw==
X-Google-Smtp-Source: APXvYqx0l+XM+y/RM5lBNKK08dmvrItnrfq1oaOVrorSFF6qrqtgnxooCEJnrGSerzK40GYbI9eFcfvFcEy+nJdGwRY=
X-Received: by 2002:a1c:dfc5:: with SMTP id w188mr1007379wmg.133.1571853981650; 
 Wed, 23 Oct 2019 11:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20191018174431.1784-1-richard.henderson@linaro.org>
 <CAFEAcA-MyKoA63UF6DYQ6J-dKihYn9iyG09eFCgWT8j4OqsQnw@mail.gmail.com>
 <CAFEAcA-Xj-6CdVzgfcVONipApD5b5PZ84nPnvbbOQjQkqQLnqA@mail.gmail.com>
 <6e06dede-2470-92e1-eba9-40646ed56af0@linaro.org> <87zhhrmqyh.fsf@linaro.org>
 <3e366a5d-0de6-ff1d-7a0c-a40ef8a2bf98@linaro.org>
In-Reply-To: <3e366a5d-0de6-ff1d-7a0c-a40ef8a2bf98@linaro.org>
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Date: Wed, 23 Oct 2019 19:06:11 +0100
Message-ID: <CAHDbmO3BZCUMkk0Q=6ZcRqG7D47vy8enYdh6hpeVXsRoEL4FkQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/22] target/arm: Reduce overhead of
 cpu_get_tb_cpu_state
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000373710059597c659"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000373710059597c659
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For system emulation? Sure. I think linux-user is harder because you need
the be crt and libs packaged.

On Wed, 23 Oct 2019, 17:13 Richard Henderson, <richard.henderson@linaro.org=
>
wrote:

> On 10/23/19 11:17 AM, Alex Benn=C3=A9e wrote:
> >>> Dropping this series again for the moment.
> >> Argh!  I had forgotten that we have no testing of armeb in check-tcg.
> >
> > Does it need it's own toolchain or can it be done with flags?
>
> I think the compiler only needs flags, so we might be able to gin
> something up
> for {aarch64_eb,armeb}-linux-user from __start.
>
>
> r~
>

--000000000000373710059597c659
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">For system emulation? Sure. I think linux-user is harder =
because you need the be crt and libs packaged.</div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 23 Oct 2019, 17:13 Ri=
chard Henderson, &lt;<a href=3D"mailto:richard.henderson@linaro.org">richar=
d.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">On 10/23/19 11:17 AM, Alex Benn=C3=A9e wrote:<br>
&gt;&gt;&gt; Dropping this series again for the moment.<br>
&gt;&gt; Argh!=C2=A0 I had forgotten that we have no testing of armeb in ch=
eck-tcg.<br>
&gt; <br>
&gt; Does it need it&#39;s own toolchain or can it be done with flags?<br>
<br>
I think the compiler only needs flags, so we might be able to gin something=
 up<br>
for {aarch64_eb,armeb}-linux-user from __start.<br>
<br>
<br>
r~<br>
</blockquote></div>

--000000000000373710059597c659--

