Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4920BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:38:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E1232074B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKTUGFVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1232074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj9M9-0001Ap-Ao
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 18:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jj9LR-0000X0-3G; Wed, 10 Jun 2020 18:37:18 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53895)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jj9LP-0005OL-T7; Wed, 10 Jun 2020 18:37:16 -0400
Received: by mail-wm1-x341.google.com with SMTP id l26so3284179wme.3;
 Wed, 10 Jun 2020 15:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=X1NZl19z7ZxNbyVulTDuGJmobBM7Gb0SHumeBceYjD0=;
 b=GKTUGFVWaMu/JMOW5L4kfvoEByrCrkpi6eMBBr1V6wNO9PvKR7xWy+lEYliTrVzdM4
 5OYRY8aLn2PqnFx3ZGeo/G/lCYZ56Tp09eWCstFb96rbAOVXgEGzqzM1HbXiYFwz4yYA
 0I15U32poyPJA7QDNW8laRg3cYUwMKMv/uc+Wc70ba9uzxpWVoEooMtxCosqrVTkt2Z6
 8AkH44PwoAaaLdCQU6dCStt593rnMEX+AoQyjWLpaS2670BsDCHyx43/xsXL6pf3S3Ra
 a6au2gm4UUlHF4Y1jh4xfnNJQNAnfHSxaoUS04wKe9B8z9gdJND74dhpjZUmc2LK6AIf
 GfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X1NZl19z7ZxNbyVulTDuGJmobBM7Gb0SHumeBceYjD0=;
 b=UQN8nkb5pE1YaIzznxiT2HyTT56sTZQ/UfqotDODL9EYQ5h4kLwiOAzJyD6pFW91u/
 cGtwCu4/0Jx6iS9jODe4mr9wzPlEBHz6djFit35BXCmFkJpWCw8ckAYg1aD5pSh2siFk
 vglbTKFXWyXD4uRUX9EeMoBsluxXD0BQXXkWykiBxvizZ61jwetc6/UPFcNUiAl/CRe5
 /98AfBLFFCYcKHpf5mtWND+Nf5cmZlJHD/B5HVV/NoF/0kkb26JGqUsKz2le/3ilzxvJ
 C0ZHIfmyF+GObR81FxVxiI9SOFQzJNdOKEuQm69VZGAo2tuS+81FA5WZ1qi4SsXNEAAB
 7ZdQ==
X-Gm-Message-State: AOAM530+DEduhDB3D3tjaghGr1NC2xWW4UoAekKeidh0VzQ54FouKcs1
 LD0Y7paJUiVtaQM0C8i6QeLcpbnILX6DZY92pIM=
X-Google-Smtp-Source: ABdhPJyKGFtEEiQAknlJi6KCRfllbkscJJExhgN4lN2cTyULA8ttDgoGJrjTmgpIPsxR00q/qUF/E029YbhdaLBaEWI=
X-Received: by 2002:a1c:46c3:: with SMTP id t186mr4957998wma.36.1591828621995; 
 Wed, 10 Jun 2020 15:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200610220853.8558-1-f4bug@amsat.org>
 <20200610220853.8558-2-f4bug@amsat.org>
