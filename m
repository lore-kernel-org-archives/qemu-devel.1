Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E6AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:08:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7E61233FD
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dDSQXwVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E61233FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1D2j-0000KF-RU
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 13:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i1D0n-0007Xc-Dz
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:06:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i1D0m-0001Js-EC
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:06:05 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34241)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i1D0m-0001Ij-6i
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:06:04 -0400
Received: by mail-oi1-x244.google.com with SMTP id g128so7565296oib.1
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 10:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WbFBLukMqRE4t7Rzf5sEVXgO7jsZfBnO2NXnaYZpscs=;
 b=dDSQXwVhJ0tjzt+pYi+oVZvQkpLDD+yMgsFCbXIgkVzgTid19fGlYqXCqh0KDh59Br
 tLaz0JG3CWPmCsN2SXJTJP6/NW9eXBVbp9dmMUDSSYqJSKmTXNDOBx02UBIEFkYiN4VS
 aU7hTMlcgiz2ALDvQUzhStHaCK3Pra8zkj2qPQJzchm6nm1QT4zkeEC+jHeeig0+hn+l
 3TiBk5lx+wlhRKQRwqbJF/HF0nd6WUO0IHB5e4zB/KQtX5v+eUaCEGXWGfr8Fjm57yOn
 1g+1ss6kCknD8kXiLH+GvKWAzkD1yTPwAoNgw9qH5EKo4ImyyhQ5YQn3oVzR2hrQ7H2i
 u3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WbFBLukMqRE4t7Rzf5sEVXgO7jsZfBnO2NXnaYZpscs=;
 b=YL2RsFdtjHP28wSjU5nwK2HObTilsluz2D7uqwuA4q4weuK9nGBQzjKDP4MggAxB7+
 xdngi4bdRWIiayUh5CNhXbieXPqlLbL9L5bp54ghDvjzP8aBo+ihT3ijzg7/YCfseR7a
 MFp6L1V01FEHAYlSKw16jVwm/WE1JznvILRlZMBGJs4YsZqogGMnhxi4NVaMrPM4QYRa
 DchISx+BSt0PcL3v2bEeTx9Q08Qcm4HhpuKeiWFojXpvtuN2B35G9ux9m95Xd6l+kGzF
 NC4ch2gbFvgKO9U/wJ0V1tiwInmiQNHkrN9iCB1QuFInrsuAd28pd5cJamwfhUySPJjb
 JfYg==
X-Gm-Message-State: APjAAAWsIRQEW9BRlRHEGKODKfa3YDjFyTRCmoTxamBGA+pbXMODXgjE
 FEHqUWVsWQ5I0yHfu9OcbUieJMaZftLARcsh6rlkyA==
X-Google-Smtp-Source: APXvYqx52MJtSdXrKr+hCfgKTzEDWgjh/93+QoX6StnuNS8OUA/QnT3WO4Xd+EdeSLi1U7PZ8pyuADLdbdZvQJpAGkw=
X-Received: by 2002:aca:4b86:: with SMTP id y128mr3885248oia.163.1566579963201; 
 Fri, 23 Aug 2019 10:06:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-27-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-27-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Aug 2019 18:05:52 +0100
Message-ID: <CAFEAcA8pE3oXnowMLcdOP6hPy9tKV-fkZffWsMWgcmg8bJc87Q@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v2 26/68] target/arm: Convert MOVW, MOVT
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

On Mon, 19 Aug 2019 at 22:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 89 ++++++++++++++++--------------------------
>  target/arm/a32.decode  |  6 +++
>  target/arm/t32.decode  |  9 +++++
>  3 files changed, 48 insertions(+), 56 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

