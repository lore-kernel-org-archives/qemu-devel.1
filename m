Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68756C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 17:06:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35EAC206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 17:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mH2SaamN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35EAC206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjQf0-0001mI-Cf
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 13:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjQdr-0000fx-Lo
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 13:05:27 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42817)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjQdp-0007dq-US
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 13:05:27 -0400
Received: by mail-ot1-x342.google.com with SMTP id t6so5085078otk.9
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 10:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jnpMvxPIBKMFACOSSbza1pcMxQ8eGv/1PVQ9OlP6zUE=;
 b=mH2SaamNpLUO+M3uc1nUVlnL7aZb0A/2D1irhUXfqYlCSMPz64HKWTbdCnvido1Oq4
 sO1N901xFuCfR+7x8z7gMgTaG9XJ7gZRZuxov3sqsorlEc0KY7/tbX6ur9CyTmirIZGk
 6CRzhByNoK4ycaZq4FJFoIRLKYYrN3fKh5ZvBYldPolbgGOy6yeIz0XzTbUEzUfjcoXo
 bWyFBnQUHXrsoRUHHOEImGV+90vECDqBYEEt4Mr9/Hjc+npQdTrmUa0uzHvE53NOGTY2
 tfmRvbdNkEXvi/mDinh6d7saOfqo4O0JFa0U3+pJOTz1BDUrGPYRyk1EOTly2OrgrNd4
 AVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jnpMvxPIBKMFACOSSbza1pcMxQ8eGv/1PVQ9OlP6zUE=;
 b=t+BOoQkGomv7N8cSox4AXORd5RYnPyUprjVE7p9CSR2mFJBPS5LKaegiOtczBqLU6X
 LOpJEVRdq1lcepu0X6l8tjX0FCanrjzMK3w8TTkn1QIcIY1IBBS2WOh6OsM/vtftP/uW
 B0fWftjEwtU3wfQNQJg6SGf/QXKxyBlT9WXHNaIhhah9SjU7VkeOu9fQmq0u/dlg5MuW
 HTJHzRP8PF6tDpMzqlKd3oDWFF780luc74qnHioUhWt5Z7cmKK4//S0oqgXD+j470edI
 Jtk4AZ9Ar7kdR6eaN2PiIBiK89U+3v/etTjzVKteSPmi2xI6+HQNFqUS/gdxdDVLuSIm
 R5kw==
X-Gm-Message-State: AOAM533q/9STXjFlsFr1wEkwGfOWGGZyB5/vpT3FuzSpjxOW5QDuasJ7
 x3AG5av7thLvVqCRjQZ26xxAcRnxWFcxegiCeSyPHw==
X-Google-Smtp-Source: ABdhPJzxdthIcgmguvMgqQcPH4quPdufa8IN00kieiiY7OoykdoJCoV6QxLOJdHzBc28FMpA/WqRblVOACnQ6wAjgGY=
X-Received: by 2002:a05:6830:8d:: with SMTP id
 a13mr7366786oto.91.1591895117425; 
 Thu, 11 Jun 2020 10:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200611144529.8873-1-peter.maydell@linaro.org>
 <20200611144529.8873-3-peter.maydell@linaro.org>
 <d32b36c2-6662-91b1-5b18-ff7a56386cd8@linaro.org>
In-Reply-To: <d32b36c2-6662-91b1-5b18-ff7a56386cd8@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jun 2020 18:05:06 +0100
Message-ID: <CAFEAcA-xw6pHejLVjUze1UWwBpygNWjam_KNOCyfthL-3vYDBQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] target/arm: Add missing TCG temp free in
 do_2shift_env_64()
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On Thu, 11 Jun 2020 at 16:43, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 6/11/20 7:45 AM, Peter Maydell wrote:
> > In commit 37bfce81b10450071 we accidentally introduced a leak of a TCG
> > temporary in do_2shift_env_64(); free it.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > My test setup wasn't looking for temporary-leak warnings (they are
> > not as easy to get at as they used to be because they only appear
> > if you enable qemu_log tracing for some other purpose). This is the
> > only one that snuck through, though.
> > ---
> >  target/arm/translate-neon.inc.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
> > index 7c4888a80c9..f2c241a87e9 100644
> > --- a/target/arm/translate-neon.inc.c
> > +++ b/target/arm/translate-neon.inc.c
> > @@ -1329,6 +1329,7 @@ static bool do_2shift_env_64(DisasContext *s, arg_2reg_shift *a,
> >          neon_load_reg64(tmp, a->vm + pass);
> >          fn(tmp, cpu_env, tmp, constimm);
> >          neon_store_reg64(tmp, a->vd + pass);
> > +        tcg_temp_free_i64(tmp);
>
> Huh.  I thought all the a32 stores magically freed their inputs.  I guess
> that's just the general-purpose registers.

Confusingly, neon_load_reg()/neon_store_reg() do the "create
new TCG temp for the load, free the store input" thing, but
neon_load_reg64()/neon_store_reg64()/neon_load_reg32()/neon_store_reg32()
do not. I'd kind of like to get rid of this weird proliferation
of load and store functions, but neon_load_reg()/neon_store_reg() are
also the only ones which take a (regno, pass) pair of inputs,
so it's not a completely trivial substitution.

thanks
-- PMM

