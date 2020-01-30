Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634A5C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 07:09:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E8072083E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 07:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+PxyYQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8072083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix3xU-0000NU-BF
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 02:09:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hsp.cat7@gmail.com>) id 1ix3wo-0008HZ-5s
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 02:09:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1ix3wm-0007mH-WB
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 02:09:05 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46636)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>)
 id 1ix3wm-0007gf-PW; Thu, 30 Jan 2020 02:09:04 -0500
Received: by mail-ot1-x342.google.com with SMTP id g64so2130919otb.13;
 Wed, 29 Jan 2020 23:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/ZL3yrFImByXTRvvSQXEo/9Z3roN9PdOZ3/H9+MjK0w=;
 b=o+PxyYQ+6cNm8q/UtXMENC5UAXJa4NcAfLAEJl0PuIQk+DrEYJAsOdm0KvLilWNnh7
 7OAreNvmJ9vh21U4j4UXcU7TaTgCTdtYavF2YYWKRpfBeh1+Pr/TGVnF1gs5l7aEvIj1
 ug1trJ3OKNxU+v9sqND61mrrsz5KmS53JfFMzd92km2OIXB3LEta3E29obU3IWgFl2aD
 /9hzAQx4WZOBIqya5zJKNBeGwKE32GtvZTEIVSteZx/zuG8O9nI9hdXfAPxrQB76LoBK
 RiHBhCXpcwpm885LjwwOpjv5MizFvVXTkLscsJA5RtqD9pjS576Uu0EPn3y9dWwc1Ysa
 bJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/ZL3yrFImByXTRvvSQXEo/9Z3roN9PdOZ3/H9+MjK0w=;
 b=HkPgdTCKL5JU+FJw05bo6qqVRGg4PS5qz8CPfN3qa5K33bXTf+Iu3vEX06E+A5bf4R
 ItP4TiIjPEqT5UDRgg2bPw2flZVPjVLNEYP6KtHn7P5Y9bGY18J251aV97pd/GSUnBzX
 V21+4wpnun5aVn/1iU11pu0qiD1lQACIwmN0QMF0xvaH+JBioKEYh1yQ7X47ebKTS3tw
 O/KclQgWDbjrptN6EqCZKArEmfgujG9NV5VB/OWh65LsJS1MERcpiSfBLihshN5GOAAf
 SLAydkErqrfO6Q81In4FHX5RmSxfs+jS8FKotkv3ysJSTSKwD2AQP0ptLN/HAIKmrZ8k
 IEQg==
X-Gm-Message-State: APjAAAVeDywc32tBOXS1eEnZBKmtTFPrXR/b/jTzahBllMKxh8EDTfV7
 Y83N1ujlQsBJt5m/7n55BIWHpsdHwD6dzLH9dsA=
X-Google-Smtp-Source: APXvYqyU+XPBRk7CIczGYvDnn+95GfO+NWQ8Ab+4YKzXnrdRYOuJxbqVt1v7gta5mGJ+YS89t8Q6Rm5VwAi+j2ujuk8=
X-Received: by 2002:a05:6830:139a:: with SMTP id
 d26mr2545819otq.75.1580368141292; 
 Wed, 29 Jan 2020 23:09:01 -0800 (PST)
MIME-Version: 1.0
References: <20200129235040.24022-1-richard.henderson@linaro.org>
In-Reply-To: <20200129235040.24022-1-richard.henderson@linaro.org>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Thu, 30 Jan 2020 08:08:50 +0100
Message-ID: <CABLmASGt_mSiqZYNWu3DLK6DDhRZs+WD4Ch+EphgVh6TFPW+xA@mail.gmail.com>
Subject: Re: [PATCH 0/4] target/ppc: Use probe_access
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000ad192d059d5621e1"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ad192d059d5621e1
Content-Type: text/plain; charset="UTF-8"

On Thu, Jan 30, 2020 at 12:50 AM Richard Henderson <
richard.henderson@linaro.org> wrote:

> The first two address the performance regression noticed
> by Howard Spoelstra.  The last two are just something I
> noticed at the same time.
>
>
> r~
>
>
> Richard Henderson (4):
>   target/ppc: Use probe_access for LSW, STSW
>   target/ppc: Use probe_access for LMW, STMW
>   target/ppc: Remove redundant mask in DCBZ
>   target/ppc: Use probe_write for DCBZ
>
>  target/ppc/mem_helper.c | 197 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 162 insertions(+), 35 deletions(-)
>
> --
> 2.20.1
>
> Hi,

I can confirm these patches fix the performance issue I reported.

Thanks,
Howard

--000000000000ad192d059d5621e1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 30, 2020 at 12:50 AM Rich=
ard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.h=
enderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">The first two address the performance regression noticed=
<br>
by Howard Spoelstra.=C2=A0 The last two are just something I<br>
noticed at the same time.<br>
<br>
<br>
r~<br>
<br>
<br>
Richard Henderson (4):<br>
=C2=A0 target/ppc: Use probe_access for LSW, STSW<br>
=C2=A0 target/ppc: Use probe_access for LMW, STMW<br>
=C2=A0 target/ppc: Remove redundant mask in DCBZ<br>
=C2=A0 target/ppc: Use probe_write for DCBZ<br>
<br>
=C2=A0target/ppc/mem_helper.c | 197 +++++++++++++++++++++++++++++++++------=
-<br>
=C2=A01 file changed, 162 insertions(+), 35 deletions(-)<br>
<br>
-- <br>
2.20.1<br>
<br></blockquote><div>Hi, <br></div><div><br></div><div>I can confirm these=
 patches fix the performance issue I reported.</div><div><br></div><div>Tha=
nks,</div><div>Howard<br></div><div>=C2=A0</div></div></div>

--000000000000ad192d059d5621e1--

