Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FB5C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 06:17:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDD0024671
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 06:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="liH9E3y3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD0024671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irbzC-0005Qi-RR
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 01:17:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shihpo.hung@sifive.com>) id 1irbyR-0004xo-DH
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 01:16:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shihpo.hung@sifive.com>) id 1irbyQ-0002m5-9R
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 01:16:15 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:42169)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shihpo.hung@sifive.com>)
 id 1irbyQ-0002lR-2M
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 01:16:14 -0500
Received: by mail-wr1-x430.google.com with SMTP id q6so14465937wro.9
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 22:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZD6xhsHq7LG4gxxxAyq+0gHrm8TRJbCiS/LOxD19Kpk=;
 b=liH9E3y3exHsayNri1Vim8t9LT4jfNLdOjNJ++ImUA6aVTo0sOHAOQFn3NE5fadXU8
 6XbArikhc5FjBEL189P3yGyJtde13wAOs9B2SMOzl+oLiADP5cRcFYCBerOrv2mc1tgX
 YpmrUZ9p+nabKaYfQ3TEypDa3zZ1mKyHNJeNXwj8OoYe81erGoU4tGpls+jOYXsOXVai
 5yD3bVNRNTD5jZz6VW9N6NPInXq2a0d8mCevoA9Tx5pduVHyNugjLmFjQ2i7lEiU/2lS
 H42cDWEph/oMoDTW9FS1OHvU7OdoSyUZmDJOzL3iI73+IU9JAEZgLS9IU0ymNJ/lcLYI
 G+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZD6xhsHq7LG4gxxxAyq+0gHrm8TRJbCiS/LOxD19Kpk=;
 b=qvBZ7UgnUsKmtbFpk79qOP1spPD8k5p82cMjHmPAtiAhRheutfzWQUlXNUmQu7L39C
 rI+fIkvyApp80iAN2lTuEOeGFP19SsUoJNN1i3MDvkEVXQWDm8KkHxBGUb3vk4m+QziR
 rbCArROZiNDNb9LP6c85yR/Bd1J2eSMBNT0qsuWcSCIN5qkImnMEEdYeZUXAjKgiQRft
 LI+QfmsbkYwQJlhgam2Sp9uk15DA+0sOCPLY50K8FL4vfEAb6Tvq4XOuiss2e5VRqZ97
 /s2LS/iRLw1qhVsSdE4YVUb0JSQi/8nws3JDDPTS2SUxf0DkeHkQmOvm1Gq7JQfIyzMJ
 jyeQ==
X-Gm-Message-State: APjAAAXQMJpYCd/CMpdu/PtOmyXp65Mg8fHP8T4EO1Fjx0tjVwyfHzYD
 EdP1dsPzesjOckgAE4kUsM/1u+Kk9CeQ9HCNifyRIQ==
X-Google-Smtp-Source: APXvYqw95TPJeF6OA/vZoEYN7DzHfzepl76uQSQI+K/IZhWoTabouWOYMfbrPyBmUpYp2kfHrsGXJI5FepO9ZMOOS6g=
X-Received: by 2002:a5d:4cc9:: with SMTP id c9mr28636876wrt.70.1579068972669; 
 Tue, 14 Jan 2020 22:16:12 -0800 (PST)
MIME-Version: 1.0
References: <1578996840-14863-1-git-send-email-shihpo.hung@sifive.com>
 <6fb13179-c56b-8270-5c64-06ba1d05943e@linaro.org>
In-Reply-To: <6fb13179-c56b-8270-5c64-06ba1d05943e@linaro.org>
From: ShihPo Hung <shihpo.hung@sifive.com>
Date: Wed, 15 Jan 2020 14:16:00 +0800
Message-ID: <CALoQrwdKx+YwgFLSyjUo0vGzGKjjyAdZ9CMhGq1eXazUeJbq6Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] target/riscv: Fix tb->flags FS status
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000313337059c27a5e6"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Cc: qemu-riscv@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000313337059c27a5e6
Content-Type: text/plain; charset="UTF-8"

On Tue, Jan 14, 2020 at 11:29 PM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 1/14/20 12:13 AM, shihpo.hung@sifive.com wrote:
> >      if (riscv_cpu_fp_enabled(env)) {
> > -        *flags |= TB_FLAGS_MSTATUS_FS;
> > +        *flags |= env->mstatus & MSTATUS_FS;
> >      }
>
> Note that riscv_cpu_fp_enabled is *also* testing env->mstatus, and that
> this
> assignment can be made unconditional.
>
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>

I'll send v3 that cleans up the patch accordingly.
Thanks for the review!

--000000000000313337059c27a5e6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jan 14, 2020 at 11:29 PM Rich=
ard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.h=
enderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On 1/14/20 12:13 AM, <a href=3D"mailto:shihpo.hung@sifiv=
e.com" target=3D"_blank">shihpo.hung@sifive.com</a> wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (riscv_cpu_fp_enabled(env)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 *flags |=3D TB_FLAGS_MSTATUS_FS;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *flags |=3D env-&gt;mstatus &amp; MSTATUS=
_FS;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
<br>
Note that riscv_cpu_fp_enabled is *also* testing env-&gt;mstatus, and that =
this<br>
assignment can be made unconditional.<br>
<br>
Otherwise,<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br></blockqu=
ote><div><br></div><div>I&#39;ll send v3 that cleans up the patch according=
ly.</div><div>Thanks for the review!</div></div></div>

--000000000000313337059c27a5e6--

