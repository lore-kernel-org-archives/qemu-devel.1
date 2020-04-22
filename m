Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9470DC55185
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:06:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D74E206EC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUPY9SCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D74E206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRF5O-0002Z0-G5
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 09:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46338)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent.desnogues@gmail.com>) id 1jRF4g-0001kv-W5
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:05:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <laurent.desnogues@gmail.com>) id 1jRF4g-0001kt-JN
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:05:58 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:42415)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent.desnogues@gmail.com>)
 id 1jRF4f-0001j3-0e; Wed, 22 Apr 2020 09:05:57 -0400
Received: by mail-io1-xd44.google.com with SMTP id e9so2209783iok.9;
 Wed, 22 Apr 2020 06:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=i1R+UL3czKmE85NT+9SniKL1KoeLdWjkivQZRFm6sOo=;
 b=GUPY9SCbsSCctyV/ntggVRN98jUIWxhEZIpNharXv7yWn0qmyxHzTZNQQhUfBr/fql
 Z5yCNLZ+nTX6ZD73x55KRykyDYhG334SOdMuQnSJZ4BcxN3IHaY0ywd2y+3kDaEIUSVk
 lDlMKg5adqGce9j+K2M1ab8baoH9hAfshQeHcTnDHsYpAYH1E5NxINx7Y4eNYQb1J8He
 4lpTQqwfsXWGVWvwRQrGpR8bc5xO3p5QevT63YpSmVr/LIP2RFFW/OodHojwzKgNJLCo
 EdSTnWGbXgWKT2HJkxlBWPKE6tZTZfvGsncbLtz1HLWfIxO6KtwlRCZi3FDn/atAQedx
 BbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i1R+UL3czKmE85NT+9SniKL1KoeLdWjkivQZRFm6sOo=;
 b=cFfNRjADWS7QzJd+d1PAEHG5tmPrlg3+VXjyZXoO83LWINotnp6tGYB+Uee6Vtz9u5
 92H/SLv+FQGp56iOPpWr9djr7eR0YvRfU4xDjacvg3iTGh0gSsJpW3Z0ahwySXIimIel
 +3a89qsXkjtshfrFYJ8PsPkRH3HtGYb8xsEyC/Zym0s27zc2Svi7esaaUQfd3bkPT/8r
 7TfTDpPwX3CTYtZe8Vs6bjNc79UlqD2ThI3PFi1eJ/uH7ARkj52D+8UttN4n3CZrj8v9
 tC3UphIscQjoG2djmYzBesP9h4dddrpEinDtSSgEAi8oemwstOWBBd9BZ5uxAIv9FDUV
 PBpQ==
X-Gm-Message-State: AGi0PuZz2akX1gJ+NEsHY2DD6E4eAaZTzdP61GscWdBJACX6PhsIYyRG
 AlTgpwYGX2p/KVtM+FUjmhnuO3uo9VRHJe9/B4MrFL2c5C4=
X-Google-Smtp-Source: APiQypKHYnk1YsfBHdZRn8fb9sh/TsUdVI7nLEkOgT3xVGSqp43WP92Y3pUrP+MUhgEHszDOy6j//ogMCkXNCnFGupM=
X-Received: by 2002:a02:9a0d:: with SMTP id b13mr25009973jal.60.1587560755286; 
 Wed, 22 Apr 2020 06:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200422124501.28015-1-peter.maydell@linaro.org>
In-Reply-To: <20200422124501.28015-1-peter.maydell@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Wed, 22 Apr 2020 15:05:55 +0200
Message-ID: <CABoDooNn+RdZ0FuSu5NfD5=rbPuftgxFA-CHS973EHB1z33FnQ@mail.gmail.com>
Subject: Re: [PATCH for-5.0?] target/arm: Fix ID_MMFR4 value on AArch64 'max'
 CPU
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=laurent.desnogues@gmail.com; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::d44
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 22, 2020 at 2:45 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In commit 41a4bf1feab098da4cd the added code to set the CNP
> field in ID_MMFR4 for the AArch64 'max' CPU had a typo
> where it used the wrong variable name, resulting in ID_MMFR4
> fields AC2, XNX and LSM being wrong. Fix the typo.
>
> Fixes: 41a4bf1feab098da4cd
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Thanks,

Laurent

> ---
> maybe 5.0 just because it's so trivial. I dunno...
>
> There's also an error where we use the uint32_t u variable
> to update the 64-bit ID_AA64DFR0 register, but that's harmless
> because as it happens the top 32 bits of that register are
> all zeroes anyway, so we can just fix that in 5.1.
>
>  target/arm/cpu64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 62d36f9e8d3..95d0c8c101a 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -705,7 +705,7 @@ static void aarch64_max_initfn(Object *obj)
>          u = cpu->isar.id_mmfr4;
>          u = FIELD_DP32(u, ID_MMFR4, HPDS, 1); /* AA32HPD */
>          u = FIELD_DP32(u, ID_MMFR4, AC2, 1); /* ACTLR2, HACTLR2 */
> -        u = FIELD_DP32(t, ID_MMFR4, CNP, 1); /* TTCNP */
> +        u = FIELD_DP32(u, ID_MMFR4, CNP, 1); /* TTCNP */
>          cpu->isar.id_mmfr4 = u;
>
>          u = cpu->isar.id_aa64dfr0;
> --
> 2.20.1
>

