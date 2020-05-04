Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9F9C47247
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:40:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB5EF206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mp65KvBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5EF206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVXal-0005z3-UC
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 05:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVXa6-00058K-2a
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:40:10 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39214)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVXa5-0006bC-2g
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:40:09 -0400
Received: by mail-ot1-x342.google.com with SMTP id m13so8346884otf.6
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 02:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nlMeQyCuToriEPua2lTUEAFV+wuloF2MhCmzZ8nrNJI=;
 b=Mp65KvBLhn+0vEEjlM3pfpf7HiTbLMZYNuYRiNv2BedPiiYnjuuAWD0nkk/p7TQY7D
 +Y+HZAK4kab+z2KaOKa2I1gZxRZZEo0MYr1CllDHQ9tDMJrKZh90sNwVKhtelQr2Pt/p
 de2/fM4z2dOg7MQq1KUuGKbMP8KLA8zsIMXrYHFo67y8rqq/2inwjtUIuCMvvCQYo8Yj
 VRNM3Ec1zei19JNNYy4k3BUEuJeQtYJIbVOMUbBV9jmyu1rq+MXySfvfG+KN5nGtfQiK
 7EDbK1XzRWeAVtqPe9bMvJ1huCn+KpxODriBbAbI4tIf1t3H9IVha+kkPrTo13gjSTh0
 0W+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nlMeQyCuToriEPua2lTUEAFV+wuloF2MhCmzZ8nrNJI=;
 b=qrCdZJQY6X2PVDw60/2LKCqrrrFo3sj2n8ldnJO1Jrt9NizR/tXBjpm+GU7JVBNIi0
 aEJgMbrMhpEF8Bte7DqVI79CVNbBSAPKzQyevQeYFdXN8LHKQNNeL3W9pfz26mQ9TwYD
 kP41ScEWx5FWRN8aMfvgiHpPaEKweWbWSMnbviLjRZXdi9g+wZNZurOHJi7jPpF4p49J
 R+FgmiTAjNYNAVuCAgNItVYXko7PwPq7gcijtk4VOJ9La/waNgAnM9FLG6R1gaSW0ken
 JaoebPWiQcJXyoYW3K7KaiPEVc31OmYPSutwKJ9hu49D+j7K+Ek0hIru8I/JffYRXHzE
 GmEQ==
X-Gm-Message-State: AGi0PuYQGslb89mBAott2iinn9f3bhKi0HFgO1I8kq1WIQNcltttvLRQ
 wzoxkTA3EMqHyYLDQHSoDyj4zZUbf/Puc+mPGw1zzQ==
X-Google-Smtp-Source: APiQypLJOpk0TYsZLGmIhiB2LFsFMbFlsRbV7c2DeFWSTE8IJfuiRYoEt/ftbC0hAnO/JaDAzXHeiK8cH357CQOwYqg=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr13330956otj.91.1588585207566; 
 Mon, 04 May 2020 02:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200422043309.18430-1-richard.henderson@linaro.org>
 <20200422043309.18430-5-richard.henderson@linaro.org>
 <CAFEAcA_ugvJWmN8fNbvZYJvOtyv6uPAumQ8UPtK-k9nqN=uerQ@mail.gmail.com>
 <69d6cc05-2610-d81b-df8f-0f8d723530af@linaro.org>
In-Reply-To: <69d6cc05-2610-d81b-df8f-0f8d723530af@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 May 2020 10:39:56 +0100
Message-ID: <CAFEAcA-4VxCuCV4tYvgKFtOA5nnnhNH+2BWribpPPR86=KL32A@mail.gmail.com>
Subject: Re: [PATCH v3 04/18] accel/tcg: Add probe_access_flags
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Apr 2020 at 17:00, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/27/20 3:48 AM, Peter Maydell wrote:
> > The old code passed size into cc->tlb_fill; the new version does not.
> > The old code passed size into page_check_range(); the new version does not.
>
> This is the user-only version, and size is not used for tlb_fill.  It is only
> trivially used in page_change_range; we have just verified that addr+size does
> not cross a page boundary.

Yes, but:
 * they're APIs which take sizes
 * we have the size in hand so it's not difficult to pass it
 * in future maybe those functions will change to make more use
   of the size value, since they're being passed it
 * this change ought to be a refactoring that does the same thing
   the old code does

What's the reason for deliberately *not* passing the size and instead
using a constant 1 ?

thanks
-- PMM

