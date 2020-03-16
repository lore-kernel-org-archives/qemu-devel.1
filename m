Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455F0C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:17:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD6D220663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XX7HJayG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6D220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDsQM-00073n-4e
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jDpIp-0007U6-8H
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:57:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jDpIo-0004zs-9i
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:57:07 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37675)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jDpIo-0004qH-2b
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:57:06 -0400
Received: by mail-ot1-x343.google.com with SMTP id i12so12412359otp.4
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 05:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QRV/ChvtGjZft6K3OHjZBBimz6AQdGw7nbmGSsNMAOw=;
 b=XX7HJayGmsCndQ4lLxUWj4I6PAN6YzLfQSkxsPZ/MMj1lYrfvE+8lC+3u3odVysy9B
 L/jOHTCvd81dkTmgaZZLvkF27sGFIzy39xfIU14Ady8TSKMEERWWrC8iStBnElDP8mIa
 11k+AZIpbD36rwYFcTNq2Hi+PUIeZ5LK9lk6EL2vX0IB/rKBObpfzcN+Nk44Yyv9kKim
 GvIpLO9cBnwYpFm58ggG8a+R3iTFeNinHjt8ysH5ZnTHL9P2KYoyM4ur80wMzfkEuFJ0
 RGjCQ6636rzvaomnK3H2kbZU4lm+LpARlWqQh3GkHe1y48pN03evSW8cF4sVN6epIKAu
 lsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QRV/ChvtGjZft6K3OHjZBBimz6AQdGw7nbmGSsNMAOw=;
 b=b+cENw/pmcJli/EeP6nAz+7XPTNF2OLhbZjLwrmnr7RCdbyVllL8Y/18174d9a/ek+
 7SGHpa5NwkYxFwVwErNYnuhBf7gUiaS9fWUB1Zg1xczjtLYZnHNm7cKZLRI9zm6lfG0J
 qKEYHySdDqiMtKWp05pwan9854XfvfovD+rYYXqbx+YDf2lEL5FMPSEgId2dcJjd70Pe
 cX0SJGQWsWj2KMhAvSZa2i0o2mFEzOzuDnMla+EBgbMfwrnoL/64Aj254mdJCXDtWpaC
 9MMDHd28IJCc2yf5EwIJqP89/n2dvrSCs5zlF0HR1IJRQniEx12PxieZYhT25RlBW0KL
 O2LA==
X-Gm-Message-State: ANhLgQ1QGmQfOwZeREnzqaD5KJKjEuAs0i3c8YX6nZX9DR/AaFFu6ZVk
 BSSVhZ7d6izlg4txmDjszntgIiEsklIAU5+yEQzeOA==
X-Google-Smtp-Source: ADFU+vs5ekls+Fwi0z+zQAPsi3P7Yyf2yd0Ry39LcrarYv7N0h196zjVNomgO3ruCpfpWFtWmMuRu7Pg2nzZWfe/b4A=
X-Received: by 2002:a9d:76c9:: with SMTP id p9mr22462494otl.135.1584363425054; 
 Mon, 16 Mar 2020 05:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200316114050.3167-1-jiangyifei@huawei.com>
In-Reply-To: <20200316114050.3167-1-jiangyifei@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Mar 2020 12:56:53 +0000
Message-ID: <CAFEAcA-+hmJALSwuf4NW=KTmpSXJQ4pv5TagDNjc1VXzv8OeBg@mail.gmail.com>
Subject: Re: [PATCH 0/2] avoid integer overflow
To: Yifei Jiang <jiangyifei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, limingwang@huawei.com,
 victor.zhangxiaofeng@huawei.com, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, dengkai1@huawei.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 16 Mar 2020 at 12:25, Yifei Jiang <jiangyifei@huawei.com> wrote:
>
> the constant default type is "int", when the constant is shifted to the left,
> it may exceed 32 bits, resulting in integer overflowing. So constant type need
> change to "long"

"long" would not in general be the right type to use in cases where
 we do need to make this change, because "long" also can
be only 32 bits wide on some hosts.

thanks
-- PMM

