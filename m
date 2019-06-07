Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC537C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:44:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DDA6208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BhK1y/5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DDA6208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48746 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZDIZ-0002OJ-PF
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 07:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37020)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hZC3k-0002nn-Bc
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:25:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hZC3d-0001GM-SQ
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:25:18 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44509)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hZC3Z-00013L-L9
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:25:11 -0400
Received: by mail-ot1-x344.google.com with SMTP id b7so1342495otl.11
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 03:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=he4P8/BHNsH7Rjfw5tDQkts46u8Rf8xVcDOZBP1joI8=;
 b=BhK1y/5tMKP+IfkGJeYpZTqYbqsGAnvTuvqGON0hllIWy2B0N916JNyvHtC8WR436U
 +FWDRlrc0GDBabS6amZkoOsCJjZfFOHMtIpqD9TPxJZIEfMXrwOOYpLVof/Lcd4OEmYs
 0oOsXM15tT/ZwewnaMWM8PpBGhgcMEpUa9RdmxWKDsoq2uFaZTR5FRLlmb+WNC0ovZdO
 SCuvoDpQrMCLsr0CCF8FAfTCR2OJ9mNwCdl3UPbNMvcluKuN08/zny9mI9YajGDc19NZ
 Wgi9kYtfTREJ8BdFzyT7Oo7eTI0Jee7zHc+2B4cxK4VcwCo54mWM1jmWu0dZm5l/WpTb
 s+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=he4P8/BHNsH7Rjfw5tDQkts46u8Rf8xVcDOZBP1joI8=;
 b=pahJJc9RQTNM2qyAy8/ckMAXm+thAX5gQCvhtc2Auwf0YptiQtuBrihGbD9QIi32I7
 bRr5mqXWpDmgpiKx612W4KZhxVL1zC/i9qk27Mlq8JTEHr31mvFKIh6oTwPD1uUKVd4W
 kSctEH0cKuX4dxREiTmMgMiegRhZcx6z2/2AIfJYMPaXv8s+p7/5IUbCsf/5tZL5BSw4
 +VQfMFlpaGBmcdy8w9QlA0GopfFFTHTB9Lkg28ei9zhy1JGrOCngnx0u19i9oDP7FTYj
 4lk80+3dVYYZbIvjWiMQ+0fTStD8V6+O2jyyXYYA6Y1KkJenuI+ymYpRliZS9LevfjhJ
 YoHw==
X-Gm-Message-State: APjAAAVEanSIFMiiuVjsVWtEmtYEZNejkOR8qFIRMZAvwwzRvPO+MzRY
 Gl+VCb0V/n4HVhoBoQn5U7P1ZTTX181KxpT8EMSI7w==
X-Google-Smtp-Source: APXvYqziaYYlCS8l2D8KmX+mrCiYOuBlhfNlwsb7fEFyz5ZMGi2+hTtFWGz1Kl6lppxM7E/VehOWhc7mfUVHmxG6xOw=
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr18976059otp.91.1559903105450; 
 Fri, 07 Jun 2019 03:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190604203351.27778-1-richard.henderson@linaro.org>
 <20190604203351.27778-39-richard.henderson@linaro.org>
In-Reply-To: <20190604203351.27778-39-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jun 2019 11:24:54 +0100
Message-ID: <CAFEAcA-MdduL0NpFb8foTwcNufF-BWNPpRnkJdKhn_vf3=1jzQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v4 38/39] tcg/arm: Use LDRD to load tlb
 mask+table
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

On Tue, 4 Jun 2019 at 22:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This changes the code generation for the tlb from e.g.
>
>         ldr      ip, [r6, #-0x10]
>         ldr      r2, [r6, #-0xc]
>         and      ip, ip, r4, lsr #8
>         ldrd     r0, r1, [r2, ip]!
>         ldr      r2, [r2, #0x18]
>
> to
>
>         ldrd     r0, r1, [r6, #-0x10]
>         and      r0, r0, r4, lsr #8
>         ldrd     r2, r3, [r1, r0]!
>         ldr      r1, [r1, #0x18]
>
> for armv7 hosts.  Rearranging the register allocation in
> order to avoid overlap between the two ldrd pairs causes
> the patch to be larger than it ordinarily would be.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

