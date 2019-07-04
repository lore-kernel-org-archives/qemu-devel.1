Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0877EC0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 14:59:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBECB218A6
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 14:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ksHMS8aa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBECB218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj3D2-000371-Jf
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 10:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34391)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hj3C5-0002Se-IF
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 10:58:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hj3C4-0006pr-HP
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 10:58:41 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35528)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hj3C0-0006nc-Lr
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 10:58:37 -0400
Received: by mail-ot1-x343.google.com with SMTP id j19so6254354otq.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 07:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pnSN6bT8WDYmz1MF231b9e9dZ4pet2hgT+VssadvTL4=;
 b=ksHMS8aaV0dYHZWAGuz2gL3bhDPHZoNvmFWR7+v5s3boz38yLk+CZeK2BoVQkg1IlO
 FDCaxt3pQYn2wBCQ6Ohd4NDQ3IrOtTSzlz/1Uy4OSsuSuGTseLqz5joTezjhEHoL51QA
 PTk7V1YmGsfQ4/Rci3di4TmcZLHmyxppmRD+SOMlG0Yh3iuCwKnnaH9Wl5XDTMVHM+c1
 B+I44PzFsRpsc6MZ2Y0kRvfhF+xCoULu4FRXypyHQSPW3Yzjv+oY6zIRatmx6pzYPsHo
 fXg+Kn8YgSOW/ES3MfNNjBTMN8FdJ/PhW1i1tGlSf6T1lGC1bmdkq3AQ8E/MHaozqRuy
 b6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pnSN6bT8WDYmz1MF231b9e9dZ4pet2hgT+VssadvTL4=;
 b=txHnZKdniyKNTA4YZRqUH3qA+luFWP8Jr0qcvckQH711H3SrNXf6ALDZR6On07JbzA
 embA+QuCK8Ak9xrO133dmJX76l8PfC4g3K6lhifTCulzH1CPCVjhZEKR8Lh1WleXOKzV
 nbdnqgEoV6inSTKBpH8CgzSGlUOChigbT7pjKXY5kBfXTbL7V6Aj6a3HRfQx4EeRM62Z
 PkYZOCUKh9tEB2rBFyN5EIj65xhgR/KSMXZRstpbUc4xQAxmbQB1e2IhlwqaHQh8XA1O
 oKusr8Qoj/Y9+3zMVbI2Ws9BwE2qduSqZxQaidviufNDBNMIXGjU6Yyfur6DX6lpKjm+
 pl1Q==
X-Gm-Message-State: APjAAAUxQvono5Y7eoCA9Zp7aU6uaPhzkIjA/wc1PBTE9RzFoyphjZJw
 XpaYrDsasbSYphdXOK9A78v2/fKU3YMqGd0iMnP17g==
X-Google-Smtp-Source: APXvYqx01l8a5KH/mJscELtAs4TjPpyPMyPoKFR5Cme8a2YnieIxW06VtHQ6R2HVHj7qSfqvJYc6oAskHVqKtvQ/v6I=
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr11790026otk.221.1562252314669; 
 Thu, 04 Jul 2019 07:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190702102505.32044-1-alex.bennee@linaro.org>
 <CAFEAcA8k9QJA9iE-kwiaPhr0fY_2zG7JRX5uV4AaSSjXCSs4+A@mail.gmail.com>
In-Reply-To: <CAFEAcA8k9QJA9iE-kwiaPhr0fY_2zG7JRX5uV4AaSSjXCSs4+A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jul 2019 15:58:23 +0100
Message-ID: <CAFEAcA--ThxYkzPervj228ejYjj68+_08ke_VS-mFmEQ4JO8Wg@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PULL v2 00/20] testing/next for 4.1
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

On Wed, 3 Jul 2019 at 00:02, Peter Maydell <peter.maydell@linaro.org> wrote:
> NetBSD vm run seemed to get stuck.

I tired a rerun, but it got stuck again on the
"pkgin -y install git-base pkgconf xz python37 bash gmake gsed flex
bison gnutls jpeg png SDL2 gtk3+ libxkbcommon" step.

thanks
-- PMM

