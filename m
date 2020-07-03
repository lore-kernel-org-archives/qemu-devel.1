Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038B6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:27:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C361520760
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OVZp9QIF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C361520760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrLj1-0002JE-3H
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 09:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrLgH-00070C-7t
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:24:41 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40351)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrLgF-0001yp-Rh
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:24:40 -0400
Received: by mail-ot1-x342.google.com with SMTP id c25so9067897otf.7
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 06:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wi0XvQgN4MzLYR8X8YB/2qYQKfuUXG3ZqkcC6avYveM=;
 b=OVZp9QIFBP6khk+E2KF14k+XOqs34xTD2kocyj7XK5Z/d0lNFxYfbrRVNLdgbm3Gkd
 ly2jO6WrBqqki/FE1R2B51r6P6NqBiZLjg7QAVHQ+Mc2Zv0hl7WhYZBp8OCVSY/42nT1
 KiNR41/t4C8JDxDPpOjL9rvWn5Tab6iOLLJn4AGq43BMr7cr8fv9LmWB3p1EzLxhwBb0
 NRePbUrFNbdv69PUF8pwDO2s+ytoWXcqrxt5fc+1FEDuop3HqTvag03fOnP1zOQZfJek
 SGqIFm5V0GzFtqJQUToF5OPrw9dlGybJn+JGv6Kshw9F/xzQ0QVfZduIKBVX7tDl/4Hb
 vRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wi0XvQgN4MzLYR8X8YB/2qYQKfuUXG3ZqkcC6avYveM=;
 b=ZgY79d81qGYcoSCK2gjuv41JfkWjH8pRGyrY6p3Sb0Oyx5iLAF37YoOFLxNu6MbXZM
 UDoEfL81VyRIJGF1Mlij6yEpR2A5LN/we1aQQGz4OQ2deWRjISaczwnOEBx75+CPaMVV
 8Y0H0Fd322fzfskNc6S2vhkCCro8v5d+q34OQkUSok6MWOUtzsMZqclLuhSyF6xiP9UU
 fQCvauWOjAzIAKm6dwQmQ6RF28bDRw4KJDMtpuXkF0imfNMjXJ7fHSazt/7ru3HJjMpp
 y/nZcjqLsB7YIwa8f35IP++gF4OzqPsuvr60ge9esGbNhcCNGqIqcaz0fequVMfcvDUc
 Ftcg==
X-Gm-Message-State: AOAM531maBmaNWNQ1sKH3miCZc04N6DcF6yX99DYL/MjxS5Tfrf9oE0x
 G6dg235NaYDlAwpePdVGLr/jaFyKyiCYq1pJKZlDsBr4kT8=
X-Google-Smtp-Source: ABdhPJxgPvsEe6vkw9hYXHSeWNw/CZem6S77IIBtqxUBfziBsOn5zIMUGD+6QAqLk1uWoRUxAW6Ldr0iyxF5UyTjTlU=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr24472008otk.221.1593782678528; 
 Fri, 03 Jul 2020 06:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200630133912.9428-1-f4bug@amsat.org>
 <20200630133912.9428-14-f4bug@amsat.org>
In-Reply-To: <20200630133912.9428-14-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2020 14:24:27 +0100
Message-ID: <CAFEAcA-8VAWZgo=w0io1EnTgEQO81AsfKeb2z_fBNVaA-GJrdg@mail.gmail.com>
Subject: Re: [PATCH v7 13/17] hw/sd/sdcard: Constify sd_crc*()'s message
 argument
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jun 2020 at 14:39, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> CRC functions don't modify the buffer argument,
> make it const.
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

