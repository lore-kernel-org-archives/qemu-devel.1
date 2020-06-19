Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267C2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 13:53:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3239207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 13:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pHDpLgxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3239207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmHS5-0006vR-7w
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 09:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmHRR-0006K2-S1
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 09:52:25 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46257)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmHRO-0000w9-Cy
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 09:52:25 -0400
Received: by mail-oi1-x242.google.com with SMTP id 25so8467545oiy.13
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 06:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9q3TKhY7AwymSeQ+ExBiktzoKtLThZ1qOZJ9ez18g5E=;
 b=pHDpLgxXE0xww+9q7AHQse8/LckvTp9WcC3lL4gAVCL/xxqgcbPG2/AiYCObWI06pN
 MZs3I9SyT34UpTtAr5H+ghH5USNwZHwX5ALmdFmBsxgldIzjYX3/w9kUFpPQg2T5NQX0
 0ZCK4ZVYzwtULH2mS72ItiSRkyvAf+BzrqmEpi4aX+/Mk6gtmirQJgfCiopbmvFPcR0U
 XZ/PET4VtQwaT5qXh/M0sB82OIZqNn//Z6tO73PBjaFOz28HAPiwHsrjMzdEehgc7OcI
 AkXY7bC+N7UkQ5tsJFwnyGR2qdEVIXnv4T2f2QLxREO1nh6KpellR2ck2j0Z4hCx+o4P
 3fjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9q3TKhY7AwymSeQ+ExBiktzoKtLThZ1qOZJ9ez18g5E=;
 b=ByFnojQQBnVzIFDzI7/ahFkMdqbKVZUEuIxR9qD9zejqRycz3ePRCE3JZSUEma4qHe
 5vQ26u4y4lNiPsGXJ6eLyLEJQ7bUY1j/ihaaDuH0UBOlMby/+Kj/HJ68hysqhlvkyKrG
 fYhz3iCPrdm/IKhDFhU5F77hWwKdn6KEVO2a5peDZutBxRTeDIPrxTQPq9IiHxg4z6Vs
 +6hdqAfNZ37nd4wBnvVVbufW+SS4YDqADEYnkn8pEwBtrqG09crx7l8AOF7/mHTGfAaY
 cMngr+cKG5m+TNYGZMPQBamfU1bnHIThYPpgFAS+rAC1ATJkEcz3xSV77HRDvlKElEU3
 DN5Q==
X-Gm-Message-State: AOAM532/R19g6ODtl5V3n9dw2jaiY8fsGArWQ3LVxdXRH69JcWyl/cti
 MPiDGCP1LSICOPCOu9SZdrWRl6YVwR/rZWmj0J/uwQ==
X-Google-Smtp-Source: ABdhPJxyRxI+2k32N9YF37PraBPyz3KR248Edriar6FrCRV+QP4s5ARM3QMKa/Qh67Cn11YtekTjtMNTmvVqzGD/J7A=
X-Received: by 2002:aca:5152:: with SMTP id f79mr3004043oib.146.1592574741067; 
 Fri, 19 Jun 2020 06:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-27-richard.henderson@linaro.org>
In-Reply-To: <20200603011317.473934-27-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2020 14:52:10 +0100
Message-ID: <CAFEAcA8z6H=p9KXEQdDTahXCUFSmf8y2jvE2T92mvebaTdPNOQ@mail.gmail.com>
Subject: Re: [PATCH v7 26/42] target/arm: Implement helper_mte_checkN
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jun 2020 at 02:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Fill out the stub that was added earlier.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v7: Fix page crossing test (szabolcs nagy).
> ---
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

