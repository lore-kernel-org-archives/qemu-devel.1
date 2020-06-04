Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429C3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 13:34:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0823420772
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 13:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TR5Y21QS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0823420772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgq0c-0007Gl-8Q
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 09:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgpz9-0005ur-KK
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 09:32:43 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38171)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgpz7-0005Ac-Vx
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 09:32:43 -0400
Received: by mail-oi1-x241.google.com with SMTP id c194so5070409oig.5
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 06:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iF6lYs0rjs+LXewzJpDLup0f6TB0lKBSIu4YZCV/Ldk=;
 b=TR5Y21QSc892xfGQsO3mKxocfrwlp80r10IH+iF4EeyllnHIa2BonbHIuh+KtSVO9g
 wbsDHf8JPog/m9bULU6RAtuj9Wlk/VM2nBC1yMXHJQEF/1MTJHakhl7oiU9ewLnB4ohP
 +UnvatNcn3xK8sNR4fh9qOcuwP7WlG8uk0NHypbEtF6vnkQdS/hCB3WvXCRny23YE3fF
 CXjyUbgtP7z33ig/3UmxyphXEo/LsRYKGsK0CBnDHE6PWbjwylR2jVvnwtpQNJHaqDAm
 wN2iHM4wD75ZlMtimip/228Mq+W71x17GmyIR/98UDNXeUi2rc7QPHdlQ5K7JIKyidPU
 Yl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iF6lYs0rjs+LXewzJpDLup0f6TB0lKBSIu4YZCV/Ldk=;
 b=V1Y5kaFjSpPJBKeBSllkeBKMjQosJfgtVmKAbb4+yhE1RbmKep455pei3a300aIjS8
 s9rIT8GTsX4nMN07mjVAr9qUddBjhpPRVZIn/iFHIRtqajSQ3BSDIbDIyCHCvieahqEY
 t/Q0awVUSjetx1QDHpvg2t+ds78uqnFQ2lj8J1vI9MrUr8MpFcO419/Jd9NchoCSKp2t
 0HllV9T6h5dHTyYhzbtC4/sP1RVXgPdo75gUkbP7mKR7kVo6S27KfTD8ukq/B6wUeaIY
 s+yt7Hd1cwEimaDlePJmaQn2FbWTTInyaLTyLMpC/NR7g3VSDwEwR3kpOxRaB8EJw8Ie
 jR0w==
X-Gm-Message-State: AOAM533V/n4l/66xPUD1VYwxTZ6X5G0sMS90vLkvlJXDm2068E618tP5
 pxItkvULLYhyI4yf+rEp55VC1TEThWWMXFBt3aBcPw==
X-Google-Smtp-Source: ABdhPJwitoQZTRX93CBzRdSPXk6i32wXmkHzDfvv6/XUjj2v0KSpumQotQSneUIu2/1tVrhL1uLJJ3nEjUahCqwoi+M=
X-Received: by 2002:aca:5152:: with SMTP id f79mr2998379oib.146.1591277559946; 
 Thu, 04 Jun 2020 06:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <81607772-7cbc-1d61-2687-313f6389e1eb@c-sky.com>
In-Reply-To: <81607772-7cbc-1d61-2687-313f6389e1eb@c-sky.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jun 2020 14:32:29 +0100
Message-ID: <CAFEAcA84BwfhEEk6_mG9Fzp8HizRUEm5cRQo-QhOory0Gz7Duw@mail.gmail.com>
Subject: Re: hw/char: a question about watch callback function in serial
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair23@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 4 Jun 2020 at 13:15, LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
> I see many UART implementations have a G_IO_OUT | G_IO_HUP  callback function.
>
> In hw/serial.c, it is serial_watch_cb, setting by the following code,
>
>   s->watch_tag = qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
>
>                       serial_watch_cb, s);
>
> In hw/candence_uart.c, it is cadence_uart_xmit, setting by the following code,
>
>         guint r = qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
>
>                                         cadence_uart_xmit, s);
>
>
>
> I tried to call it with booting a Linux, but the interface will never be called.
>
> Can someone give a reasonable answer why needs this interface, or a way to call it.

This code is here to handle the case where the UART wants to pass
data to the chardev which is acting as the backend to the UART
(which might be host stdio, a TCP port, etc), but the backend
cannot accept data.

Older UART code (eg hw/char/pl011.c) calls qemu_chr_fe_write_all()
to write data, but this is a blocking call and these calls are
usually marked with an XXX/TODO comment, because if the chardev
backend can't currently accept the data then execution of the
guest will be blocked until the backend does start to accept
data again.

The solution to this bug was the introduction of the non-blocking
qemu_chr_fe_write() call. But to use the non-blocking call, the
UART emulation code now needs to handle the case where
qemu_chr_fe_write() says "I couldn't write all the data you asked
me to". In that case, it must use qemu_chr_fe_add_watch() to
request a callback when the chardev is able to accept new data,
so that it can try again. (It also needs to emulate telling the
guest that the transmit FIFO is not yet empty via whatever status
registers the UART has for that, because in the meantime guest
execution will continue with some of the data still not sent to
the chardev, but sitting in the emulated FIFO; and it needs to
correctly emulate "guest tried to write more data to a full FIFO".
Older UART emulations that use the blocking write_all function
don't need to bother with these details because there the tx
FIFO is always empty -- from the guest's perspective data written
to the tx FIFO drains instantaneously.)

The common case execution path is "the chardev can accept the data
faster than the guest can feed it to the UART", in which case
qemu_chr_fe_write() will return 'wrote all the data' and the
UART never needs to call qemu_chr_fe_add_watch(). To exercise the
add-watch codepath you need to connect the UART to a chardev
that can be made to stop accepting data (for instance a pipe
or a unix domain socket where there's nothing on the other end
reading data.)

thanks
-- PMM

