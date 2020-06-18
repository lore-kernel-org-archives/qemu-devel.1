Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA261C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:04:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1DEB204EA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ucaUpmgo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DEB204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlsLG-00062D-U4
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 07:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlsKI-0005Dz-HM
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 07:03:22 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39995)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlsKH-0004i7-2A
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 07:03:22 -0400
Received: by mail-oi1-x243.google.com with SMTP id t25so4669657oij.7
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 04:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sblb7qlJdr34B47GIhwzR92sWkubK3mKOcyUPBBcXEc=;
 b=ucaUpmgop2q4eutZnwqY+teLFGqoyUvnu3KAlbRfpht+f/MBPDOEgjtztvBwmdLyhF
 O6s2lxvmHzn1JsuDMCUXCC5EVNQdktCxyVxgwJMM1Xg4C2XhH2fKFRK9K2toM7dj6MJW
 An3WliX9wJPevEblMBWkeVqBD1IQcIoyugeDH5B1c43iOOjK7cgxGvMqZNrvpJbFdAN0
 uzVqY3qZpkZDHt1HKxrTWy+aox852goEAiPUzkSikiJ/cadFY/1oiScRjn5XnV0ch4FN
 DJdVy4qExsLxKJa7kNQp1Rh7cb6+agBt0e9ooWbFLeUcVKAYEdNDDwrEplU9L0ygK+xo
 1glQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sblb7qlJdr34B47GIhwzR92sWkubK3mKOcyUPBBcXEc=;
 b=gVRDRx8tJn7sS1pbgtYhZpyp+Gk29kzv5Abdk/N1EPMhuvYXTBJnWiHo7ZZwqYuSWe
 NWEc8A20SaBW33oAwcehsuRMRyREyv+jJHw4LqIYaQVCARD3gvbRQk7uUNS9LQ4ZWnhY
 94sHjO+lUebShvHMEjqg5BRym737uzB+3TDHMrdgOp4mA4qw0mMnHmGzkgzLgeo2O0eI
 Wf3g3vIt4oMurV0TZDZFLNax1JVuFZrTCbgceJ7sb3Zqf5IaMrOJsrgb95NaW5z58B8e
 c/YbdHBaP6u7YInmZjUToIuA4tZwLeFdFZqc/VqRt6d7SHqmRPOx+OWXY0vBH6ML8OPM
 fE7Q==
X-Gm-Message-State: AOAM5325XBLyd0JQBWeu1QsMQA8E/trkkE9A2jywt+ZL4rJWHgG4pUwM
 QOOjPnsULDsg1MT+xSg5sMvqwKSy4sz1qNw7KwFpRA==
X-Google-Smtp-Source: ABdhPJwNtNEWTTy4g9D6k5rj0n185MpZKofYBB3sbtdfWwjqJ0yVA7xtaLoulU16mUf8AzVUtDZssM8XfrL7He26Bok=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr2351759oia.163.1592478199972; 
 Thu, 18 Jun 2020 04:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-6-richard.henderson@linaro.org>
In-Reply-To: <20200603011317.473934-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 12:03:08 +0100
Message-ID: <CAFEAcA_dbXptwF6GiQ=o2sM5Wvbrv+fVegxS4HYOo8fP_w2ifg@mail.gmail.com>
Subject: Re: [PATCH v7 05/42] target/arm: Rename DISAS_UPDATE to
 DISAS_UPDATE_EXIT
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
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
> Emphasize that the is_jmp option exits to the main loop.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

