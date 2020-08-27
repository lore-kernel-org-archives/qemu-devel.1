Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEC6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 18:38:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA25C2080C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 18:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pPhcLxj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA25C2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBMmp-0005Sn-Vq
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 14:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBMdH-0006iE-6v
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 14:28:19 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:46348)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBMdF-00016q-CR
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 14:28:18 -0400
Received: by mail-ej1-x641.google.com with SMTP id d11so8925915ejt.13
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 11:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7gy43hJYSthS0yDfxJco0vtNdRiXACowfmWjmerpjQ8=;
 b=pPhcLxj26e3PXSvsQdTj5DXrI8g0fLPiKErRN+9pwrnjjMqNr9CRBroZrM4/Ht5uis
 tJ7K9/bGWFHM/jZ/31PpgFiXvu+J6rEaJjnRuxDSr94WxO6nS6CxGnMygSU+A0xodizZ
 VlBPXCRWvtW1ErDcnZBb/ytmZbHUUBuzFf2o2emgqjzopjc7ajp1l4XVfKxg8iJBnxXy
 GPHs9CgHY/6GfsdD1rqjvfwDYEs4yeW6RfImMt3J9SNfFsMGoi06c/NlvG/HhgrmZM/4
 6h1KW3hVEC7f02GFqJ9tq3wRcIAoUnb6qac6hjOOiQxNTKIOql7YhJz+BkBbzCmZ2Yvn
 6VkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7gy43hJYSthS0yDfxJco0vtNdRiXACowfmWjmerpjQ8=;
 b=tKTbQrOSihQbBUGx7k76FEFVFqJAPGIH2kOZMCnDpMw9K1EFhCyR3ldrzSbJzbPWj+
 yTC4vLPRGu3w/S14z6H5vB8rZ4xfznomVVKRCCIHuLKcYq8BzXmvxIMujFqz+vhPDBbi
 RVrZs9b6rSXqBqsWDbzyaR1jniBIh55vcbdY0eNr+I/IK8FgH21IsoszmhvUswTwjGJz
 RvCZWt58ZQ+7ILYW2sudRF598EhtqF0ZLwk6EydAWpc89Ij9rrJ9dFnlnh+PbY61fY3v
 PVcuvrzRu/Rg7J88ZWgI6NcoLBoRVWaKXDz4xoG4Xn3rPTgyFOUbfAMhPPthHK9HsMei
 oe+w==
X-Gm-Message-State: AOAM5309+XayO73ia+vFuVbllvgC62gX4WO+swYw8L0351caXbnqZdBu
 7a3p3ReYXqjrE1ySPrke1logvxuFc+kxaqlcpPUUJA==
X-Google-Smtp-Source: ABdhPJxXaTU1PM/FBqHFtORLBRIvcp0eRlrbp+4Rvu95PsEmfSYkXiPI/gvPdpzENgsJYQo96YdyqzFowvwA+U3sXQE=
X-Received: by 2002:a17:906:d8ca:: with SMTP id
 re10mr21491029ejb.382.1598552895628; 
 Thu, 27 Aug 2020 11:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200815013145.539409-1-richard.henderson@linaro.org>
In-Reply-To: <20200815013145.539409-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2020 19:28:04 +0100
Message-ID: <CAFEAcA8OfO_XxNG9KRHVgM501cu-ERVXXwVSMqcNhySA1QMrqA@mail.gmail.com>
Subject: Re: [PATCH 00/20] target/arm: SVE2 preparatory patches
To: Richard Henderson <richard.henderson@linaro.org>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 15 Aug 2020 at 02:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
> This is collection of cleanups and changes that are required by
> SVE2, but do not directly implement it.  The final 3 patches are
> relevant to Peter's aa32 neon work.

If you agree with me about my suggested bugfix (s/=/+=/) in patch 14,
I can take the reviewed patches (1-14,18-20) into target-arm.next
(which will be useful for me as I need 14,18-20 for my neon work).

thanks
-- PMM

