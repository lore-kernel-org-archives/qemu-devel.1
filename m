Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589A4C4363C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:07:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93352083B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CQjHHCBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93352083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQVe1-0006gi-TJ
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 09:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQVaI-0001t8-44
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 09:03:51 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:33836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQVaF-0002qf-FU
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 09:03:49 -0400
Received: by mail-ej1-x644.google.com with SMTP id u8so8020213ejg.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 06:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8VE0OJTYu/kfj7Ku7R4xwIwNrgngP0Ve9pQKoTkgoL8=;
 b=CQjHHCBHyuj/ChjPmkA1qIR0nkaWlqwScCKE06dQzJOMNsL0kgCvsZ0eKOL4A8zTJr
 TxP5YAvxDmAb+MAA5nfyCNknRbBfp0l+8sqF/y1V2094gHLxZObF+wW5y+df+x6TB82e
 YBfOm2UHugq5Z9dInbxS5W2AkRZ9vC3Jo1KBii369e2lUrkw1i4olX4XvE3vo1JNw1w3
 lkfg0IKrydYQHD6wlKq+olJfJVtUSz/rFc43LEeXECEhJ59xeHADQ0CcYou2hb7ziyxJ
 OEWP0TjOBK9aLtp5//ipFvyYuerkdYAQDRVxVyOnetUzzRk3PeFF6iVS6CS2tzYOt5DK
 JESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8VE0OJTYu/kfj7Ku7R4xwIwNrgngP0Ve9pQKoTkgoL8=;
 b=IOovWrToREWMf3Uw7vR445zG+2SrfEe30l527/ddTMSWXOvuJt47OQHjNJ9kDJ+xCI
 YzbE6Ad3kPUmp4uUsth6qxlTHr64AWVBbezQWb6RIjRq8jdmYeKE1iqwVCgUUec2nlqr
 aFjhw68X/nCHk2DPnHTnyrFFoaO0HAxv+kwp8p2xgTACvP7PMFeukzKBvBTOW/D9nsAs
 dHX39re7+14PIFdeZemAKq410duG94stHx++6L1hMh6VS05AdksExbfXrfqRCE93Yt3Y
 GcPfnwgpqLR3EDxSfy8ottKWQC79noCRy/C8U6cKOIzZyDN+nEzH1/peZ2dTXh+jPWru
 bppw==
X-Gm-Message-State: AOAM532guwqAmobemNTkd/FXEK3myUaK/kZuonqKpkb2obrpzka6TlTl
 /XMM4gUP21bi7UjpZYZvVwk7pCrlN0ccvWCWACz0Dw==
X-Google-Smtp-Source: ABdhPJz9QFa0Hdal5/YdDCfwYTYHhcnJTmUJch8jr1LKSi/PVsi/1GL5EaEUAZhWlMjyqzllgAyjcn2uqNUmAMeQ6ws=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr8524433ejk.407.1602162224590; 
 Thu, 08 Oct 2020 06:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201002215955.254866-1-richard.henderson@linaro.org>
 <20201002215955.254866-5-richard.henderson@linaro.org>
In-Reply-To: <20201002215955.254866-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Oct 2020 14:03:32 +0100
Message-ID: <CAFEAcA-y_PtciTq0+GQAL6cAKhJvdV+PZU1y5T5rZa8hX+S5Qg@mail.gmail.com>
Subject: Re: [PATCH v10 4/8] linux-user/elfload: Fix coding style in
 load_elf_image
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2 Oct 2020 at 23:00, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Fixing this now will clarify following patches.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

