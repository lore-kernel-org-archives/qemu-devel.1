Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19956C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:42:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D415423770
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCZ9z7hL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D415423770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jprF7-0005ZP-3C
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 06:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jprDI-0003vE-8O
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 06:40:36 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:53480)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jprDG-0002Ss-GW
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 06:40:35 -0400
Received: by mail-wm1-x331.google.com with SMTP id j18so14896053wmi.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 03:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=WvHySOHByyOqfiPucbdVL2c+sQMvouxzT9RzexWvpRk=;
 b=cCZ9z7hLD5LXHc7eg7oU4TgtZ/gE8JY73Tp0Akwma034+SHWIigMYQWAq+eS8dGpCF
 XCzPs+7IK1U9kFCPb8fgLyAYQ3ZiOIZROhFhZkolVt/xBqRbi9ERmGbsbIc3Is/OXz52
 fB6i5FUqGgBLUHcLgZgdZCeE2h8Y7Gkty33Kpk8mQNtTjfEV7bsctg7eUzqUYafmgek7
 bvmLf7DWBuiAhTBvmw/lVeZVAIo1vJvr6Z6AD/0JvSEBk1GvbqLijG9To4js13wvySyp
 ypXvtrxhxr4oZHzch1VHbTkT/HGzz7JN++dXB12oqYLKQtHlqqZhRgqz5uYho0A9eqCR
 LWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=WvHySOHByyOqfiPucbdVL2c+sQMvouxzT9RzexWvpRk=;
 b=RmFRKBbknSqZFfqum1/9QMh1PF7Mq0lSl5tdLjogTWxVYol1dU4wXN+0p+yY0NZFgT
 qrhy6+NNoz/12jCBt4HjOt4ANJOzRvb6/6K+WowtxTBQZJWDrZSwecpWcyqi2jQugF/f
 18oMNkOZLeZyQJzym0xG1Z1hNkhj1p23wtK6BHwX0gUanNNF2N9cNVStP5bIsj6HgFJI
 O6TLPreIoadOeDbOvwdrzU5zcYV5sPKtiOhMd5zy6md6paRCib5sSnO0dGjLZ3MASApR
 epMqRKhrKSfGIl7Id9Nh0QeBZTdUBe+802yg2CVvz7puc1cJi5uag4si37ys1La+12ou
 KFPg==
X-Gm-Message-State: AOAM531LTbzFzh3mmy8tYeXdE9G7UNl6QiG6pi3ZflYSpi1IfnSvJtai
 iHiVYuePb3E5pkulOOu011gCNeqvfD0ffhzmjHM=
X-Google-Smtp-Source: ABdhPJzJsa6f8+IWsDws+YhrxdRbqVsbaUkVbCjA6CHwQp5w8uzdgUXsnlI9zHTFuiowaRErxAoVGvKdmBGUw//06gk=
X-Received: by 2002:a1c:cc0d:: with SMTP id h13mr17502052wmb.168.1593427232820; 
 Mon, 29 Jun 2020 03:40:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b407:0:0:0:0:0 with HTTP; Mon, 29 Jun 2020 03:40:32
 -0700 (PDT)
In-Reply-To: <CALTWKrVAW33jJs1Q+51wN07DDUbAqwo=o+WDCpoT=NFB6dNZ6A@mail.gmail.com>
References: <CALTWKrVAW33jJs1Q+51wN07DDUbAqwo=o+WDCpoT=NFB6dNZ6A@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Mon, 29 Jun 2020 12:40:32 +0200
Message-ID: <CAHiYmc561nFcHR-RxqgCt9V+tegqpDbKFuDTdOEZKd9xW6MATw@mail.gmail.com>
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#2] Dissecting
 QEMU Into Three Main Parts
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000030104105a936b079"
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x331.google.com
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000030104105a936b079
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D1=99=D0=B0=D0=BA, 29. =D1=98=D1=83=D0=
=BD 2020., Ahmed Karaman <ahmedkhaledkaraman@gmail.com> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:

> Hi,
>
> The second report of the TCG Continuous Benchmarking series builds
> upon the QEMU performance metrics calculated in the previous report.
> This report presents a method to dissect the number of instructions
> executed by a QEMU invocation into three main phases:
> - Code Generation
> - JIT Execution
> - Helpers Execution
> It devises a Python script that automates this process.
>
> After that, the report presents an experiment for comparing the
> output of running the script on 17 different targets. Many conclusions
> can be drawn from the results and two of them are discussed in the
> analysis section.
>
> Report link:
> https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/
> Dissecting-QEMU-Into-Three-Main-Parts/
>
> Previous reports:
> Report 1 - Measuring Basic Performance Metrics of QEMU:
> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.html
>
>
My sincere congratulations on the Report 2!!

And, on top of that, this is an excellent idea to list previous reports, as
you did in the paragraph above.

Keep reports coming!!

Aleksandar



> Best regards,
> Ahmed Karaman
>

--00000000000030104105a936b079
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D0=BF=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D1=99=D0=B0=D0=BA, 29. =D1=98=
=D1=83=D0=BD 2020., Ahmed Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@=
gmail.com">ahmedkhaledkaraman@gmail.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=
=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex"><div dir=3D"ltr">Hi,<br><br>The second report of the TCG Continuous Ben=
chmarking series builds<br>upon the QEMU performance metrics calculated in =
the previous=C2=A0report.<br>This report presents a method to dissect the n=
umber of instructions<br>executed by a QEMU invocation into three main phas=
es:<div>- Code Generation<div>- JIT Execution<br>- Helpers Execution<br>It =
devises a Python script that automates this process.<br><br></div><div>Afte=
r that, the report presents an experiment for comparing the<br>output of ru=
nning the script on 17 different targets. Many conclusions</div><div>can be=
 drawn from the results and two of them are discussed in the</div><div>anal=
ysis section.<br></div><div><br></div><div>Report link:</div><div><a href=
=3D"https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/Dissecting-QEMU=
-Into-Three-Main-Parts/" target=3D"_blank">https://ahmedkrmn.github.io/<wbr=
>TCG-Continuous-Benchmarking/<wbr>Dissecting-QEMU-Into-Three-<wbr>Main-Part=
s/</a><br></div><div><br>Previous reports:</div><div>Report 1 - Measuring B=
asic Performance Metrics of QEMU:<br><a href=3D"https://lists.gnu.org/archi=
ve/html/qemu-devel/2020-06/msg06692.html" target=3D"_blank">https://lists.g=
nu.org/archive/<wbr>html/qemu-devel/2020-06/<wbr>msg06692.html</a><br></div=
><div><br></div></div></div></blockquote><div><br></div><div>My sincere con=
gratulations on the Report 2!!</div><div><br></div><div>And, on top of that=
, this is an excellent idea to list previous reports, as you did in the par=
agraph above.</div><div><br></div><div>Keep reports coming!!</div><div><br>=
</div><div>Aleksandar</div><div><br></div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex"><div dir=3D"ltr"><div><div>Best regards,<br>Ahmed Karaman</d=
iv></div></div>
</blockquote>

--00000000000030104105a936b079--

