Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F9BC433E6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 13:53:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6814920C56
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 13:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v3rbjyZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6814920C56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC1IJ-0007Z1-HV
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 09:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kC1He-000710-06
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 09:52:42 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:40858)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kC1Hc-0003Ct-L2
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 09:52:41 -0400
Received: by mail-ed1-x544.google.com with SMTP id l21so1570364eds.7
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 06:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TLoBdnrYojAW/6644vytV0Fe8KUqij1xapHp9AFymdU=;
 b=v3rbjyZBCjtVgZ/xg7DvhCKQAop21zsHEJHJfMZPmLXrIoBm+l61D9sv5lVPjmOmxo
 r31q/Aa9le8mTTWEea/WzPIBSVzmYQ69/hB4svxGmCkdL+/wwFdt52qbbUL9cZnrocqh
 sfeWyi1bWpVKPj9m3xPlUNDvzb6mjrmGtMtK2niVL6l8/sd/2slIZLpp5eF0Q0wVX7sl
 r4oeBANtK6wB9E8f97eQWAAinfaAGN7/zrUQCNql40P+iqiqMAQCcAP4gyJiJLORjkDx
 YRTjjtJb4+Jo6X6ZYT3sQj9tRSbgPPl/eepfcSvbjHUR/2ttQYWuozBNNvF9p6xecvhG
 TXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TLoBdnrYojAW/6644vytV0Fe8KUqij1xapHp9AFymdU=;
 b=haQr2ftJ6LC0Fk6wjbBJtQQg5IabSujy5J83046EqChvnfgnE1vdzO+RPGT5OXKp75
 fIyihR9tZlNcUDS78GFgzVom1qwwwAAwDSJDz8MIakp9W9zxda6//mR+lvJ8hveYsj2Z
 AoOHMX2pPbGbzqCEN6m43/E099tQw+oxpyLEWJ78AO24dz+hmMItNcyd63xm3oi6AJpq
 RYNlXAHp8sUWY/yOrrU84YkzeVLrIN98qMYUVPd15m+nTr0GM7kC7wolKsIxN+2Be/AH
 OaxRdqWNOtKhnFMayfJFzdo0oIijLqz5OwCHeHG7FWJU2+QmKqpsvyp2+spTODtmfubl
 Cc3w==
X-Gm-Message-State: AOAM533y6uKjdUsPYKZxnoi/az9v0oBzHPcbQvSGfZXneGyC0wvbQSIg
 r3LuGV4tqisqxPCVc6SUMoStDMeDOynovx9g7y4qVtg9mZZAkg==
X-Google-Smtp-Source: ABdhPJwRpQqWt0/KYoOigzrg/eBa2c50JsgtYzVXq7grSILM1ELW4hfbW1pN4L50iy/eeIFrHGw8ODyoboIZ4V6wEMc=
X-Received: by 2002:a50:8f45:: with SMTP id 63mr3646506edy.52.1598709159264;
 Sat, 29 Aug 2020 06:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200828183354.27913-1-peter.maydell@linaro.org>
 <20200828183354.27913-45-peter.maydell@linaro.org>
 <1306a667-216c-533c-9107-e42aa9ebfa24@linaro.org>
In-Reply-To: <1306a667-216c-533c-9107-e42aa9ebfa24@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 29 Aug 2020 14:52:28 +0100
Message-ID: <CAFEAcA9nVMS9YhemLcBbVKgqTwtubO0sB+jb=FTLQ8sTUANm+g@mail.gmail.com>
Subject: Re: [PATCH v2 44/45] target/arm: Implement fp16 for Neon VMUL, VMLA,
 VMLS
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, 29 Aug 2020 at 00:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/28/20 11:33 AM, Peter Maydell wrote:
> > Convert the Neon floating-point VMUL, VMLA and VMLS to use gvec,
> > and use this to implement fp16 support.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> > +    /* a->vm is M:Vm, which encodes both register and index */
> > +    idx = extract32(a->vm, a->size + 2, 2);
> > +    a->vm = extract32(a->vm, 0, a->size + 2);
>
> I know this is what the current code does, but I tend to think that this is
> better done in decode.

Yeah, I thought that too as I was writing it, but I didn't
want to mess with the decode in this patchset, especially
given it would have meant I needed to touch all the non-fp
scalar-indexed operations too...

-- PMM

