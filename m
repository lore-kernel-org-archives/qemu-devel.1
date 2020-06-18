Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEA3C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 14:08:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57B4220734
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 14:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HVHtDE29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B4220734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlvDR-0008PL-LT
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 10:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlvCj-0007Y9-2I
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 10:07:45 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36403)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlvCf-00065M-JV
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 10:07:44 -0400
Received: by mail-ot1-x343.google.com with SMTP id 97so4609385otg.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 07:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tTIdqA9YBmh2AxRpFhSPhVFkhn0l26ciempdi4X5B04=;
 b=HVHtDE29ABOMWzH8KA3Ak5EqOwl9i7stCtoYbjrLcyWctLeP0Gewvs8cX4Am8/KatC
 O1iym461vqvxG9SXMRfUEA0lw3w/2Gtqbddll9uxGFvSTCPfcd5gz3wq+rkKefGitV74
 pNdOyFSpUhrIUHdGi3BHxpI2PASJypIbI2rgMGm7b11RvoBwcfOiuAhObr9vmoXqdlyR
 f7uNP6kONH8wOZQu3KR69siWsLl8T2KdKHGi8RduB6goykOn0T3DLj8aiG7G5z3Zz9Xv
 2E5B/gMhtiPUeSws/7C3viV5yA/XHF4VCLP/bRiaFl7mM4ap7L5uRfKG2M5daMuZh+SU
 UA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tTIdqA9YBmh2AxRpFhSPhVFkhn0l26ciempdi4X5B04=;
 b=T8JL6w2JXCUDbfhw8g9SswCd1ouXJWxEAUrdpcL/aDn55XbyQemTjBuhw2H26cVFIZ
 xrzcrqPs27xStaY2iO8m+nfrfNGXQ3ye2R/E272ZUC24u9tPhsGQMyNmoy5VCWaVkz1+
 5WnRV9ivZ7Ign1YQwwtWl9DvlFTpojUF4ZppdFd9JG0LhHkduBV8em+4+1mtfJOlKTE2
 kNUJsX3zc7RA3b5WOzY1/obKijN4tc7wyAuUJOpx57Q0F6Pf9050FGvXe71YyAw3HT1N
 JvXYjKc3c1SOzBcPMATbBkGq7Lo+4g3mxSqBTmbn8SWCCnk3yA5PYF/5wInx21FsvuTI
 rkxA==
X-Gm-Message-State: AOAM533BZCuHJTO/UHK7Dz2jYP5XUxSdGWhhOFE5ssPsMIQ6fGZgtB+U
 +nLhrLt0ejj4ajgcrwuWAWisRch1dEu/JgMrHIrwBg==
X-Google-Smtp-Source: ABdhPJxJkkISO7UB2E7HrjM44sjp4e87Im5sAVuJsJVY3jQ7Nky7JJXRvTAQi4YdaGm48p8EkzMYmts4TmKKYQSZDv0=
X-Received: by 2002:a05:6830:18da:: with SMTP id
 v26mr3657411ote.135.1592489260114; 
 Thu, 18 Jun 2020 07:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-18-richard.henderson@linaro.org>
In-Reply-To: <20200603011317.473934-18-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 15:07:29 +0100
Message-ID: <CAFEAcA9xZs3ZDkmp7ndbPct3W8VeH8cWuKxZZe_MKRXoujoTyg@mail.gmail.com>
Subject: Re: [PATCH v7 17/42] target/arm: Restrict the values of DCZID.BS
 under TCG
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jun 2020 at 02:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We can simplify our DC_ZVA if we recognize that the largest BS
> that we actually use in system mode is 64.  Let us just assert
> that it fits within TARGET_PAGE_SIZE.
>
> For DC_GVA and STZGM, we want to be able to write whole bytes
> of tag memory, so assert that BS is >= 2 * TAG_GRANULE, or 32.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

