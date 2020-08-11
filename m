Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C61C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:21:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32F8B2078E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="btyUMSA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F8B2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5W61-0003bH-Ev
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 11:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5W4n-0002kr-Fq
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 11:20:34 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35]:34542)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5W4k-00014H-Pn
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 11:20:33 -0400
Received: by mail-oo1-xc35.google.com with SMTP id k63so2697719oob.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 08:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LhipV3OzC4dEosq3d9R+7AnvHo5SEdfg+6Oq491p3V0=;
 b=btyUMSA4AHwbdZwkGNPMsC8fAjCvkewYTlWhzo8oxtafc1WoP9CfJAnExyJxCgy/it
 6o2jWo8/3HNhBhStBjf5qyaIeqYXya/rZFlqvfv3+QLsg5cxz9qaWyFKWuC68IW4k7MY
 1S6huH/WsujB79iginX8rsANriQ5DVRLJdBdSnp4ojYK1irl1+9tDkv12t0bPFiqWuAp
 GM11cEBboQbXN8RoJ3j88EC6z9BG39Cv6TrO8Se7+6ozQRWBUZ+/Eh4rZFnNQi1P49qe
 tjgq8xeymniMEcv7kITbh8KeVOQOmolg60ynVx038u3/zkrBWzjLEBxjiaNeUyN7UY53
 AjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LhipV3OzC4dEosq3d9R+7AnvHo5SEdfg+6Oq491p3V0=;
 b=KHnt5gSXwTpTAQh7vINTrsUhcVdENgA3DJ4alYuaQDPIXsWrhckoMo6kJreVfveCir
 IRhNlpczyfn5ZMEhz0vCA3bcKV65xrZuy1KCcMD7smpGlNBXlTN1fgto1QGHGJiqTa9Q
 R2XsfXWIhtsChQtZYIkYllUywZNdy/a3JcHKGNwNKHI56G8GVGdYkgXTz+YSVw4wVNKc
 xyNOpaUP2EW16ajND0Qf+GFtMdT80T8zWBKgKOzNpqksnaaY3nlazmYHzttikAjYNNIm
 U8YAShs3X2YlUi7eJjB3nnUXogM5+hLF/U+F3GN4B822wdPHipMSt/YOINbOSxAzRHx8
 m8fA==
X-Gm-Message-State: AOAM530EyuAVqoOuGA2v4Hg/A+sXsv/fK1xLOekrmCHcwfjZ6UuVBfI2
 VqqRJMb2je46u/GAOJgPwikKLyTiJairb1BuOASjiw==
X-Google-Smtp-Source: ABdhPJzUMN/qkwG2AjzE8CmjWoI8Q6D5C5qV5XGQhHjCDngebPfaCOwfVkqLL8BVZoSeH5HtTmEnxte88d3icLW9snc=
X-Received: by 2002:a4a:8dc1:: with SMTP id a1mr5676910ool.69.1597159229386;
 Tue, 11 Aug 2020 08:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200811151643.21293-1-philmd@redhat.com>
In-Reply-To: <20200811151643.21293-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Aug 2020 16:20:18 +0100
Message-ID: <CAFEAcA-Rnu4mL6uv7uek41g88eyRRw3qekKXNoMu9nXeO54DLA@mail.gmail.com>
Subject: Re: [PATCH-for-5.2 0/3] trivial: Remove 'and and' in descriptions
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc35.google.com
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
Cc: Corey Minyard <cminyard@mvista.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 11 Aug 2020 at 16:18, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Remove duplicated 'and' in comments.
>
> Philippe Mathieu-Daud=C3=A9 (3):
>   hw/i2c: Fix typo in description
>   util/qemu-timer: Fix typo in description
>   util/vfio-helpers: Fix typo in description

Series:

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

