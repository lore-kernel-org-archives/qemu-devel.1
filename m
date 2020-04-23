Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8BFC54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 11:40:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 718922084D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 11:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="da2GwoiY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718922084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRaDT-0004iC-Kn
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 07:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jRaCg-0004Ii-Fj
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jRaCf-0002Wq-Bh
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:39:38 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33008)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jRaCe-0002Wa-Tv
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:39:37 -0400
Received: by mail-ot1-x342.google.com with SMTP id j26so5465633ots.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 04:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oF4b1qKUX09s91W3vY8eqc/v5kcgDFIgZ1EbTD6sq9g=;
 b=da2GwoiY7NW9ARcqq3rGr9NaPi0G4Q5HIfObafNHGlSFZyYvSARF5EnuMcaFpy+Qf3
 ypm0p38RmXbZyG9/COp+8OUFCQ6U1iaqMtLEAudgKtp9tNk6qOT8IE37MIZMq4mBfFyU
 tfJFzImbXXD7FPy5HFXCrguH9mDYgvkCds5gmTmOjOO6aFneSTVpKp+iXNhF9A8PFxWM
 ITd2NVyGfWhPRtZQirus7KIHhPcpFeq/+jKUIiwWf/e3280EXRKY2imtQmIFstewu6m1
 aQ4bGoXjS2qVkAhrmBMAyUC4R2wNhmR/Uc1mn7/aGl4uZEqdPjHuGdVNuSGDODPkw9EH
 Ap3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oF4b1qKUX09s91W3vY8eqc/v5kcgDFIgZ1EbTD6sq9g=;
 b=ShUSZRjkGSK7LK5Wxz708y1ICybYgZRT1F8MdAx4buQbTXu853wsBShC1C398+CRlb
 VR29OvRHjt4yU6pLKqp6YHIrVexphrkAtOVBreZTQ49nxqh3i/UCknHeCQU1dOMRrVsE
 RZU2o5UlOa0hlfAuwkI4DgYK6O2BeWlTui+jTeCa02xqB/aN3QZk5hzTgvCDXqqB1KTN
 jyKVmLa/7l7WKRFLf9AXUTbHWbpXVDOxi3qFtl2O72iVH1HEprxm7reXllrpGUSmMe85
 SvktfK5Ukx9VpTGDyqR+cZvmbyT0HaXcfvyK4maM/FjcKaQIvX9DJux2HinBFN9Z+YXB
 UgZw==
X-Gm-Message-State: AGi0Pua5AZyd7+hz7fs1i7Er9Ew0Rusr8Pd4+7lPksKhQMHmZEAHyeGd
 9jjguSSipRGI4Az8A7nN2l0ePTNHU+c8bnR2UspboQ==
X-Google-Smtp-Source: APiQypJrywb5CGkIsWTL61xXFm7uZE2U1aH8BF5/H1oLGIUaQ9E/cHyBdatkBwil2tdq0KDcaT0nhBAPuhL3nt/mVVo=
X-Received: by 2002:aca:dc56:: with SMTP id t83mr2477252oig.48.1587641975609; 
 Thu, 23 Apr 2020 04:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200418162808.4680-1-richard.henderson@linaro.org>
In-Reply-To: <20200418162808.4680-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Apr 2020 12:39:23 +0100
Message-ID: <CAFEAcA8EV5vRBOCDqNc78zEGt8jnpMk3_68WstUY_R567wV_4g@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Vectorize integer comparison vs zero
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 18 Apr 2020 at 17:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These instructions are often used in glibc's string routines.
> They were the final uses of the 32-bit at a time neon helpers.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Applied to target-arm.next, thanks. Luckily my decodetree
conversion for Neon had not yet got to any of the 2-reg
insns :-)

-- PMM

