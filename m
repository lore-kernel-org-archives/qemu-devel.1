Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A966C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:27:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5FD1222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tDFdPN+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5FD1222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2EWF-0004cx-Va
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 08:27:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2EVI-0003yO-MN
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:26:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2EVH-0002C1-I5
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:26:04 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33374)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2EVH-0002Bf-Cr
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:26:03 -0500
Received: by mail-oi1-x244.google.com with SMTP id q81so5758524oig.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 05:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HF5g4kSRlv2Qu0Oi8UGUfVAaO4opW32vHKBa3UTS3DU=;
 b=tDFdPN+2xebpGzz5qOGbgPMZ8zDTeb0s2BUoRXuXwczqIr0Nhf728dr3hrZ0F7zrQW
 15ylgyHRF76Np0ZY1oiRUCxN8Lc2PwxDJOGP/14qqAWAOF8qgqOvGqeJ+vkj7GmwhkED
 Jq9sbAuSJxEWY6q29u6bHrC0bbJHu4tZ/eU78bkz3TimIwFzR5sdj9KmQ2gBCFKtfyVW
 kpKnCKQ9caiGS/mPtcM0U7BgXJF77CETQIVcvspErgeik6QjEW9HEtQj9fiY+jYfK5w0
 WVu+daJMVevysZ5C1lPcv8HG2UpWQJTp6IQhq4TBWSkRRMAJbFCh5Tiv6t5ljARfHyfZ
 Y3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HF5g4kSRlv2Qu0Oi8UGUfVAaO4opW32vHKBa3UTS3DU=;
 b=BTg1JsOuBj8Yr8xa+J1/5YIkDXCS6gq6hpyQNRRPgAe2qviYifMhyXPKbsIX1eD6ro
 ZLTOcfnOoFddQn95+WoUYpgWiPIU5MyfloO6sduKwgj87MOVT7AzJ48nhg8Bnxqos2xm
 yUccA1TBvHcTPuBkW23TJKxqMIjfrYZwZjIrY1nWHHTmMfnHFWdmFNptSvVAT8TSpNc1
 p+TmaBF+Is5IHj06fR64vb/PjLKO5hhxiojRREliLjjLYSS8KNKlDa7PydM9msOBc/AR
 lIFVs9h/pgJFbxfJPN7n9BnvrE98Xy0tCH+HNi5zwyGwEut4NSoxrDu/PgAo6H7N+tFx
 iOSg==
X-Gm-Message-State: APjAAAVvCaorH9F8gXayQt7TCm1CfIegywwnqZ5JryjYTkvX0jBXhlT1
 UMBT5Z1pVx/NGLQF0n1AjODDLc7A3jqhG6vYDgLNkg==
X-Google-Smtp-Source: APXvYqy3OfVREAZwedAbYzVPxAVL/uiMO+wgRdWEXqKrm/2dKs5XRVdE0zLDyZ7tSlPXiwsD/ZtudVKX6VAOhzojWEw=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr2942332oiy.170.1581600362101; 
 Thu, 13 Feb 2020 05:26:02 -0800 (PST)
MIME-Version: 1.0
References: <20200211194228.16907-1-richard.henderson@linaro.org>
 <20200211194228.16907-2-richard.henderson@linaro.org>
 <CAFEAcA9Lq2tbsGqpSYWU=g1OYfu_TeXv5nuyBayJwapdLLKP9w@mail.gmail.com>
In-Reply-To: <CAFEAcA9Lq2tbsGqpSYWU=g1OYfu_TeXv5nuyBayJwapdLLKP9w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Feb 2020 13:25:51 +0000
Message-ID: <CAFEAcA8ed6mzXSKVGMKDEVm0zz4VS63RCwCwbedj_c4N4BCpPw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] target/arm: Fix select for aa64_va_parameters_both
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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

On Thu, 13 Feb 2020 at 13:12, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 11 Feb 2020 at 19:42, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > Select should always be 0 for a regime with one range.
> >
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> This change makes sense, and matches what aa32_va_parameters() does,
> but I think we need to update some of the callsites.
>
> (1) In get_phys_addr_lpae() we have the check:
>
>         if (-top_bits != param.select || (param.select && !ttbr1_valid)) {
>
> where ttbr1_valid is the return value of (effectively)
>  aarch64 ? regime_has_2_ranges() : (el != 2);
> but I think it's no longer possible to get here with param.select == 1
> and !ttbr1_valid, so this becomes a dead check.

...or should the code instead be checking literal pointer bit 55
against ttbr1_valid now ?

thanks
-- PMM

