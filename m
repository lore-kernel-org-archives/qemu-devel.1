Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D913C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:53:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BE3B214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wrREmsny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE3B214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j07oY-00083r-CE
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 12:53:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j07np-0007V9-CX
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:52:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j07no-0008SD-Gn
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:52:29 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33089)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j07no-0008Rv-BB
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:52:28 -0500
Received: by mail-oi1-x242.google.com with SMTP id q81so2825860oig.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 09:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OlVBhFe3K60yD2Gtzy4DVtQpGsy1MkuRQKMc2Xp8IbY=;
 b=wrREmsny3RLoIZIE20P4qaG10TSx5sun0VVeMVcvE4cvJeOglMoOH2M8uYCltaMec2
 p7WKAHGqKskaFgRRliyY6Me2MjSJtUliKcKWw1bh/tr2eH1bzX4fy6QOiZRj45nJAO3O
 dsXC40cD+jdvkhZqbyPCH0ukkR1y0SQgE0lB8WXzBEYlpsm+dEz7esJPJHKEKIqE+h+n
 X3cbWaTHefwacFBro0ff3c6C9NBeGoX4ygXd9zmHb0eckGyX/EEH7TYVae0Wp4WkryJM
 DpekBxy6zaaP4RTffzvj4w6Tya34v+EHcqWOywZYtYNSO6IPrwhfGMu1bOyt0VS9B0+i
 Mkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OlVBhFe3K60yD2Gtzy4DVtQpGsy1MkuRQKMc2Xp8IbY=;
 b=ox6AHbVWvN31faoPMz3c18AFwhTEIVUl66Q610jgb5r8xmk1a7wcjmzTB6icBeBVRo
 sBmrgktZiyOS/UCqScdpxfZHbxiqQAvVjLFsHDQlgPjjBb1p4lZLzq0XJr1C1c06fz18
 ucHdZ7tBgZ1QdM0LDgb+nIzu8ayKH31UjO60TvNOmjfAuelYxDIDumyxIps+vDcXdRyy
 K7m9aEuJuQ+D6Cc1GJeMdLqto8zql1SJt6AufUfdE5swtWYmSZQPE6k7ysWCrpY4YSKm
 i3mq5jMM8xU8h6udT+HQiy/fK8HVLS4q5jGWhFLJfD1SBmq8fqL1WscTeZn/AXtKaq7R
 s+ZQ==
X-Gm-Message-State: APjAAAXfz+hQOZmNyJg5sV6EIhbLwSWM2t28BsAfCybqva0pj/KKus1F
 CBsJp9dPqJqd+QWWYNAlLSuKxoImJZ2JI000SPq0s8Gz
X-Google-Smtp-Source: APXvYqysLNWF97JC/pDSqf2Xx7BVT/lTR1vWycCLqNTBcKTQ5V3KVjgZV06/vLFXqoet9tSOTSwBKNWTRZhdOb69Jxs=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr2761451oie.146.1581097947670; 
 Fri, 07 Feb 2020 09:52:27 -0800 (PST)
MIME-Version: 1.0
References: <20200203144716.32204-1-richard.henderson@linaro.org>
 <20200203144716.32204-19-richard.henderson@linaro.org>
In-Reply-To: <20200203144716.32204-19-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Feb 2020 17:52:16 +0000
Message-ID: <CAFEAcA-4TwFjWcfN1XZ8-x5C4d551OHcrM7LRZUHSagHXUxG2w@mail.gmail.com>
Subject: Re: [PATCH v3 18/20] target/arm: Update MSR access to UAO
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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

On Mon, 3 Feb 2020 at 14:47, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Move reginfo to file scope; avoid setting uao from spsr
>     when the feature is not enabled (pmm).
> v3: Update for aarch64_pstate_valid_mask
> ---
>  target/arm/cpu.h           |  6 ++++++
>  target/arm/internals.h     |  3 +++
>  target/arm/helper.c        | 21 +++++++++++++++++++++
>  target/arm/translate-a64.c | 14 ++++++++++++++
>  4 files changed, 44 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