In-Reply-To: <20200610220853.8558-2-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 11 Jun 2020 00:36:46 +0200
Message-ID: <CAHiYmc6MCb44L6JXvttzQjagZkiYevkMdjgXz22g2GeCtf8gAg@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] MAINTAINERS: Mark SH4 section orphan
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="0000000000008eb13705a7c27b86"
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008eb13705a7c27b86
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D0=B5=D1=82, 11. =D1=98=D1=83=D0=BD 2020. =D1=83 00:08 Philippe Math=
ieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Aurelien Jarno expressed his desire to orphan the SH4 section [*]:
>
>   I don't mind being [...] removed from there.
>   I do not really have time to work on that.
>
> Mark the SH4 section orphan.
>
> Many thanks to Aurelien for his substantial contributions to QEMU,
> and for maintaining the SH4 emulation for various years!
>
> [*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg708400.html
>
> Message-Id: <20200601214125.GA1924990@aurel32.net>
> Acked-by: Aurelien Jarno <aurelien@aurel32.net>
> Suggested-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

I am sorry if I hurt anybody's feelings with my choice of words, or in
other ways.

As requested by Philippe, I wrote the patch that represent a comprehensive
summary of all needed changes related to sh4 maintainership, that is, I
believe,
simple, effective and productive in both short and long term.

https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg03080.html

The patch I wrote supersedes patches 1-2 from v2 of this series, and also
patches
1-6 from v3 (this one) of this series.

Please let me know if you have any objection to such patch.

Sincerely,
Aleksandar


>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3abe3faa4e..129517cfb4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -296,8 +296,7 @@ F: tests/tcg/s390x/
>  L: qemu-s390x@nongnu.org
>
>  SH4 TCG CPUs
> -M: Aurelien Jarno <aurelien@aurel32.net>
> -S: Odd Fixes
> +S: Orphan
>  F: target/sh4/
>  F: hw/sh4/
>  F: disas/sh4.c
> --
> 2.21.3
>

--0000000000008eb13705a7c27b86
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>=D1=87=D0=B5=D1=82, 11. =D1=98=D1=83=D0=BD 2020. =
=D1=83 00:08 Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.=
org">f4bug@amsat.org</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BE/=D0=BB=D0=B0:<br>&gt;<br>&gt; Aurelien Jarno expressed his desire=
 to orphan the SH4 section [*]:<br>&gt;<br>&gt; =C2=A0 I don&#39;t mind bei=
ng [...] removed from there.<br>&gt; =C2=A0 I do not really have time to wo=
rk on that.<br>&gt;<br>&gt; Mark the SH4 section orphan.<br>&gt;<br>&gt; Ma=
ny thanks to Aurelien for his substantial contributions to QEMU,<br>&gt; an=
d for maintaining the SH4 emulation for various years!<br>&gt;<br>&gt; [*] =
<a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg708400.htm=
l">https://www.mail-archive.com/qemu-devel@nongnu.org/msg708400.html</a><br=
>&gt;<br>&gt; Message-Id: &lt;<a href=3D"mailto:20200601214125.GA1924990@au=
rel32.net">20200601214125.GA1924990@aurel32.net</a>&gt;<br>&gt; Acked-by: A=
urelien Jarno &lt;<a href=3D"mailto:aurelien@aurel32.net">aurelien@aurel32.=
net</a>&gt;<br>&gt; Suggested-by: Aleksandar Markovic &lt;<a href=3D"mailto=
:aleksandar.qemu.devel@gmail.com">aleksandar.qemu.devel@gmail.com</a>&gt;<b=
r>&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4b=
ug@amsat.org">f4bug@amsat.org</a>&gt;<br>&gt; ---<br><br><div>I am sorry if=
 I hurt anybody&#39;s feelings with my choice of words, or in other ways.</=
div><br>As requested by Philippe, I wrote the patch that represent a compre=
hensive<br><div>summary of all needed changes related to sh4 maintainership=
, that is, I believe,</div><div>simple, effective and productive in both sh=
ort and long term.<br></div><div><br></div><div><a href=3D"https://lists.gn=
u.org/archive/html/qemu-devel/2020-06/msg03080.html">https://lists.gnu.org/=
archive/html/qemu-devel/2020-06/msg03080.html</a><br></div><div><br></div>T=
he patch I wrote supersedes patches 1-2 from v2 of this series, and also pa=
tches<br><div>1-6 from v3 (this one) of this series.</div><div><br></div><d=
iv>Please let me know if you have any objection to such patch.<br></div><di=
v><br></div><div>Sincerely,</div><div>Aleksandar<br></div><br><br>&gt; =C2=
=A0MAINTAINERS | 3 +--<br>&gt; =C2=A01 file changed, 1 insertion(+), 2 dele=
tions(-)<br>&gt;<br>&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>&gt; ind=
ex 3abe3faa4e..129517cfb4 100644<br>&gt; --- a/MAINTAINERS<br>&gt; +++ b/MA=
INTAINERS<br>&gt; @@ -296,8 +296,7 @@ F: tests/tcg/s390x/<br>&gt; =C2=A0L: =
<a href=3D"mailto:qemu-s390x@nongnu.org">qemu-s390x@nongnu.org</a><br>&gt;<=
br>&gt; =C2=A0SH4 TCG CPUs<br>&gt; -M: Aurelien Jarno &lt;<a href=3D"mailto=
:aurelien@aurel32.net">aurelien@aurel32.net</a>&gt;<br>&gt; -S: Odd Fixes<b=
r>&gt; +S: Orphan<br>&gt; =C2=A0F: target/sh4/<br>&gt; =C2=A0F: hw/sh4/<br>=
&gt; =C2=A0F: disas/sh4.c<br>&gt; --<br>&gt; 2.21.3<br>&gt;</div>

--0000000000008eb13705a7c27b86--

