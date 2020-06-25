Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EEBC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:46:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1385920706
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XEeBBj7Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1385920706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joPPF-0000VY-5O
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 06:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joPOR-0008PI-Vm
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:46:08 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46611)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joPOQ-0006bp-34
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:46:07 -0400
Received: by mail-ot1-x343.google.com with SMTP id n24so2556473otr.13
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 03:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+Mx21h3y+Q75lM29HgRdR7KtzfXMxQn8kCmJI0yVOGY=;
 b=XEeBBj7QU+2ZevEeZYp7+lBSIwViX4f+XJGKXmphsyvyNrDq1UngL+/g8qbbTZix75
 I1UgEcTvcbeKqnmCvgzMbSpceEubY8NqxznZNheyi54CWmhBLzwrSXZFryzIumdKO7Fv
 38m0HwknUOeFufXGEMl+dVhmYI1Wd0qJ1nvp6o5r1hNTMgVkvhw6tBmZdnr6qnjgGxQ2
 UZ11Jk/buXcrABjgZpKDHSHYXYUPhy66Jvkw2T5SrKzQ28W2c8BFRZnC4hszOkMIeLhm
 uRKGGzDIX08Q/qCYCd7yvBF1UczlpUyfIT82uT9L42t3sFYF7IGUaHwh+t/bu5MUOs0U
 e7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+Mx21h3y+Q75lM29HgRdR7KtzfXMxQn8kCmJI0yVOGY=;
 b=jaHHeIWoIJYYMhUWHggyD1HUOMV7zro0rq/vQWOOnvsGrTiwO5+WCaGh1KaWe9g88r
 wIlFJ8BMwlllPir9ar/n6ulyYxjAn4CNe4lCilI0mELftg5xWh/UWvzBLxqkCwKXLLu6
 M8S4V5+cCbZjVBYE5sNf+IeL7YOnIE6APHdXSYLIIh2Rd8f22VkWHvda0iYBezXOTPXr
 K346eP9xwq5y2Rx03FeNXs+2yBalafTvDZ8/1l0sL7NeGWJO0S1s8rh5pWIfmkJSBVM3
 /ohNh5VEx53lAqnZCbCO6BlOMOxVjOUKEcNp1kuJPD6pfcMjbjK8W8WTy08a3jHBNNx0
 Mx0A==
X-Gm-Message-State: AOAM531WayVoD1C/O6MEDcGfDphRdsAUx5HeJpLoC66jdqxTfoxEMzpK
 GrjzZ0w0paMXeclVXxcwbY4SKXuchzd/Ad0aqU/TIg==
X-Google-Smtp-Source: ABdhPJyS/TiVRBUcyOq5J1u39jTCeZDGc9bnRYMhT/8CAYztDdP6PZb5oXgF8MZdKPW1rCAqte8gxtdvqeKlHIRZI8g=
X-Received: by 2002:a9d:5786:: with SMTP id q6mr12336731oth.135.1593081961502; 
 Thu, 25 Jun 2020 03:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200623193658.623279-1-richard.henderson@linaro.org>
 <20200623193658.623279-15-richard.henderson@linaro.org>
In-Reply-To: <20200623193658.623279-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 11:45:50 +0100
Message-ID: <CAFEAcA-JDMyGiiypfz8uDqT7yf9Fv2AhLbMNELXz3Vm9vMJxXg@mail.gmail.com>
Subject: Re: [PATCH v8 14/45] target/arm: Define arm_cpu_do_unaligned_access
 for user-only
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
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
> Use the same code as system mode, so that we generate the same
> exception + syndrome for the unaligned access.
>
> For the moment, if MTE is enabled so that this path is reachable,
> this would generate a SIGSEGV in the user-only cpu_loop.  Decoding
> the syndrome to produce the proper SIGBUS will be done later.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v8: Raise the normal data exception + syndrome.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

