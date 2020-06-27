Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FDEC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 21:36:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 405CA206D7
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 21:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XdxpcFom"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 405CA206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpIUs-0000zN-IR
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 17:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpIU5-0000Y2-JO
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 17:35:37 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:37124)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpIU1-00027n-Tf
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 17:35:37 -0400
Received: by mail-ot1-x332.google.com with SMTP id w17so4102442otl.4
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2020 14:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MsJiXeJr1Xvdhi+WbuyBmY5tZOOiKlCBDrNJ75v4aEc=;
 b=XdxpcFomXN2pRm1euEytXkqHg0DYmqJbcDOm01eaDWymwBlQMLEaLHYA8SPcS0mJUd
 mw6wOnQolQaISjZlw0wMRnmkjAgHIkEfCRX6QydMLXRMr6m4iTl2eMgW5WwehY2vDPGW
 ax32ftryo+bVWhClTPrd4RUsh7/QHN2MxJpqWNeMuJrwvim4I7P+6gfAB0Ak2lquMm7q
 P3U9SfXC7D4pjWdYWNmNt0Mjj4GEF6V/F7Lgq/bUGPHAzd2/gReyyFrVxwDjaJqA5ssc
 FKluctmV30rZPdKR7SJRThM6sUtNMgShZbEjgxNlGbPr3R3/ZdGpkbEPNiancs7wm0WD
 9E0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MsJiXeJr1Xvdhi+WbuyBmY5tZOOiKlCBDrNJ75v4aEc=;
 b=coe9G8SUsz3uw/aXS//fKbFksmSvVepFc3nboNcI2UNCZ2WOyKgwGmqOSEtLy2JgSK
 pSqdMgy1NTeFMV6oYrAaarpMD+jtLsH1CHGg6+aEAGc0j75PxTyfqc6kgDCr/7sUKHxk
 xtaIekjpqzFCut6CCr8i7DfVIMWcFTDpVG19tkbHh/LTkK8WR2kSNaaQYSXwsliszbl0
 NRXaITUsWNmkfPd3x1+x/IQsrc/kor8YvdANQ0YGN4W4tmkrQA82fYuA0K5lNTnp/fJJ
 K9UpV9ejkv+K5j25/zRZaDexulQxtaN2vSHIOYyXHhNKwBFid5XYQApRHuNrYxhXRZ6x
 LlMQ==
X-Gm-Message-State: AOAM532dW0ppK63Dar+KvK5N7iVnoxg9nS3maeyE5IIR0JI/zsk6Xjws
 kY4T0j311MFxA6gT/sGiGXX+RkGvyPNqYcOrEqzPMg==
X-Google-Smtp-Source: ABdhPJyb5+l4SvzQffkAdOJjrSsslG+I7NecLE/EucWhESBvtzUtTHI0Hv+w7Ak2O62GaENDl5VQNZs+Taip+7vTcJQ=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr5141328ota.91.1593293732456; 
 Sat, 27 Jun 2020 14:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200626135608.6920-1-pbonzini@redhat.com>
 <20200626135608.6920-3-pbonzini@redhat.com>
In-Reply-To: <20200626135608.6920-3-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 27 Jun 2020 22:35:21 +0100
Message-ID: <CAFEAcA9DOyivMUS1gAE_BPcmO7yf6J8d-_YZ8W=Ox8U_O0QcBg@mail.gmail.com>
Subject: Re: [PULL v2 25/31] osdep: Make MIN/MAX evaluate arguments only once
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x332.google.com
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jun 2020 at 14:57, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Eric Blake <eblake@redhat.com>
>
> I'm not aware of any immediate bugs in qemu where a second runtime
> evaluation of the arguments to MIN() or MAX() causes a problem, but
> proactively preventing such abuse is easier than falling prey to an
> unintended case down the road.  At any rate, here's the conversation
> that sparked the current patch:
> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg05718.html

Hi; the changes in this patch seem to confuse Coverity.

> +#undef MIN
> +#define MIN(a, b)                                       \
> +    ({                                                  \
> +        typeof(1 ? (a) : (b)) _a = (a), _b = (b);       \
> +        _a < _b ? _a : _b;                              \
> +    })
> +#define MIN_CONST(a, b)                                         \
> +    __builtin_choose_expr(                                      \
> +        __builtin_constant_p(a) && __builtin_constant_p(b),     \
> +        (a) < (b) ? (a) : (b),                                  \
> +        ((void)0))
> +#undef MAX
> +#define MAX(a, b)                                       \
> +    ({                                                  \
> +        typeof(1 ? (a) : (b)) _a = (a), _b = (b);       \
> +        _a > _b ? _a : _b;                              \
> +    })
> +#define MAX_CONST(a, b)                                         \
> +    __builtin_choose_expr(                                      \
> +        __builtin_constant_p(a) && __builtin_constant_p(b),     \
> +        (a) > (b) ? (a) : (b),                                  \
> +        ((void)0))

In particular, where MIN_CONST or MAX_CONST are used to
define values that must be const, eg in qemu-file.c:
 50    DECLARE_BITMAP(may_free, MAX_IOV_SIZE);
or in hcd-xhci.h:
217    USBPort  uports[MAX_CONST(MAXPORTS_2, MAXPORTS_3)];

Coverity reports:

CID 1429992 (#1 of 1): Unrecoverable parse warning (PARSE_ERROR)1.
expr_not_constant: expression must have a constant value

Can we do something (eg providing fallback less-intelligent
versions of the macro ifdef __COVERITY__) to help it?

(This is the cause of CID 1429992, 1429995, 1429997,
1429999. Parse errors are unfortunate because Coverity
abandons analysis of the affected function entirely,
and analysis of its callers is also limited.)

thanks
-- PMM

