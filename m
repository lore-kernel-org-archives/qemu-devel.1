Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F74CC4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 23:54:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A44F1206B7
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 23:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SB2Av6+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44F1206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJngl-0001xp-In
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 19:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iJnfi-0001Z5-4Y
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 19:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iJnfg-000691-EQ
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 19:53:10 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38688)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iJnfg-00068Z-74
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 19:53:08 -0400
Received: by mail-oi1-x242.google.com with SMTP id m16so12357419oic.5
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 16:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=sPRBrRTbrjiyciGnFyUtCEKEj9HdiXkupV19VIPvBd4=;
 b=SB2Av6+VbBC3YgOtS1VcE/YOwjcQ4/ZEtUS28PoGqmyJcCIRmsEr3d414s95s5ENsL
 fX40Z0ls3Zt+vR+C2e78vlllN+xLUbT7BPSkhPVJ4r4wZ9KKin3cDOW9VciYhH700060
 FVNT8I5BK7WUi8HHyOQ8lRWUwCz2GgG1oeiWT9VNXpa0dP8DV12XM7UxBhlloUkUfPaY
 pfC4Knru9kv9R66V0/eZwtK63EHLbYn/tjarmSAHRejaSQtPx8mYF0ODgmjf+zcHqJIj
 jm0YSnKcpFgqMXRWKyuEAW5puEsSLbz+8BjPe3hd2E4eja0+tMaF1HnBwJb6az2s3KF0
 SzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=sPRBrRTbrjiyciGnFyUtCEKEj9HdiXkupV19VIPvBd4=;
 b=DPCx4zaWGnPigubCXHHqBxxjVT6EOVv8dQunAoZ6MrPuKBH1DqsyoPCWVvAX9sf+KX
 nzmUKHplT/VeJQ0SWe5PLJ9/LEftGJffUbaUpeFhyI2MQvo4Y/nLrsMyM/W36GK8Yeea
 AIQo3e1dQk0em51bmzdlEZzQrtncYwBLt0wX6BmRU3pIIXW9tNMEpuRo9QMUAgp1nNdx
 MMnxiL67cqF4blC6Rz9/uDs8xVpct/eNxK33vQ85JriCEuvmeACAH8x0gsxSSTz4ch/Y
 XH879V+8bKUcA11fsIL3LXdgjliMxIROCWTb2XpOKjEaZoWQRS1zycDgC56cKtTQ82yo
 Bsgw==
X-Gm-Message-State: APjAAAViKNZYvIcFCris0MjX4B/77Su3db2p4tXyL1dk/2+nC/q40kr0
 zQnrzX53T0mHueW+6U+14CrZaRxingtU1LewNbE=
X-Google-Smtp-Source: APXvYqyAIvAmIQ0CU+dBz8jUP/65cc0aMupDkLSL4Ow5+PvNIXyv57jFID8lgKTp8mTtjIxljsbK9UJzIs1dAn0dg5E=
X-Received: by 2002:aca:d64f:: with SMTP id n76mr21468426oig.79.1571010787138; 
 Sun, 13 Oct 2019 16:53:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Sun, 13 Oct 2019 16:53:06
 -0700 (PDT)
In-Reply-To: <20191013222544.3679-1-richard.henderson@linaro.org>
References: <20191013222544.3679-1-richard.henderson@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 14 Oct 2019 01:53:06 +0200
Message-ID: <CAL1e-=ioCkAxyjdDvBTeQPMWpUy0W=ej-WiUmZkyTVJYUsd-_A@mail.gmail.com>
Subject: Re: [PULL 00/23] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000e7e2ef0594d373b2"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e7e2ef0594d373b2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Monday, October 14, 2019, Richard Henderson <richard.henderson@linaro.or=
g>
wrote:

