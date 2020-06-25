Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCFFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:30:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 458AE20675
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p/lyoEpP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458AE20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joUlj-0003QS-H6
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 12:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joUkt-0002Xx-3H
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:29:39 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36328)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joUkr-0002SN-Id
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:29:38 -0400
Received: by mail-ot1-x342.google.com with SMTP id 72so5837099otc.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 09:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ddiux/sYQjnweRf6rcjF7Ygr1+nd2QQjo9m7w/+qT68=;
 b=p/lyoEpPTaiI1U47P1P1QLjWIRtOJANV1Z2K76EeuedCRb2ZtfY24lxikMes2T0GSy
 2ui2ThTsvhBGFeBt1F/rbKzCq7zDy741+trUG5OmMX4eE1FZTpbb6lXAY1WiuCfuxsHT
 zt2GFEZEfqulOYMLjw/R2F3xo1YIhkohXgevtw6xOueVSOvf+hbRI1dOKaqFfNzEEJRC
 Sv6dfMN4DWt6NgUl7I8suVx8O4OLcvJMc9b9O8hJBIuS2iAHDKSBuph6f2C7yZm4nASg
 ii8k28U3oCA8zDuvxfRYBtLJjTZ/iGso1l5WZyFrBPcAXGnoOyx2MsYhGlF4j/2eLLu9
 181g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ddiux/sYQjnweRf6rcjF7Ygr1+nd2QQjo9m7w/+qT68=;
 b=hEuNRRPhEHJAqyE/q1UssjEqAdMMmPosi9r2FIsONOcPM0zyLksv48MQa0MaRueeqy
 9MqgVgZtFsYIWJZLFJc1VK/G293sabMOhohMOxFMuN8rVVAOaQzGuPJigopZELFHLt9A
 qU9THcv5ssK/oZOMXhCO0ysNDnyR+AqB/54GBswZC/q8g26K6+T1YqBbYQ0ImHpbbf5D
 yWCZbg/D3p9eqyKwMPqvdgehhKWvJA6wCxamjZ/3P9X0YUf4VLt26y5UyneLk8IGktpy
 WfGwqEY7ptJZHoqcLjkIjedkZbk1QAKH1RbyI8mmc6jJ5jjNnIFQgx4xpF6D9KrIgvK7
 GTWQ==
X-Gm-Message-State: AOAM532GEsHrDESjjrq+rGVvOWVfhptuNmPR49SHJqimM1AJ8EPwT6f/
 Vxc8kveyU16fy0z88oF83nCCQ/HFbbAX0SwzxbkV/Q==
X-Google-Smtp-Source: ABdhPJwqUHXliLrl9n7ke3HRaiTVy8ug62p5/yOBQIDQN53ioN8Vjj7lofbfboKpuwYI0NUUH6JNRu6X+8TCemhmoGI=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr26297591otn.221.1593102576241; 
 Thu, 25 Jun 2020 09:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200605041733.415188-1-richard.henderson@linaro.org>
 <20200605041733.415188-5-richard.henderson@linaro.org>
In-Reply-To: <20200605041733.415188-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 17:29:25 +0100
Message-ID: <CAFEAcA9pYuqY5xB+z=3RxQmGRf0C7-bubsJiec5OprJ4goa6ZQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/17] linux-user: Tidy VERIFY_READ/VERIFY_WRITE
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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

On Fri, 5 Jun 2020 at 05:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These constants are only ever used with access_ok, and friends.
> Rather than translating them to PAGE_* bits, let them equal
> the PAGE_* bits to begin.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Side note: at some point we would ideally want to support
syscalls that checked for write-access-only (ie some of
our VERIFY_WRITE uses should really be VERIFY_READ_WRITE
and some should be a true VERIFY_WRITE):
https://bugs.launchpad.net/qemu/+bug/1779955

thanks
-- PMM

