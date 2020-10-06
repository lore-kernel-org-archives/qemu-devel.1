Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89128C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 10:35:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD4092080A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 10:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ERv1JDYo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD4092080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPkJR-0006Os-H3
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 06:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kPkIH-0005q2-9y
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 06:34:09 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:44132)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kPkID-0000WR-3Y
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 06:34:03 -0400
Received: by mail-ej1-x643.google.com with SMTP id a3so16844831ejy.11
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 03:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kxE8PjBsWXiYOR28MiHtwsXhbAi4gt6gIwPX8ni2D9o=;
 b=ERv1JDYoPYtClOGYBeT4XkTOySUYMQn3bahDE88u5i2A6VFANZ1o/ZQk+IGLmpRLN3
 114dQ7By5AxLFH2Pi+4PXLbt4ZgCw8vuKU9e6DOjQGImux2tRWlaZWKv1Ju8iEXZGJED
 54csw0nEE962Lx8df1qr6T+w1TdYiQgQNripjolNM8o/3cS4lxxuANShkVsA5ekw7E56
 2F0JFmldzk94HeGIyEQgG1ePjDQNU3fSZCj4tjGPAwS9AIrIfLbNg3jMfmKPh8Ad3P2/
 0KSgM6hqAEX1VJOAsLixW3dPOeZ+oXmd8Mj2edDWlm9BsrHuzDJ8Oyyk+b5HPVom7d0t
 RGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kxE8PjBsWXiYOR28MiHtwsXhbAi4gt6gIwPX8ni2D9o=;
 b=p0hC/34hBNH+lIiD91hlli7bo7+ofMFhE/14Ybc+hWfxoRPm4naYY7975U3MrRZCxF
 VnrGOp3C1W8ms/iNfGngVLd/P88KNkQLXElmMi/ow6T3lMETp0Bhnwv6AibhO46VMggh
 ouAUhFVNFJvVwbI/Q+JZj7x0QtMmXFYMjC9qS2yIX8nyEQqqQxom1V/ysAWYDTwyHq/b
 X7DQ3tiCRncPEcpjSQLn33xm6rhKWuZMphlYck/cD8349GyErzhssIgetkCPbigStHVa
 3rJgKPrdDwK1TFIeH32LbtB+G+2bSbIKLax19Fgu2mgukytR6+eYBRhyCjSO12QC2zBu
 ZN1g==
X-Gm-Message-State: AOAM531mCndkJI/sStn3bF55p/vy4UDsOp8XdFqa6sXiajQAcX04MlgG
 TO5lsyKOetsMkhOcf1YYqsd3fhIr2K4O3ksZKi2rEg==
X-Google-Smtp-Source: ABdhPJzFu6QjAlak5uRV/Dm9q+VGTq8eZp3CqSlpy3UBU8ufgFqJsUqzNH5Jhe6XArqG9XT6rT27MlDHFZn1MycynzA=
X-Received: by 2002:a17:906:ad87:: with SMTP id
 la7mr4403200ejb.85.1601980439378; 
 Tue, 06 Oct 2020 03:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201005195129.1507-1-luoyonggang@gmail.com>
In-Reply-To: <20201005195129.1507-1-luoyonggang@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Oct 2020 11:33:48 +0100
Message-ID: <CAFEAcA8oa7A8f9EjSTnutUKC8tZ98Y_DrSYxdhy22T3y9NHRaQ@mail.gmail.com>
Subject: Re: [PATCH v3] scripts: Convert qemu-version.sh to qemu-version.py
To: Yonggang Luo <luoyonggang@gmail.com>
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 5 Oct 2020 at 20:51, Yonggang Luo <luoyonggang@gmail.com> wrote:
>
> The sh script are harder to maintain for compatible different
> xsh environment so convert it to python script
> Also incorporate the fixes in
> https://patchew.org/QEMU/20200929143654.518157-1-marcandre.lureau@redhat.com/
>
> Testing args length and if not enough, setting pkgversion and version to ''
>
> +#
> +# Script for retrieve qemu git version information
> +#
> +# Author: Yonggang Luo <luoyonggang@gmail.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2.  See
> +# the COPYING file in the top-level directory.

Does this have to be GPL-v2-only ? We strongly prefer
v2-or-later...

thanks
-- PMM

