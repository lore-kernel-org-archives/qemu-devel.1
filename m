Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106E5C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:37:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CABB720657
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="THtdy50N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CABB720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jahp8-00062K-0i
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 11:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jahmZ-0003cB-2p
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:34:24 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42208)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jahmU-0003Fx-9d
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:34:22 -0400
Received: by mail-ot1-x343.google.com with SMTP id z3so6710506otp.9
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 08:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rw1e0y0S61n2Z3+FGN0UAjAbD+HY2ekOgCqWh/CGanE=;
 b=THtdy50NUvbwfO0c6sOfCAw8PSz6RkrAq5wbOafIzLYIIdRJoIWSzWh9bWt2oya7gJ
 0CYomWvNMIaRq8liVlH1ALsjk87BoYrHxU21fVPCB/EqtPVu1egvJ+p10P5QuUNs1eJU
 cbhvoBulFMBHeVc+CaU88XbwDplMinen9VAdsTzVgUoYUKQ/d62N4G++S+9pwCRotHK1
 aTSxNY94Z4mGUIHFjetywciJGuNVs79qyhdlVNOBEXLrWleAflTSP1yu/3Q2RTWTS2MC
 q1H27XQ+DuGzW7mzT4O+c2pMbKilVLMbqEnw0qGXCIIiHUmlJy0/jSLou6cd9Qx/K3D0
 9W6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rw1e0y0S61n2Z3+FGN0UAjAbD+HY2ekOgCqWh/CGanE=;
 b=NdxcglMpyAfycdyMuY7tUfYUQo8ECqp72zElV4CrO7g5YTEnrx9sgDBfKhc8lyAnCu
 fAQdfuEIk/JpOyDDfoZN/rgeibnkuGd+iKOOeTnGotP7Q3/s1WA4lpszzX68AyP41CQB
 r7K5qWweeMlYbSz6cEWmBKVNBwmA1S1Pl4UiBKe1H8agE4T3Sr57k5hvdNkhcDGk26vV
 2XIP4Shm4BEf+tbb3qGm3jmuKJDXdDgTllgun2d4VatsKfAlxFUWra1vN/ng5nXCuFR0
 wOKEvoEZ7IwXHpX8jtICh+iuZcViTmBH/PZh958HIZRL4Nhmed1Dc1lVRn3bsdSeh9eO
 4Qaw==
X-Gm-Message-State: AOAM532TaAowc13fdCc99yZd9miA0alrZHR9C/kADYwlUh85L9jUMlEP
 FLimYU+xt2ilBVuGMdDIoYo+BNH8nPD2ac0BMB0OuQ==
X-Google-Smtp-Source: ABdhPJxGr1sWorBrFR7jYNQ01GE6Z/+jJTaNYCGBOoTIkRcDfJr1t+Mi6JGXR9i4qk4c2Z+tG/932iI7Klwto+NiNVQ=
X-Received: by 2002:a9d:b82:: with SMTP id 2mr12132565oth.221.1589816056946;
 Mon, 18 May 2020 08:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200512064900.28554-1-pauldzim@gmail.com>
 <20200512064900.28554-5-pauldzim@gmail.com>
