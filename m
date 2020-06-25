Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DF1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30AB2206FA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="buIVmduX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30AB2206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joPs8-0006wj-6s
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 07:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joPo9-0000ms-HG
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 07:12:41 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33309)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joPo7-00058c-Vx
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 07:12:41 -0400
Received: by mail-oi1-x242.google.com with SMTP id w10so1114170oih.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 04:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2mxHRW8MSjNqz5XJ/PBqKLrSV/78W5mMnJyFAPuyRLY=;
 b=buIVmduXOAsjLSZPB3h21JGeV1TO3bmB3XnB7OnOUkYmic4rAWgTrZJpH0CB9IsXQQ
 2StHmTe+OCsqvUrUFdYyDVTQRRhlG+OdPfK3juwgrdY5AIcRZpP6wQQrb26fJhYG5G9/
 k6t+mKLkE2prNRIAiRELbBMsy3GtKYGFom0gtaj+D91Uup6hOmha44IjiG7QOlwqKVO0
 azbRTYzjL84Tv92XC13q10FZ+1omdhGW4iPRGV3MdldxAXHsXykDo0wl0IrxJVs3YZVm
 YAwf9hbhuZvIPFvcmROfDBqPghDObMnNoxm/sTnxSObN+5zZ1md1WtiXR7C2tpCjE68g
 3bVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2mxHRW8MSjNqz5XJ/PBqKLrSV/78W5mMnJyFAPuyRLY=;
 b=lSE4QYFUb4D2sDwFNF8rTPVY1adJh2q4kwuZPKRt1MLDKR+I0IJi8/E0wsJNb398xo
 2wUdWHRRe9S/JpHy8fG3hU3hmwKz6sB1MsRSYm090CjhfLV3abfIf56gTla2Uq9PEpCT
 tW0ophhzS+yOe0hK7Ty9VEFdjnT/4lMKA0EEBDeGZQdxHbtChqObjBv/qsKyCT9kVoMX
 xDS7z/9IHCbi3OalGSBk0Htn3Nk+uAw1KAzSSVJD5LfX9zN0/Np9FRklE9AFbUI4Z4+q
 qpKPsfGHC7ZmbiFG5DF9X3TqAS+Dlu7f2fRUuyeGWGtsv2XwVFgVeYI5PM8DeSZGIpfU
 BJBQ==
X-Gm-Message-State: AOAM531tftZzLvi/0+4aB++y4c1iq+hhPuLxGaaeAhXX+JYWnS1rtB53
 NEBLjpPxxRtYd6jHlykwOnQcqCUmsd8N6c84l23uPA==
X-Google-Smtp-Source: ABdhPJz67FvBh243j+JsET8U1kJJPOEX8Awh32L7G3lbKtiwyOI9oXwytmutc3gwRCTyJMHULc8+3GPGE/AuglEdiig=
X-Received: by 2002:a54:4694:: with SMTP id k20mr1652844oic.146.1593083558974; 
 Thu, 25 Jun 2020 04:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200623193658.623279-1-richard.henderson@linaro.org>
 <20200623193658.623279-32-richard.henderson@linaro.org>
In-Reply-To: <20200623193658.623279-32-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 12:12:27 +0100
Message-ID: <CAFEAcA8peNugU721+PO+kDEH52Dr6+oP_x=n3wYVzpEeGfur_w@mail.gmail.com>
Subject: Re: [PATCH v8 31/45] target/arm: Tidy trans_LD1R_zpri
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
Cc: david.spickett@linaro.org, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jun 2020 at 20:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move the variable declarations to the top of the function,
> but do not create a new label before sve_access_check.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v8: Split out from previous patch (pmm).
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

