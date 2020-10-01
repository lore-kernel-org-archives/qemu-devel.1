Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824ECC4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:05:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5F0D207DE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zgEd70E5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F0D207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO08z-0001gF-Q2
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kO036-0003zx-Rp
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:59:13 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:33957)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kO034-0004Wy-Uu
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:59:12 -0400
Received: by mail-ej1-x642.google.com with SMTP id gr14so8579401ejb.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 07:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OhshDeuTlYrET9+GxlQx3YF2YV3AKQdS3Wg0wje5TlM=;
 b=zgEd70E5lWpK0BNNnExUiniMgnkdJqWOYaP1mhe2I5Wq20za4/XxT2vC6VPHEB9G9m
 wnxAXEL3ndG5NdrUawXejsRCL3Q+I8gy5T4nJulCP6BkI3HZunMptv6tL6zFvKFNhJsp
 RJUXxvy3WX3P4s8a24XSnqQX/mtgPimKXq8ujnpBVXefg5dhskXSTWBTAymxUf6ttwHm
 Hzw87JB3Bern0PKoPrhjk7zzKxVn2WT5E7pEMhezTXnvjdxc9NVfDg0Ucf+L7rCTnh1i
 E2qx+8v37WWHE8Qag+yHoJ7i9bbUv9uiK+Jb5WvJpJIddIXkXx9MS3a/z4v8TWjsi64D
 uTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OhshDeuTlYrET9+GxlQx3YF2YV3AKQdS3Wg0wje5TlM=;
 b=Ajo7k+0FKObKZG5TJQNKgdPbo7kiTpqHdHymX74K+9rM5ZB3WD4Bj7cPSLRQMCIaRe
 9cLt9cnnIuBxM8D4MZUP4hk222tEZXIKuEk6lHptOE05Wz2Q+H4bXShdwLpR1EHqUXkX
 CM0TdXQpeE0c0fCrlsJKwcZNv4lAv/1hem/gc+XHOBgIYAgdfWWNYOC2YAkFoNU+rhgg
 0suHIWaQslU+3y/3cRe7Ep1TVKEL7EMrQ4hyTRwgiVWSJv8MUjQTJOMHlUki488Wjvsv
 ZlnnHq7tESBD7DUrx9oKHMJFpbiTv2ri3lxi7AohAY9x7vFl992Zg417yOY4iY54+xpp
 Z1cg==
X-Gm-Message-State: AOAM530t5rPCfalRB5yU0dhEe+t+QH64y4LE3tq4Jl0wt2sD4PvJ9Jw7
 g6e+Ike3t/dWd92y7wQs+/mxd8TUbQP1Mu1naol/WQ==
X-Google-Smtp-Source: ABdhPJyOjnpHfGwczCBwoJ71JvES2B8KmZ/m0+xHNfGOq5dYyFCqL/duxIXOp/9Vdi3ejwj69VxB4vYdvaD45Bd3hHY=
X-Received: by 2002:a17:906:c7d9:: with SMTP id
 dc25mr4465954ejb.482.1601564349377; 
 Thu, 01 Oct 2020 07:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200925024143.26492-1-maxim.cournoyer@gmail.com>
 <CAFEAcA_wU73U6eaHU0mwccr-E0EHSKzFJ1yiR++YEKv=1LneJQ@mail.gmail.com>
 <87mu1dtao6.fsf@gmail.com>
 <CAFEAcA_4wXqGeOgsY2GbY1mk==DCz--j-jhs+OdGQnOHEf+D_A@mail.gmail.com>
 <87wo0grmae.fsf@gmail.com>
In-Reply-To: <87wo0grmae.fsf@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Oct 2020 15:58:58 +0100
Message-ID: <CAFEAcA-ZcMQB+7P1r3u8m4wM7mJ_ogPrqasKSqL_9XPS+xQ3yw@mail.gmail.com>
Subject: Re: [PATCH] build: Build and install the info manual.
To: Maxim Cournoyer <maxim.cournoyer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 27 Sep 2020 at 03:21, Maxim Cournoyer <maxim.cournoyer@gmail.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> > It is the best way we found for getting Sphinx to do what we wanted.
> > I agree that it would be nicer to have one manual with all the user
> > facing parts in it, but it is apparently not possible to do that without
> > shipping the devel docs to users, which we didn't want to do.
>
> I personally don't understand the rationale of hiding the devel section
> from users, especially given the kind of users QEMU is likely to attract
> (e.g, teksavvy people, perhaps themselves developers that could be
> curious peeking into that section to deepen their understanding of
> QEMU's architecture and internals).

Mostly I think we came to this opinion because
(a) it was how we handled developer docs before -- they tended
to be standalone files in docs/ somewhere, not part of the
old shipped-to-user Texinfo docs
(b) internals docs are much more likely to become quickly outdated:
you almost always want to be looking at the docs for current-git,
not for some older distro-installed QEMU version
(c) sure, some users might want to look at QEMU internals docs,
but they are definitely going to be the minority
(d) the developer docs are rougher in quality overall
(e) you need the source tree anyway if you're interested in
the internals, because so much is not documented, or not in
the rST manuals

That said, we are kind of working against the grain of how
Sphinx wants to be used here, which is usually not a great idea,
and it does result in some awkwardnesses (it would be nice to
have the devel docs on the qemu.org website, for instance).
I asked around on IRC and nobody seemed to be very strongly
against moving to the just-one-manual setup. So maybe we should
do that.

thanks
-- PMM

