Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D10C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:05:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D69A4206B8
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qvDW9uja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69A4206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQSMl-0002SW-2e
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 05:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33932 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQSLd-0000yu-0C
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:04:13 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQSLb-0007op-Ja
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:04:12 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33967)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jQSLb-0007nk-6h
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:04:11 -0400
Received: by mail-ot1-x341.google.com with SMTP id 72so986015otu.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 02:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YEWtSFhrdXnNaDGlrw6fFEIcRZRyA0vza2uKJTdSmOk=;
 b=qvDW9ujadIXOneCKqaMl9awocChxQkx0htfBA3v8NR6BX8ZZb4pWrMsjXyDKEcIATr
 eLWzc+753p7Dhh86HJlZncYeNmXtst8jXBaK6K7M2v6N9QyifdVlmZIj8D77u6xnT7dz
 7pryKXY1/MhDJQOc9ws8Sjv4QNvZG/dkUygHezFupBuX3v3N84QrljrBbJYi12Ma26jA
 tFXgi5sZ3a1vMXq4STa1F5a+8veR9v5md/l01sNQUCfoymVPLO3g/sbAcd7bg3+myAIo
 MAySzHceWrvpNw65Mo5lra5AhgZscE1nw1u1bQjUawKUZSk0UleEXSZ7sP4jXJ+oXrMQ
 +zjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YEWtSFhrdXnNaDGlrw6fFEIcRZRyA0vza2uKJTdSmOk=;
 b=hOf1YJyRjI2C8NT/oCAKsukkgWoCOvyhA8ocPu46540xkJM8/gtccGtUWIize3NSNL
 coXTRjLowB+/4NMziEijLEO7Yh/uN55y5EmLEYcs6ER3bvOMgu05OdbxYCKOZcMOS0ek
 h5FoKb1120a8Qj5tijIC4wTisYoF/3UbDVnk4Bco5kLG/2CsFCXQSh6Wra+OmlqACtAr
 IqatCQnftaY9DKI7vY7CYsW20dkZx/PHEkh6USNgZoaL5J2dYIgdUM3AXwNeA86mfko5
 GTM6g43kIn3+kbg0Yb1NSUv3iGExYs29I932FwvhdaY6rxZRpgLrbyseYKKGrEuLudfb
 LVfQ==
X-Gm-Message-State: AGi0PuYbC4YdenGCNcQrcF14s0/y+gqfUwdWGWx8BnXhJHoqcLHxp6ee
 X+LBtOwVJW6bZnRw7kLwfnVnvG0yF/YZHUrdnuYB5w==
X-Google-Smtp-Source: APiQypKV9OslRYDAveq20g3+NJUuiSEFIl0RC2MesfygxWXwfIpjne9AY2pZGbfonB8qMK/BCS0YmQB+2pnkKdT1IxU=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr8693289otj.91.1587373449624; 
 Mon, 20 Apr 2020 02:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200417171736.441607-1-rfried.dev@gmail.com>
In-Reply-To: <20200417171736.441607-1-rfried.dev@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Apr 2020 10:03:58 +0100
Message-ID: <CAFEAcA8brVNH4i_psLN3fdqSrw9Nuza9OU-f6cv5b-XDdwQaaQ@mail.gmail.com>
Subject: Re: [PATCH v2] Cadence: gem: fix wraparound in 64bit descriptors
To: Ramon Fried <rfried.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Apr 2020 at 18:17, Ramon Fried <rfried.dev@gmail.com> wrote:
>
> Wraparound of TX descriptor cyclic buffer only updated
> the low 32 bits of the descriptor.
> Fix that by checking if we're working with 64bit descriptors.
>
> Signed-off-by: Ramon Fried <rfried.dev@gmail.com>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
> v2: Fix indention problem.
>
>  hw/net/cadence_gem.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)



Applied to target-arm.next for 5.1, thanks.

-- PMM

