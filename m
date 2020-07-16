Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90CAC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 13:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76DAA207DD
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 13:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mS+bEVjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76DAA207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw464-0002gN-LF
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 09:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jw45P-0002B6-Hc; Thu, 16 Jul 2020 09:38:07 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37595)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jw45N-0005IE-Uw; Thu, 16 Jul 2020 09:38:07 -0400
Received: by mail-wr1-x441.google.com with SMTP id a6so7117680wrm.4;
 Thu, 16 Jul 2020 06:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kpchH1Ymxb7KdPCSvmu92LHERYgYPs9pq4bs9hihZrg=;
 b=mS+bEVjmN+X5rISH59bOljcw7xb7iqIGNgrx9FQdy8J9GYbr0K49tdty4JTq/0bJkM
 GdKI+f6jkaWIn3nHXOws4O28tnuu4hpb8yI3gqBiHvNPYxIe/48xaUx7ea34zGudCThi
 vDVwO4vrDSYcVRi6RCaBrh2vGWNzhJAAd/28kUpBANbSiVhDgf+1oMm/oWuIX4W4YOk6
 c73+QMLvhXiqmMrNDGPVXdoRJ4yV7UN7/EB12NebRiJIH3x87zBpZPRZ8ep8UW7cu6DA
 QCAep9a9BPD4DCEvjIhmSsmggs0Z1xGyzr+ZrCgnaNvsKspIpnvxciFlzAOZQIYg5UBK
 KhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kpchH1Ymxb7KdPCSvmu92LHERYgYPs9pq4bs9hihZrg=;
 b=GIQt2rc+7YbkADjbt3eJreb47qGL/snv/5k+Rrz1zzz20yHBN3TOCY5PtZ4VXmAaw6
 w/CaXNIfyKuUb+Wp29h+Zy2BRgqgWiRStjpnVzWXr0Edz7qxZCgmf68hU9acZznGom9b
 9UgLIiXDem1OyYAG3YEGJWmNkBDHiMVwFFFEAm9I5y1nezHpBSvs2pJxpLEczbx30evb
 MrrWWzQvxLJJmPO1wL/8GuVF3t85ND0DqxJrkwfG3BM6AF2SR85OiIosZsXd8kMQ1lJi
 BXcgd8MoUjTmH5lUu7zmKMlA+A5HOnj7SuujrZAn4Y0BTlLbP178zNSo7ebaSai3eBGZ
 FUoQ==
X-Gm-Message-State: AOAM5319QCe0wU9SAPJ3mb6LPYtNzL5dKcEmKjafTDWG2ZxAv83mtqPb
 h9kIE4khqQTIEjtc3yx11ig=
X-Google-Smtp-Source: ABdhPJxxkvC7HpIIvV2DW3hKXwk1yp4Ew5I8mEjWSwCojGpRAIpbU7hcUUkTUjjIdMsKPMXNrAokWg==
X-Received: by 2002:adf:ff87:: with SMTP id j7mr5461505wrr.128.1594906683318; 
 Thu, 16 Jul 2020 06:38:03 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id g144sm4889336wme.2.2020.07.16.06.38.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2020 06:38:02 -0700 (PDT)
Subject: Re: [PATCH v8 08/18] hw/arm/allwinner: add SD/MMC host controller
To: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-devel@nongnu.org
References: <20200311221854.30370-1-nieklinnenbank@gmail.com>
 <20200311221854.30370-9-nieklinnenbank@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fb2469a5-6146-de4e-b07a-1c95e8d7e7c0@amsat.org>
Date: Thu, 16 Jul 2020 15:38:01 +0200
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

> +static uint64_t allwinner_sdhost_read(void *opaque, hwaddr offset,
> +                                      unsigned size)
> +{
> +    AwSdHostState *s = AW_SDHOST(opaque);
> +    uint32_t res = 0;
> +
> +    switch (offset) {
...

> +    case REG_SD_FIFO:      /* Read/Write FIFO */
> +        if (sdbus_data_ready(&s->sdbus)) {
> +            res = sdbus_read_data(&s->sdbus);
> +            res |= sdbus_read_data(&s->sdbus) << 8;
> +            res |= sdbus_read_data(&s->sdbus) << 16;
> +            res |= sdbus_read_data(&s->sdbus) << 24;

Also I'm a bit confused by the endianess here. Does the FIFO
uses a particular endianess?

> +            allwinner_sdhost_update_transfer_cnt(s, sizeof(uint32_t));
> +            allwinner_sdhost_auto_stop(s);
> +            allwinner_sdhost_update_irq(s);
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: no data ready on SD bus\n",
> +                          __func__);
> +        }
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset %"
> +                      HWADDR_PRIx"\n", __func__, offset);
> +        res = 0;
> +        break;
> +    }
> +
> +    trace_allwinner_sdhost_read(offset, res, size);
> +    return res;
> +}
> +
> +static void allwinner_sdhost_write(void *opaque, hwaddr offset,
> +                                   uint64_t value, unsigned size)
> +{
> +    AwSdHostState *s = AW_SDHOST(opaque);
> +
> +    trace_allwinner_sdhost_write(offset, value, size);
> +
> +    switch (offset) {
...

> +    case REG_SD_FIFO:      /* Read/Write FIFO */
> +        sdbus_write_data(&s->sdbus, value & 0xff);
> +        sdbus_write_data(&s->sdbus, (value >> 8) & 0xff);
> +        sdbus_write_data(&s->sdbus, (value >> 16) & 0xff);
> +        sdbus_write_data(&s->sdbus, (value >> 24) & 0xff);
> +        allwinner_sdhost_update_transfer_cnt(s, sizeof(uint32_t));
> +        allwinner_sdhost_auto_stop(s);
> +        allwinner_sdhost_update_irq(s);
> +        break;
> +    case REG_SD_RES_CRC:   /* Response CRC from card/eMMC */
> +    case REG_SD_DATA7_CRC: /* CRC Data 7 from card/eMMC */
> +    case REG_SD_DATA6_CRC: /* CRC Data 6 from card/eMMC */
> +    case REG_SD_DATA5_CRC: /* CRC Data 5 from card/eMMC */
> +    case REG_SD_DATA4_CRC: /* CRC Data 4 from card/eMMC */
> +    case REG_SD_DATA3_CRC: /* CRC Data 3 from card/eMMC */
> +    case REG_SD_DATA2_CRC: /* CRC Data 2 from card/eMMC */
> +    case REG_SD_DATA1_CRC: /* CRC Data 1 from card/eMMC */
> +    case REG_SD_DATA0_CRC: /* CRC Data 0 from card/eMMC */
> +    case REG_SD_CRC_STA:   /* CRC status from card/eMMC in write operation */
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset %"
> +                      HWADDR_PRIx"\n", __func__, offset);
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps allwinner_sdhost_ops = {
> +    .read = allwinner_sdhost_read,
> +    .write = allwinner_sdhost_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,

Maybe this device is little endian only?

> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +    .impl.min_access_size = 4,
> +};

