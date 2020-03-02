Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE37C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 15:45:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A92F222C4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 15:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JJUFiFMs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A92F222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8nG5-0000LC-CN
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 10:45:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j8nFQ-0008Ce-3x
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:44:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j8nFP-00019x-5D
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:44:48 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41121)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j8nFO-00019g-Ve
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:44:47 -0500
Received: by mail-ot1-x341.google.com with SMTP id v19so10134497ote.8
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 07:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yyRwetK4iaXS3mSeej/UIS0tNCUXW66arMw8aU9xvNI=;
 b=JJUFiFMs54cUkZhLrk6Vk/vK7JEYU28xrp/2KTtyJ8iJ/OXBCEVBk0cPoHeanyhNtp
 L7bQe1Hxlc7KmxbuM6Z8bmZ0UtKMzKTDrizCpVbNGXA0G5gyYGZ9uVCfH6uHKcl80+sq
 baPZPl7MguNXUEEiTjslkmLre/tINC24lzJbCG3rNtuWfA3ZBIjs6g6a+M/68lwZTInG
 I940CDIUTrFqt5oetALzIdsU6l1r6ITbgSWRwqgEXL20xoeb0sxT4gXZYtvhVkooxocv
 6jhr9mv+Yha/6NJ2pRU+O47qq9C4woWnJpQ+i5bjWpWWlKbEIT7T/ZBVFuYUrLsqrxEi
 MjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yyRwetK4iaXS3mSeej/UIS0tNCUXW66arMw8aU9xvNI=;
 b=AAnem2FrIcS8ARX8fwq+LNo9tOMtH5Y1t9jaBjHJedB92cacRgnuvLrxuHA30JOrUK
 cXs6cYGvAh8kw/cHKgy0bBVW9swS9Gc30zlOdn/8J4xXmz7xscsXzmk4FpDSSmVBk932
 RgJ6XgejU3n2Z6QAQU5pu1sn5z+Cysia7EfRK7yiXMQeqgLNsfgaIvWBH6KYunx8E0VT
 8yMSH1l1cOz3bHogeokkFEe83m+FBkb1DThguF1dTEB0FJt1/aI+ujP+0qWR0ZMrJVYG
 WBqoFRXkG97KA8y1n6/PQ4v3G1drpkCRd8MAiiPFzCcz10P3MROAw4djE2I04n2cB5Ux
 6IuQ==
X-Gm-Message-State: ANhLgQ2FX82R0gwkL/iiwpIFuYookOVMBLDRTSByuN/qManXnGX7YGCz
 ye93reowf+udUTpStI5TnzWi3KVPRiGeYxtS0tOBRw==
X-Google-Smtp-Source: ADFU+vuUv54ORu4j1huPLIdnMrX49gn4R8U0Q14bn/pS/5TZYqPIzys20WqFBSTnBcKY0/unxQkxS93YJke67wSzZSM=
X-Received: by 2002:a9d:6f88:: with SMTP id h8mr5387723otq.91.1583163886316;
 Mon, 02 Mar 2020 07:44:46 -0800 (PST)
MIME-Version: 1.0
References: <20200227220149.6845-1-nieklinnenbank@gmail.com>
 <20200227220149.6845-5-nieklinnenbank@gmail.com>
In-Reply-To: <20200227220149.6845-5-nieklinnenbank@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Mar 2020 15:44:35 +0000
Message-ID: <CAFEAcA94U=G7Bhiayt5YyJHFUMjyKwT1m5VNOH+1rV-NMysR7Q@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] hw/arm/cubieboard: report error when using
 unsupported -bios argument
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Feb 2020 at 22:02, Niek Linnenbank <nieklinnenbank@gmail.com> wrote:
>
> The Cubieboard machine does not support the -bios argument.
> Report an error when -bios is used and exit immediately.
>
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> ---
>  hw/arm/cubieboard.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
> index 6c55d9056f..871b1beef4 100644
> --- a/hw/arm/cubieboard.c
> +++ b/hw/arm/cubieboard.c
> @@ -19,6 +19,7 @@
>  #include "exec/address-spaces.h"
>  #include "qapi/error.h"
>  #include "cpu.h"
> +#include "sysemu/sysemu.h"
>  #include "hw/sysbus.h"
>  #include "hw/boards.h"
>  #include "hw/arm/allwinner-a10.h"
> @@ -33,6 +34,12 @@ static void cubieboard_init(MachineState *machine)
>      AwA10State *a10;
>      Error *err = NULL;
>
> +    /* BIOS is not supported by this board */
> +    if (bios_name) {
> +        error_report("BIOS not supported for this machine");
> +        exit(1);
> +    }

We don't usually bother to check this, but I guess there's
no reason not to.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

