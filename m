Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60131C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:01:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F56320732
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjLO2Zqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F56320732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHlIo-0002zR-Iy
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 06:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHlHd-0001sS-Ew
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 06:00:25 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:46549)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHlHb-0005nt-MJ
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 06:00:25 -0400
Received: by mail-lj1-x241.google.com with SMTP id a22so18044680ljp.13
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 03:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=aLj1PNi0cUhlXNZ/e7XrbjNxNJmNbMcR6REmhwI3N8o=;
 b=cjLO2ZqzOg/00FaJWgKb8FaXEql0DCAeJ1d3uLhC2MBZCdDBja8313rvv/MAbfka3+
 dApu50VVkFnqYr8fDnqHXi7PPxM4B02NrQ8O01+Qb5OWqPFhcI25WVXM9/gT9XzNx3Xm
 YDbC0zVxq7PGldJWXbialpHNu2O2CiheLaqwvg/OJtRXtaGPF6FmoBfmZAce5zuNFhcU
 H0qwJMW/bCy0kr06daHagfzUYT+zhpmwQHksGKIrzowwzFf/DkDolSRp9dADYXo93QWz
 CqTsLd8ujbKXmN8AOqBqcn8jJwH0mGFgcpf/QuuMJnntlLqZ361rxXMUffSccHV2srqg
 uQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=aLj1PNi0cUhlXNZ/e7XrbjNxNJmNbMcR6REmhwI3N8o=;
 b=paxoMW5eKQImPxAA/++rfHdtMGi2GDRONB9zqwJKOKFbSxU+JnjzbCbmjdTYd65tNx
 LW9z723MYbIzGOqdXCgHu0JgneP0MLcCgBz5QOgX/CR5ka3Dc0gJms2RKbb6IZZxLo39
 gAOZYllIgiOPDUUIUdaPH2tYsaPAjVtsDD/Uh0FGpGIC60cJaacK4GZaXaBktOF4Tt3X
 4oVWU0yaDfB1NgeG0IoxcN5ADRH9YAXfbgNFgfP9DUvzngMNsaZktiCk8lILOBPyx6xn
 J8p7zBTCJFMK+nFlgd3hjP/HIVib+VtzZpgDNnVk/X7BVDY+f63L+mW2yk1Nvwao6Dvp
 Nrzg==
X-Gm-Message-State: AOAM532lHWNIkpLSlVWljAgFZvVWpF3ggTWpSpemx1MF2cAB0SftGUlR
 yow/pL1NFyMRFJj5Ex2ngnjGYy3BNFhBgSXtOws=
X-Google-Smtp-Source: ABdhPJwaEJwP7zDEbb2UUJ+o9hxmmXyEhjd0DmguQSW+lEWgEPeU3zGovw97FUkKl2rsdNI8etPDkH/xcotU9bujtyE=
X-Received: by 2002:a2e:86d3:: with SMTP id n19mr5189355ljj.368.1600077621589; 
 Mon, 14 Sep 2020 03:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200913100534.22084-1-pbonzini@redhat.com>
 <20200914095753.GB579094@stefanha-x1.localdomain>
In-Reply-To: <20200914095753.GB579094@stefanha-x1.localdomain>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Mon, 14 Sep 2020 18:00:11 +0800
Message-ID: <CAE2XoE_00RqJyMH2azqS6sFFtmf+G-moJOFOKDQLcyKSqnOr0w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Automatically convert configure options to meson
 build options
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000003f7a9805af431a9c"
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: luoyonggang@gmail.com
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003f7a9805af431a9c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2020 at 5:58 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Sun, Sep 13, 2020 at 12:05:31PM +0200, Paolo Bonzini wrote:
> > - because we parse command-line options before meson is available,
> > the introspection output is stored in the source tree.  The output
> > is slightly modified using the "jq" tool in order to ensure that it's
> > stable and that modifications to meson_buildoptions.txt do not cause
> > horrible conflicts.  This is the main reason for the unattractive
> > diffstat (the number of JSON lines added is higher than the number
> > of configure lines removed, though of course the latter are code
> > that must be maintained manually and the former is not).
>
> Does this add a build dependency on jq? Is it possible to use a Python
> script or even a command-line one-liner instead?
What's jq stands for, is that a perl script?



--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000003f7a9805af431a9c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Mon, Sep 14, 2020 at 5:58 PM Stefan Hajnoczi &l=
t;<a href=3D"mailto:stefanha@gmail.com">stefanha@gmail.com</a>&gt; wrote:<b=
r>&gt;<br>&gt; On Sun, Sep 13, 2020 at 12:05:31PM +0200, Paolo Bonzini wrot=
e:<br>&gt; &gt; - because we parse command-line options before meson is ava=
ilable,<br>&gt; &gt; the introspection output is stored in the source tree.=
=C2=A0 The output<br>&gt; &gt; is slightly modified using the &quot;jq&quot=
; tool in order to ensure that it&#39;s<br>&gt; &gt; stable and that modifi=
cations to meson_buildoptions.txt do not cause<br>&gt; &gt; horrible confli=
cts.=C2=A0 This is the main reason for the unattractive<br>&gt; &gt; diffst=
at (the number of JSON lines added is higher than the number<br>&gt; &gt; o=
f configure lines removed, though of course the latter are code<br>&gt; &gt=
; that must be maintained manually and the former is not).<br>&gt;<br>&gt; =
Does this add a build dependency on jq? Is it possible to use a Python<br>&=
gt; script or even a command-line one-liner instead?<div>What&#39;s jq stan=
ds for, is that a perl script?<br><br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A=
<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div>

--0000000000003f7a9805af431a9c--

