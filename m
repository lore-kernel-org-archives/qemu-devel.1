Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60191C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 02:32:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 244DB20707
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 02:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dJcSFNfK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244DB20707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCw68-00010o-9o
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 22:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kCw5P-0000ZK-5F
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 22:31:51 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:37932)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kCw5I-0004Ho-8C
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 22:31:50 -0400
Received: by mail-oi1-x244.google.com with SMTP id y6so2869899oie.5
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 19:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GsmPyW26XmtGNgls22KwKKKOV38LVbbpPfdQd0G8qww=;
 b=dJcSFNfKMeWReK0PfUtitQ8r/nPLbwT6TWuUiao3yXvbr631Bg8ChOTFpUd7ivXKS3
 v485mMf+nZIJXFoiOmaUBaCJwsNnVYwnYrJ6kxtpGHCZJIm0rtDIY3HP1b791Qwz2xbI
 tRBvLdxJPSwOH9vwHwA0nXjNo2D8yYUiT/rGTSJnG5oiybCLD7vZvbbVl+L0T9jsFb4r
 AI1utAIoNfKgGJdvANIS7eDV/RfCUcKEtEiKBS1Zli8zOddo/oRcVgUjLUm5wOeKMQx7
 kGwMtK52iVinTwTXTHxpOO9vk3Owovbzu4Q1RIUHtK0fMlfD1yyy/Bjpd8PCaP0bPQfz
 NCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GsmPyW26XmtGNgls22KwKKKOV38LVbbpPfdQd0G8qww=;
 b=Cgpz/5nZKt5Y3Oqmlx58U1/IiLvwsmb2Lk99w8NWONDn2k2K8uoAvoEupVLtr23WKx
 NqP0jO5C203ADv5w8zsHDHGZbtyhoArlYfr9Lo37uDypLCKKqFqjnwfdM5/vbx9UvUyZ
 +HxMjRjnGDFWZUkZLQkz4KnG44qgShMoql9V7Hatv6I6wmYJMpRU5RJhxRjYROHvoi40
 kBcvq/y0NwBK0JhZwTwfRrEoiRTb1HJhwVDQNLW8OMkaE0+6nl4hi0O8xoTOQ0X0eh/0
 0LSnJmEAhJw2Jf8z2+S4WfjxtHea07S2z/+siEsz707s16TowxSmx05JgJP9z3oJCn6G
 TjSQ==
X-Gm-Message-State: AOAM530yHA+KxQ+5PScRUlaMMqrVRBhGyhfMAwZgn7fOGPmOBeJ4dxTx
 nwZJaIg0gTRObdCiFkwmPensaRnPgqsZ3d1QusM9qK86GgHzrw==
X-Google-Smtp-Source: ABdhPJzjbZkJ87pID1r9YROmSZM7YWfl8Z3dcIPmUHPT19sfNmkDOX01kvhF7CiAuKHTtIpoWpr+JcEVqCJQ83THNbM=
X-Received: by 2002:aca:53d7:: with SMTP id h206mr1356927oib.118.1598927501852; 
 Mon, 31 Aug 2020 19:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200831222945.875453-1-richard.henderson@linaro.org>
In-Reply-To: <20200831222945.875453-1-richard.henderson@linaro.org>
From: Frank Chang <frank.chang@sifive.com>
Date: Tue, 1 Sep 2020 10:31:31 +0800
Message-ID: <CAE_xrPgyu3wZhVOcc0w_uH2BcuBpOnV8hJgjP+bX5cPGYhRkcw@mail.gmail.com>
Subject: Re: [PATCH 0/1] tcg: Adjust simd_desc size encoding
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000c5192905ae3751da"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=frank.chang@sifive.com; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c5192905ae3751da
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 1, 2020 at 6:29 AM Richard Henderson <
richard.henderson@linaro.org> wrote:

> Frank, this is intended to address the vector size limitation
> that you encountered with the risc-v rvv patch set, as per
>
> https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg07924.html
>
> although not exactly like that email says.
>
> This will allow vectors up to 2k bytes in length.
> Please test, if you can.
>
>
> r~
>
>
> Richard Henderson (1):
>   tcg: Adjust simd_desc size encoding
>
>  include/tcg/tcg-gvec-desc.h | 38 ++++++++++++++++++++++++-------------
>  tcg/tcg-op-gvec.c           | 35 ++++++++++++++++++++++++++--------
>  2 files changed, 52 insertions(+), 21 deletions(-)
>
> --
> 2.25.1
>
>
Thanks Richard, I will give it a try on my RVV 1.0.
Thanks for the quick fix.

Frank Chang

--000000000000c5192905ae3751da
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Tue, Sep 1, 2020 at 6:29 AM Richard He=
nderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.henders=
on@linaro.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">Frank, this is intended to address =
the vector size limitation<br>
that you encountered with the risc-v rvv patch set, as per<br>
<br>
<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg07924.h=
tml" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/archive/htm=
l/qemu-devel/2020-08/msg07924.html</a><br>
<br>
although not exactly like that email says.<br>
<br>
This will allow vectors up to 2k bytes in length.<br>
Please test, if you can.<br>
<br>
<br>
r~<br>
<br>
<br>
Richard Henderson (1):<br>
=C2=A0 tcg: Adjust simd_desc size encoding<br>
<br>
=C2=A0include/tcg/tcg-gvec-desc.h | 38 ++++++++++++++++++++++++------------=
-<br>
=C2=A0tcg/tcg-op-gvec.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 35 ++++++=
++++++++++++++++++++--------<br>
=C2=A02 files changed, 52 insertions(+), 21 deletions(-)<br>
<br>
-- <br>
2.25.1<br>
<br></blockquote><div><br></div><div>Thanks Richard, I will give it a try o=
n my RVV 1.0.</div><div>Thanks for the quick fix.</div><div><br></div><div>=
Frank Chang=C2=A0</div></div></div>

--000000000000c5192905ae3751da--

