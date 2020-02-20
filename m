Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A17C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 10:11:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C1D420801
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 10:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CCya6m+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1D420801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4inb-0007X1-Fi
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 05:11:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j4in1-00072D-BA
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:10:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j4in0-0006iG-1C
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:10:39 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43865)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j4imz-0006h7-RP
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:10:37 -0500
Received: by mail-oi1-x243.google.com with SMTP id p125so26961744oif.10
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 02:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/e2aIq6+KTlWo5s9WlgNylEFifK+JmjI80oq7DNCZwA=;
 b=CCya6m+EB/JlQ2duDW9Z8Ifeu0ZdD06Ajs+gswUvUK9n9BLjP2453zpam2q+cNj8vp
 fFX1E65zttDreOXkXPkYWGNuRGgYDGTQ6eW2XVAryHf9EONBbr0N5/SNOF9KoT5K60px
 /Y5z63SbN3vCKr6u0uT2r+2M5PBm97gIhuQmysQr2jzXJ/c4RrujCDTHC4aCyNUpo6Xb
 NtE9LA8bOhAY2S5vejWCCPyYNRfrshAbkR8GMRFLa3l6PzK3KKNzZjk1lY3GfarHnqIk
 dczNLjmo5GqoCRY45i/Qjtaruy7K3L76CZOJX9cGU0CKQbsle5ud/95zkgSEZV6JUcVe
 YUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/e2aIq6+KTlWo5s9WlgNylEFifK+JmjI80oq7DNCZwA=;
 b=mJeOeAsbMof41a9HBN/39Ktd/OLD2RkOfkr7+yHC0T+9PgWNMkbllx3346yvD62jYt
 UaWmt6x8FTfY20DvyO2n4zQXfh0nipjAdUbR6eraIYvtc7cAPw4M8p/SZFlMqeX+wYJr
 AKdHuWeFXeuMqvDQ76bSUEirzfPQxp4TSvuIMB8/s9JAUD2U6YusnLL70vZtgkvobBgf
 wH859mSeCrus3ZKRxYOvcPZE3KZ4hSSFUFm2wQhJt436nXqvtGT+yfkw+C6HFdzgYk27
 L+0iYH2FQPcv//XIuqHTYAfS5k1ga0H7ji48vDcAbiQXZUlp/3dXVsbslo05CLYNtJQI
 WqWw==
X-Gm-Message-State: APjAAAWNPchKbHGabS/cQsdIT56h949H8L3Qryd0RngNdshCOZ9Zf6f6
 7TNjxG4PzVlMftUXMM+yebcb8jPNjYJqGdz0JqE9u36Gvgc=
X-Google-Smtp-Source: APXvYqxDgbsBWFlDicMAQ4/Dh1Qzwr5UAUo5x7NEAsBRm5nbhieKonXI5s1bOrqKdp3hdfUTzTWjQim+l2SCFpX2x6A=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr1367097oic.48.1582193436880; 
 Thu, 20 Feb 2020 02:10:36 -0800 (PST)
MIME-Version: 1.0
References: <20200220060108.143668-1-gshan@redhat.com>
 <f3c8adba729d050ba2144cc9c834fe82@kernel.org>
In-Reply-To: <f3c8adba729d050ba2144cc9c834fe82@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2020 10:10:25 +0000
Message-ID: <CAFEAcA8inLO75XOcCO3bUiiJQyZT+nqmp1be+z6ZtQx2a=68+g@mail.gmail.com>
Subject: Re: [PATCH] hw/char/pl011: Output characters using best-effort mode
To: Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: qemu-arm <qemu-arm@nongnu.org>, Gavin Shan <gshan@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Shan Gavin <shan.gavin@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Feb 2020 at 09:10, Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-02-20 06:01, Gavin Shan wrote:
> > This fixes the issue by using newly added API
> > qemu_chr_fe_try_write_all(),
> > which provides another type of service (best-effort). It's different
> > from
> > qemu_chr_fe_write_all() as the data will be dropped if the backend has
> > been running into so-called broken state or 50 attempts of
> > transmissions.
> > The broken state is cleared if the data is transmitted at once.
>
> I don't think dropping the serial port output is an acceptable outcome.

Agreed. The correct fix for this is the one cryptically described
in the XXX comment this patch deletes:

-        /* XXX this blocks entire thread. Rewrite to use
-         * qemu_chr_fe_write and background I/O callbacks */

The idea is that essentially we end up emulating the real
hardware's transmit FIFO:
 * as data arrives from the guest we put it in the FIFO
 * we try to send the data with qemu_chr_fe_write(), which does
   not block
 * if qemu_chr_fe_write() tells us it did not send all the data,
   we use qemu_chr_fe_add_watch() to set up an I/O callback
   which will get called when the output chardev has drained
   enough that we can try again
 * we make sure all the guest visible registers and mechanisms
   for tracking tx fifo level (status bits, interrupts, etc) are
   correctly wired up

Then we don't lose data or block QEMU if the guest sends
faster than the chardev backend can handle, assuming the
guest is well-behaved -- just as with a real hardware slow
serial port, the guest will fill the tx fifo and then either poll
or wait for an interrupt telling it that the fifo has drained
before it tries to send more data.

There is an example of this in hw/char/cadence_uart.c
(and an example of how it works for a UART with no tx
fifo in hw/char-cmsdk-apb-uart.c, which is basically the
same except the 'fifo' is just one byte.)

You will also find an awful lot of XXX comments like the
above one in various UART models in hw/char, because
converting an old-style simple blocking UART implementation
to a non-blocking one is a bit fiddly and needs knowledge
of the specifics of the UART behaviour.

The other approach here would be that we could add
options to relevant chardev backends so the user
could say "if you couldn't connect to the tcp server I
specified, throw away data rather than waiting", where
we don't have suitable options already. If the user specifically
tells us they're ok to throw away the serial data, then it's
fine to throw away the serial data :-)

thanks
-- PMM

