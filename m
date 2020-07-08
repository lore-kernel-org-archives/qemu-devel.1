Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D3AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:38:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 960F2206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVtYK7t5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 960F2206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtE1V-0004vi-Sp
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 13:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtE0v-0004UI-K8
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 13:37:45 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34677)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtE0u-0006To-A5
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 13:37:45 -0400
Received: by mail-pf1-x443.google.com with SMTP id u185so18232738pfu.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 10:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=R1u14pRHN8pQGo+vXTT/czb6okc7fp85OLKnvf/ostw=;
 b=WVtYK7t5RZndAV2Gpj8jpBTuYTZ0IcAINF8DWunR8DL6pth9eDpI4IEiVvj2TOTM1B
 hAwYpqdp95NNZ2xFhfdmphq67clhQLC4Cq/pwDVucOxI3j3cujHSQL2m5vh2z5A9RZEK
 /beiTVlKL/qnz+/VZUqMLM1NXuEUB9W0VSh3Q/hgzKwp9XKWeRLdGB6W6wMyWFwCQF2u
 4Aqq7ysGriOAC6PBlzjeBqqMtbtubio/XZvSR6qb7rjirIMcEujfE9nDkKfxeqS4xr7I
 QfWmL5y/4qHWfoVzE+RdGuuwZYmvBp0DlZgZUdHAZmVAH5/MQrQPk80trteHOdRn6WbC
 oL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R1u14pRHN8pQGo+vXTT/czb6okc7fp85OLKnvf/ostw=;
 b=KB9IJ+bnoVmDf2RyGIZ5/2SLNffy84r9EXylQnkuHDrztOIu8U95mv7YQSrDIoA/H3
 FAw+KkU6DIPowMmHw1tRCx4Y9Ud+6H89opjgLk6cSSGDLFsNQuHDpIelM7gnF5IxQ0Bg
 feWl/Kg2b2t6vwcFM2f7Hof7uR2fYjrwoqHZZUy4ZfHkCr2Lj4ekuRIOo/ZzFC7wu8sc
 TfFL33eCK2NCxaO4fZ59PSNpViGkYL19vf+4TVKCZTo7ErDuuJ8zpzym/i+1JqcjUP/G
 /AREtpqOvYBeGlQKX4lnI9qTWBl8+EtqJ1Jgso9w1wZuM/1v5KvUkVQ58sipGOgdIMF3
 B2RA==
X-Gm-Message-State: AOAM531eBYQc6OxL3V2wtzyD1TtjadQaosv4h+TE7ux0joBUM/T+5H8Z
 4SugDTE52kjv4Ae7wdaRWa5tRie7d67Yn2sb5H0=
X-Google-Smtp-Source: ABdhPJz+AZUqIlDYHM7ldgMN8GoznWigoVSfk/P09fAptkiyTrz/8r6zm1XVj0Tdpv4IowH6kOpp0gbmwiirpmT5C78=
X-Received: by 2002:a63:9dcd:: with SMTP id
 i196mr49447246pgd.378.1594229862767; 
 Wed, 08 Jul 2020 10:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200706234737.32378-1-jcmvbkbc@gmail.com>
 <20200706234737.32378-10-jcmvbkbc@gmail.com>
 <4fc60414-4b04-2402-3e72-50e77a7854b6@linaro.org>
In-Reply-To: <4fc60414-4b04-2402-3e72-50e77a7854b6@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 8 Jul 2020 10:37:31 -0700
Message-ID: <CAMo8BfKLbHrJBfz64vO9Mtyz6fWL8+ZekiOzvpdYVhg58_PxpQ@mail.gmail.com>
Subject: Re: [PATCH 09/21] target/xtensa: add DFP option, registers and opcodes
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 8, 2020 at 9:25 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/6/20 4:47 PM, Max Filippov wrote:
> > +float64 HELPER(add_d)(CPUXtensaState *env, float64 a, float64 b)
> > +{
> > +    set_use_first_nan(true, &env->fp_status);
> > +    return float64_add(a, b, &env->fp_status);
> > +}
> > +
> >  float32 HELPER(add_s)(CPUXtensaState *env, float32 a, float32 b)
> >  {
> > +    set_use_first_nan(env->config->use_first_nan, &env->fp_status);
> >      return float32_add(a, b, &env->fp_status);
> >  }
>
> I think you can do better than to set the use_first_nan flag before every
> operation.

And it was better, until I found that the rules for float64 are a
bit... peculiar.

> E.g. the translator could remember the previous setting within the TB, only
> changing when necessary.  E.g. if env->config->use_first_nan, then set it
> during reset and never change it again.  Similarly if DFP is not enabled.

This thought crossed my mind too, but then set_use_first_nan only
sets one variable in the float_status and gets inlined.
Is it worth the trouble?

-- 
Thanks.
-- Max

