Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82EEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 19:35:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A825B2076C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 19:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mfJKnXAt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A825B2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB1CK-0000aN-UG
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 15:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kB1Bm-00008f-Cp
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 15:34:30 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:40095)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kB1Bj-0007Vi-Tv
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 15:34:30 -0400
Received: by mail-ej1-x643.google.com with SMTP id o18so4464003eje.7
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 12:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AJYVAIksZwFEHAZNcHOnSEZrcCpGNDBV8FUK4gCkFIY=;
 b=mfJKnXAtUMtKIuKrHyvZFz0Y69ZPrNR1C7O6ODlTMfrXsk76aU37D2GPD6/MU6Noa+
 iZDN23NMoanNRGiHwRCTDkBNhwU4BOA/QbMkfIrawF69QtAidO2d2QUzUr6OVQYDE2Ng
 Y4w0Mv1ZXv1wgNs7mYSlpZJGS29UaqOsPrIxuhd5P+evaiduJ/h6OC10LA/HjIgDFflp
 c3YKoycrrnN7WFigXFUrrPck/anMUP1xeSxyL21bhdj4GLRnmRa5QZAV0E8j896aZTq1
 TIH0MemBm2OEasBeye/ToUT5XlTr3K8mLP5htCt02CVeoS4T24NazShDUIb5G/mEmwkX
 6jxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AJYVAIksZwFEHAZNcHOnSEZrcCpGNDBV8FUK4gCkFIY=;
 b=Ug50fF93m8YGCkvNv6XJQzA4KIC9aAK1/zNh5twQLQaPFHX2ZYmXDvSIsX7tdtSWAv
 0lmzKWenrDNrWJ7ggHL+Hp4cM58rVaqnzQ4OekptF4xeCBjt46phoAhaGcyS50YdJNEf
 djJpcBgrp0JzYj3A75fHxlxHyzIDkEk3WSIP3Ee0w9ynxv66tog276sY6BAaT7JBHeU2
 FmbUqyjm4vk6C63pfunOUmScZgOUwQZ6PE4OP8RmOSMlOebGfxO07MXRKd+Yq1hM3tW3
 3R8gcOx9MMpkgkwN+KsSPsyg8qBDQTEzKYboifagFJL0U0RxufON6g/gUEohWLDtRdmp
 +6hw==
X-Gm-Message-State: AOAM531BkwahlSRJnColgo+yrdzgseHGhPpQ6yJ9R5Q9sGz2SrgkPprg
 Ns1QaBfQCbBgYuU4NwR0GVV1DsQT1mIxzEkASXLuQA==
X-Google-Smtp-Source: ABdhPJxTPIK05Wdsmf0X2xWMpSOoVi3XpZUNQ/Bud6DI5Ma1Nwvh/EjsN+65+dacIwNZSg7ABB4fZd51KYz3L3d9WnA=
X-Received: by 2002:a17:906:d8ca:: with SMTP id
 re10mr16685927ejb.382.1598470466206; 
 Wed, 26 Aug 2020 12:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200826190128.22707-1-pbonzini@redhat.com>
In-Reply-To: <20200826190128.22707-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Aug 2020 20:34:15 +0100
Message-ID: <CAFEAcA8MSzo7+zSWTr8vmU294M3oYkZKk17SFRrBZLmqfxGdmQ@mail.gmail.com>
Subject: Re: [PATCH] ninjatool: quote dollars in variables
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Aug 2020 at 20:03, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Otherwise, dollars (such as in the special $ORIGIN rpath) are
> eaten by Make.

Incidentally, why are we using rpath anyway? I'm pretty
sure the old build system didn't need it, and it's one of
those features I have mentally filed away under "liable
to confusing and non-portable weirdness"...

thanks
-- PMM

