Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54067C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 13:33:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 191AB20652
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 13:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zFMz7fcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191AB20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57683 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL6P4-00042U-7Q
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 09:33:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL6O4-0003fg-TQ
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:32:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL6O3-0005fm-Rs
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:32:04 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39991)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL6O3-0005fQ-Lv
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:32:03 -0400
Received: by mail-ot1-x344.google.com with SMTP id w6so8580582otl.7
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 06:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=eY3dtc71jibE6WTycqkDgU3W/mdPJcs8BxdxZnMnPAg=;
	b=zFMz7fcj+KSnpKuSu+o8WHR8P8tq9XUA6vGUABnDXVRrilC9a2TRYQWbP8hkTOryqs
	+28WSY3rC7Bs4o8nWWk26gacahQJ/QYANN2135yB2uyVeh7bO5TlLW/4IYBjScquT2tP
	WcjTjblng6316PQkOOTXZ3VoGp+JBPy+dic7kxFhyqN090mAwi+jV0Mo5/zXolP+7jHc
	mKnXfUKTf3qrdAiyodwlvv6QJPm7z0rkQ6TwSaPXt2yxUx37hApjXKLJn8JKiDTPdpnG
	o9NK1IWeGCw1QZw6P7fyZERkEOxa0Mo0k8zxFIvAzkg6PPDZnpRsS6wPQ50a3SqmNkK3
	DujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=eY3dtc71jibE6WTycqkDgU3W/mdPJcs8BxdxZnMnPAg=;
	b=of8bxaR+PQ1FW330dEZMlVKmWMbIYqNLpLzXV6sCfuiPKi/n70nhw1fx4fR4CMthSt
	XZwZh0ue46poVScuFb3jbD2c9AF/8XEOCaw5oTa6volBJ321fP1gv4l79NEKYyTF0nFI
	UpSvFw62CR9KA92JioHVrrpIdfyUHDjofjbA1PM9TN+o+2xHy2UhK4L2IQTJz555KZg4
	WmUki6/lQaVtGDSPU5/ShMvIAD+ZoqPHd1DOfJseg1JK6Bl0Y3sSDUbkoz2+/lTGJnRs
	Q0Vya+g3uJeZNBr0dkBqkqtQBHrpsM/Xre0OmxkX56vDro8u88Dqf6fKkPSgbENoD7p2
	ayzA==
X-Gm-Message-State: APjAAAXrT8wE49SPv7ogzUks7018ZiRqDJvcSWX2JdUPgA+uqWaqO2Qp
	e4nc6kIKUxklbojXntB3Og9KjHitb1Vh4Zk7BssTiQ==
X-Google-Smtp-Source: APXvYqwAuIwlCEyOW9YXaZugzuhq16yLAft1i6WO3lY+BoVfWZEE/hp3yjdwP1i7PHp8fTS0ql5+1kKQDcwbR8mmZPw=
X-Received: by 2002:a9d:57c4:: with SMTP id q4mr3999693oti.151.1556544722657; 
	Mon, 29 Apr 2019 06:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-3-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 14:31:51 +0100
Message-ID:
 <CAFEAcA_KNSzerED7aLVeieVC4W15zfu0oKfV8PY0b46Db3xJCw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 02/36] tcg: Split out
 target/arch/cpu-param.h
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429133151.IlIxUxDao8MI8qkFtfVXlebWaGkAOec1tgS2vyevjM4@z>

On Thu, 28 Mar 2019 at 23:40, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> For all targets, into this new file move TARGET_LONG_BITS,
> TARGET_PAGE_BITS, TARGET_PHYS_ADDR_SPACE_BITS,
> TARGET_VIRT_ADDR_SPACE_BITS, and NB_MMU_MODES.
>
> Include this new file from exec/cpu-defs.h.
>
> This now removes the somewhat odd requirement that target/arch/cpu.h
> defines TARGET_LONG_BITS before including exec/cpu-defs.h, so push the
> bulk of the includes within target/arch/cpu.h to the top.
>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


Your new headers all need the standard copyright/license
header comment and multiple-include guard.
> diff --git a/target/xtensa/cpu-param.h b/target/xtensa/cpu-param.h
> new file mode 100644
> index 0000000000..000e6026c0
> --- /dev/null
> +++ b/target/xtensa/cpu-param.h
> @@ -0,0 +1,9 @@
> +#define TARGET_LONG_BITS 32
> +#define TARGET_PAGE_BITS 12
> +#define TARGET_PHYS_ADDR_SPACE_BITS 32
> +#ifdef CONFIG_USER_ONLY
> +#define TARGET_VIRT_ADDR_SPACE_BITS 30
> +#else
> +#define TARGET_VIRT_ADDR_SPACE_BITS 32
> +#endif
> +#define NB_MMU_MODES 4
> diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
> index 4d8152682f..93440357b0 100644
> --- a/target/xtensa/cpu.h
> +++ b/target/xtensa/cpu.h
> @@ -28,28 +28,17 @@
>  #ifndef XTENSA_CPU_H
>  #define XTENSA_CPU_H
>
> -#define ALIGNED_ONLY
> -#define TARGET_LONG_BITS 32
> -
> -/* Xtensa processors have a weak memory model */
> -#define TCG_GUEST_DEFAULT_MO      (0)
> -
> -#define CPUArchState struct CPUXtensaState
> -
>  #include "qemu-common.h"
>  #include "cpu-qom.h"
>  #include "exec/cpu-defs.h"
>  #include "xtensa-isa.h"
>
> -#define NB_MMU_MODES 4
> +#define ALIGNED_ONLY

ALIGNED_ONLY is a config thing that tcg.h needs to see -- if
we define it this low in the cpu.h file it seems a bit fragile
whether or not tcg.h will get included by something else
before we get to the definition... (This probably applies
to a few of the other cpu.h files too.)

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

