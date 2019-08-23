Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13986C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 14:57:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D233022CE3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 14:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZQxlTS3a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D233022CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1B0j-00013K-Tc
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 10:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53334)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i1Aqc-0006h2-0k
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:47:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i1Aqa-0004R4-V0
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:47:25 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39543)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i1Aqa-0004QE-Mn
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:47:24 -0400
Received: by mail-ot1-x341.google.com with SMTP id b1so8981705otp.6
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 07:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RwV0aNMRcjdNVhgHO2URJ0Fn0gRb2Mvt2rirl+7u9G4=;
 b=ZQxlTS3aBS6FklFVFj9c8RM5oCVv3QaCy+zLECKcJXnyoGqK8bYRc3QSui6S0kAf6n
 9z8QvOUS/kJtYxovNdS+ZuCssLoZKbazn+cmg2FzjX7qiGBJrLf8OKbT1/+ZQNkKBldJ
 eZ/u1K1lh7Yk/Sxoig7fju5fwYpmKbSoJ94s9gtvh6vQ14YEjDBx+MUIEZXFzUgWfktN
 7RIWC/DyQwexN5o8FYdf6pvbHrS4SXr5MCLORFWOr/4cFA/GEW9C3JoVlmupqTzftT2u
 uxOIyxupUJPCO9VDmoswk9xBm+VpB/Y3qsgVfzL/5+bfD4wUk+Dp+UWjURLev/xoCK3n
 NgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RwV0aNMRcjdNVhgHO2URJ0Fn0gRb2Mvt2rirl+7u9G4=;
 b=FVWmWfkv6ltGY2H/RKzU458tgvQ6P3Y/9oiNkPrwldNTEzmGaUeMI24st9FIqYZNM2
 Hi3cLz//+1/kY8OiZg2naMNzWFR/ohMNZ7JwoQ0ZfmhEyG380CEXE0t8czMWDR6uUARe
 T3DUsyglcYApcnl5NQ9pCupzWR7fHEl5huFHFWXQkrTXihaJud1hyj0+pvSC0KWNN/i/
 7GUEG4PgHPMEAfIxs2MYj8KyuIgn2WYuTjLjin1ebQdVODYXNZdPqEkBFuRtcTeDbJrS
 5BAqje1eQNvP6x6KS99GnDMnvnxpwTo5aeRXYeDHHqoUrAk7al9gjRerPsR4PJCeAePT
 JAjA==
X-Gm-Message-State: APjAAAXOCI2I+Qhu6xDwHDIhuNQY5DBcV0FiANzSyNAK88ssHtwdiyLH
 2l1X7nLwViKPASGXJIM6rVFdxMz0BakBSNnWXHDq3g==
X-Google-Smtp-Source: APXvYqyqjHwddUaqtlaxEW+sntcZw5GkXPsyprKug9SeKiC8JI755aYwSvG4krebQeUHUj1aZ6dYATz5Ky6tp9bNyqE=
X-Received: by 2002:a9d:4817:: with SMTP id c23mr1601429otf.97.1566571643817; 
 Fri, 23 Aug 2019 07:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-20-richard.henderson@linaro.org>
 <CAFEAcA8Q3ujQFtZfLXTsbKBxUQAHCPo0i_TpdX9KcmnNUY04Eg@mail.gmail.com>
 <c8809173-6b8a-afab-507f-69983ac29224@linaro.org>
In-Reply-To: <c8809173-6b8a-afab-507f-69983ac29224@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Aug 2019 15:47:12 +0100
Message-ID: <CAFEAcA9Rq3VR3F+zUV3BiZ7zQm-gE=Ut4hv7Hi0cK3me4Vch3Q@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v2 19/68] target/arm: Convert T32 ADDW/SUBW
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

On Fri, 23 Aug 2019 at 15:45, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/23/19 6:04 AM, Peter Maydell wrote:
> >> +&ri              rd imm
> >>  &r               rm
> >>  &i               imm
> >>  &msr_reg         rn r mask
> >
> > Should this change be in some other patch ?
>
> No, it's used by ADR.
>
> >> +  ADR            1111 0.1 0000 0 1111 0 ... rd:4 ........ \
> >> +                 &ri imm=%imm12_26_12_0
>
> ... here.

This is in t32.decode, which has its own definition of &ri.
The one I was asking about was the one in a32.decode -- the
addition of that line is the only change to a32.decode in this patch.

thanks
-- PMM

