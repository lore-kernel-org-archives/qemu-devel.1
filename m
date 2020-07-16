Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF11C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 13:23:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FBB52074B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 13:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Saayd0+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FBB52074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw3rY-0004V0-Fc
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 09:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jw3qp-0003nX-UG; Thu, 16 Jul 2020 09:23:03 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38894)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jw3qo-0002Sw-8y; Thu, 16 Jul 2020 09:23:03 -0400
Received: by mail-wr1-x441.google.com with SMTP id z13so7052151wrw.5;
 Thu, 16 Jul 2020 06:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=f8kTRj9f/lKZV3whiDWS/qsQN7HcFp/YvD+z4gzOGw8=;
 b=Saayd0+vy3GQOzwm53X6xFg0xaES0rMLU3ZhFMlWJwTNldspCnDA2mEtojQh/gD4HO
 oNDuAhkgnt6+7CcRiMrxoZBbeB2IOe4ypEmpzUk/U0jyp+50OklTxE8Qz7RurnnhKdbk
 n3mUrh6hIQW9Cyqdg65G5PTYoTi5kS9TrQz0H9eomYOti3bxUi8bPb9DoIvi3YrG95xe
 SBjdXfnP5M/IHIEsgc3UEd93ZCBxH0dusPLVOfz3rg/KmeIpcHaA4ezJxVUcXicUgr6l
 MZw8cKVD+Rx68mdGdLLtJngV/2SWdnjKm/vzO5ShkxgDqS9NzlOaWkZWcRbd25cebvO+
 gwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=f8kTRj9f/lKZV3whiDWS/qsQN7HcFp/YvD+z4gzOGw8=;
 b=iQqyQgUJ6rKELGzUJ//uw++3gPKl5DBP3//e7UQJVfSffaLZmxfHnzi1fg8caodYgR
 IQmsl649FxWBQLvL4EDsG/bROe/XuIKHepIikfGt92lriaPTxkGZ0rMW0YugUTfdfMUR
 v6geqQpB4m1BMT2PRQmqh4X5nElj4Pq3U5eHFIjPAFcP3xMVlaxtLb6rcfgLAxf3ZndY
 9rMPRRXgswqXZpl9Mt9IRWTV7VvwddTo/9jnphvT+gee7ArXgSogsPPeb4Tf2OyS6uxq
 qJCme/dc1T7XCNtcioDQ//n4snXP56O2yed0N56nG9KD4rQ23zakWmWpAkf8DqsXOKLl
 0F1g==
X-Gm-Message-State: AOAM531ZCIiAYoJaaNodz0xQaAgNv22pXliTdnJDy4ZH7Oot6dsgbsnC
 D70sDDgOJY66OCvJRQTkEcw=
X-Google-Smtp-Source: ABdhPJwrghvhX7hLwrf11MYvAyQT71KOFsgl5vw+alrTNa0lRkftrAvvXzmb1/VcWyXRnxVbIV891A==
X-Received: by 2002:adf:f984:: with SMTP id f4mr5004583wrr.221.1594905780151; 
 Thu, 16 Jul 2020 06:23:00 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id s10sm8922430wme.31.2020.07.16.06.22.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2020 06:22:59 -0700 (PDT)
Subject: Re: [PATCH v8 08/18] hw/arm/allwinner: add SD/MMC host controller
To: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-devel@nongnu.org
References: <20200311221854.30370-1-nieklinnenbank@gmail.com>
 <20200311221854.30370-9-nieklinnenbank@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <29ee48af-ff20-9c97-0e09-f752e6186f03@amsat.org>
Date: Thu, 16 Jul 2020 15:22:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200311221854.30370-9-nieklinnenbank@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, b.galvani@gmail.com,
 qemu-arm@nongnu.org, imammedo@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Niek,

On 3/11/20 11:18 PM, Niek Linnenbank wrote:
> The Allwinner System on Chip families sun4i and above contain
> an integrated storage controller for Secure Digital (SD) and
> Multi Media Card (MMC) interfaces. This commit adds support
> for the Allwinner SD/MMC storage controller with the following
> emulated features:
> 
>  * DMA transfers
>  * Direct FIFO I/O
>  * Short/Long format command responses
>  * Auto-Stop command (CMD12)
>  * Insert & remove card detection
> 
> The following boards are extended with the SD host controller:
> 
>  * Cubieboard (hw/arm/cubieboard.c)
>  * Orange Pi PC (hw/arm/orangepi.c)
> 
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/hw/arm/allwinner-a10.h   |   2 +
>  include/hw/arm/allwinner-h3.h    |   3 +
>  include/hw/sd/allwinner-sdhost.h | 135 +++++
>  hw/arm/allwinner-a10.c           |  11 +
>  hw/arm/allwinner-h3.c            |  15 +-
>  hw/arm/cubieboard.c              |  15 +
>  hw/arm/orangepi.c                |  16 +
>  hw/sd/allwinner-sdhost.c         | 854 +++++++++++++++++++++++++++++++
>  hw/arm/Kconfig                   |   1 +
>  hw/sd/Makefile.objs              |   1 +
>  hw/sd/trace-events               |   7 +
>  11 files changed, 1059 insertions(+), 1 deletion(-)
>  create mode 100644 include/hw/sd/allwinner-sdhost.h
>  create mode 100644 hw/sd/allwinner-sdhost.c
...

