Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A3BC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 13:01:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BECA720671
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 13:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LUxsuTvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BECA720671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZwRQ-0004d6-0j
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 09:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZwPF-0003Gl-FZ
 for qemu-devel@nongnu.org; Sat, 16 May 2020 08:59:09 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:40004)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZwPD-0005mx-MF
 for qemu-devel@nongnu.org; Sat, 16 May 2020 08:59:09 -0400
Received: by mail-oi1-x241.google.com with SMTP id v128so4831842oia.7
 for <qemu-devel@nongnu.org>; Sat, 16 May 2020 05:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CSDwTdglGBcUiYcwrNq87h8MezYP0RC9lNzjM6ntXVU=;
 b=LUxsuTvVLD/MdWWCaLu4Rz1+WSCXq4oJazspQb3vBNydVQVLjrXTdKmRkNno+ej3r4
 msp4bpjf8S8CcZlVI9CQbzZvnHSLZhyANMwL8wk/k0id413WVd4QDxoIfsRFNtbPnByw
 ycm+4CVat+Mla1QTn26+nMV8o6xJ3XJMPTz4bJkqTH85YlsfvwRKaxkcwSpiCUfR2IzJ
 p5MbbuA3Wz5HXgWGc/bHQ0bG0SX7wSabClJb3FaoV5sJNGzg7rpABU4Iofr7eyQiDDg9
 i0bW62PMrkCbyOw52r8wU3jGrvkHHN08rG86uS0A4jC09HiILlEM9C/IqOTJarJnOR+R
 5fJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CSDwTdglGBcUiYcwrNq87h8MezYP0RC9lNzjM6ntXVU=;
 b=NlCaJFXLfj1y+YyteUe1ZjFJaNv/G8egffyJtRO2iAVoh3vp2sV1gxykZwJKZHqQ1f
 mxK41c5gJ89F5V/ByInmTKDFcSvD0iCZoDKVXeCYss7DCxJzYN2j2fh1baxHpBozJ8t7
 l2p5rewtWvbjIwMZAI6TI51tEq9DftWSkTOFl7KyUEI4ea95GDyvhjDoBSBv8/fEiVxx
 rbSqC0PSgZ40E9TejlVbrsy7I2zRPX0FJ9SROVvotlEK39zYmCaP4vV22YVMJshgIwe6
 VCETfuCSaHdt0syaRCjhouaZPLXJTVJXfaaDTEvK+fGOaTxiILh8tlobsGDXl/XxT0Mq
 qu9g==
X-Gm-Message-State: AOAM532qPups0JsABhPBWF9Gk6qj1geaTHeuCdzJ9ZpUEi4EmkUbMcti
 WvrjnHtt42jsZEN9ey4k7jmS4mh1Pn0HCSouE71gRQ==
X-Google-Smtp-Source: ABdhPJx1CnodMp7rD6JR829WslCVXRkJKYgxkhO0ALc383X1WAl+G56YwYI2urHYsrIGLq8GyWQodNt6hbEnREH1cz0=
X-Received: by 2002:a54:400c:: with SMTP id x12mr5042216oie.146.1589633942694; 
 Sat, 16 May 2020 05:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200507202429.1643202-1-amanieu@gmail.com>
 <CAFEAcA-n8-pOcwovsS1Z3T4AMa1Nueo2yik9zX5H16QAHeE05A@mail.gmail.com>
 <CA+y5pbSueV8HQKQEZnBS4DvOvMDXUY7HMaODNhY7v-fKkJJPYw@mail.gmail.com>
 <CAFEAcA8etD+V3KrCFwvqfDuZ0x4_cW-RN423WG13iVpJBRvq4g@mail.gmail.com>
 <47fd7f16-a7ed-e3ee-9a97-b2b21f43e7b7@linaro.org>
In-Reply-To: <47fd7f16-a7ed-e3ee-9a97-b2b21f43e7b7@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 16 May 2020 13:58:51 +0100
Message-ID: <CAFEAcA_5_98BZfTbdLTR75w=qdOVVKra3eCM0YKX_gUEJSfkkw@mail.gmail.com>
Subject: Re: [PATCH] linux-user/arm: Reset CPSR_E when entering a signal
 handler
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-arm <qemu-arm@nongnu.org>,
 Amanieu d'Antras <amanieu@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 16 May 2020 at 05:12, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/15/20 2:25 PM, Peter Maydell wrote:
> >> You also need to call arm_rebuild_hflags() after modifying CPSR_E
> >> otherwise the change doesn't take effect.
> >
> > Hmm. I was expecting cpsr_write() to take care of that if we
> > updated a cpsr flag that was in the hflags, but it looks like
> > the rebuild_hflags() is in the HELPER() wrapper but not in
> > cpsr_write() itself. Richard, does anything go wrong if
> > cpsr_write() proper does the hflags rebuild ?
>
> We wind up rebuilding hflags multiple times, is all.
>
> Most of the time we call cpsr_write we also do something else that also
> requires a rebuild.  So we do it once after all updates.

The downside is that it leaves a trap which makes it really
easy to introduce bugs where hflags aren't rebuilt: as
a caller of cpsr_write() I don't really want to have to
care which cpsr flags happen to be in the hflags or not,
and it's particularly awkward that simply fixing which
flags belong in CPSR_USER suddenly means that a call
that happened to be OK before is now buggy.

thanks
-- PMM

