Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE841C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 980482065C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HY2uYfXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980482065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfhoC-0000GG-Qx
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 06:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfhnP-0007j4-M2
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:35:55 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40851)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfhnO-0003NC-PO
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:35:55 -0400
Received: by mail-ot1-x342.google.com with SMTP id f95so4158644otf.7
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 03:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Raah8jLu1rOGRHgYL+0Wiqd4fUkBSWrv42NAsaR1Md0=;
 b=HY2uYfXOa/6A6XcPUkXBO8nd+R+nWNO8IXdp1emRPGbP9sw/AMDEl4A8hT03/Hzf03
 fC2DIwo5hg+zeardiMsZM/BxlTnH63loTriW8mDH8HTsQ50f/2i4gP1z4V9BEe4+3+he
 4EM4ZGykSH/fUJ/PmN1g9M2tXlPBiflQn+K7xKsDdZMLxIF3olaYF2HjjuVps0wO/rW5
 Q4v9KYdNc5W8TzPYeMh/TDHpMw3oeDzTx94Xa/kyp6iPDBOoagCgLSiAmo4ZNWmGkCtH
 a6TnWo4mzEmg0JRnxZLLCOPTWx/9op62qwQRBmdv+yGRRySq2VONcNcIJutNpBdJ0i8g
 1Uug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Raah8jLu1rOGRHgYL+0Wiqd4fUkBSWrv42NAsaR1Md0=;
 b=gNmZgWt+x0PARwXVGxDaZkdYQ5WdrPuFdnkrEeMkIHIEBf9oiHtr4p1305Pd+as93I
 lCSci+uSvWcUdqQaim34/G2h5eElSwBgBiTDQIKYAERS0WNSI+yhAI/3gc8ps2Nr1i7e
 HHHSgoQ0fGSBinUmrtIACHsLIzYw0yji++7jCBMrmIFLrwPS6+2DaG04/LH0xi45NSRJ
 bIbKwMBcOnInFmgOU9orXnbFCMd0eokRTTtSCQIJ27zDmPScgPdmLkxvvlY8KrB63Fq+
 Q61ORKYhYaoG61zycpz8vZZEv2wzkXP9O41kN9egAB021E7vIZfQ6NOYzgNQatTuBRkJ
 iZ7w==
X-Gm-Message-State: AOAM533atdUSBvuXKEwT8Sjtm3IJrG/m1aYfApKNoijs+rt8gkV3trWA
 ZNBj171/ZJBOVkeHUvltfy4Tw6+PImEe4ZtpjwPu8w==
X-Google-Smtp-Source: ABdhPJzWufstJ0iW5g4vwdC83+iPLklwQ8pWWnGwUbodAlZthGoY3X35Qw2Q5pK821eC8uYPs2FCnpFXUa4/Mnw2Vi4=
X-Received: by 2002:a05:6830:14a:: with SMTP id
 j10mr7754686otp.135.1591007753206; 
 Mon, 01 Jun 2020 03:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200601075400.2043-1-f4bug@amsat.org>
In-Reply-To: <20200601075400.2043-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jun 2020 11:35:42 +0100
Message-ID: <CAFEAcA_bpWQr+ztbrYc03Kij8wwAJ2fm5v-Bi8Q3viApWvjW6A@mail.gmail.com>
Subject: Re: [PATCH 0/3] exec: Kill CPUReadMemoryFunc/CPUWriteMemoryFunc
 typedefs
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 1 Jun 2020 at 08:54, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> Followed Peter's suggestions:
>
>  * delete the unused MmeoryRegionMmio
>  * move these typedefs into include/hw/usb.h and rename them
>    to MUSBReadFunc and MUSBWriteFunc, since that's all they're
>    used for now

>  include/exec/cpu-common.h |  3 ---
>  include/exec/memory.h     |  6 -----
>  include/hw/usb.h          | 30 -------------------------
>  include/hw/usb/musb.h     | 47 +++++++++++++++++++++++++++++++++++++++
>  hw/usb/hcd-musb.c         |  5 +++--
>  hw/usb/tusb6010.c         |  1 +

I think we usually would give the .h file a name matching the .c file,
so include/hw/usb/hcd-musb.h ?

Either way, whole series:
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