> The following changes since commit 9e5319ca52a5b9e84d55ad9c36e2c0
> b317a122bb:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into
> staging (2019-10-04 18:32:34 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20191013
>
> for you to fetch changes up to d2f86bba6931388e275e8eb4ccd1dbcc7cae6328:
>
>   cpus: kick all vCPUs when running thread=3Dsingle (2019-10-07 14:08:58
> -0400)
>
> ----------------------------------------------------------------


OK - great! Congratulations for bringing the series to this final stage!
This was not an easy task at all. Our team will be using and enjoying the
fruits of this work on our test ppc hosts, that do have an important place
in our test bed.

Just for the sake of being punctual, may I ask you to add "Tested-by:" for
Mark Cave-Ayland, and "Reviewed-by:" for myself to all 22 ppc host patches,
as it was indicated in the responses to the last version of the ppc host
series?

Thank you in advance, and again all kudos for the series!

Aleksandar



> Host vector support for tcg/ppc.
> Fix thread=3Dsingle cpu kicking.
>
> ----------------------------------------------------------------
> Alex Benn=C3=A9e (1):
>       cpus: kick all vCPUs when running thread=3Dsingle
>
> Richard Henderson (22):
>       tcg/ppc: Introduce Altivec registers
>       tcg/ppc: Introduce macro VX4()
>       tcg/ppc: Introduce macros VRT(), VRA(), VRB(), VRC()
>       tcg/ppc: Create TCGPowerISA and have_isa
>       tcg/ppc: Replace HAVE_ISA_2_06
>       tcg/ppc: Replace HAVE_ISEL macro with a variable
>       tcg/ppc: Enable tcg backend vector compilation
>       tcg/ppc: Add support for load/store/logic/comparison
>       tcg/ppc: Add support for vector maximum/minimum
>       tcg/ppc: Add support for vector add/subtract
>       tcg/ppc: Add support for vector saturated add/subtract
>       tcg/ppc: Support vector shift by immediate
>       tcg/ppc: Support vector multiply
>       tcg/ppc: Support vector dup2
>       tcg/ppc: Enable Altivec detection
>       tcg/ppc: Update vector support for VSX
>       tcg/ppc: Update vector support for v2.07 Altivec
>       tcg/ppc: Update vector support for v2.07 VSX
>       tcg/ppc: Update vector support for v2.07 FP
>       tcg/ppc: Update vector support for v3.00 Altivec
>       tcg/ppc: Update vector support for v3.00 load/store
>       tcg/ppc: Update vector support for v3.00 dup/dupi
>
>  tcg/ppc/tcg-target.h     |   51 ++-
>  tcg/ppc/tcg-target.opc.h |   13 +
>  cpus.c                   |   24 +-
>  tcg/ppc/tcg-target.inc.c | 1118 ++++++++++++++++++++++++++++++
> ++++++++++++----
>  4 files changed, 1119 insertions(+), 87 deletions(-)
>  create mode 100644 tcg/ppc/tcg-target.opc.h
>
>

--000000000000e7e2ef0594d373b2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, October 14, 2019, Richard Henderson &lt;<a href=3D"mailt=
o:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">The following changes since commit 9e531=
9ca52a5b9e84d55ad9c36e2c0<wbr>b317a122bb:<br>
<br>
=C2=A0 Merge remote-tracking branch &#39;remotes/bonzini/tags/for-<wbr>upst=
ream&#39; into staging (2019-10-04 18:32:34 +0100)<br>
<br>
are available in the Git repository at:<br>
<br>
=C2=A0 <a href=3D"https://github.com/rth7680/qemu.git" target=3D"_blank">ht=
tps://github.com/rth7680/<wbr>qemu.git</a> tags/pull-tcg-20191013<br>
<br>
for you to fetch changes up to d2f86bba6931388e275e8eb4ccd1db<wbr>cc7cae632=
8:<br>
<br>
=C2=A0 cpus: kick all vCPUs when running thread=3Dsingle (2019-10-07 14:08:=
58 -0400)<br>
<br>
------------------------------<wbr>------------------------------<wbr>----<=
/blockquote><div><br></div><div>OK - great! Congratulations for bringing th=
e series to this final stage! This was not an easy task at all. Our team wi=
ll be using and enjoying the fruits of this work on our test ppc hosts, tha=
t do have an important place in our test bed.</div><div><br></div><div>Just=
 for the sake of being punctual, may I ask you to add &quot;Tested-by:&quot=
; for Mark Cave-Ayland, and &quot;Reviewed-by:&quot; for myself to all 22 p=
pc host patches, as it was indicated in the responses to the last version o=
f the ppc host series?</div><div><br></div><div>Thank you in advance, and a=
gain all kudos for the series!</div><div><br></div><div>Aleksandar</div><di=
v><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Host vector support for tcg/ppc.<br>
Fix thread=3Dsingle cpu kicking.<br>
<br>
------------------------------<wbr>------------------------------<wbr>----<=
br>
Alex Benn=C3=A9e (1):<br>
=C2=A0 =C2=A0 =C2=A0 cpus: kick all vCPUs when running thread=3Dsingle<br>
<br>
Richard Henderson (22):<br>
=C2=A0 =C2=A0 =C2=A0 tcg/ppc: Introduce Altivec registers<br>
=C2=A0 =C2=A0 =C2=A0 tcg/ppc: Introduce macro VX4()<br>
=C2=A0 =C2=A0 =C2=A0 tcg/ppc: Introduce macros VRT(), VRA(), VRB(), VRC()<b=
r>
=C2=A0 =C2=A0 =C2=A0 tcg/ppc: Create TCGPowerISA and have_isa<br>
=C2=A0 =C2=A0 =C2=A0 tcg/ppc: Replace HAVE_ISA_2_06<br>
=C2=A0 =C2=A0 =C2=A0 tcg/ppc: Replace HAVE_ISEL macro with a variable<br>
=C2=A0 =C2=A0 =C2=A0 tcg/ppc: Enable tcg backend vector compilation<br>
=C2=A0 =C2=A0 =C2=A0 tcg/ppc: Add support for load/store/logic/comparison<b=
r>
=C2=A0 =C2=A0 =C2=A0 tcg/ppc: Add support for vector maximum/minimum<br>
=C2=A0 =C2=A0 =C2=A0 tcg/ppc: Add support for vector add/subtract<br>
=C2=A0 =C2=A0 =C2=A0 tcg/ppc: Add support for vector saturated add/subtract=
<br>
=C2=A0 =C2=A0 =C2=A0 tcg/ppc: Support vector shift by immediate<br>
=C2=A0 =C2=A0 =C2=A0 tcg/ppc: Support vector multiply<br>
=C2=A0 =C2=A0 =C2=A0 tcg/ppc: Support vector dup2<br>
=C2=A0 =C2=A0 =C2=A0 tcg/ppc: Enable Altivec detection<br>
=C2=A0 =C2=A0 =C2=A0 tcg/ppc: Update vector support for VSX<br>
=C2=A0 =C2=A0 =C2=A0 tcg/ppc: Update vector support for v2.07 Altivec<br>
=C2=A0 =C2=A0 =C2=A0 tcg/ppc: Update vector support for v2.07 VSX<br>
=C2=A0 =C2=A0 =C2=A0 tcg/ppc: Update vector support for v2.07 FP<br>
=C2=A0 =C2=A0 =C2=A0 tcg/ppc: Update vector support for v3.00 Altivec<br>
=C2=A0 =C2=A0 =C2=A0 tcg/ppc: Update vector support for v3.00 load/store<br=
>
=C2=A0 =C2=A0 =C2=A0 tcg/ppc: Update vector support for v3.00 dup/dupi<br>
<br>
=C2=A0tcg/ppc/tcg-target.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A051 ++-<br>
=C2=A0tcg/ppc/tcg-target.opc.h |=C2=A0 =C2=A013 +<br>
=C2=A0cpus.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A024 +-<br>
=C2=A0tcg/ppc/tcg-target.inc.c | 1118 ++++++++++++++++++++++++++++++<wbr>++=
++++++++++----<br>
=C2=A04 files changed, 1119 insertions(+), 87 deletions(-)<br>
=C2=A0create mode 100644 tcg/ppc/tcg-target.opc.h<br>
<br>
</blockquote>

--000000000000e7e2ef0594d373b2--

