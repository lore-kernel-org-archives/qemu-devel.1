Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECD1CA9EC3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 10:10:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A58C32086D
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 10:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Owybeb0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A58C32086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQ7Po-0008TN-MT
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 06:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38734)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iQ7Mf-000873-79
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 06:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iQ7Mc-0005z4-Qw
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 06:07:35 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:37736)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iQ7Mc-0005xU-LS
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 06:07:34 -0400
Received: by mail-oi1-x22e.google.com with SMTP id y194so4668403oie.4
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 03:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JRnFEKNufL62fXTNoBKl1G/F3Ae0unmaHxu1Pmz74a8=;
 b=Owybeb0ueVaQHqnRvdmoqUZFPrK1dbmbSuR0ON2qPUNB0a+tYWnrUC2vk5w/et2WJo
 17G4MPSC9hCzQZycUmmN7tEbXY3ZIs1EZfFSgqNv2uR8KLPLLEaDHePDEborugMML6u3
 qXIRaQ5pn5d9FHnE+NUWVS9Xn3Fl/Y4dCOJoNnVHiMt3YvIcqdqdHCEnoPGNRtIDSz+A
 lotDb63welZ1RNwyUvrJ2Ch+RPwMW+AQSpfzbJFiYr9bOkVntRmYCZyVMLOt47D7HcHa
 uIMwhW32f7x35ReotZ6vnDHBVunGfI8d189wgnIPa7FQdCrkVJBJwx5cFICEVYaOH25b
 /+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JRnFEKNufL62fXTNoBKl1G/F3Ae0unmaHxu1Pmz74a8=;
 b=ZVgW64ucV+XkWhMRuzzzmMeiSTBJwupp4gumK8O7cO074c5JmN/EkWENpZ7LuhxZoM
 eTnTfQh2r2ZK/1QmiEDknA0Gx34qqIopkygdX5SPWdorYeIjWzRBK1xY3pAtoQTM5QHe
 G8hmq8H0KpuxArylqQDt/YmXLhC4I3x7A0Fsfz8f31utlyrPC9/cfoSeWIvcMT00QTWo
 JNVyAG3tQzFhOjcnBjqWDJKLjc2TInmCiWyaaKMi8Z5YdIQbS4fYps9D9qzZO/JUnmXg
 j610qA1OfHQ62jQpRfz74qQiW/sH4Y+KXIdpvH+6fdhCso2yenViwMFv4awh4/L5cfIh
 NM0g==
X-Gm-Message-State: APjAAAUcuWfjmbyPr6Lh+QhDrNuykFvuKqlHxbjM72asjun10E6Xsszq
 uE+UFtsVkCOiHpXtu+s12ksowp+29XYigma51AWrqA==
X-Google-Smtp-Source: APXvYqzL8uJG8o+6UU3wUGsqCU822041+tD4wvva3HndO/FROdUZhY3ujg+vujpbfUA/LYnTzL87N/PsxQ5fmYJMBuM=
X-Received: by 2002:aca:451:: with SMTP id 78mr61968oie.170.1572516453478;
 Thu, 31 Oct 2019 03:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191030180953.24180-1-richard.henderson@linaro.org>
In-Reply-To: <20191030180953.24180-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Oct 2019 10:07:20 +0000
Message-ID: <CAFEAcA-qodQY=dHkwQtuVj0oKv1A6PzwMK_qBaMLyJdBtvCFVA@mail.gmail.com>
Subject: Re: [PULL for-4.2 0/1] softfp patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
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

On Wed, 30 Oct 2019 at 18:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Just one easy patch that made the cutoff.
>
>
> r~
>
>
> The following changes since commit 16884391c750d0c5e863f55ad7aaaa146fc5181e:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2019-10-29' into staging (2019-10-29 20:06:08 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-sfp-20191030
>
> for you to fetch changes up to 21381dcf0ca8fc822328e30570c8465ec4e52be9:
>
>   softfp: Added hardfloat conversion from float32 to float64 (2019-10-30 19:03:37 +0100)
>
> ----------------------------------------------------------------
> Use hardfloat for float32_to_float64
>
> ----------------------------------------------------------------
> Matus Kysel (1):
>       softfp: Added hardfloat conversion from float32 to float64
>
>  fpu/softfloat.c | 19 ++++++++++++++++++-


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

