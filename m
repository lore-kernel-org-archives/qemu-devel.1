Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B370C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:42:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A73206A3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bRDvQSu2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A73206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYW76-0001az-Eq
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 10:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYW6F-0000XK-Vl
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:41:40 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44328)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYW6E-0002Vd-QM
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:41:39 -0400
Received: by mail-ot1-x344.google.com with SMTP id j4so10650490otr.11
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 07:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rhkfwuLotT9TAWS/iuSW4hth2gU7uKhrg+fKgp2fjK0=;
 b=bRDvQSu2VWG00KvQwY2VA3FqngCQ8Ie/yl/X3yKRlmzh6WGkh1uPLrWOdDxnVnQfrp
 OHbL8bt9TBBuTmOI1Je/Ou7SCrISKsoh1vG4vFhE1K7ZWrGaQbzo/TntFE7wq4BIOgQc
 Sl1honl60m4uUXdKCUE1VMr9VrnqFf/k78D3jcq3P5N+HtNA6t3pg3v/8RF+HD3xNnYL
 Db8W8sEp1sTT/ow+mJq5+1qEOYoAsoIa1wh/5w7deju3kJBpOwQTHMI77heULg4Ir94I
 HEpdscYRvTity+bKBhXinqOtmVtLt95T6CXZrHKilrpZ9K6twgMMzJHnVC59hnjHeU7w
 pSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rhkfwuLotT9TAWS/iuSW4hth2gU7uKhrg+fKgp2fjK0=;
 b=NE3DAR8vLx+4lWMu/7EMfHlPeArJS6zwxk+ofnucduG906IdxtlZg9z3DdxxwaG0BH
 nh/aT8+wOcKYjtJRTs+jSzl+AB2sotFKw2OnwbJdw8JPW7LnIctJoHFnrphQDtQvYNok
 3uyoxTBW7Q6J471P7i9Vmz2wt8gr8FleL92evv6DWsH0RVuQs0To7hT9LXWIfHyvK6RH
 nUFDboRV40JhHe2dfH9Kkr0oP02+2PsMomW+eCFZYgufrnp4/rD7Ne8hcq+DC/LBjxNo
 KdfFx39LmeSyvRP7jVaE2H9OWfPSlDP063gIXpi4TqLDBc7x+0e6uFEAGBo0Rl9EwZ/7
 g9Og==
X-Gm-Message-State: AGi0PuZ6YPpOWVepaK+TxknkqPlRDjGInQBC3099o1HIaxnRXSiB0DKo
 3SgBQIBjkkDoivzjvjesMMqWOyQVwFAEavcMTqAoqQ==
X-Google-Smtp-Source: APiQypKBuAwuwwNVQPR8hZ2HU4Uw+pGiY5rbdPzVtErBuRgRA9IbDdRLWzEZPv+yuzQxgrLN8nSAZ7jgxL8yDPF467c=
X-Received: by 2002:a9d:398b:: with SMTP id y11mr4935990otb.135.1589294497369; 
 Tue, 12 May 2020 07:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200508152200.6547-1-richard.henderson@linaro.org>
 <20200508152200.6547-17-richard.henderson@linaro.org>
In-Reply-To: <20200508152200.6547-17-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 May 2020 15:41:26 +0100
Message-ID: <CAFEAcA_KpuT18fhaV3B3o+wcNeFu4MHdi=7Y1Au46BqYq2aTTQ@mail.gmail.com>
Subject: Re: [PATCH v3 16/16] target/arm: Vectorize SABA/UABA
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 8 May 2020 at 16:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Include 64-bit element size in preparation for SVE2.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

