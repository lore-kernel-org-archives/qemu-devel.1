Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1612C10F11
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 07:09:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 965A92084E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 07:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BnbTQl3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965A92084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47800 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFCmZ-0004Bs-G2
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 03:08:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFClY-0003Nd-UZ
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 03:07:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFClX-0004Kp-Qw
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 03:07:56 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:38417)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hFClW-0004KA-TB
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 03:07:55 -0400
Received: by mail-pg1-x534.google.com with SMTP id j26so6220148pgl.5
	for <qemu-devel@nongnu.org>; Sat, 13 Apr 2019 00:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=k8oI1rFy3E518WcT6RKAmVFWvu5AL2jlh6i6AvLckA8=;
	b=BnbTQl3fPWg+RSTy2OfF/4IG85cIIP3yI9nICmj1uSSsWNocOMVV0r6pSfZryxMpmh
	gAO6iMB7JF5OpMIdn0w+1mr34Aqb8IN67U+JEiz3G/eQuPSaDZgAWBdnqj/YyauqbI8h
	9o0th2vK5aHIl4+2oGejlyjeiYEoSo30E7yZqg1ZMfhTr4BHpAWvSXg/TLHfmBLzK0tv
	VEDG8qj1DlrLhJ71LppbxMZCbSE2KsrapbCfUyvAMn4clVymsLHE8K1WHRe/UU55cCt0
	Er8wWToEZ0uKXIZqHcZcMZ4p2dUd3q9gtL7qkVUyBBPMHOhkrUWsyxbOgBb14eyjmlnI
	Eh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=k8oI1rFy3E518WcT6RKAmVFWvu5AL2jlh6i6AvLckA8=;
	b=eZ5ko8ozAPJqxcsLE0A9hxJI03w8BANftMPy7jYwa1iuJt5QKEdQhoxvb87Eggkibj
	/uzAYNHgMTUapHBD/F/yCtGjK272yJhkw2/8FPQ/583qhAeKrNOwV6LR0VgxXNG2IarF
	qm4Jnm98V1qJOFs4wHBkyGlq8xgaOPG0nWn+7YQWy77vR5Lfk5IfXSmnhlLtnzH4hNzC
	8HBh5hpMjuS1zLoOdqUka/Sd3cvbouUQ5RmX0vo+9ztgQ1dea+Vzfkofhk+1TZAwvvFV
	Edc0swGz2K0ljpbLa9WMohMFpxuCSi3GY4HM2I6jMFkzM20hl2K8U8u3MeZoAm985KPC
	DDnQ==
X-Gm-Message-State: APjAAAVMGNbBT35uQqNYmWZH4n3P61zN71MoZJVWOS6pfUVPhMxhngU9
	xUCm2qdvZDh7+PwodFiCfj/GtBFIf1c=
X-Google-Smtp-Source: APXvYqzQlmKOX949mnF+qL8oemUkTWi5mgr7YyWkVGfIOEZHhjY7fR+cjIopsFztRBetfAHi+cSOyQ==
X-Received: by 2002:a63:195f:: with SMTP id 31mr58273279pgz.116.1555139273200; 
	Sat, 13 Apr 2019 00:07:53 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	q5sm12946064pff.97.2019.04.13.00.07.50
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 13 Apr 2019 00:07:52 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190411153942.4533-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <53930e87-3bb1-fdd5-a8fe-8603c0adecc2@linaro.org>
Date: Fri, 12 Apr 2019 21:07:48 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411153942.4533-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::534
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190413070748.Ko6kMWtUW6ddCQF4O55mNKWOcMByGodc4kOquHoEKvY@z>

On 4/11/19 5:39 AM, Peter Maydell wrote:
> +static uint64_t cptr_el2_read(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    /*
> +     * For A-profile AArch32 EL3, if NSACR.CP10
> +     * is 0 then HCPTR.{TCP11,TCP10} ignore writes and read as 1.
> +     */
> +    uint64_t value = env->cp15.cptr_el[2];
> +
> +    if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
> +        !arm_is_secure(env) && !extract32(env->cp15.nsacr, 10, 1)) {
> +        value &= ~(0x3 << 10);

Read as 1, and yet you're clearing the value?  Cut-n-paste error from CPACR?
Surely better to do nothing on read, but set on write (to either HCPTR or NSACR).

> +static uint64_t cpacr_read(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    /*
> +     * For A-profile AArch32 EL3 (but not M-profile secure mode), if NSACR.CP10
> +     * is 0 then CPACR.{CP11,CP10} ignore writes and read as 0b00.
> +     */
> +    uint64_t value = env->cp15.cpacr_el1;
> +
> +    if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
> +        !arm_is_secure(env) && !extract32(env->cp15.nsacr, 10, 1)) {
> +        value &= ~(0xf << 20);
> +    }

This one does do the right thing, but better to clear the bits on write to
NSACR.  This lets you avoid the change to fp_exception_el, and the missing
change to sve_exception_el.


r~

