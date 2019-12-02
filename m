Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0B8C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:25:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B1372073C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r9S8ttlO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B1372073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibnaF-00059I-Gm
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 10:25:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ibnZA-0004RW-Tg
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:24:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ibnZ8-0000wF-U1
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:24:48 -0500
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:35502)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ibnZ8-0000vK-Pz
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:24:46 -0500
Received: by mail-io1-xd43.google.com with SMTP id v18so9972491iol.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 07:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QJOBjADfA+ccFaGnSH39XSvCu6Wstd7Jkr8Gx+Uryd8=;
 b=r9S8ttlOFu9FrNkNhafD22Ym2jqdHI7GqFoRxy0httgyf4nbuWCsksV0WtiKhZIjYx
 lB0mvqEv45ErC5LUI8zxMIEoyUtlQVXsnHmM4ZzkvnWjxefcvBshyWgNeK/B0z6FLbac
 fwtuAFo0TzHl81W54r+NjN/0G/2eLYMRxNZUDwqPGwnIBuP+TNxJXHEcA06kmXPBuvqJ
 P72NT+mFSDwBRctmy0+ZxYWSf76qdaNyOEGvFNXxMyiWz69iNpBXcnmqjbT2jp8AiplM
 8fLaaWCqpbsl5u8ELyCVzGOfTdbPopLw/SnVnezQ5CVd1gqMzqbs7VxcXqD1RwFbvI/U
 nvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QJOBjADfA+ccFaGnSH39XSvCu6Wstd7Jkr8Gx+Uryd8=;
 b=d0kv8qcwEGeCiwHr1SPPnCrpMzcr6Uoaz4rL7SVr5i9B62WiDoWkB3zptsumfwgll7
 LrK/kx+aGwczpgXZbzDOZbuzceCiN+UchkNhsX5Pl2Dca8/0FTyrJW/UqN869SFANLV+
 U1Q4mcBU0ALylWklGFGEVjmdHBCJ3hQJVPGIMfmNf+ADXnFEGLghIHbBmXsDqO8i62ki
 NCurpVbwM1iDUE2xdjMzpPqoaiLt7Oxxxsz9+KTOdBxaBmkclskaQBNrPf3SPIeRUsuu
 RRJDBEESMfp74g1Q4hqsaJD5JQkXWQXPQ9JD+nv93gbOB1k50aH5in+I6rBGbO5nRbhG
 lZeQ==
X-Gm-Message-State: APjAAAVj1FEJ/FNIGfgo5+sxThRHiABO9rkCGxlMYWRgjLgjkCwXquRk
 DSyK5e+U/hf9ooL3R9AbD1Gts4nmNV6thRxYDuRFjA==
X-Google-Smtp-Source: APXvYqzkuUkVr8fRB9we+E4pd5c/vS8aPDdLSHH0NksGaOdrLAMCkQ+geUqDgwt4zpyCP7oQdybke/iulnioqciO3wA=
X-Received: by 2002:a5e:920a:: with SMTP id y10mr12339198iop.292.1575300285908; 
 Mon, 02 Dec 2019 07:24:45 -0800 (PST)
MIME-Version: 1.0
References: <20190904125531.27545-1-damien.hedde@greensocs.com>
 <20190904125531.27545-9-damien.hedde@greensocs.com>
In-Reply-To: <20190904125531.27545-9-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2019 15:24:34 +0000
Message-ID: <CAFEAcA8=7yhQR4Gw2OYmiF0cFJDaVn2hnUrfnZGFJK6wyuB97Q@mail.gmail.com>
Subject: Re: [PATCH v6 8/9] hw/char/cadence_uart: add clock support
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Sep 2019 at 13:56, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> Switch the cadence uart to multi-phase reset and add the
> reference clock input.
>
> The input clock frequency is added to the migration structure.
>
> The reference clock controls the baudrate generation. If it disabled,
> any input characters and events are ignored.
>
> If this clock remains unconnected, the uart behaves as before
> (it default to a 50MHz ref clock).
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>

>  static void uart_parameters_setup(CadenceUARTState *s)
>  {
>      QEMUSerialSetParams ssp;
> -    unsigned int baud_rate, packet_size;
> +    unsigned int baud_rate, packet_size, input_clk;
> +    input_clk = clock_get_frequency(s->refclk);
>
> -    baud_rate = (s->r[R_MR] & UART_MR_CLKS) ?
> -            UART_INPUT_CLK / 8 : UART_INPUT_CLK;
> +    baud_rate = (s->r[R_MR] & UART_MR_CLKS) ? input_clk / 8 : input_clk;
> +    baud_rate /= (s->r[R_BRGR] * (s->r[R_BDIV] + 1));
> +    trace_cadence_uart_baudrate(baud_rate);
> +
> +    ssp.speed = baud_rate;
>
> -    ssp.speed = baud_rate / (s->r[R_BRGR] * (s->r[R_BDIV] + 1));
>      packet_size = 1;
>
>      switch (s->r[R_MR] & UART_MR_PAR) {
> @@ -215,6 +220,13 @@ static void uart_parameters_setup(CadenceUARTState *s)
>      }
>
>      packet_size += ssp.data_bits + ssp.stop_bits;
> +    if (ssp.speed == 0) {
> +        /*
> +         * Avoid division-by-zero below.
> +         * TODO: find something better
> +         */

Any ideas what might be better? :-)

> +        ssp.speed = 1;
> +    }
>      s->char_tx_time = (NANOSECONDS_PER_SECOND / ssp.speed) * packet_size;
>      qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_PARAMS, &ssp);
>  }

thanks
-- PMM

