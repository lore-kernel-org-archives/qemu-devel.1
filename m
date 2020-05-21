Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A78C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:10:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82ED620671
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L7km76KN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82ED620671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbnlu-00021c-O4
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbnhW-00029B-8V
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:05:42 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbnhU-0005wl-Jq
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:05:41 -0400
Received: by mail-oi1-x242.google.com with SMTP id w4so6671728oia.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bT3gaOeZufGXXDWlU1SW7moyeQJ4r1NDiSe3lomWxgQ=;
 b=L7km76KNNRQyit0R7Fl6wyJy4mU32M2xxS3c1GCDhr8M6TqP6gmwf6CW1NZ4bk70GH
 X7Ucwm7wq6J6h1Ka6R1rSWCQypM6qAqOMLNQA1bewM/olFk8J5U6YYX7e6yWx8YBTe/D
 5x2Q1TEGx/pLZ4dRE7Cl07efqMNRRVyREH4K2JKdqJsLZG2bLhcvzFFW7PQSXzfRU/cX
 /inJmtFSIe1Ulv8hy1JryAX8L642C+7S8uKsR01TDuyFwrNydmb34QYX8TuahmM4y8LY
 zF6p1QikWi3hKxvW3uyae3ZYDH4qYKkkzC48AcHySo0ys6BEMgzMKt65HfXjVRhWT+cw
 2U3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bT3gaOeZufGXXDWlU1SW7moyeQJ4r1NDiSe3lomWxgQ=;
 b=CHFzkUF26LyE5P5aPR1Xws37M8Z2u5Pi6PBJ6qTP2pvzL47Pd1QW2w8d6wq7ojrR9K
 7pVg/r7o2+JFG50fU+qxDnYtV2NLxFPLdiA7v2VOy4fDshdqERoeRDcvx4rKsLej0bkS
 HxNxYfc4GA49W5CjXc8VmpRUIwbdpl8PniRirbKjRc6eBUJWG5hEz7776w8o2bSsaZL9
 LZKCu0pQr47UbcZfckUkQiZK8SENepLaqo3KVGq/LIuYhSGnu6mVJ1Wxl8vUIWtGgvXm
 5tm1lpwtX053kZDWKyV+xPNazAhOct0vxwj24GLxb/PzjHRk2Ki4H+GJij2varyC32O1
 fzhw==
X-Gm-Message-State: AOAM532v88dqv9JMRawKG20AFK2Q8NIsL6FklanyKQSWslYgp7D74PVO
 tyoZquKlv4t9zQN/w3oALEe2iZAMaEL9ndWqGxZBsg==
X-Google-Smtp-Source: ABdhPJy2+n/En3kRVTL4Igt0+xAgs84gPMpbMGkbdWw2ZP0jMI7rFSKxLXuf48gFOOYgX3u6xLCg+hqLIsr3H3LzXXA=
X-Received: by 2002:a05:6808:6c6:: with SMTP id
 m6mr5854979oih.163.1590077139195; 
 Thu, 21 May 2020 09:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200518140309.5220-1-f4bug@amsat.org>
In-Reply-To: <20200518140309.5220-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2020 17:05:28 +0100
Message-ID: <CAFEAcA9OyhO=EKy-7KC8hOWYN1QsnxYmyg83mSvGx5+J229-0Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] hw/arm: Replace hw_error() by qemu_log_mask()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 May 2020 at 15:03, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> When fuzzing the devices, we don't want the whole process to
> exit calling hw_error().
> Replace these calls by qemu_log_mask LOG_GUEST_ERROR/LOG_UNIMP
> when possible.
>
> Since v1: Fixed uninitialized variable
>
> Philippe Mathieu-Daud=C3=A9 (4):
>   hw/arm/integratorcp: Replace hw_error() by qemu_log_mask()
>   hw/arm/pxa2xx: Replace hw_error() by qemu_log_mask()
>   hw/char/xilinx_uartlite: Replace hw_error() by qemu_log_mask()
>   hw/timer/exynos4210_mct: Replace hw_error() by qemu_log_mask()



Applied to target-arm.next, thanks.

-- PMM

