Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8241AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:10:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4107320748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HONoJ9zw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4107320748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbltp-0004WW-GC
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 10:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jblsb-00030j-Ei
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:09:02 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:44999)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jblsa-0003xp-AG
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:09:00 -0400
Received: by mail-oi1-x244.google.com with SMTP id y85so6259702oie.11
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 07:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=v+4zKBMipe8VLEbaLWYBkDY62U3XWJ+1vsATZL+j7ws=;
 b=HONoJ9zwytOVmTzi34Voc6xOTBJK4EGERCufLsXSIX8bdrJF+w+tRD5dOxeLytdMAK
 biA49+BqZTwYCnHeBK1NC4gTxRQCG/ctdXNd+7As+qkN8813OhaRU+VKiQbRqZNA/qZ0
 4jnYlKX44jDHfSZKeQt8oK3OWvxOytg3tn0muqgyyUw0vXQ9l9ce3Sp6eWRcYHMDCJ9S
 H1QzR/+Qpr4B18KmvqlAX/rvtuLS6Q3OBfx1pMatrM8xJr6PCR36Ddmhi19mDH0nlYkd
 MAniegGS2HoZHzd2lIIlHe0JT5Ad3ejg8MF52Ezsa/5E8HG/fuWioXGHeK2ZilOa60JP
 Tunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=v+4zKBMipe8VLEbaLWYBkDY62U3XWJ+1vsATZL+j7ws=;
 b=GxNi7lZRCc8XEpJcg42PKN8MrmA8J/gLoB1rMsEbgcCihbo3gKKwSvSH0Kdf+GvdZ9
 ZLG/gu7Wmk7lE451XKQxR3G+r0FN2c3RsLfglgBbJy62//7OqYrZVRzfQ3+MWibV7R6o
 pbhxvTcImUhcGjS/XJohs0YKH0VhPJMom/fKmSJD2zbnFSNq7b5BYizcjhQ8EC+uH5oL
 Q/qzhlTcs6x8jIfoVocq0zGeB2aoDWMeHcYwuimP6N5NXJKA+gi1F8OEaVwOTnfAA+Cl
 HSdxzQ81b0C+meplytE6XnKpXFTPEjXVnYkHfoKUIdrE5ZZ/Y2uza2qrO7Z/9vXQWgXs
 QBwA==
X-Gm-Message-State: AOAM533RgtqKiB+AzVjjF+QxtYWku1Dp/7moVXRqkT+h6193psUSmlTa
 cJjEkMUYunmKWt7YHdRJb0pmMvuOaAkDP5ihIH3LGA==
X-Google-Smtp-Source: ABdhPJzIL210s8jDG2oxz0NZLsPYxqG5XNKfTcZW+Cr0PGqE+5HA6yvS8nBwsrI1IBcirAFt6WpXBIjsXa+RkwZdsH8=
X-Received: by 2002:aca:ed16:: with SMTP id l22mr6506722oih.146.1590070138559; 
 Thu, 21 May 2020 07:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200521135748.9859-1-alex.bennee@linaro.org>
In-Reply-To: <20200521135748.9859-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2020 15:08:47 +0100
Message-ID: <CAFEAcA-kdX1nkEgqNMn-Bvg6UHxt3Og11yS5A9zE1h4ChdnBLA@mail.gmail.com>
Subject: Re: [PATCH v2] linux-user: limit check to HOST_LONG_BITS == 32
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 21 May 2020 at 14:58, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Newer clangs rightly spot that you can never exceed the full address
> space of 64 bit hosts with:
>
>   linux-user/elfload.c:2076:41: error: result of comparison 'unsigned
>   long' > 18446744073709551615 is always false
>   [-Werror,-Wtautological-type-limit-compare]
>   4685         if ((guest_hiaddr - guest_base) > ~(uintptr_t)0) {
>   4686             ~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
>   4687 1 error generated.
>
> So lets limit the check to 32 bit hosts only.

> +#if HOST_LONG_BITS =3D=3D 32
>          if ((guest_hiaddr - guest_base) > ~(uintptr_t)0) {
>              error_report("%s: requires more virtual address space "
>                           "than the host can provide (0x%" PRIx64 ")",
>                           image_name, (uint64_t)guest_hiaddr - guest_base=
);
>              exit(EXIT_FAILURE);
>          }
> +#endif

Is this also a tautological compare in the host=3D=3D32 && guest=3D=3D32
case? Do we maybe want "#if HOST_LONG_BITS < TARGET_ABI_BITS" ?

thanks
-- PMM

