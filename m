Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F15AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 11:28:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DA7422275
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 11:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GbHWu/J+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA7422275
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZY16-0000By-6V
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 06:28:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZY0A-0007kz-M3
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 06:27:54 -0500
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:37471)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZY08-0000qu-T2
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 06:27:54 -0500
Received: by mail-ej1-x641.google.com with SMTP id gn41so1099711ejc.4
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 03:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Ds2wWP284UEUKBYpqtN2b4m+SfiFSXhhPK+Nj+v/mE4=;
 b=GbHWu/J+dY04Kr7KQqY1qUokza+KRnBAu05Y4DINxDSF3eXeeDoWgpFrZGoWG2nE/Y
 oStP9vOOASSnPWXVxBYj0QAh7StTvyUN/bBdysnAzjcOzDnBIFSzPNc7cIOlfPWCOd8y
 aLKbMZdGswCTvrPa++IfLZV78kK2vbeX5tifMtLczlQtrj8ZW3g/Z6sarDHnuuXLr+4x
 VV+qzbo4X2pLW5FpnVpUyOA2MWkRITBagkkPuWZIHPCMS3SVAoMm0s75FwPTFBUzxxiI
 srAPl1q/fCAc/4VafAihdUYOWpatUK+Yu4LEnZUomrq8Irr5oUb6x+uqjCNADwH/6edu
 EzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ds2wWP284UEUKBYpqtN2b4m+SfiFSXhhPK+Nj+v/mE4=;
 b=eG9mq339QmfAWzl+Pb4F4/UyRXm3YXfw/5/30VKEIUz9cvjV0QZC1PxxXH4UvFkhCb
 b67P5eThhnb34dp4YVwXJk1C+ggC8boERaRyHypidAGdV+q+2MCRG7Y0E/h0ohmLQ3UH
 3mrfA82TfCfhQsmDwcoOjEgk4n233wPyu3KG+epzVnW4txpPXIVHAyPXlWK9PUUJQVhQ
 rlz5tdOhvR3aJqSQq3/4Np9FsMOris3Mfe7IpzgJap0aPPWeuYVLWHtBCLlVLwcQj7cf
 8/DinRGHIDx5GTJM1jHHwKsV7vOAP5CFA8Ek3DjFoEbhR65VE7Ra5L4TCRbkpsGNN5gh
 7rFw==
X-Gm-Message-State: AOAM5338LGod7jZ4CfbcA3pq6Wp/9T9diIpRIfkjvjCMemM54B21u2fQ
 H2MXq+nJUfUsIXb/IrbiN1GGFKqbwCYSouDH5Dnf9Q==
X-Google-Smtp-Source: ABdhPJwekDeE8TCwLvt7Zua15xrie0NVqY1Pbobad2Cl1E/vnTCnLp4q0GdnyCeQn/ujZucLCDkfM/BY1up8P4B9ILY=
X-Received: by 2002:a17:906:3a97:: with SMTP id
 y23mr14853270ejd.250.1604316471367; 
 Mon, 02 Nov 2020 03:27:51 -0800 (PST)
MIME-Version: 1.0
References: <2172054.ElGaqSPkdT@basile.remlab.net>
 <20201102105802.39332-1-remi.denis.courmont@huawei.com>
 <CAFEAcA9xhfhGToCXk9H+M5=HQKC91o-ED6eWTy32nvjwpFeJOg@mail.gmail.com>
In-Reply-To: <CAFEAcA9xhfhGToCXk9H+M5=HQKC91o-ED6eWTy32nvjwpFeJOg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2020 11:27:40 +0000
Message-ID: <CAFEAcA8xrk1Yd3GbkYRMjBwGjZ-f7bSp4gHGGk=tkhKNk5CqRQ@mail.gmail.com>
Subject: Re: [PATCH 01/14] target/arm: add arm_is_el2_enabled() helper
To: remi.denis.courmont@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Nov 2020 at 11:06, Peter Maydell <peter.maydell@linaro.org> wrote=
:
>
> On Mon, 2 Nov 2020 at 10:58, <remi.denis.courmont@huawei.com> wrote:
> >
> > From: R=C3=A9mi Denis-Courmont <remi.denis.courmont@huawei.com>
> >
> > This checks if EL2 is enabled (meaning EL2 registers take effects) in
> > the current security context.
> >
> > Signed-off-by: R=C3=A9mi Denis-Courmont <remi.denis.courmont@huawei.com=
>
> > ---
> >  target/arm/cpu.h | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index c18a916766..aaf3671806 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -2040,6 +2040,15 @@ static inline bool arm_is_secure(CPUARMState *en=
v)
> >      return arm_is_secure_below_el3(env);
> >  }
> >
> > +/* Return true if the current security state has AArch64 EL2 or AArch3=
2 Hyp */
> > +static inline bool arm_is_el2_enabled(CPUARMState *env)
> > +{
> > +    if (arm_feature(env, ARM_FEATURE_EL2)) {
> > +        return !arm_is_secure_below_el3(env);
> > +    }
> > +    return false;
>
> You could usefully add a comment mentioning the EL2Enabled()
> pseudocode and that we'll need to adjust this if we implement
> Secure EL2 in future.

I replied to this before the cover letter explaining what the
series is doing arrived in my inbox, so the second part of
my suggestion would be a bit pointless. The first part
(mentioning the name of the pseudocode function) still
seems worth doing.

thanks
-- PMM

