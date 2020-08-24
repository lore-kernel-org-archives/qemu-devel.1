Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D556C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 13:19:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C90D2078D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 13:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="buzVZHJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C90D2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kACNO-0002Fz-BG
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 09:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kACMl-0001JO-A0
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 09:18:27 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:34669)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kACMj-0001QN-K7
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 09:18:26 -0400
Received: by mail-ej1-x642.google.com with SMTP id d26so1753290ejr.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 06:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zntdPPS1QFYpvxxzmh8hC0pXrmmiO5RgZChYOynAOBE=;
 b=buzVZHJOjD5yYBP7vOPgcNftYEHbPsKCFBdNqTgiuBpMlOinMKkdjsDN3j2Qv68lu8
 vJXKm/B7CyQfGXgbmhL5ACS75q8Xr9gS3gyY6/XMC1TvBJyOKL7U8fAeILMh2bmNMHs4
 kcj9YQ0xAj9JSdXwfofATe45GsuwETtmbWnkPowt0S4jcylGa2RGD39HsLHCpaj5XIMI
 L2sSwmj4uMkbrPEEze3N1xlq4lYlMSEMgJaF0Q7NRyqwY9hZpj4OKeiPL8Lpss7bC5F1
 imnFG1FSZ/MSDfWm1rf87wXYoroO+GxAVVc7xMMUdde7Rigath0phDcsmhFEdEF7YaBp
 wHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zntdPPS1QFYpvxxzmh8hC0pXrmmiO5RgZChYOynAOBE=;
 b=VdwjxILYHYb28K+f+yH9HnEcNkBHncopzWt4yQEa88XTWnrLquqdp8vSzysgBbuReg
 9R58QUHuJ9VjCl48zWptTOWP5E6S47mbUBLamhJOW2u/QtOHIWErmiCCzBMkCXlHwpHC
 F4DEsfIMpHUENq7ULjPkHd9Xyzev/p2G0RwHHMV4es3a9fPeTqmeWbVG1JhmiUXiUOHL
 vmUCub5qZI08sstssxOKuk3MLFUjBsfZ5Ttz22i/mpRNEyVkp4AdeLkl6f4OolToRSb5
 bPSPMJTiNJCg1zBJTiXZdPJ+PT9Ftb+BSjzXkGsQrf0+OyrnL7TuAKqocJ4tsf/SYThR
 WLfg==
X-Gm-Message-State: AOAM533qooMAw3HwC1iCUfwZ6Kr7ca+UZshn9glv/ZfRVWNd5nriUdgE
 1RkvOI2jiVryyKX6Mit51Tl8gBZMU0DRtxl2c/GlkA==
X-Google-Smtp-Source: ABdhPJyBZkBn+mQS2Wb/W3B01Owj/4Lbc9EtH+7SvkKgqgOY+gCaNZrgj/3pBD2zOdc7PkRqTSw0LP+/24xngYNy8zM=
X-Received: by 2002:a17:906:59b:: with SMTP id 27mr5855113ejn.56.1598275103823; 
 Mon, 24 Aug 2020 06:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200824130114.41368-1-thuth@redhat.com>
In-Reply-To: <20200824130114.41368-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2020 14:18:12 +0100
Message-ID: <CAFEAcA97pa2eUx2-c-YmuBGaVA9jUDZ-VTd5fCpcyJ1rigiEww@mail.gmail.com>
Subject: Re: [PATCH] disas/libvixl: Fix fall-through annotation for GCC >= 7
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 24 Aug 2020 at 14:01, Thomas Huth <thuth@redhat.com> wrote:
>
> For compiling with -Wimplicit-fallthrough we need to fix the
> fallthrough annotations in the libvixl code. This is based on
> the following upstream vixl commit by Martyn Capewell:
>
>  https://git.linaro.org/arm/vixl.git/commit/?id=de326f850f736c3a337
>
>  "GCC 7 enables switch/case fallthrough checking, but this fails in
>   VIXL, because the annotation we use is Clang specific.
>
>   Also, fix a missing annotation in the disassembler."

Maybe I should just update us to a newer upstream vixl...

-- PMM

