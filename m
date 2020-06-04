Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A30CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 05:56:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 271A1206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 05:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="phMuAolX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 271A1206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgirE-0003JD-A5
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 01:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jgiqe-0002q3-K0; Thu, 04 Jun 2020 01:55:28 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:36061)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jgiqb-0008BL-72; Thu, 04 Jun 2020 01:55:28 -0400
Received: by mail-il1-x144.google.com with SMTP id a13so4936520ilh.3;
 Wed, 03 Jun 2020 22:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nQtjsjGPjwWyApFnJH5bDNHxhHOkFHccsYdGOx5Lu/E=;
 b=phMuAolXprKtdj6MkfF9qBtgoyKgtimeasHu41wVdRdy6MqeHlwbZ8I6tDWk0ldjDG
 2JnFyh03hW8DPqyjE5ChZyVVUBgB6z+nvgXIe9PipdB6hs7qvpW2Q1DgcElKwm7sqf2t
 HGFF4XkMXc1cAAHUSMVkacmVbvu/SD5soDhfMYa9/mMy34cI3usdfVKy0CNE5tGqiM/t
 Jox5U/gmixTRJS+RGkqHq7Fg6aVevLqcR6XHnETvsVgfMaWr+omA3AaUMxxw+IRNTj+0
 HpPw+tdrTTVLwCZ2eYZbEXtFlF0Lb9O1dgofkjDE/U5MuzGioXMUGtrWrE0VGB/lGwfX
 AMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nQtjsjGPjwWyApFnJH5bDNHxhHOkFHccsYdGOx5Lu/E=;
 b=Z0aKoNYf0x8DLppYD3VZiduPwqFjIEzmJo8d67gkfaOQAOPUy88TOqZ65C+WHqGrCp
 kSSMQFokfHIzHfrjeOWQGntWryEHPTK3xZc9fDiHAZ0d36s6EQDTOy6XAcSnCzkxLqCS
 nU4w7zNngpuV52Vy9tiqroUpRqY6ogbE88hDs51AzIbmu0AO+FU11h0089n96vcHp6dO
 1D/ZKa76Ukc48X7779oyw3HEKqnuVXLxHMsZwseIxzBycn6Ua28+WWZONb3somPooKxP
 HyCgiRWu5GZ6BUa8mv0ky1C3xuto43FWPhjl2ILWJazH+jY+2MUF1NoWdX8QCcXQEm7A
 HSFQ==
X-Gm-Message-State: AOAM5326nUzs1SjkXG8Rv2glkBOAX0OqHr4AhZbKeZqWLhmaupDvLKCQ
 7YqaK9t+BLQxcrQPM1TR9eay/cNDaYbPLYpvcSw=
X-Google-Smtp-Source: ABdhPJxIj71W3wWa2Z5glQzTcbXXv60/0IDJNERsLuSa+BVv7h0c3FmIF18Q6MA0ERam4L4vRY0OXjZFH8UxggrCduI=
X-Received: by 2002:a92:c94b:: with SMTP id i11mr2789332ilq.177.1591250123750; 
 Wed, 03 Jun 2020 22:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590704015.git.alistair.francis@wdc.com>
 <73cce2d0edd0d41ba15df403a2096bfa70bf0565.1590704015.git.alistair.francis@wdc.com>
 <cc1a1671-b926-bb31-1ed2-d2920f0faf38@c-sky.com>
 <c9f16143-4e9b-a3a8-ffd3-12d43fd2e343@c-sky.com>
 <CAKmqyKM6rigjbDoFh0bfq8gJXJ=+H+onh=DXjCzhAijMCvR16Q@mail.gmail.com>
 <ec0a7545-1793-d1a9-fccf-068496cf1f0a@c-sky.com>
 <CAKmqyKOvv2HCpXoD+8E5q2S7JqSDfT7_z3+_=cKFLi+H92itjw@mail.gmail.com>
 <aa240d2d-42bb-b9dd-90f0-1a3051c2491f@c-sky.com>
 <CAKmqyKN3QBadrqzohWe0uwiCPcjU9WFHF_4j0dsKehszsZ4AWg@mail.gmail.com>
 <a56ffc6e-037b-5120-f22c-f18d98e8a382@163.com>