In-Reply-To: <20200512064900.28554-5-pauldzim@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 May 2020 16:34:05 +0100
Message-ID: <CAFEAcA8ru0DyVTvVcTjf0AH8wi+d64m=iP_qbHrsLnGt65Y0Kg@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] dwc-hsotg (dwc2) USB host controller emulation
To: Paul Zimmerman <pauldzim@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 12 May 2020 at 07:50, Paul Zimmerman <pauldzim@gmail.com> wrote:
>
> Add the dwc-hsotg (dwc2) USB host controller emulation code.
> Based on hw/usb/hcd-ehci.c and hw/usb/hcd-ohci.c.
>
> Note that to use this with the dwc-otg driver in the Raspbian
> kernel, you must pass the option "dwc_otg.fiq_fsm_enable=0" on
> the kernel command line.
>
> Emulation of slave mode and of descriptor-DMA mode has not been
> implemented yet. These modes are seldom used.
>
> I have used some on-line sources of information while developing
> this emulation, including:
>
> http://www.capital-micro.com/PDF/CME-M7_Family_User_Guide_EN.pdf
> which has a pretty complete description of the controller starting
> on page 370.
>
> https://sourceforge.net/p/wive-ng/wive-ng-mt/ci/master/tree/docs/DataSheets/RT3050_5x_V2.0_081408_0902.pdf
> which has a description of the controller registers starting on
> page 130.
>
> Thanks to Felippe Mathieu-Daude for providing a cleaner method
> of implementing the memory regions for the controller registers.
>
> +
> +        if (pid != USB_TOKEN_IN) {
> +            trace_usb_dwc2_memory_read(hcdma, tlen);
> +            if (dma_memory_read(&s->dma_as, hcdma,
> +                                s->usb_buf[chan], tlen) != MEMTX_OK) {
> +                fprintf(stderr, "%s: dma_memory_read failed\n", __func__);

Don't report things with fprintf(stderr, ...), please. Other
options:

 * use qemu_log_mask() with a suitable mask; in particular for
   "guest just did something silly" we have LOG_GUEST_ERROR,
   and for "guest tried to do something we haven't implemented"
   we have LOG_GUEST_ERROR
 * use a tracepoint
 * for "this can't happen unless some other part of QEMU is
   buggy", just assert()
 * don't print or log anything if the emulation is just doing
   what the h/w would do in some situation

In this case LOG_GUEST_ERROR seems plausible. Ideally we'd do
whatever the hardware does on memory read failures (maybe it
logs this in a status bit somewhere ?)

I've noted a few other fprintf uses below but all of them
should be changed, please.

> +            }
> +        }
> +
> +        usb_packet_init(&p->packet);
> +        usb_packet_setup(&p->packet, pid, ep, 0, hcdma,
> +                         pid != USB_TOKEN_IN, true);
> +        usb_packet_addbuf(&p->packet, s->usb_buf[chan], tlen);
> +        p->async = DWC2_ASYNC_NONE;
> +        usb_handle_packet(dev, &p->packet);
> +    } else {
> +        tlen = p->len;
> +    }
> +
> +    stsidx = -p->packet.status;
> +    assert(stsidx < sizeof(pstatus) / sizeof(*pstatus));
> +    actual = p->packet.actual_length;
> +    trace_usb_dwc2_packet_status(pstatus[stsidx], actual);
> +
> +babble:
> +    if (p->packet.status != USB_RET_SUCCESS &&
> +            p->packet.status != USB_RET_NAK &&
> +            p->packet.status != USB_RET_STALL &&
> +            p->packet.status != USB_RET_ASYNC) {
> +        fprintf(stderr, "%s: packet status %s actual %d\n", __func__,
> +                pstatus[stsidx], actual);

This one seems like maybe it should be a tracepoint.

> +    }
> +

> +    case GRSTCTL:
> +        val |= GRSTCTL_AHBIDLE;
> +        val &= ~GRSTCTL_DMAREQ;
> +        if (!(old & GRSTCTL_TXFFLSH) && (val & GRSTCTL_TXFFLSH)) {
> +                /* TODO - TX fifo flush */

Maybe LOG_UNIMP these so we know if the guest tries to use missing
functionality ?

> +        }
> +        if (!(old & GRSTCTL_RXFFLSH) && (val & GRSTCTL_RXFFLSH)) {
> +                /* TODO - RX fifo flush */
> +        }
> +        if (!(old & GRSTCTL_IN_TKNQ_FLSH) && (val & GRSTCTL_IN_TKNQ_FLSH)) {
> +                /* TODO - device IN token queue flush */
> +        }
> +        if (!(old & GRSTCTL_FRMCNTRRST) && (val & GRSTCTL_FRMCNTRRST)) {
> +                /* TODO - host frame counter reset */
> +        }
> +        if (!(old & GRSTCTL_HSFTRST) && (val & GRSTCTL_HSFTRST)) {
> +                /* TODO - ? soft reset */
> +        }
> +        if (!(old & GRSTCTL_CSFTRST) && (val & GRSTCTL_CSFTRST)) {
> +                /* TODO - core soft reset */
> +        }

> +    case HFNUM:
> +    case HPTXSTS:
> +    case HAINT:
> +        fprintf(stderr, "%s: write to read-only register\n", __func__);

This kind of message should be a LOG_GUEST_ERROR.

> +        return;


> +static void dwc2_reset(DeviceState *dev)
> +{
> +    DWC2State *s = DWC2_USB(dev);
> +    int i;
> +
> +    trace_usb_dwc2_reset();
> +    timer_del(s->frame_timer);
> +    qemu_bh_cancel(s->async_bh);
> +
> +    if (s->uport.dev && s->uport.dev->attached) {
> +        usb_detach(&s->uport);
> +    }
> +
> +    dwc2_bus_stop(s);


> +    dwc2_update_irq(s);

A device that uses single-phase reset shouldn't try to change
outbound IRQ lines from its reset function (because the device
on the other end might have already reset before this device,
or might reset after this device, and it doesn't necessarily
handle the irq line change correctly). If you need to
update IRQ lines in reset, you can use three-phase-reset
(see docs/devel/reset.rst).

thanks
-- PMM

