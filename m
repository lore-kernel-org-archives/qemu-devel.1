Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB650C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:51:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4F29206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eUxvfzU1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F29206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBIJ8-0006Ti-UD
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 09:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBIEM-0002pF-B6
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:46:18 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:36851)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBIEJ-0007Bs-Tc
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:46:18 -0400
Received: by mail-ej1-x642.google.com with SMTP id l2so7736202eji.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 06:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CGrK+0iK2Y0NicqMq1swc/EaOXpiNI5JBP4oBAovEyE=;
 b=eUxvfzU1ksZ/JbgmCJdEly6dyqTpBu3R9NIZhv9DJFDgzzDMWP4GYwQcI/NfQf7T3d
 tFE+a1tCO/Ks+xznjZzepbcdsEf/BfxjHBoieD0Ihhb8i6saee+ekDlNt1N0aQnie4/T
 wkxAmiIeLfxXjUUwf/wpZmqsn9tExWeJumajde0c3LUSMwDIftu6A3kAzy2GC9GJASdn
 k2yErzCfGWFTNDnBeDd2rPkNulNrgLS0iMpXrJTFjGfUA4ATutERK9P9tJ/SL5t3al28
 Qcw545Bhbi6Xg9hFEXmZzih7k1JOQNVyBfiK2CBRaUJro3xYYahH+wVA4ac/xHX8ESxi
 6qpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CGrK+0iK2Y0NicqMq1swc/EaOXpiNI5JBP4oBAovEyE=;
 b=g0l9hf514mZ4ldV1T4RSCW0i9kWJsA16+1UK4iVZRliXE6MNuyDBwy9WkK0kQt8eB3
 xQAFzR4ZWlQYjkkId5s0HmP8ooqJoThXSXIGXMCsI0pd0zWaiPaGJacWKer/FBrZBE+O
 fc95cxPqez/ynuPjc3Bg4fYIiG/94/3FGfXIJqLPTAti7B4bw1f9Xx/OtgnCmadiqkq1
 OGTT6I7tGo9Y6J5kUJvw8TI+CLBZ1eyfoajuh6iFhGIttuIQAlvc5l5XqQ0lV+Tt3Q4y
 WsQDrh6AZOGozWGmRD1BB7oPCrPZZlDQiUVjaFFTsXjNahGOvfPAf9D9ZK6cGJXQzkkv
 IHbg==
X-Gm-Message-State: AOAM531UEuzhOC6utRcIgEozSPINB/G0Qjn6Uv6BLdAQzlV6svSnGetA
 VWDl28hD5f/B7qRZkRPIsgCxA/izrfCo+aLx3ad3Og==
X-Google-Smtp-Source: ABdhPJz8GY54reoWSG0nXqpOQWyGGS1EfBRPycn0Z14g00BkjzRWuFhu2gqkyS3Hpn/9PbiVphT9BAoJa+lMezxiRi4=
X-Received: by 2002:a17:906:2b0b:: with SMTP id
 a11mr11143697ejg.250.1598535974136; 
 Thu, 27 Aug 2020 06:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200824142934.20850-1-peter.maydell@linaro.org>
 <20200824142934.20850-3-peter.maydell@linaro.org>
 <0a7f9574-2d82-9c32-ca37-e5fad0e9bb42@linaro.org>
In-Reply-To: <0a7f9574-2d82-9c32-ca37-e5fad0e9bb42@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2020 14:46:03 +0100
Message-ID: <CAFEAcA9Nau4wOJBORF_=OYV+_3Wzq6Vcw4yoDz=WRtLWxbQhXg@mail.gmail.com>
Subject: Re: [PATCH 02/22] target/arm: Use correct ID register check for
 aa32_fp16_arith
To: Richard Henderson <richard.henderson@linaro.org>
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

On Tue, 25 Aug 2020 at 19:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/24/20 7:29 AM, Peter Maydell wrote:
> > The aa32_fp16_arith feature check function currently looks at the
> > AArch64 ID_AA64PFR0 register. This is (as the comment notes) not
> > correct. The bogus check was put in mostly to allow testing of the
> > fp16 variants of the VCMLA instructions and it was something of
> > a mistake that we allowed them to exist in master.
> >
> > Switch the feature check function to testing VMFR1.FPHP, which is
> > what it ought to be.
> >
> > This will remove emulation of the VCMLA and VCADD insns from
> > AArch32 code running on an AArch64 '-cpu max' using system emulation.
> > (They were never enabled for aarch32 linux-user and system-emulation.)
> > Since we weren't advertising their existence via the AArch32 ID
> > register, well-behaved guests wouldn't have been using them anyway.
> >
> > Once we have implemented all the AArch32 support for the FP16 extension
> > we will advertise it in the MVFR1 ID register field, which will reenable
> > these insns along with all the others.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > I don't expect that any guests will have been using these insns,
> > but in any case the fp16 work will be all done before the next
> > QEMU release and the insns re-enabled...
> > ---
> >  target/arm/cpu.h | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
>
> Cc qemu-stable, for the bug fix?
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I'd rather not put this in -stable, because it is removing
insns that previously worked. (In master the insns will also
be removed, of course, but there they will come back again
once the fp16 VFP and Neon patchset is all done and we can
set the MVFR1 value correctly.)

thanks
-- PMM

