Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D08C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:15:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C552A2078D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XbWoBlBv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C552A2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlsW5-0006Mc-0Y
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 07:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlsVG-0005NI-LL
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 07:14:42 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45651)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlsVF-0006p2-5n
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 07:14:42 -0400
Received: by mail-oi1-x241.google.com with SMTP id p70so4678309oic.12
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 04:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0rXg20TJkXLtN3v1tJPX1FStPIBVLi+Tb1eX8kmdZwk=;
 b=XbWoBlBvwZumdYCpNqG855vUHaeJeA781jEtYwgC4rBxfOrDntcAXItVv4Yf/wA8ZK
 d7E5DPGsi3c+ax6mt1M6NEfIrimdac7VMVUyL6n25QKOZYcs+HggP/cFIZOhn5Sjh+TV
 wP41t+SfoVYZAkFQR2Xf8t1DYG4ibqi0yGZ/0uDoxVVMENhA4kK8Xtxcc2BGVDURJSII
 8rF6PYeflCKfABRI4VcibOdnmrTD1DI9b86hsRB51ARFo8iPef+wQ/NP9gtTv/VGIIbZ
 aVOgNT8WZDstIAB9op+ngj+WOu7p6/TI4s4ubWEuz41w9ibYIX6GNLnlRT4Cq8LIINCi
 Qg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0rXg20TJkXLtN3v1tJPX1FStPIBVLi+Tb1eX8kmdZwk=;
 b=L/XwPTj5UJ0fTK8wGGJnM7bIoKu1cdNHZ4TtU/h5OFUPNc8KcMH0YrMkBKuXEqguwN
 M2U4CjVySLWu0zoH8ay0DtfIFwh/U3IfUPPnqw9gQcipVWgunF7Ks15f43ifFWI5S8OU
 8dFeaLx8/6B5yMKA288+hmlBdZE/sgX6YJwfzE/xNBM+fq7VMjxQFzUzTj9zOziQxMUm
 5MsBzaaNAbHY3SJhl3dXTdnDeYC6AcMK9x2m+Qro4a6twiwW+Qj8zTmRbPFiGggGoRuW
 VClCL1KfQuGqwXBnGc+fAa2FaKvSK52/yQZJtUIPacSUFODfqq9dUsyiq/CEK1FSs70V
 uuCg==
X-Gm-Message-State: AOAM532GWls8g95rEFuSynuhgkjqOIxmG0J5EekbbC5GQqrAoMLMM0hm
 eJkDEaE4yHWdW6SC0gp7k1y99NuG2BMgZzvciOj/Zg==
X-Google-Smtp-Source: ABdhPJwaCDMS52I99aPvtpjTNQ8IMyn4ZhtKcvPxxd/oFt4LZ3RbZGhCTfhiaUxxHtKWfZcfGClWhT9jiRt008D5ihA=
X-Received: by 2002:aca:568c:: with SMTP id k134mr2296910oib.48.1592478879798; 
 Thu, 18 Jun 2020 04:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-7-richard.henderson@linaro.org>
In-Reply-To: <20200603011317.473934-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 12:14:28 +0100
Message-ID: <CAFEAcA9mRAP+Zj_zY2Ub=VpL1Pwi+2iD6y_T=b7ctW7x6aHWCg@mail.gmail.com>
Subject: Re: [PATCH v7 06/42] target/arm: Add DISAS_UPDATE_NOCHAIN
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
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
> Add an option that writes back the PC, like DISAS_UPDATE_EXIT,
> but does not exit back to the main loop.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

