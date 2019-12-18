Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CB9C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 20:17:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78F39227BF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 20:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QnVhgSE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F39227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihflM-0002NB-L1
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 15:17:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44781)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihfkO-0001nQ-Il
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 15:16:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihfkM-0002qg-WE
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 15:16:40 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39542)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihfkM-0002j3-Eq
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 15:16:38 -0500
Received: by mail-pg1-x544.google.com with SMTP id b137so1850825pga.6
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 12:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=imihML2X4ulF6Cvoo2a0C+FhAV8/c9KGoJ7dSo18MqQ=;
 b=QnVhgSE7o8gY7kFKUbFXaMfubO9N6B4UpDRV62EYoPHZQ1k7uTXv/rL/7A8oxpO/0X
 Pgz7B8RmwYJYoPAOeKNqQ+KWSgcFDl7aIiVzIsic7eiuX6wu2F/pWDpGB4Yboh6xoI0f
 0FK1jeocLUz6wf1m325ZlrwT6HVDkBOoKS869e1TBs0CvvIQL+pCGjrVVkuA5eVOCoRO
 S7amjx3MsRCPKr0wlOqSCrwSv6GqZ5whQAPLr8FSqGJT7mzjQX45sWNu793m2imdJ+rY
 jPGvaGnt+ydCXAU2iTROxqSgmZcCxxP9zTXdd4i++fVxKLls1HMgVvH3h6jCbfnsgRbw
 LnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=imihML2X4ulF6Cvoo2a0C+FhAV8/c9KGoJ7dSo18MqQ=;
 b=C3XK9CkGpjqRTUuJ+mYEdEjc7TWDu6ln7hcpTQ7SeBtgEwtfcQJlkDtRsWaj43hNQp
 9rnVfMSzRmaUMnR5qezjMZM5Gh0GOgVdK7FCcO+0jDwuNlVFiCNN/BcPhX4+oRQpXlPC
 Tz28mfAZVno11RxFht8yIbcUieU2mONzJzOVrhVtrQJJUFJUDTpMlU4T49B6Td8GVYfs
 IJBDieoUmCfHzd2XbBSd9QzvsUZXcvdOw3tin7sk70rsu+AkzrtWg6uBLA8VuDfkkxLD
 QVBzL1Yuht3Cwg2LOvTAOEIVstAcdmdwkZKnwbjtnC46/IbOctAuoGC6xRq1bTxLeUM4
 2KYA==
X-Gm-Message-State: APjAAAWs5XRHW9xKablLQ0Pwy0BycbkucNASpZSdDtwfNl1yX1GTOiJW
 WMZFgdMODXoomiy4ErwcTZpr1w==
X-Google-Smtp-Source: APXvYqylzub/2RqlAjktCcgUMR3g4Y4wdSZGw5SRfrpOCegeJSWqeIZIKcT2CezO8xXBg7KyWxgIfw==
X-Received: by 2002:a65:66da:: with SMTP id c26mr5057095pgw.354.1576700196642; 
 Wed, 18 Dec 2019 12:16:36 -0800 (PST)
Received: from ?IPv6:2605:e000:c74f:dc00:6838:d2b2:17e2:8445?
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id r3sm4434114pfg.145.2019.12.18.12.16.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 12:16:35 -0800 (PST)
Subject: Re: [PATCH v1 3/4] semihosting: add qemu_semihosting_console_inc for
 SYS_READC
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191218180029.6744-1-alex.bennee@linaro.org>
 <20191218180029.6744-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5ca1462e-5129-2b32-f014-a732a26a0587@linaro.org>
Date: Wed, 18 Dec 2019 10:16:32 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218180029.6744-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: Peter Maydell <peter.maydell@linaro.org>, keithp@keithp.com,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/18/19 8:00 AM, Alex Bennée wrote:
> From: Keith Packard <keithp@keithp.com>
> 
> Provides a blocking call to read a character from the console using
> semihosting.chardev, if specified. This takes some careful command
> line options to use stdio successfully as the serial ports, monitor
> and semihost all want to use stdio. Here's a sample set of command
> line options which share stdio betwen semihost, monitor and serial

between.

> +/**
> + * qemu_semihosting_console_inc:
> + * @env: CPUArchState
> + *
> + * Receive single character from debug console. This may be the remote
> + * gdb session if a softmmu guest is currently being debugged. As this
> + * call may block if no data is available we suspend the CPU and will
> + * rexecute the instruction when data is there. Therefor two

re-execute, Therefore

> + * conditions must be met:
> + *   - CPUState is syncronised before callinging this function

synchronized, calling

> + *   - pc is only updated once the character is succesfully returned

successfully.


> +static int console_can_read(void *opaque)
> +{
> +    SemihostingConsole *c = opaque;
> +    int ret;
> +    g_assert(qemu_mutex_iothread_locked());
> +    ret = (int) fifo8_num_free(&c->fifo);
> +    return ret;
> +}

Boolean result; better as

  return fifo8_num_free(&c->fifo) > 0

(We could usefully change IOCanReadHandler to return bool to emphasize this.)

> +static void console_wake_up(gpointer data, gpointer user_data)
> +{
> +    CPUState *cs = (CPUState *) data;
> +    /* cpu_handle_halt won't know we have work so just unbung here */
> +    cs->halted = 0;
> +    qemu_cpu_kick(cs);
> +}
> +
> +static void console_read(void *opaque, const uint8_t *buf, int size)
> +{
> +    SemihostingConsole *c = opaque;
> +    g_assert(qemu_mutex_iothread_locked());
> +    while (size-- && !fifo8_is_full(&c->fifo)) {
> +        fifo8_push(&c->fifo, *buf++);
> +    }
> +    g_slist_foreach(c->sleeping_cpus, console_wake_up, NULL);
> +}

I think you should be clearing sleeping_cpus here, after they've all been kicked.

> +target_ulong qemu_semihosting_console_inc(CPUArchState *env)
> +{
> +    uint8_t ch;
> +    SemihostingConsole *c = &console;
> +    g_assert(qemu_mutex_iothread_locked());
> +    g_assert(current_cpu);
> +    if (fifo8_is_empty(&c->fifo)) {
> +        c->sleeping_cpus = g_slist_prepend(c->sleeping_cpus, current_cpu);
> +        current_cpu->halted = 1;
> +        current_cpu->exception_index = EXCP_HALTED;
> +        cpu_loop_exit(current_cpu);
> +        /* never returns */
> +    }
> +    c->sleeping_cpus = g_slist_remove_all(c->sleeping_cpus, current_cpu);

Which would mean you would not have to do this, because current_cpu is only on
the list when it is halted.

I presume all semihosting holds the BQL before we reach here, and we are not
racing on this datastructure?

> +target_ulong qemu_semihosting_console_inc(CPUArchState *env)
> +{
> +    uint8_t c;
> +    struct pollfd pollfd = {
> +        .fd = STDIN_FILENO,
> +        .events = POLLIN
> +    };
> +
> +    if (poll(&pollfd, 1, -1) != 1) {
> +        qemu_log_mask(LOG_UNIMP, "%s: unexpected read from stdin failure",
> +                      __func__);
> +        return (target_ulong) -1;
> +    }

Why are you polling stdin?  linux-user isn't system mode, there isn't a
separate monitor thread to get blocked, and you aren't even blocking the thread
to try again just returning -1 to the guest.


r~

