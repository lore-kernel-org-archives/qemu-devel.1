Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A60CC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:40:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 622312173E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EgEV8cy0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622312173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i18rp-0001LH-6Z
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 08:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57972)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i18bH-0002MQ-CB
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:23:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i18bG-0004WJ-6l
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:23:27 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45205)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i18bG-0004Vo-0z
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:23:26 -0400
Received: by mail-ot1-x344.google.com with SMTP id m24so8532511otp.12
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 05:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kOykgX4jukzcLHOtQbzxdIt0wUVBkJ0RXtssb8+ftHM=;
 b=EgEV8cy0/QGrCDwvZ4BKMo+OxUU8zGio8eowE/1+h0RPq/FFCu2y0wH7G/7Kz6cOD0
 dN1mcWGgWX/xVmA0grNk5Je9JVkDqcAWSSCXlPv3Ud3thiXl6fY0Rv3a0J9KvEvgz1qU
 gVsCnulRNsm9YxTf4MmdPSXuu0abDJZeciqA6/LwSCkqeUEarl5KPXtqYoinV1/gEghr
 j/eYEaW2jzztf5bKTZ0jP33HC5lmt7oHnkYFouA3rFFdpK564tXaAh279HiXpOpA0Yjk
 8vtiOwabUqIItY9QT3FlYFC5fMZ0EfeDVRzzdO3pfpH43Ge3Vmj51VufMY751Lm6l7zL
 IpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kOykgX4jukzcLHOtQbzxdIt0wUVBkJ0RXtssb8+ftHM=;
 b=WN2bWE63XDJPX6mo2URR4u5UHWgZjuQq3L1FkA1l6vL3MLISkcUEsWNLGhsJJzATVS
 skUN65wQLlcUoH7f4o5V9jzi9aC3IcdnGJ1FCDKKojTfrv79F6LarRGZHamePPFJFFHq
 //dTMwN8oBQgSnRGKqm/Q4nyjs4bxVHbrrj7lQ6ysEAnHPsB8+XZCvvuEK6hSoWJsiPW
 W+5HgMeiNCl86fy4HM2juZkEzDwDGPSCXRiczShx+asInepkEBxp2VJEZhRULaAJwTsS
 xSUtpxRuRNZvY++zy+zALRzzFlubfcgau4H3MLx3X4eldZiPwaGBoJueza+qjdqdlek1
 a0EA==
X-Gm-Message-State: APjAAAWWNqgC6/l7ZhjsWQUBXQuszxBwVb0fpKYOcgTeYhfWlIRhUGYn
 RQV04UZDqV1asi3nle8Ry+ph/bt+Xd/vNng+rlrVzA==
X-Google-Smtp-Source: APXvYqxK6uBvCyaVDssLLQ4DKErt4lXCKTRUzuu9joey8OcFY2MhTbQ7hmVqz0NDow7+msxtbviBvtRu/LUUTIX67YQ=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr4048393oti.91.1566563005259; 
 Fri, 23 Aug 2019 05:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-14-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Aug 2019 13:23:14 +0100
Message-ID: <CAFEAcA92qXihhbmaP5oHTCNV8LtmZUuxA9m8iPGVUY-JidBaUQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v2 13/68] target/arm: Convert MRS/MSR
 (banked, register)
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
> The m-profile and a-profile, decodings overlap.  Only return false
> for the case of wrong profile; handle UNDEFINED for permission failure
> directly.  This ensures that we don't accidentally pass an insn that
> applies to the wrong profile.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

