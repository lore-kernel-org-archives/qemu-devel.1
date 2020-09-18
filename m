Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4123BC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 12:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE6362073A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 12:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VU8lPCZ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6362073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJFey-0002FQ-OB
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 08:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kJFd6-0001OP-2L
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 08:36:44 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:42220)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kJFd4-0004Bc-9U
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 08:36:43 -0400
Received: by mail-ej1-x641.google.com with SMTP id q13so7864505ejo.9
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 05:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Js+KIzfKsiljwC2Yw1FBf9d03ZsA9KvNpr005GhdJkA=;
 b=VU8lPCZ0v6B+1lPf3SdNNXe7BMML6KnQqMxUTHsSzoIYxWPBe6STh/CZ1q0upIqPkK
 HdRB5zTGdsk4LI704dtW4FDdGHSgz5QC7XjNuS8iIjf+BDCegytdCdbBWihyjisir53Z
 ogDNhBfx9/XM8FLAuod0Uvp2BMMZSLu/GPzWURn17pz4W5mYQiyvq6Xm7zodw1fAU9k0
 LFAHFIe4o5HI5e167cZycmk6twvZIO5KeuvgzUICmMsCvUETZK+HUju/85CqqdkovMbM
 lvXdmkW/z07dXTu0R8E35QJ9haBBVcE+11WgylILxJJySjz7mQrTV7pj3SUvKmOOHLFI
 TTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Js+KIzfKsiljwC2Yw1FBf9d03ZsA9KvNpr005GhdJkA=;
 b=j+0Pkh2xvnu0ghclnIMQRKzOrN4FJi8f3n9qOeV/F4SxO2gwU5Hg0LnGmIliEqFVZp
 /7FLdhWLrb2xp1yDCQSVdTU/6u9ME46nUSZZQ6zS1vPD2XuUsXI4uvY/P5ygMOXD8pJ5
 sSqKMjJzwG+VgNjnFGjxv79jZXqLlrO5Zj7tjZigiHTg1C8PttdOXRTtzgOpqAixkFXZ
 eDag5brU4wnr71zvvp9wZ21vBcxHAkJItMvVeFwZ4poVaIYD0Jk24ir8EHUeuawC0ooL
 036w8z7OVj8F0QS4f7uXx/xjjm6WVSkfYg1GzD/z2toAivZD47eTEYkusd2+4PZN4d0G
 Fkvw==
X-Gm-Message-State: AOAM5338ZjozYe8KCpe9NDHs/LIgDch3iBufZB4R43G/YD9nyPS+UMwC
 mT0ljK4Y7DT2bDkn8FnRM56N5IWKLhwsYxeryj9OHQ==
X-Google-Smtp-Source: ABdhPJzuwCnsPoyLG5RZi921b1I0CEsn4d5wPcKGIqiGab7ZT8Preed5LbCFX/VmscDC//CP62XUeMbW3mscULLNbUs=
X-Received: by 2002:a17:907:20d9:: with SMTP id
 qq25mr34163848ejb.382.1600432600345; 
 Fri, 18 Sep 2020 05:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200917104441.31738-1-pbonzini@redhat.com>
In-Reply-To: <20200917104441.31738-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Sep 2020 13:36:29 +0100
Message-ID: <CAFEAcA8HOMypsmEjT3kb+nQD5vPi5mYGU87434J4ZmFgopiCDA@mail.gmail.com>
Subject: Re: [PATCH] docker.py: always use --rm
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 17 Sep 2020 at 11:45, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Avoid that containers pile up.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/docker/Makefile.include | 1 -
>  tests/docker/docker.py        | 4 ++--
>  2 files changed, 2 insertions(+), 3 deletions(-)

Applied to master, thanks.

-- PMM

