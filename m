Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95DBC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:17:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 900C92467B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkbBoutq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 900C92467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iucMl-0008Q6-2C
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 08:17:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iub75-00080d-C8
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:57:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iub74-0003Ut-9Q
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:57:31 -0500
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36]:42168)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iub74-0003Tr-4g
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:57:30 -0500
Received: by mail-qv1-xf36.google.com with SMTP id dc14so1312471qvb.9
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 03:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Zs3C0moVFYQrAeeeVDEJyevqfF+VQBDa1YIUJ6XWpyk=;
 b=JkbBoutqNzP+qwZ4Jkkb8VESP6Wd1cu5kO/WN0R8RJYWworILJcjOwQdpBkX+fPWKJ
 c5Cpk1F4xSh03ayphRf2NImy1eUitXt1/oUQaPSglGwk3mQQqjO6XEQfW6ZfxhQ34EZv
 fmhe4NBPNFduai4kkZnifBSUdUX6Iv4H1fdYfvZ/OKz9W+sK5kfKzsj/w481uE1wieNG
 ZhsqhAq+mSyMQWQJgiH298hQbtBO5HNrX5+72Sbjaqbhno5ubn3RnIenZaE5CJUbu7wh
 1B7sbGaDQuxmtQR3/clwtOyQfvDxQa45D1PGbtl7DCwe/C9W7ux0admNYpNoi/kFuaWj
 GYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Zs3C0moVFYQrAeeeVDEJyevqfF+VQBDa1YIUJ6XWpyk=;
 b=o7duvPodtX8Y2sTzVHlwt6sZoSfvy8+oNdK3YRhjQrkdf0iaCd7GHZ300PnXNrr/2Q
 /TrFMWSXt+bvS0A5LzQ79wdKzXE2FJRwBEgYDHiZvCmc0a/tIVPA8Nggwb5CuX/mxUce
 y006Oo/Q4yD3QnllR7rMrGD6SBMOa+UHA+1Db43fuLnuYkCFKXn0iZrHODQw+f3USn1i
 1RVw9X27bE+3u/Pw8SmFJ2XlYjAuaJdoC18poG1hzGXBQ6sC/GhK2WnPoLcMx9rRVaBa
 Db0ivrumVOBGO4f9u5YOuwJ/n/qgs9baos/5KRat/mbBgDKlfLmFBggw5JHZ8BapBTBA
 XtCA==
X-Gm-Message-State: APjAAAXhANuXvf/hzskXeh19WaakDPAC7yaKMgZPhNHegxrrclCs/KjO
 bW6uku3wx7+Y9lLBnvrzAJLtPRhKDrQDZ7TW+fo=
X-Google-Smtp-Source: APXvYqxaJzv6wEDw2fzZkzw5riEVEGsYOJQnFR5UFAvtkHjLf5lej8d4BuFTm9DWDkH1i6lSYDzpkxqCINBnu0Xp3ww=
X-Received: by 2002:a0c:f68f:: with SMTP id p15mr15016701qvn.79.1579780647027; 
 Thu, 23 Jan 2020 03:57:27 -0800 (PST)
MIME-Version: 1.0
References: <20200123000307.11541-1-richard.henderson@linaro.org>
 <bdcf69f2-a88a-6484-8321-f8b6a9977763@redhat.com>
In-Reply-To: <bdcf69f2-a88a-6484-8321-f8b6a9977763@redhat.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Thu, 23 Jan 2020 13:56:47 +0200
Message-ID: <CAK4993j5xy6uJhi4e-denFjPt3BX+2yLnLcHKSg9hEYHj7QpKw@mail.gmail.com>
Subject: Re: [PATCH rc1 00/24] target/avr merger
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000004a07da059ccd5831"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f36
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004a07da059ccd5831
Content-Type: text/plain; charset="UTF-8"

How do I get it? from where?

On Thu, Jan 23, 2020 at 7:12 AM Thomas Huth <thuth@redhat.com> wrote:

> On 23/01/2020 01.02, Richard Henderson wrote:
> > This is a merger of Michael's v41 of the base avr architecture,
> > and v4 of Phil's arduino target boards.  Call this release, or
> > merge, candidate 1.
> >
> > Has all commentary been addressed?  How much more, if anything,
> > does anyone require before allowing normal development in tree?
>
> I just had a quick look at the series. Apart from some few nits, it
> looks fine to me, so I think it's fine to merge it now.
>
>  Thomas
>
>

-- 
Best Regards,
Michael Rolnik

--0000000000004a07da059ccd5831
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">How do I get it? from where?</div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 23, 2020 at 7:12 A=
M Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 23=
/01/2020 01.02, Richard Henderson wrote:<br>
&gt; This is a merger of Michael&#39;s v41 of the base avr architecture,<br=
>
&gt; and v4 of Phil&#39;s arduino target boards.=C2=A0 Call this release, o=
r<br>
&gt; merge, candidate 1.<br>
&gt; <br>
&gt; Has all commentary been addressed?=C2=A0 How much more, if anything,<b=
r>
&gt; does anyone require before allowing normal development in tree?<br>
<br>
I just had a quick look at the series. Apart from some few nits, it<br>
looks fine to me, so I think it&#39;s fine to merge it now.<br>
<br>
=C2=A0Thomas<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--0000000000004a07da059ccd5831--

