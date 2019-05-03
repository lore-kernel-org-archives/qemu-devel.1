Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6E3C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 13:14:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B30482070B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 13:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IP/mrDxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30482070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40637 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMY11-0004pe-K8
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 09:14:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMY0D-0004Tn-0E
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMY0C-000691-2x
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:13:24 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:34922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMY0B-000685-N9
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:13:24 -0400
Received: by mail-oi1-x243.google.com with SMTP id w197so4387577oia.2
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 06:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=RzxudKemH3AI7iqLcMcMxSNiWjSkEogCcEQ8KwqH6ak=;
	b=IP/mrDxjZv20KF5baFr3Rf5fAVUTVlzct53Wg9APwLo71jLRMfg1c2sciWvAhE1MK3
	CTfp8972gg0oFm5OnB37jsyY6nu7lbBD0MuuHWSVOk5eWzhywPe4Ic4pZvYU2GMCxobJ
	IJoTwbeNR9iD+KIrFf+3I/Q4FMeFvrokByZzNQEe3RTWnbjOCqo5mbPJaOFZ2TnPo+sS
	LITZ8sG6UIKQrNGxu9TNd421tL8iwm2ELEpGhIPIMqtRH5PJsDuXoEcR9odbZjsNUDjp
	q/G9YzJR2xRcp7AIPXjAAOn93nV/M4GRFpWX2yMvzxzxg21Awsdk0DkhIMiFvF/gJvHH
	Kg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=RzxudKemH3AI7iqLcMcMxSNiWjSkEogCcEQ8KwqH6ak=;
	b=Why/bS/7UEpMYktnza/gULkj7wk13MhqsPsQm1o1yeU+UBAjYs6tXxsGjv1F4FqhLe
	jOtCaq+Ry6ttVYM3XHBlpLJceg4UyIr+l8oKhvqhS+ath9ReehcMAn9uqsjYxgT33LxY
	k4cFgGXVatKKBgvClZSIxcv/CXypIbA+QR4JlrMJIl9Ojbh0y0aKh0VTXHsM95HYW7XZ
	fGa/4qE+Dk0vahof2HHErLbZzjilQkn9D+Vfa/gQ+zwpjpB/vGgL6r7AcoPeBLMQfpTo
	uvxQ61I2doY/qDTND5ihDCRU5ehbVz3Ju6JBouH33Qkg4F1N5rEJLpFuE/TrpbOue9X/
	2hUw==
X-Gm-Message-State: APjAAAXfhtjWtZ+/aHl/oNKtG5M5dZncr//HJ/Y7xtdCDRBppKy4YhY9
	9L4rXKPTHUbWOwU85EV7DyFecOUIPscQJ6F1K4YxvQ==
X-Google-Smtp-Source: APXvYqw+gfJBentKDJ5XDlnkRturmxoUhsxdgDEK8FOtQYyFnJ9yTv4WAwsEJzTOdiziIrkmcFtttQu9QWnyzArnn9g=
X-Received: by 2002:aca:ab12:: with SMTP id u18mr5473345oie.48.1556889202462; 
	Fri, 03 May 2019 06:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190411153942.4533-1-peter.maydell@linaro.org>
	<53930e87-3bb1-fdd5-a8fe-8603c0adecc2@linaro.org>
In-Reply-To: <53930e87-3bb1-fdd5-a8fe-8603c0adecc2@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 14:13:11 +0100
Message-ID:
 <CAFEAcA_GZPJj7OQ-jK1TX4wKS4hO6OR43OG0Y3eCuxVdiUtsnQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH] target/arm: Implement NSACR gating of
 floating point
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503131311.089_ug1M4j7NQNQcwdyvdpbHUbjgjPdEduZw3_S05Ak@z>

On Sat, 13 Apr 2019 at 08:07, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/11/19 5:39 AM, Peter Maydell wrote:
> > +static uint64_t cptr_el2_read(CPUARMState *env, const ARMCPRegInfo *ri)
> > +{
> > +    /*
> > +     * For A-profile AArch32 EL3, if NSACR.CP10
> > +     * is 0 then HCPTR.{TCP11,TCP10} ignore writes and read as 1.
> > +     */
> > +    uint64_t value = env->cp15.cptr_el[2];
> > +
> > +    if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
> > +        !arm_is_secure(env) && !extract32(env->cp15.nsacr, 10, 1)) {
> > +        value &= ~(0x3 << 10);
>
> Read as 1, and yet you're clearing the value?  Cut-n-paste error from CPACR?
> Surely better to do nothing on read, but set on write (to either HCPTR or NSACR).
>
> > +static uint64_t cpacr_read(CPUARMState *env, const ARMCPRegInfo *ri)
> > +{
> > +    /*
> > +     * For A-profile AArch32 EL3 (but not M-profile secure mode), if NSACR.CP10
> > +     * is 0 then CPACR.{CP11,CP10} ignore writes and read as 0b00.
> > +     */
> > +    uint64_t value = env->cp15.cpacr_el1;
> > +
> > +    if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
> > +        !arm_is_secure(env) && !extract32(env->cp15.nsacr, 10, 1)) {
> > +        value &= ~(0xf << 20);
> > +    }
>
> This one does do the right thing, but better to clear the bits on write to
> NSACR.  This lets you avoid the change to fp_exception_el, and the missing
> change to sve_exception_el.

Hi Richard -- I was just going through the review comments on this
patchset, and I saw this bit. Could you clarify what you mean by
"the missing change to sve_exception_el" ? Since SVE is AArch64 only,
there can't be any configs where we have SVE and EL3 is AArch32,
so I don't think these two features should be able to interact.

thanks
-- PMM

