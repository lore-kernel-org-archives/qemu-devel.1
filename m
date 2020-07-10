Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CADC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:35:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BA8B20578
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="C6fogeXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA8B20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jttBc-0008HE-D0
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtrwX-0001CY-QW
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 08:15:53 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33]:44899)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtrwV-0001tW-Ru
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 08:15:53 -0400
Received: by mail-oo1-xc33.google.com with SMTP id o36so947080ooi.11
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 05:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yDT+xjbmnBte6qteDf60M/ur8XNiuBuAS62SAURwG3k=;
 b=C6fogeXkPiLhlQDXxKIrRSQhObU9bT8gK7T0kUgqQ3N47gmRikkk8EUjQEob0fop7C
 f7PPXISnFp8BJs7J0azVnPJdOnQx9d55RtIQbSaJabRyN4Oljx3riOdkD6yCNq/LEzLt
 Sn0UTAYNYn0MwcsvkGCVIm2/59tbVgN7HCSCdAnZTLyHKzqPAJ+DYjiFAKSsfuLnMnVu
 zdyZPY/8E34xz28XvIjlZz5ity8h3uvcO27JRT6Yk8yn3W123sw6JuwX9VJw1+qrCmi+
 PoFq0MDePXJLJd70CwKDJK8M2Z10wfg3Wt1zeZehvnLwAVrrZTSlf1Yzq1MLYBNoHRTp
 yanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yDT+xjbmnBte6qteDf60M/ur8XNiuBuAS62SAURwG3k=;
 b=dGduLD1uZTqLYqa7Q9xk1oqYvL4vKBIqbS4mQwXd3A70gxUr2B9gU2I6F6Zwn5MuxC
 ys0ZmgeqGG5TKSk7eQRkkR4TAmaELNiKMbOpsQ+rZEU/Z4vWHKu7PWabBxv3vKkPvGnm
 +Rcb1rdyzK0BXUC8A0WM+mQug7jU0EqHLVcoRc6hAGfMnSutNRjqbSjKxJvGuSWeA99Q
 WlvpbzAzRq4j6zzVtY03TnGmlLt1madh0HtmXkCs6Bwkpwgz4KFcbLwsvWgUpiWNWJrK
 RjVfa4LnqHHOZayBwROZuAQS9xDqACVwonzwek9tXmjcF53uTJDtTOavanRPvwhVJYaY
 Ma8A==
X-Gm-Message-State: AOAM530oUv3w3B7tO/M/2OrY/ZDWviqqIpaXakq4wzkLQuhMDd7me10/
 lbOF31SCXgQlQIPRMr/XwpvViM91Nm0sOuaeggo1oQ==
X-Google-Smtp-Source: ABdhPJwO2/B5rFJaobapmPDWRjaAC8DsbqGLa3X8OzLuayknrC8dKNHVVqqJIau8WdB1LLxi4pFPd2cKhMeCLVJULmQ=
X-Received: by 2002:a4a:2a41:: with SMTP id x1mr59812266oox.79.1594383350670; 
 Fri, 10 Jul 2020 05:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200710104920.13550-1-frank.chang@sifive.com>
 <20200710104920.13550-61-frank.chang@sifive.com> <87k0zblgjx.fsf@linaro.org>
In-Reply-To: <87k0zblgjx.fsf@linaro.org>
From: Frank Chang <frank.chang@sifive.com>
Date: Fri, 10 Jul 2020 20:15:39 +0800
Message-ID: <CAE_xrPhKg1FeRwW0zS-jpfo8XL7WvSFywif27X0kAYgh044N6w@mail.gmail.com>
Subject: Re: [RFC 60/65] softfloat: add fp16 and uint8/int8 interconvert
 functions
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000040c49a05aa154d29"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=frank.chang@sifive.com; helo=mail-oo1-xc33.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Jul 2020 08:57:18 -0400
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000040c49a05aa154d29
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2020 at 8:07 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

>
> frank.chang@sifive.com writes:
>
> > From: Frank Chang <frank.chang@sifive.com>
> >
> > Signed-off-by: Frank Chang <frank.chang@sifive.com>
>
> Did I miss the rest of the series somewhere?
>
> Otherwise this looks fine to me:
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> If you mean float16 to uint8 and int8 conversion functions, this commit i=
s
everything.
I think I just cc the mail based on *scripts/get_maintainer.pl
<http://get_maintainer.pl>*, so probably didn't send the whole series to
everyone.
--
Frank Chang

> --
> Alex Benn=C3=A9e
>

--00000000000040c49a05aa154d29
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Fri, Jul 10, 2020 at 8:07 PM Alex Benn=
=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.or=
g</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex"><br>
<a href=3D"mailto:frank.chang@sifive.com" target=3D"_blank">frank.chang@sif=
ive.com</a> writes:<br>
<br>
&gt; From: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" target=
=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt;<br>
&gt; Signed-off-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.co=
m" target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
<br>
Did I miss the rest of the series somewhere?<br>
<br>
Otherwise this looks fine to me:<br>
<br>
Reviewed-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org"=
 target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
<br></blockquote><div>If you mean float16 to uint8 and int8 conversion func=
tions, this commit is everything.<br>I think I just cc the mail based on <i=
>scripts/<a href=3D"http://get_maintainer.pl">get_maintainer.pl</a></i>, so=
 probably=C2=A0didn&#39;t=C2=A0send the whole series to everyone.</div><div=
>--</div><div>Frank Chang</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
-- <br>
Alex Benn=C3=A9e<br>
</blockquote></div></div>

--00000000000040c49a05aa154d29--