> +static uint32_t allwinner_sdhost_process_desc(AwSdHostState *s,
> +                                              hwaddr desc_addr,
> +                                              TransferDescriptor *desc,
> +                                              bool is_write, uint32_t max_bytes)
> +{
> +    AwSdHostClass *klass = AW_SDHOST_GET_CLASS(s);
> +    uint32_t num_done = 0;
> +    uint32_t num_bytes = max_bytes;
> +    uint8_t buf[1024];

Is 1024 a constant specific for this device?

> +
> +    /* Read descriptor */
> +    cpu_physical_memory_read(desc_addr, desc, sizeof(*desc));

I missed that while reviewing, but IIUC from [*] below, this code
is emulating the DMA context right? So we should be using the DMA
accessors here, dma_memory_read() and dma_memory_write().

> +    if (desc->size == 0) {
> +        desc->size = klass->max_desc_size;
> +    } else if (desc->size > klass->max_desc_size) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: DMA descriptor buffer size "
> +                      " is out-of-bounds: %" PRIu32 " > %zu",
> +                      __func__, desc->size, klass->max_desc_size);
> +        desc->size = klass->max_desc_size;
> +    }
> +    if (desc->size < num_bytes) {
> +        num_bytes = desc->size;
> +    }
> +
> +    trace_allwinner_sdhost_process_desc(desc_addr, desc->size,
> +                                        is_write, max_bytes);
> +
> +    while (num_done < num_bytes) {
> +        /* Try to completely fill the local buffer */
> +        uint32_t buf_bytes = num_bytes - num_done;
> +        if (buf_bytes > sizeof(buf)) {
> +            buf_bytes = sizeof(buf);
> +        }
> +
> +        /* Write to SD bus */
> +        if (is_write) {
> +            cpu_physical_memory_read((desc->addr & DESC_SIZE_MASK) + num_done,
> +                                      buf, buf_bytes);
> +
> +            for (uint32_t i = 0; i < buf_bytes; i++) {
> +                sdbus_write_data(&s->sdbus, buf[i]);
> +            }
> +
> +        /* Read from SD bus */
> +        } else {
> +            for (uint32_t i = 0; i < buf_bytes; i++) {
> +                buf[i] = sdbus_read_data(&s->sdbus);
> +            }
> +            cpu_physical_memory_write((desc->addr & DESC_SIZE_MASK) + num_done,
> +                                       buf, buf_bytes);
> +        }
> +        num_done += buf_bytes;
> +    }
> +
> +    /* Clear hold flag and flush descriptor */
> +    desc->status &= ~DESC_STATUS_HOLD;
> +    cpu_physical_memory_write(desc_addr, desc, sizeof(*desc));
> +
> +    return num_done;
> +}
> +
> +static void allwinner_sdhost_dma(AwSdHostState *s)
> +{
> +    TransferDescriptor desc;
> +    hwaddr desc_addr = s->desc_base;
> +    bool is_write = (s->command & SD_CMDR_WRITE);
> +    uint32_t bytes_done = 0;
> +
> +    /* Check if DMA can be performed */
> +    if (s->byte_count == 0 || s->block_size == 0 ||
> +      !(s->global_ctl & SD_GCTL_DMA_ENB)) {
> +        return;
> +    }
> +
> +    /*
> +     * For read operations, data must be available on the SD bus
> +     * If not, it is an error and we should not act at all
> +     */
> +    if (!is_write && !sdbus_data_ready(&s->sdbus)) {
> +        return;
> +    }
> +
> +    /* Process the DMA descriptors until all data is copied */
> +    while (s->byte_count > 0) {
> +        bytes_done = allwinner_sdhost_process_desc(s, desc_addr, &desc,
> +                                                   is_write, s->byte_count);

[*]

> +        allwinner_sdhost_update_transfer_cnt(s, bytes_done);
> +
> +        if (bytes_done <= s->byte_count) {
> +            s->byte_count -= bytes_done;
> +        } else {
> +            s->byte_count = 0;
> +        }
> +
> +        if (desc.status & DESC_STATUS_LAST) {
> +            break;
> +        } else {
> +            desc_addr = desc.next;
> +        }
> +    }
> +
> +    /* Raise IRQ to signal DMA is completed */
> +    s->irq_status |= SD_RISR_DATA_COMPLETE | SD_RISR_SDIO_INTR;
> +
> +    /* Update DMAC bits */
> +    s->dmac_status |= SD_IDST_INT_SUMMARY;
> +
> +    if (is_write) {
> +        s->dmac_status |= SD_IDST_TRANSMIT_IRQ;
> +    } else {
> +        s->dmac_status |= SD_IDST_RECEIVE_IRQ;
> +    }
> +}
...

