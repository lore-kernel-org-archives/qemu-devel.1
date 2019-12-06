Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02ABFC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 19:27:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1956206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 19:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jVlF64Fg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1956206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idJGP-0004u3-Tr
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 14:27:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idJ5C-0004Hx-2O
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:16:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idJ5A-0007FL-UI
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:16:05 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36302)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idJ5A-0007Cc-Nj
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:16:04 -0500
Received: by mail-ot1-x342.google.com with SMTP id i4so6765018otr.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 11:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cW+nm4Xhk3Bi28rCVdfeb6XTtdYXaDHT7P/bjJNIZHU=;
 b=jVlF64Fg/Le+3zzXOKFgb1kA63dN7uBfZrLCnksZuwA3EVA4QSSZn9av+AkjLmB8j3
 Gk7iepohBrExX3xktfCyMgA0N5afDSOAOYrNZmXd7fuRwk+7rke8FQ2wYC/z4WLuRN6n
 ToCe8Su5qudXaeyHg3lACxl77MfiWX1IcCcUW7DuTahBypGd/Sa1N0hCTtV8PyEhMkfj
 3H/mNsG0visS4yfDQ/oM8S/E5I5tH6xZbYsCfvCa/arbJxD1BiIuJLoL2JKa2v/DUg52
 b20SNjUsjrKh7p/1DduL6CGLJK8I5HZnrYClxGnF1mtj+ohrqh0YX2JsLHujnpACNov6
 poTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cW+nm4Xhk3Bi28rCVdfeb6XTtdYXaDHT7P/bjJNIZHU=;
 b=gonEoYyYgjbJgGuV/kSXUZd6Ou2V1OVTTyC0makTYRLTwrnYeEzxn6HgsONYiUgxmV
 3wHSqF/N+lEi2WyQ2w8zyrE34EhvmTSMghFf4dn+pMJ3ZmvOzmh7jrnLO+FbYQRyEBi+
 dHvCgjo7B84Z2Ihb6bwEDGq/tpBQyrwzXsqrXPs58475CvWQmanwW31nOGqAOOBKxu50
 iqo4JKI3jUzFiBGHuazX1TSxhVRZDqY+vIhI1GjVhyA93bTb036/AHFWmmZtwcH2ZFn9
 TzvFnPeK4egeH0wkoq8w3rS8gLJ63DW6bLJtPIg+IPpww47SauQrpwZ7OrwUIyuqeFIH
 T+fw==
X-Gm-Message-State: APjAAAU0th4cS0n4p2zz15YzGxdZZ9y54whLChfndmu6clxulqiYGtpq
 tRnzv+U/n00pdSxi0yWSVyfCxPt1cf6nCjZsBY8Ucw==
X-Google-Smtp-Source: APXvYqxlYdv8S6R9R6jesSV9DEjLtVSfuekvGOEPULS1IGMyZuDamsebDt2hNSRGVJNOQohB1m8Y0k3l3L5AlFzXaIc=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr6477254otd.91.1575659763946; 
 Fri, 06 Dec 2019 11:16:03 -0800 (PST)
MIME-Version: 1.0
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-36-richard.henderson@linaro.org>
 <CAFEAcA_DmXG2QJsLCu_gYSCYVCQ4xr1hPkEbfpVXMTZe_wnb6Q@mail.gmail.com>
 <b48552b0-33d0-405f-85ad-59b46e1702d0@linaro.org>
In-Reply-To: <b48552b0-33d0-405f-85ad-59b46e1702d0@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 19:15:52 +0000
Message-ID: <CAFEAcA9HWVJqnH-sP7ym3WRPN7RegZnga7hk=rmhUavEYhkfmw@mail.gmail.com>
Subject: Re: [PATCH v4 35/40] target/arm: Update arm_cpu_do_interrupt_aarch64
 for VHE
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Dec 2019 at 18:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 12/6/19 8:03 AM, Peter Maydell wrote:
> > So I *think* what the code is doing is:
> >
> >  When VHE is enabled, the exception level below EL2 is
> >  not EL1, but EL0, and so to identify the entry vector
> >  offset for exceptions targeting EL2 we need to look
> >  at the width of EL0, not of EL1.
> >
> > Is that right?
>
> Correct.  Much better wording, thanks.  Will update.

In that case
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

