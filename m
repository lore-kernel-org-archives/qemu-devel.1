Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C50C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:31:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08A0222257
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RL4D68qX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A0222257
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUTNn-0002pt-J5
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 07:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUTMW-0001tE-Cy
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 07:30:00 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f]:39752)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUTMT-0006OO-Nb
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 07:30:00 -0400
Received: by mail-ej1-x62f.google.com with SMTP id lw21so13387894ejb.6
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 04:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sGcPrBO8q9qtGXpHMjuvj8ODOlmXKhjmyh04PeiNkW8=;
 b=RL4D68qXy2iyHykKUjwN/S4CkrpUoIvNm89s0Nq3Hxf4Z8fmspb+8td9hVDYLetL7S
 tawwvQkUho9xo3U7ppUEEbSx3vFNFgKyC9RZKjcCP1EPSfgT8Qdnp3NCdTDUc1JKMQJI
 3od/OrYGRTflViifP3Reqh6XdlgaX8K7qJac5Trc4ipftWLgYR0n0f3Zg3BhjprV688B
 f4Npty2LESmpEJuyni+xzb3w0dxnDtypFb/e4EOMGoZjcN3gF3aoVZWDam6mADRg4Sjg
 cd2sFMs2Qms9OxgZIH6YIWcKJSIzmIQ40LsYoMaazqMn/KIqL8oKivkrxwN4N+L7jf8W
 nhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sGcPrBO8q9qtGXpHMjuvj8ODOlmXKhjmyh04PeiNkW8=;
 b=R7Z9D7tMmrjFuMqeAyXwjbRMJaZVO3QBZ7ThN3eyhaOz8X8EJDR42i1ViKpk2QOZk8
 YEALWvSVkULA1oQ2ulOvLFLavnPuoC16qvzQetLuz9lU9JZPT8duEZGtgBfJ0d5UE01j
 LOEEsjnrpu4ah5kDBpo0X2/+1osfhfDwHpev7JCkmVws9P7qmraC30SHIi1QItn1CmlT
 IuCnLmEzTFaucyAdZPXlzYKQXGeWP2Y/WnAGeI54NC433GcsFnQ7I/U6gAGAJxcKkUtb
 pWarkgIGP8UxaIzSJiuhARDfXVt/nQ6e8c+6SGe605GYz98uUrbD3olluJ2Mvk5ij5XZ
 bhmg==
X-Gm-Message-State: AOAM533fSmbm1qKJU0qKCzrPMfkN3yjBka4w0Ay5z1MK3JArCpWpGsPZ
 s4dlmdk9rFuJxBpfg7ce634xFLKOZ0tallxcHBLbCxxa9Ek=
X-Google-Smtp-Source: ABdhPJwveXvpjK5HQW8CJsRBwwF9O+RHvVwVBXAW9VTf8pMmRNmi8GRvtHwZxBqzyRaaYKKI34IyxbPxSJtNv2vwdKc=
X-Received: by 2002:a17:906:3a97:: with SMTP id
 y23mr16857260ejd.250.1603106996046; 
 Mon, 19 Oct 2020 04:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20201019072027.5965-1-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20201019072027.5965-1-mark.cave-ayland@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Oct 2020 12:29:45 +0100
Message-ID: <CAFEAcA-B7u8jQjdqKF=reuTwjnHc0xxBznpdYWarqF7YLtJfRQ@mail.gmail.com>
Subject: Re: [PULL v2 00/13] qemu-macppc queue 20201019
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62f.google.com
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Oct 2020 at 08:20, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> The following changes since commit e12ce85b2c79d83a340953291912875c30b3af06:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2020-10-16 22:46:28 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/mcayland/qemu.git tags/qemu-macppc-20201019
>
> for you to fetch changes up to bb997e5c967b3b6f19f1461811df6317ed37c5ff:
>
>   mac_oldworld: Change PCI address of macio to match real hardware (2020-10-19 08:11:21 +0100)
>
> ----------------------------------------------------------------
> qemu-macppc updates


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

