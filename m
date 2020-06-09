Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A61C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A3AC2078D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="I29SJAF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3AC2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jibB8-0007dV-H6
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 06:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chihmin.chao@sifive.com>)
 id 1jibAW-00077u-3j
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:07:44 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:40597)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chihmin.chao@sifive.com>)
 id 1jibAU-0007ou-Qb
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:07:43 -0400
Received: by mail-il1-x141.google.com with SMTP id t8so19720311ilm.7
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 03:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=F2aG56k+a2G508zcUJ3HboIMxYkZy/lIq/5XCAOIFgw=;
 b=I29SJAF+OrTb5PYA5mKDYuynlVj2Ze19CQOMO0QXcgzQY6fKTbrF9tpT/cxxdcSaJA
 Im55D+ZDsBMX0u0+kS4dvG6OY9pplfw13Hmi/BIcChyI4iYB9A25SIyY8mBVznXYHLm0
 S6+CzYbtJlTYxP6DjYsj2aeNfWlOnqp8NhM8SR+5T1YQwDvYMCeroytSLvCMrSZGySQl
 EUIvAT9pOQyJVx8qJjk+Ut1H+TFFOOzOkB/VgzNJ3oOS6HM5ywg8s8YCfN3kpPAfmIh5
 mCMk/IcZbLIxgO/0lqEtwncg0fYcKZXqtIj6Ka8UZuZKYHs9NS62D8R0U/tCuNQDeZwm
 EE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=F2aG56k+a2G508zcUJ3HboIMxYkZy/lIq/5XCAOIFgw=;
 b=MXmrQ6pwVAuQi4QmaUJUTAHAnt/3LkHHdN17Of0h0g8yji1wBvepOILzsm1WYnpC9W
 BCrQ7+knSxjOloiY9TkGMcoLJCQ5PJbWry7K+fbb4Zz3pJkkWTVbJj4z+575vo4pRybe
 E1JVPsz5zjaBy4FhNyQw+5EBya2eYeCxxmab31lRZ4gwLMTvUL9WTGFFD03+1FlBSZXQ
 OoMhifKtIZPOPZmQDuDmwzdzmyozGE0scs1GOV/8D9vMnmuO8viHZbjABGCvz8Bi2z7f
 SptU0iA9ATZBvh8ZQvjnkelLc5OXvMfTUcJ1LmUe4pUmjxG4C+g6BwP6sGoogz6Q46ck
 B7rg==
X-Gm-Message-State: AOAM533tiu3OHd/PSIOAxtx2TLyXjX0jY4AMgzf9OTZiotBU9aBHRda4
 njFAVFMiCXLPhuUu1/3bIIYJLPFzi1sUgRRuROhjig==
X-Google-Smtp-Source: ABdhPJy9r6yPAS7hDo6N86BPIv51i0vM5vQbTFYwX7yguNC0ZOArA+MGg7ibTOpHZCldlpA8nf88bTcdI0LjYQyoZw0=
X-Received: by 2002:a92:c812:: with SMTP id v18mr26606776iln.178.1591697260799; 
 Tue, 09 Jun 2020 03:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200128003707.17028-1-ianjiang.ict@gmail.com>
 <b14a65dd-b565-77ca-d479-f88e53ca0721@linaro.org>
In-Reply-To: <b14a65dd-b565-77ca-d479-f88e53ca0721@linaro.org>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Tue, 9 Jun 2020 18:07:30 +0800
Message-ID: <CAEiOBXXOA40F5kdttMby6eAfMGYVT0twZOhkojFK9qRDX1Xchw@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: Add helper to make NaN-boxing for FP register
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000d2089a05a7a3e549"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=chihmin.chao@sifive.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, palmer@dabbelt.com,
 Ian Jiang <ianjiang.ict@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d2089a05a7a3e549
Content-Type: text/plain; charset="UTF-8"

ping ?  Could this be merged ?


Chih-Min Chao



On Wed, Jan 29, 2020 at 3:43 AM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 1/27/20 4:37 PM, Ian Jiang wrote:
> > The function that makes NaN-boxing when a 32-bit value is assigned
> > to a 64-bit FP register is split out to a helper gen_nanbox_fpr().
> > Then it is applied in translating of the FLW instruction.
> >
> > Signed-off-by: Ian Jiang <ianjiang.ict@gmail.com>
> > ---
> >  target/riscv/insn_trans/trans_rvf.inc.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~
>
>

--000000000000d2089a05a7a3e549
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">ping ?=C2=A0 Could this be merged ?<div><br></div><div><br=
 clear=3D"all"><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartma=
il=3D"gmail_signature"><div dir=3D"ltr"><span style=3D"color:rgb(136,136,13=
6)">Chih-Min Chao</span><div style=3D"color:rgb(136,136,136)"><br></div></d=
iv></div></div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Wed, Jan 29, 2020 at 3:43 AM Richard Henderson =
&lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.henderson@linar=
o.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">On 1/27/20 4:37 PM, Ian Jiang wrote:<br>
&gt; The function that makes NaN-boxing when a 32-bit value is assigned<br>
&gt; to a 64-bit FP register is split out to a helper gen_nanbox_fpr().<br>
&gt; Then it is applied in translating of the FLW instruction.<br>
&gt; <br>
&gt; Signed-off-by: Ian Jiang &lt;<a href=3D"mailto:ianjiang.ict@gmail.com"=
 target=3D"_blank">ianjiang.ict@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 target/riscv/insn_trans/trans_rvf.inc.c | 17 +++++++++++++++--<b=
r>
&gt;=C2=A0 1 file changed, 15 insertions(+), 2 deletions(-)<br>
<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
<br>
<br>
r~<br>
<br>
</blockquote></div>

--000000000000d2089a05a7a3e549--

