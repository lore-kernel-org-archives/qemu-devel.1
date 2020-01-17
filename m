Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504CAC33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 18:22:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EDC8206D5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 18:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iin/iOB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDC8206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isWGM-0003Wc-4D
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 13:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1isWFT-0002Vw-P3
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:21:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1isWFS-00032U-N1
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:21:35 -0500
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:39761)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1isWFQ-0002zT-0c; Fri, 17 Jan 2020 13:21:32 -0500
Received: by mail-yb1-xb44.google.com with SMTP id x18so6286626ybk.6;
 Fri, 17 Jan 2020 10:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=u9shOCD9O1+12r3IyiFFm4tISZkGsIgPercoRilwGsk=;
 b=Iin/iOB3SKzNFH6118zWBmdpqwRqox1lN/pUQaOr0WzKC0uW+e571oN+v/Mg6I94Js
 EAu4F1yM/+2kvxXgwximMJafM5W/hMtKhWDf2WcwHmL9PWKtfNQ/ChWGB//6VEjTswhp
 IhiZxUtWsv9B4r6iLw8c1+rVQnVvgbyGp8plgF+ACMOrdm7j6MRKqUYIJqwAnilYx32A
 gZlKpojdUDjOkIAW0XNAvFpHFMqEa/d8hFTOmlw+NPzfnHh0rgdloIW9MRTxCrrgvt8P
 A02g5uoaDiTX7o+kv5fBfycDDwV5UeB28PpU98h1+dc9HHKyZ8WdjSvL9pS/ZPa88i6A
 2yOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=u9shOCD9O1+12r3IyiFFm4tISZkGsIgPercoRilwGsk=;
 b=LdP11CoNcY1pB1nhCO6fqhluLVx7+yjoyQcEuF2gerRYm+82XHZS3vlo2O/b9r6NtL
 3+LkCOcrHSoywV5afK1CkJ0eK9qEET07ROCaoJoo7KEz8E3YXZ+Br6CPOBQsja8mNiV3
 H2VfmIiuBYF/u4KLSaIAl/xgHdY5urcEUXJRokclmTC86gsB3RVG4rBR3RQlymr0XwTP
 quazyUgxlBqkt3vhfyJtR05G3ruQ818Tsr4SRR9VzyoixiiVONJ9sbes1Z3ztraOw20I
 fthee9AdFWQLSs9viDjw0eDKC63G8aSJbh0l4g3l2ZwoG2klExc01cJtfjEDU7xyG1z/
 Wqww==
X-Gm-Message-State: APjAAAUF6/sbXOIsbg+Wk1fjXgPSmEUQWoPhgswHpLeSm3p+udQ28HnN
 /F5RWMj/qAm67PI0PWCIgOY=
X-Google-Smtp-Source: APXvYqzDfi6vcV4lebvIji2KQ9CHmOQX+Kim00RqTRFMIA6g1FlV3RBhC1jzHXhpVdNd/TR6LPyH4Q==
X-Received: by 2002:a25:abf2:: with SMTP id
 v105mr15317290ybi.518.1579285291296; 
 Fri, 17 Jan 2020 10:21:31 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id w142sm11782737ywa.87.2020.01.17.10.21.30
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 17 Jan 2020 10:21:30 -0800 (PST)
Date: Fri, 17 Jan 2020 10:21:29 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 4/6] hw/char/exynos4210_uart: Implement receive FIFO
Message-ID: <20200117182129.GB13396@roeck-us.net>
References: <20200110203942.5745-1-linux@roeck-us.net>
 <20200110203942.5745-5-linux@roeck-us.net>
 <CAFEAcA81V46N8eqTtBo7YZE0kDaqVNz=iAjbqdv8m=GPRsaewg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA81V46N8eqTtBo7YZE0kDaqVNz=iAjbqdv8m=GPRsaewg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On Fri, Jan 17, 2020 at 01:42:54PM +0000, Peter Maydell wrote:
> On Fri, 10 Jan 2020 at 20:39, Guenter Roeck <linux@roeck-us.net> wrote:
> 
> The subject just says "implement receive FIFO", but the
> existing code clearly has an "Exynos4210UartFIFO   rx"
> which it does some storing and retrieving data from.
> Could the patch be more accurately described as something
> like "Implement interrupts for rx FIFO level triggers and
> timeouts" ?
> 
Sure, no problem.

> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  hw/char/exynos4210_uart.c | 120 ++++++++++++++++++++++++++++++--------
> >  hw/char/trace-events      |   3 +-
> >  2 files changed, 97 insertions(+), 26 deletions(-)
> >
> > diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
> > index fb7a3ebd09..61134a7bdc 100644
> > --- a/hw/char/exynos4210_uart.c
> > +++ b/hw/char/exynos4210_uart.c
> > @@ -24,6 +24,7 @@
> >  #include "migration/vmstate.h"
> >  #include "qemu/error-report.h"
> >  #include "qemu/module.h"
> > +#include "qemu/timer.h"
> >  #include "chardev/char-fe.h"
> >  #include "chardev/char-serial.h"
> >
> > @@ -118,6 +119,7 @@ static const Exynos4210UartReg exynos4210_uart_regs[] = {
> >  #define ULCON_STOP_BIT_SHIFT  1
> >
> >  /* UART Tx/Rx Status */
> > +#define UTRSTAT_Rx_TIMEOUT              0x8
> >  #define UTRSTAT_TRANSMITTER_EMPTY       0x4
> >  #define UTRSTAT_Tx_BUFFER_EMPTY         0x2
> >  #define UTRSTAT_Rx_BUFFER_DATA_READY    0x1
> > @@ -147,6 +149,9 @@ typedef struct Exynos4210UartState {
> >      ";
> >      Exynos4210UartFIFO   tx;
> >
> > +    QEMUTimer *fifo_timeout_timer;
> > +    uint64_t wordtime;        /* word time in ns */
> 
> You need to do something on incoming migration to handle
> the new fields. This probably looks like a .post_load function
> that calculates the wordtime based on the register values
> that have been set by the incoming migration and set the
> QEMUTimer appropriately.
> 
Doesn't that mean that the .post_load function is missing even today,
and that it should call exynos4210_uart_update_parameters() ?

Thanks,
Guenter

