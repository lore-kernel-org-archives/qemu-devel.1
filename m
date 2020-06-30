Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D5AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 06:00:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDCD620674
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 06:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNRmw0T4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDCD620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq9JR-0006Aj-Sc
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 02:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jq9Im-0005kV-JK
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 01:59:28 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132]:45907)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jq9Ik-000056-Sy
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 01:59:28 -0400
Received: by mail-lf1-x132.google.com with SMTP id s16so5174418lfp.12
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 22:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=oQNpE/O1bERJ3aVsJxeJvmSbfY2XC6wig843TZ6hRl8=;
 b=GNRmw0T4h8d3IHJ9b+UxhNmGbSdsEJwB6Zv1Y0BgIOGetakJ1QELkL9mnkuTttk+dl
 vdxy66bmIceiifIR2wJamCCli4z7YAA7ssOfI6tr+x6zJKtfiSnGAWeQ8s5APWZQ/3e/
 XeoKOlco/GTrj6d8erxnuBz2xeZneXplT69dE+j4Mq8e6m0wcYDBrfHAI1YwmVpIjPjL
 pVWOdd+TyYwWN7FlDMvBIjxDxPYXwew8YjnNwX550RcrkvZKwSgGqjb4C/V79OZfsaeH
 00MK7F8iVJ7Y1s3QLknXzFfUCSy/j5WWOAnItSu5Tpnn+0ctGLmW/GSVtw+S4RMVTKYt
 tAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=oQNpE/O1bERJ3aVsJxeJvmSbfY2XC6wig843TZ6hRl8=;
 b=qpyS9Us94DWHNIpF5iM71O2NVzdVM3Zy2x4SZTCgBSHYXS9N4nLW/1aVbXFq6CrCc/
 1bLQ389buYW9G97RBE7MuXlCyfhaUPh6zshNrm9UiQ7mGp/RuUU6hvlc3VCv3T7v+eAz
 l1TTfDrKkzX0YlVJwI8X0eqRzVZ/h13FDdmAs/cF6lIXyKrZiywyRbGhuNvIwIsqore/
 +VD7fK2YBzoNmpaxREhJr+/v0u8U+KAYQlq7YHMyXt9zCa7kZX9lGCvYSuGPi11YGsHm
 Nl+5dMBXgK2kol0LtHvDnA94nJrk2cJrxlHTlpyihZ57Jyd4P+kT44oo5PUa4rLr6SK3
 0QUA==
X-Gm-Message-State: AOAM5333iFqAmPywYFStklBq0OLAyexs/z7g6Po6kAXzQyiMpfpwfB78
 YlLqn22ScL2X/maPVEQSea6eWhHVSqij5ICW2rs=
X-Google-Smtp-Source: ABdhPJyG7V0FPlLYBO6Ogj+JOwCdGyomGP2aCWmtYkynzqGtF/81ikdvg11fQvyZRf90dK5w4y79pmwddltPsynYBok=
X-Received: by 2002:a05:6512:783:: with SMTP id
 x3mr823611lfr.126.1593496764185; 
 Mon, 29 Jun 2020 22:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <CALTWKrVAW33jJs1Q+51wN07DDUbAqwo=o+WDCpoT=NFB6dNZ6A@mail.gmail.com>
In-Reply-To: <CALTWKrVAW33jJs1Q+51wN07DDUbAqwo=o+WDCpoT=NFB6dNZ6A@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 30 Jun 2020 13:59:11 +0800
Message-ID: <CAE2XoE-dOHGtJO5f0xXA7r4hEeL5LDOPB1TDNPjWNC+hf9Qyew@mail.gmail.com>
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#2] Dissecting
 QEMU Into Three Main Parts
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000094812605a946e069"
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x132.google.com
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
Reply-To: luoyonggang@gmail.com
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000094812605a946e069
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Wonderful work, May I reproduce the work on my local machine?

On Mon, Jun 29, 2020 at 6:26 PM Ahmed Karaman <ahmedkhaledkaraman@gmail.com=
>
wrote:

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
>
> https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/Dissecting-QEMU-I=
nto-Three-Main-Parts/
>
> Previous reports:
> Report 1 - Measuring Basic Performance Metrics of QEMU:
> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.html
>
> Best regards,
> Ahmed Karaman
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000094812605a946e069
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Wonderful=C2=A0work, May I reproduce the work on my local =
machine?</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Mon, Jun 29, 2020 at 6:26 PM Ahmed Karaman &lt;<a href=3D"mailto=
:ahmedkhaledkaraman@gmail.com">ahmedkhaledkaraman@gmail.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"=
>Hi,<br><br>The second report of the TCG Continuous Benchmarking series bui=
lds<br>upon the QEMU performance metrics calculated in the previous=C2=A0re=
port.<br>This report presents a method to dissect the number of instruction=
s<br>executed by a QEMU invocation into three main phases:<div>- Code Gener=
ation<div>- JIT Execution<br>- Helpers Execution<br>It devises a Python scr=
ipt that automates this process.<br><br></div><div>After that, the report p=
resents an experiment for comparing the<br>output of running the script on =
17 different targets. Many conclusions</div><div>can be drawn from the resu=
lts and two of them are discussed in the</div><div>analysis section.<br></d=
iv><div><br></div><div>Report link:</div><div><a href=3D"https://ahmedkrmn.=
github.io/TCG-Continuous-Benchmarking/Dissecting-QEMU-Into-Three-Main-Parts=
/" target=3D"_blank">https://ahmedkrmn.github.io/TCG-Continuous-Benchmarkin=
g/Dissecting-QEMU-Into-Three-Main-Parts/</a><br></div><div><br>Previous rep=
orts:</div><div>Report 1 - Measuring Basic Performance Metrics of QEMU:<br>=
<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.h=
tml" target=3D"_blank">https://lists.gnu.org/archive/html/qemu-devel/2020-0=
6/msg06692.html</a><br></div><div><br></div><div>Best regards,<br>Ahmed Kar=
aman</div></div></div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div>

--00000000000094812605a946e069--

