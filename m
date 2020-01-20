Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE4CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:59:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 255B0217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ciYy3VL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255B0217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itXaf-0002is-BO
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 08:59:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37169)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1itXZy-00027B-Dp
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:58:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1itXZw-0006Yu-V8
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:58:58 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:44882)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1itXZw-0006YH-OR
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:58:56 -0500
Received: by mail-ot1-x333.google.com with SMTP id h9so28665528otj.11
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 05:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jEgzaPkCNNQ5N+IGF5UyFuBEb2jf5dAPic+nQbNMIH0=;
 b=ciYy3VL5ceqeOlIoSShkReD3+Jh2ynD2ReZnUPMlt3diTBhNZ0dSTyJUS0IX3/XCHV
 MhWieUh3fc8NDneywqwPs5RCvUsp+8N+xrmhSX/twn2I/EifQazdbMsNxXt7N3/yjYy7
 3PyQ09O1DpJycmnw1Re4Wfsy/gBZDdUphm4gEEN/8rJQl8e3e4y6xx34d+JXTpLRVAKg
 QsuAyuE1+eEOKfGCCJw8IXJYt9UscsXgpu7avtpS5+Ax07cUsFgs1NtgUL6li/ySZQ4R
 v9+nD7UwHJeEvqmaGbxRH8TMydnK0EEkE9NMP77Tj018BDMg3j01sBDJEFzHlM+xY6EE
 RoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jEgzaPkCNNQ5N+IGF5UyFuBEb2jf5dAPic+nQbNMIH0=;
 b=FKPpnaqrLrUJgcKoWb6Q20F2QaxcdxfQuylycGsBCF/HFS5/p4axM2Ip1nGK6E6N0Y
 A3qximJvvnP7i/jVGYIHGjpEXn6uTonXpH06dCLrtt/XLn4oRZVeC6JavlruqtdUHZPd
 3KZSiUEyjLi+XBNBeXbVXTXDlkTgil0GEBHRDqdpK1lR95v2J4aNQRrAnMSuIJtQDGm+
 EGRGAzLS7VlFobajJqO9hNXOsRXV/4L1wMPKlb3hJ4xwbVfYNFzunCgYlNh/Ijjnn2vZ
 1IyooAZwVpBd/gnj3e1lYZjGj8EMI8x9vxETDOcMqV/YMwst7+eJxzEYxNDOoVx2+tho
 q5Cg==
X-Gm-Message-State: APjAAAVekvVCXhYk3a6vf+JS20z0QNvKk62MlGirZJ51ZJAbBE+U21F0
 b3xzRt496aWP+2OJwKcJIHf90NNwIJZhTq4iqao9tw==
X-Google-Smtp-Source: APXvYqwBO7dl3SCY244C0CHElDp2xq4TL/FVP/xg1Z77rEzLH+pOSk+81nr1W02K3bdMOgx356lDU+aBCmX+5HnynoY=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr16017040otd.91.1579528735484; 
 Mon, 20 Jan 2020 05:58:55 -0800 (PST)
MIME-Version: 1.0
References: <20200118164229.22539-1-linux@roeck-us.net>
 <20200118164229.22539-6-linux@roeck-us.net>
In-Reply-To: <20200118164229.22539-6-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jan 2020 13:58:44 +0000
Message-ID: <CAFEAcA9kK7mK=FQRKc0sDL8rZzibYov9Xm__+-MA06ERCotZ1Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] hw/char/exynos4210_uart: Implement Rx FIFO level
 triggers and timeouts
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::333
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

On Sat, 18 Jan 2020 at 16:42, Guenter Roeck <linux@roeck-us.net> wrote:
>
> The driver already implements a receive FIFO, but it does not
> handle receive FIFO trigger levels and timeout. Implement the
> missing functionality.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Call exynos4210_uart_rx_timeout_set() from new post_load function
>     to set the receive timeout timer.
>     Add timer to vmstate_exynos4210_uart.
>
>  hw/char/exynos4210_uart.c | 122 ++++++++++++++++++++++++++++++--------
>  hw/char/trace-events      |   3 +-
>  2 files changed, 99 insertions(+), 26 deletions(-)

Since the timeout value depends on s->wordtime, and
exynos4210_uart_update_parameters() can change s->wordtime,
do you need to recalculate the timeout at that point?
This would correspond to if the guest wrote to the
UBRDIV/UFRACVAL/ULCON registers, I think. Maybe this comes
under the heading of "undefined behaviour if the guest does
this odd thing" ? (The exact behaviour of the h/w is probably
undocumented and mildly painful to emulate exactly, so it's
hard to see why QEMU should care about getting it exactly right.)

I did also wonder whether writing the same value to the UCON
timeout-interval field repeatedly really does restart the timer
counting down from 8*(N+1) frames again, but again maybe that's
just weird for a guest to do.

> @@ -553,6 +620,7 @@ static const VMStateDescription vmstate_exynos4210_uart = {
>                         vmstate_exynos4210_uart_fifo, Exynos4210UartFIFO),
>          VMSTATE_UINT32_ARRAY(reg, Exynos4210UartState,
>                               EXYNOS4210_UART_REGS_MEM_SIZE / sizeof(uint32_t)),
> +        VMSTATE_TIMER_PTR(fifo_timeout_timer, Exynos4210UartState),
>          VMSTATE_END_OF_LIST()
>      }
>  };

Unfortunately you can't simply add entries to a VMStateDescription:
it breaks migration compatibility.

The choices here are:
 * the nicest approach if it works is that in the post_load
function you just recalculate the timer timeout. Then there's
no need to migrate the current state of the timer. (In fact
it looks like your code does do this in post_load.)
 * if something really does need adding to the migration state,
then the version_id and minimum_version_id need to be bumped
(so migration fails cleanly rather than confusingly).
 * if you want migration to continue to work across versions
(which we don't care about for the exynos boards but does
apply for boards like 'virt'), this can be done by adding
a 'subsection' to the vmstate.

I think the answer in this case is just "you don't need to
add this line to the vmstate at all". (This does mean that
a vmsave/vmload will slightly extend the rx-timeout and
delay the interrupt because we re-calculate the timer,
but I guess that's OK. If you don't like that and would
prefer the timer to retain the exact timeout value across
migration, then keep the new vmstate array entry, bump the
version fields, and don't call exynos4210_uart_rx_timeout_set()
in post-load.)

thanks
-- PMM

