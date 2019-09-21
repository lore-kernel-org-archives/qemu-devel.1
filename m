Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAA4C49ED7
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 04:46:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 217CE2070C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 04:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="MRFtUGSV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 217CE2070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBXHZ-0004Nv-27
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 00:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iBXA1-0008G7-JB
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 00:38:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iBXA0-0001Go-F6
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 00:38:17 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:37651)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iBX9w-0001Ec-Q9; Sat, 21 Sep 2019 00:38:13 -0400
Received: by mail-qt1-x843.google.com with SMTP id d2so11115733qtr.4;
 Fri, 20 Sep 2019 21:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+PPsKOCTh5RSa57I+BSSqGAEMvAJw0T0QxLY5cxA0Ko=;
 b=MRFtUGSVZQpUyY/Os2YX8cazuEcWpdYcVYSyHGl5zjFiK3HbOqdJljJt5rNo+e+RWr
 cqRol28iYlkSVs/KX0BqlrUuG/KQMYgZavizbTrSgDDjIcoWBZxDkaq3OQicPGykVUGl
 45IqBgMfyTbGmflaiqf3SyH+mrXX2cU3LBHbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+PPsKOCTh5RSa57I+BSSqGAEMvAJw0T0QxLY5cxA0Ko=;
 b=syAgRT5iGNN2wvPKpuC3a2y8khnlM60R4sc7FsbJE34/VuLIBGGUbE91ahz06gjmId
 pcvikAZVI7z2WYwfqKpLMD8KC9lTBUqMEX5d3IcSi6TkRJNC2xWI4LTg+bXMSdow6Ehc
 AOWIzg+hDNwxW+i+PfXp45JdPimeBEyeaI3P4OG9WIeEISZanVwYCXKk0sNdysVmeGI0
 XyyI9DvWRGhkuWYy3XeiL6WY0iXwnXIXQEMBQGo8+/K0Yl8eTfeJhZOvG0ygSobqeSel
 B7egdkhPPlPqLew7tn89RsohkvJ0aiWjoLsTHFuzzDJZ7fZmpZtfN3Rl6Xx2U2kcwPrH
 V7Tw==
X-Gm-Message-State: APjAAAUEo+koq6UO69CymcavEK0wg4CaKkZJmPO98cFVqPQbe56l0/lF
 7JmMa5uaBTSc/OVOvAcZ4xaP1uldB2b0hbf065A=
X-Google-Smtp-Source: APXvYqxHS86ERkC4rVC7pBQuN29N/ev7fB9wJGfVG36dku8/Kno9Yiw9bfVt0AETdpbZfaFpDiQ1N/8zIOmmTt5Gico=
X-Received: by 2002:a0c:a9d3:: with SMTP id c19mr16159222qvb.172.1569040691160; 
 Fri, 20 Sep 2019 21:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190919055002.6729-1-clg@kaod.org>
 <20190919055002.6729-4-clg@kaod.org>
 <139c3f7e-465e-4efb-b6c7-213dcd2ec6b7@www.fastmail.com>
 <2a267d68-2463-ae0d-00d0-d9a33ba845b2@kaod.org>
In-Reply-To: <2a267d68-2463-ae0d-00d0-d9a33ba845b2@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Sat, 21 Sep 2019 04:37:57 +0000
Message-ID: <CACPK8Xd2aR9tJKfVjNn7ZCnNw1XK4X7A+fe-5Z62N_HyCOiAWQ@mail.gmail.com>
Subject: Re: [PATCH 03/21] hw: aspeed_scu: Add AST2600 support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Sep 2019 at 15:15, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 20/09/2019 06:10, Andrew Jeffery wrote:
> >
> >
> > On Thu, 19 Sep 2019, at 15:19, C=C3=A9dric Le Goater wrote:
> >> From: Joel Stanley <joel@jms.id.au>
> >>
> >> The SCU controller on the AST2600 SoC has extra registers. Increase
> >> the number of regs of the model and introduce a new field in the class
> >> to customize the MemoryRegion operations depending on the SoC model.
> >>
> >> +    switch (reg) {
> >> +    case AST2600_PROT_KEY:
> >> +        s->regs[reg] =3D (data =3D=3D ASPEED_SCU_PROT_KEY) ? 1 : 0;
> >> +        return;
> >> +    case AST2600_HW_STRAP1:
> >> +    case AST2600_HW_STRAP2:
> >> +        if (s->regs[reg + 2]) {
> >> +            return;
> >> +        }
> >> +        /* fall through */
> >> +    case AST2600_SYS_RST_CTRL:
> >> +    case AST2600_SYS_RST_CTRL2:
> >> +        /* W1S (Write 1 to set) registers */
> >> +        s->regs[reg] |=3D data;
> >> +        return;
> >> +    case AST2600_SYS_RST_CTRL_CLR:
> >> +    case AST2600_SYS_RST_CTRL2_CLR:
> >> +    case AST2600_HW_STRAP1_CLR:
> >> +    case AST2600_HW_STRAP2_CLR:
> >> +        /* W1C (Write 1 to clear) registers */
> >> +        s->regs[reg] &=3D ~data;
> >
> > This clear should respect the protection register for each strap case.
>
> Joel,
>
> You are the expert ! :)

Someone could implement this if they wanted to. In the future it might
be useful to create a detailed model for the OTP and secure boot
behavior, and that can affect the strapping.

However it is not critical for running guests under qemu. I think we
should defer it until there is some guest code that needs the detailed
behavior.

Cheers,

Joel

