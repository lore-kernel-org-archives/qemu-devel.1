Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AB6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 21:43:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1872E214DB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 21:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XQ+1J66v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1872E214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTXW1-0004Ui-Ij
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 17:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kTXT0-00038K-3g
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 17:40:50 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:34713)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kTXSx-0000BR-39
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 17:40:49 -0400
Received: by mail-ed1-x542.google.com with SMTP id x1so4024704eds.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 14:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YCjcoHVYUkf4IvCRj3QowSd+8EwEZCgHUEg+0SnmO9k=;
 b=XQ+1J66vo7DkE5MgBz74FIsMPBG+eUIi7ciO/xh3t1d3NReBIub6PcAJ8/T8xc2csT
 vh2UdkvgvaKzQnO5N1d5PQgVSpDQDYfK6ar0jEEFtbpKgURuOPsJzP0ggF1y3T/YLUFY
 rmS3RwUzJtdULVuJvaKNpxaBySLXds0w+PY3cz3ILFRaedD+eXrnTeuJ8AnhbCfRCitu
 /GlW34S0RxnTZO+sHLbKCZ5dGBHN77ObUvZccenA55lEyvDk+/BqmH2GSVvj8GyJcV/L
 uzLJhfjzS8Ke+8kVqpRgFw/i/tADya0GGOygS2/2iQshB1fhtfrMa1FSFSGkmtzxUSDl
 4F4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YCjcoHVYUkf4IvCRj3QowSd+8EwEZCgHUEg+0SnmO9k=;
 b=TyJhUsVMpc5Km/1a+DF+Kw8Tw10wuvcUPrWUZY1dg9tOj64hR1aqkJRH3VD+4rm9Ue
 dahCnLlnsqAH1dI+nYF5uFVlOlHLLXFW3fAMj83p8Yr+k+1YYaed7Dwt1pEje3iVabt6
 hJnOgkIAEmqxEKqr4R3OhZ37iUORp0H+ogfzQ1FMvupcMZu9fy7RKme3gqcgBF34zEDW
 ZjXjzBNGUTv4aFARqv/4ZfjDrlG1yvw3mFEb5Ew/ix8b/mZ0sRAVMsWaodCsUsz6jbeQ
 z3VYmZJNV+Fc/ZTOO7c/W0FC8bEHH+tPqxZf7VDyjbw8DGpAVNO5ud6dm2xC66Ck5saH
 1+Vw==
X-Gm-Message-State: AOAM5320CN9dsz5EMbnCu4d+Acl9qiXeiYnEwaLb6qUoKwMtuDe+pfji
 +PJdkQyVcx6R+flz6yd1O3D+fdQmXMbamNvZjKfLXQ==
X-Google-Smtp-Source: ABdhPJyEavwUdP+9JD7f3zbLH8yaqKlpsNoLGIBkNhzsh+qnZd/LB5xTHbjVmW3iqiLTU7gqv0mgjf1PiRaL1IZ9ZQg=
X-Received: by 2002:a50:9ea6:: with SMTP id a35mr6578110edf.52.1602884443639; 
 Fri, 16 Oct 2020 14:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20201016210754.818257-1-richard.henderson@linaro.org>
 <20201016210754.818257-2-richard.henderson@linaro.org>
In-Reply-To: <20201016210754.818257-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Oct 2020 22:40:32 +0100
Message-ID: <CAFEAcA9AWL3oC000ws8gikr=teGNs=kz6x382K8kS68JWkdATw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] accel/tcg: Add tlb_flush_page_bits_by_mmuidx*
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 16 Oct 2020 at 22:07, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On ARM, the Top Byte Ignore feature means that only 56 bits of
> the address are significant in the virtual address.  We are
> required to give the entire 64-bit address to FAR_ELx on fault,
> which means that we do not "clean" the top byte early in TCG.
>
> This new interface allows us to flush all 256 possible aliases
> for a given page, currently missed by tlb_flush_page*.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

