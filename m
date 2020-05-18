Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4B2C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:11:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27FC120674
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kZmaULcU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27FC120674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaiMR-0001Pn-9l
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jaiJg-0005k7-5S
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:08:36 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35826)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jaiJf-0005Tt-5b
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:08:35 -0400
Received: by mail-ot1-x343.google.com with SMTP id 69so3930426otv.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 09:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=aEvHPXNLYXl7vuRStaAwfAn8MfOBGgU0vV6HazBxAbQ=;
 b=kZmaULcUCuC5rGz5m3brTjaDP9cEzdfKcaeMbPHGQi55NYO859kdMylN7xaj/ag/bv
 SreSZqJEUMFVpQ4KJaDU7lvW3SbOr8FS0g1dYWTyRM8Hd/aQeQ4yLQLg3Z+PzBicRxuY
 O2vLG7K+AfvV2wYisVqz3Mipw7AE+NdIxrQHSc9tQ6QYfdCcMgvONyfPTx/kbx6pk4rk
 qxAMCyhbgvUu2To7RfjfpHc0yOm3/7CUHXjoLAzJ3SO0m1PIax1mk23pgxzuxEH1z/v2
 1Ox09rG2WRS/gMxa23xMj7MEPuMCo1/LaeBAbqpWIEQ7kdhaU+LSQSfUXOoFhijijwXv
 vNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=aEvHPXNLYXl7vuRStaAwfAn8MfOBGgU0vV6HazBxAbQ=;
 b=XnHexPep7ThjUeboPeV6//pdQo+/pXwr5vJmQWPM3jhazwOQDyLrr/mybXMAQM0y3R
 JlD/BeKCze3f8qjJGuimG//saueFg6ZNxkahVSSi41/vDVTKs44sH7QIskWqz6c4LFCq
 m2vO++ELBp8A9zv+ei8Xbxc5LJ4HWvKT7ap4VuB72FPfGopSymgGfRilYMMf37+k5sEM
 29jvmx5/E79jvmHonGyJDeYvnAgd0FdW6TX8ShbCial4l4ITB+gdB63Yf5hWmbE5wxeB
 TRjTm5rM74wO4pWwPs/2sBW7STQmKgGK/wlID8J2b1yhnKFF3aPzfNOhQfV/2CvJK732
 ZXEw==
X-Gm-Message-State: AOAM530Q5wU6KAIV4ek3ERGKjskQ/96rv+vL+joMb+P6MnC31IIJoAz8
 WhVxoBFzn/yc+qZQWSxr7fkZz0y9WdTZ0mP3s+1gSQ==
X-Google-Smtp-Source: ABdhPJwo0upBYcPDEgUURdtzlsWlu2s/qUyQPm4kW0AOC8ogKFYxePsDhlyOFfo/jy+43bZTEUQWm2oqBZY0DQ5pv1w=
X-Received: by 2002:a9d:b82:: with SMTP id 2mr12243999oth.221.1589818113522;
 Mon, 18 May 2020 09:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200518155308.15851-1-f4bug@amsat.org>
 <20200518155308.15851-6-f4bug@amsat.org>
In-Reply-To: <20200518155308.15851-6-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 May 2020 17:08:22 +0100
Message-ID: <CAFEAcA-rmLFZy5oKB_-Mg5MgWV+=V1rJJcLVi_Bp_jMbivcJxw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] hw/arm/boot: Abort if set_kernel_args() fails
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, kvm-devel <kvm@vger.kernel.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 May 2020 at 16:53, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> If a address_space_write() fails while calling
> set_kernel_args(), the guest kernel will boot
> using crap data. Avoid that by aborting if this
> ever occurs.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

I think it's reasonable to make these be fatal, but I think we
shouldn't just assert() but instead make set_kernel_arg()
and set_kernel_args_old() return a success/failure indication,
and report failures to the user as fatal errors.

thanks
-- PMM

