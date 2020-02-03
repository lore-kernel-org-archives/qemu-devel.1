Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371FAC33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:31:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 031CD20661
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m2Q3hoyk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 031CD20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyZwk-0005J8-6p
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 06:31:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iyZvu-0004mU-9P
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:30:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iyZvs-0007k6-Tz
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:30:25 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38212)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iyZvs-0007jY-Ny
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:30:24 -0500
Received: by mail-ot1-x344.google.com with SMTP id z9so13274578oth.5
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 03:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ya2Txc2fZpWJo/ltEVgHiqiQwQl9L3M3tlxjIT8M85o=;
 b=m2Q3hoykxXD5c6TcJperfJ548DQdPZRfr/cbAsfHS+LzSynVT7GdxpgkSrMoJM1+Io
 b2DKBw6JZxK08Lc+c5AJHB335WST+D/qGK8WtmO6cOuNYj3mT2L5IdKSViJEvhTBp+kB
 5PlZaixScqk/aWWxvEf49teKYhKM97yZdbcWIElcvXxMTdAUhVa5QvqBlmSVazxbAaNG
 cczWVr0yQyxTAyYthTlqF9h36V0Gpkds1xj2Q/V5yVO/148FXwFYjQIRKOkJlgIrbvbT
 I8riLrrQAO+qJYel7BUjRpcASzbcCCeOfx2DYJM2LtlREX3RksdooUIcJuvULy7sSSUP
 BhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ya2Txc2fZpWJo/ltEVgHiqiQwQl9L3M3tlxjIT8M85o=;
 b=dUm4VXjsjduRnn2FROKwuzbNVjNF7BwvzipQBiOhdiV6thkFTewj32FdJOB6EiRhDM
 uL70nm4awSX4NXUfu5ff+H8Fr6NDt4a3nN/cE9rUsWzZn8kjEVogph9Fy3lp4UrBgUYC
 UTBZXQJHHNrrGMurlCUCbFTVyc/YCffkSvumcktC7WruzQ5wr1oa2DdG1BF9Tt4wa8kP
 0EXrxvCf/8HgIpN262ZPNklp05XMrqRyBP9FttbRcs65t8V7DRDi/wUvKlub9+YpiL1G
 aC8GH+Xf7o/C4eOl7nB5V9OsnSs7sFPE0TthI4gUMTjp+kKVyMYIo6LYy4zjGdYIHm4x
 m9dg==
X-Gm-Message-State: APjAAAV9HaFi7S1EDqgKzJPVFNztHblJ8U3y9MZDp2g66RMLFjeq2v8a
 EWebg2ZK6FZtpInAHQIUwEdObRVOXL0jvLCMUkxopw==
X-Google-Smtp-Source: APXvYqwM37BCGtd/KUAAfDzU0+MRSLRTuT4iKIrqerRdbErD0wyWFNPEbnPpEf/kV3rvHXZ7z+oUBnzPM2OiacQZcbE=
X-Received: by 2002:a05:6830:1184:: with SMTP id
 u4mr16763047otq.221.1580729423687; 
 Mon, 03 Feb 2020 03:30:23 -0800 (PST)
MIME-Version: 1.0
References: <20200201192916.31796-1-richard.henderson@linaro.org>
 <20200201192916.31796-32-richard.henderson@linaro.org>
In-Reply-To: <20200201192916.31796-32-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Feb 2020 11:30:12 +0000
Message-ID: <CAFEAcA-DCwZ51iUgd3BXxLyLZzS5QMvK1n=s1VjiXEeqrGu=Jg@mail.gmail.com>
Subject: Re: [PATCH v6 31/41] target/arm: Flush tlbs for E2&0 translation
 regime
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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

On Sat, 1 Feb 2020 at 19:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v5: Flush all EL2 regimes with TLBI ALLE2 (pmm).
> ---
>  target/arm/helper.c | 34 +++++++++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 7 deletions(-)

> +static int vae2_tlbmask(CPUARMState *env)
> +{
> +    if (arm_hcr_el2_eff(env) & HCR_E2H) {
> +        return ARMMMUIdxBit_E20_0 | ARMMMUIdxBit_E20_2;
> +    } else {
> +        return ARMMMUIdxBit_E2;
> +    }
> +}

The TLBI VAE2 docs say the TLB entry has to be invalidated if:
 * The entry would be required to translate the specified VA using
   the EL2 or the EL2&0 translation regime.

and this isn't conditional on whether HCR_EL2.E2H is 0 or 1.
So given that we don't flush all TLBs when E2H is changed,
I think we need to always flush all of
 ARMMMUIdxBit_E20_0 | ARMMMUIdxBit_E20_2 | ARMMMUIdxBit_E2
here.

That would make this the same as alle2_tlbmask, which
seems logically correct, since the difference between
TLBI VAE2 and TLBI_ALLE2 is that the former specifies
a VA+ASID (and the ASID should matter if E2H==1 and
be ignored if E2H==0), not which translation regimes
they affect. e2_tlbmask() is probably a better name than
alle2_tlbmask(), in that case.

thanks
-- PMM