In-Reply-To: <a56ffc6e-037b-5120-f22c-f18d98e8a382@163.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jun 2020 22:46:11 -0700
Message-ID: <CAKmqyKOTiP_UcagHnnEVsaC1ogYMJZykn2MU=Gk125+DrrXrCg@mail.gmail.com>
Subject: Re: [PATCH v5 07/11] hw/char: Initial commit of Ibex UART
To: LIU Zhiwei <liuzwnan@163.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 3, 2020 at 10:06 PM LIU Zhiwei <liuzwnan@163.com> wrote:
>
>
>
> On 2020/6/4 12:35, Alistair Francis wrote:
> > On Wed, Jun 3, 2020 at 6:59 PM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
> >>
> >>
> >> On 2020/6/3 23:56, Alistair Francis wrote:
> >>> On Wed, Jun 3, 2020 at 3:33 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
> >>>> On 2020/6/3 1:54, Alistair Francis wrote:
> >>>>> On Tue, Jun 2, 2020 at 5:28 AM LIU Zhiwei<zhiwei_liu@c-sky.com>  wrote:
> >>>>>> Hi Alistair,
> >>>>>>
> >>>>>> There are still some questions I don't understand.
> >>>>>>
> >>>>>> 1. Is the baud rate  or fifo a necessary feature to simulate?
> >>>>>> As you can see, qemu_chr_fe_write will send the byte as soon as possible.
> >>>>>> When you want to transmit a byte through WDATA,  you can call
> >>>>>> qemu_chr_fe_write directly.
> >>>>> So qemu_chr_fe_write() will send the data straight away. This doesn't
> >>>>> match what teh hardware does though. So by modelling a FIFO and a
> >>>>> delay in sending we can better match the hardware.
> >>>> I see many UARTs have similar features. Does the software really care about
> >>>> these features? Usually I just want to print something to the terminal
> >>>> through UART.
> >>> In this case Tock (which is the OS used for OpenTitan) does car about
> >>> these features as it relies on interrupts generated by the HW to
> >>> complete the serial send task. It also just makes the QEMU model more
> >>> accurate.
> >> Fair enough. I see the "tx_watermark" interrupt, which needs the FIFO.
> >> At least,
> >> it can verify the ISP.
> > Exactly :)
> >
> >>>> Most simulation in QEMU is for running software, not exactly the details
> >>>> of hardware.
> >>>> For example, we will not simulate the 16x oversamples in this UART.
> >>> Agreed. Lots of UARTs don't bother modelling the delay from the
> >>> hardware as generally it doesn't matter. In this case it does make a
> >>> difference for the software and it makes the QEMU model more accurate,
> >>> which is always a good thing.
> >>>
> >>>> There is no error here. Personally I  think it is necessary to simulate
> >>>> the FIFO and baud rate,
> >>>> maybe for supporting some backends.
> >>> So baud rate doesn't need to be modelled as we aren't actually sending
> >>> UART data, just pretending and then printing it.
> >>>
> >>>> Can someone give a reasonable answer for this question?
> >>> Which question?
> >> I see  the UART can work with many  different backends,  such as pty ,
> >> file, socket and so on.
> >> I wonder if this a backend, which has some requirements on the baud
> > The backend should be independent so it doesn't matter what baud rate
> > we choose here.
> >
> >> rate.  You can ignore it,
> >> as it doesn't matter.
> >>>>>> 2.  The baud rate calculation method is not strictly right.
> >>>>>> I think when a byte write to FIFO,  char_tx_time * 8 is the correct time
> >>>>>> to send the byte instead of
> >>>>>> char_tx_time * 4.
> >>>>> Do you mind explaining why 8 is correct instead of 4?
> >>>> Usually write a byte to WDATA will trigger a uart_write_tx_fifo.
> >>>> Translate a bit will take
> >>>> char_tx_time. So it will take char_tx_time * 8 to transmit a byte.
> >>> I see your point. I just used the 4 as that is what the Cadence one
> >>> does. I don't think it matters too much as it's just the delay for a
> >>> timer (that isn't used as an accurate timer).
> >> Got it. Just a way to send the bytes at sometime later.
> >>>>>> 3.  Why add a watch here?
> >>>>> This is based on the Cadence UART implementation in QEMU (which does
> >>>>> the same thing). This will trigger a callback when we can write more
> >>>>> data or when the backend has hung up.
> >>>> Many other serials do the same thing, like virtio-console and serial. So
> >>>> it may be a common
> >>>> interface here. I will try to understand it(Not yet).
> >>> Yep, it's just a more complete model of that the HW does.
> >> I try to boot a RISC-V Linux, and set a breakpoint  to a watch callback
> >> function.
> >> The breakpoint did't match.
> >>
> >> I just wonder if there is a case really need the callback function.
> > AFAIK Linux doesn't support the Ibex UART (or Ibex at all) so it
> > shouldn't be triggered.
> I tried with the UART in the virt board.  It also registers the watch
> callback on
> G_IO_HUP and G_IO_OUT.
>
> However I will through the question alone in another mail.

Ah, sorry I misunderstood what you meant.

I haven't looked at it, it's possible it's not enabled by Linux.

>
> After the two points addressed,
>
> Reviewed-by: LIU Zhiwei<zhiwei_liu@c-sky.com>

Thanks!

Alistair

>
> Zhiwei
> >
> > Alistair
> >
> >> Zhiwei
> >>> Alistair
>
>
>

