Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09472C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 10:54:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 573DD222C8
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 10:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yl3kwqRQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573DD222C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUpHW-0000cj-BR
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 06:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUpGv-0008Sf-9B
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 06:53:41 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:41499)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUpGt-0005MS-4c
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 06:53:40 -0400
Received: by mail-ej1-x643.google.com with SMTP id x7so1978224eje.8
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 03:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TpMzdY0jDvV08YNRqq+Nfm6bW0Q1ejlsZL020UWCrm8=;
 b=Yl3kwqRQ/l8oXPJ21n/R6oJvbw2avZh8G3NA8QTMb9m2Bv5CZsOHbJpiHdasZ7x7un
 IPFggBhEaDpI9OnE44qQiatj0urcVNvt0gXKUkhaaYcoxKIuNy855DURakI1PodZTBnh
 r6Ujvp8oxrzN04pwTY8CzwbV+iYUrrv65EJvxDbqikaYi4Ee7AMswRHvEs0n3flpSriB
 bas2Zo2wwzNE1DqXCbOYoJzM94xZplJNG2ZrFmpYiGrLrcyQqbZcsx7dKHyScciqoJO0
 KSkETc3fBms/YXqM5NU3pG2SSNY4kT0dlUFTWSCyL8NU9x7o0H/F+0rgJx0h+2Q/KVeJ
 1InA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TpMzdY0jDvV08YNRqq+Nfm6bW0Q1ejlsZL020UWCrm8=;
 b=L3CeVmfAxRNO7LaqVS7ZUbGT5YurRwlwIUx+q+CRLX3xTFqMQwfPcZEBgjOMdKttmR
 bbhsQmFYnh0Eg5ijq1yYgpMjCTt4+oIjfQTFaDHPObSUDkhMw9U1nugq63B1a0H3Gvg/
 Igm8qL9OlNJk66qj4y24DFKi4rj2sOJu6CfARIJ/Cly47BH57tuvOkmdEUUHdwl0+wyY
 1gz5AxOi1PbyCfO2B0GJAkiJQqXaT6fj9ZiDXc0icVFcJvgdNgR9zIQSq5vaHNkOsta/
 22pdiuoKdEN8tbrs28UdnAuKUq6Nb2JBAYK/YYHqraoK69nhbknuEEUB2RoFB0c1hPkj
 iQfg==
X-Gm-Message-State: AOAM533uKvnTHEv8fz2ZIhzIU/Ay7pPOjc8ec8TscZYUm+V11ZFUCuY6
 nB8YmnwOrqTLv1+kttyjiX4XgfTN7WZsKV65CmX4Fg==
X-Google-Smtp-Source: ABdhPJxthAvBh0h4NN0e6VaGL7divZCAec0RJu6h5mnBaqD0M34W8kHnPel6VjezlihCbnRR9Zkik9sLGDuA9PvZr9k=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr2402364ejk.407.1603191216374; 
 Tue, 20 Oct 2020 03:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <1602654397-35162-1-git-send-email-fnu.vikram@xilinx.com>
 <1602654397-35162-2-git-send-email-fnu.vikram@xilinx.com>
In-Reply-To: <1602654397-35162-2-git-send-email-fnu.vikram@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Oct 2020 11:53:25 +0100
Message-ID: <CAFEAcA_=eERP_Q49k9oNa6Jun8oWGeE0D+uZaN6QxEZAfZO+mw@mail.gmail.com>
Subject: Re: [PATCH v11 1/4] hw/net/can: Introduce Xilinx ZynqMP CAN controller
To: Vikram Garhwal <fnu.vikram@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: figlesia@xilinx.com, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 14 Oct 2020 at 07:04, Vikram Garhwal <fnu.vikram@xilinx.com> wrote:
>
> The Xilinx ZynqMP CAN controller is developed based on SocketCAN, QEMU CAN bus
> implementation. Bus connection and socketCAN connection for each CAN module
> can be set through command lines.
>
> Example for using single CAN:
>     -object can-bus,id=canbus0 \
>     -machine xlnx-zcu102.canbus0=canbus0 \
>     -object can-host-socketcan,id=socketcan0,if=vcan0,canbus=canbus0
>
> Example for connecting both CAN to same virtual CAN on host machine:
>     -object can-bus,id=canbus0 -object can-bus,id=canbus1 \
>     -machine xlnx-zcu102.canbus0=canbus0 \
>     -machine xlnx-zcu102.canbus1=canbus1 \
>     -object can-host-socketcan,id=socketcan0,if=vcan0,canbus=canbus0 \
>     -object can-host-socketcan,id=socketcan1,if=vcan0,canbus=canbus1
>
> To create virtual CAN on the host machine, please check the QEMU CAN docs:
> https://github.com/qemu/qemu/blob/master/docs/can.txt
>
> Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>


> +#define MAX_CAN_CTRLS      2
> +#define XLNX_ZYNQMP_CAN_R_MAX     (0x84 / 4)
> +#define MAILBOX_CAPACITY   64
> +#define CAN_TIMER_MAX  0XFFFFUL

"0x" is more usual.


> +    if (ARRAY_FIELD_EX32(s->regs, SOFTWARE_RESET_REGISTER, SRST)) {
> +        trace_xlnx_can_can_receive("Controller is in reset.\n");
> +        return false;
> +    }

> --- /dev/null
> +++ b/hw/net/can/trace-events
> @@ -0,0 +1,9 @@
> +# xlnx-zynqmp-can.c
> +xlnx_can_transfer_fifo(const char *message) "%s"
> +xlnx_can_srr_pre_write(const char *message) "%s"
> +xlnx_can_update_rx_fifo(const char *message) "%s"
> +xlnx_can_rxfifo_pre_read(const char *message) "%s"
> +xlnx_can_tx_post_write(const char *message) "%s"
> +xlnx_can_can_receive(const char *message) "%s"
> +xlnx_can_receive(const char *message) "%s"
> +xlnx_can_realize(const char *message) "%s"

This is not the usual way to do tracepoints. Generally rather
than having one trace point which gets passed an opaque string,
you should have trace points for each interesting event,
which have an event-specific format string that prints out
the useful information. Here's an example from a UART model:
 pl011_can_receive(uint32_t lcr, int read_count, int r) "LCR 0x%08x
read_count %d returning %d"
Notice that it's specific to one event (there's only one
place in the code that calls that tracepoint), it mostly
relies on the name of the trace event itself to give the
user context, and it uses the format string to provide some
information about the internal state of the device (not always
relevant for all trace events -- sometimes you do just have an
event).

That way users of tracepoints can enable, for instance,
all the 'xnlx_can_rxfifo*' tracepoints if they want all
the logging, or only 'xlnx_can_rxfifo_full' if they only
care to log the "fifo filled up" event but not others.

thanks
-- PMM

