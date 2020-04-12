Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52C2C2BA2B
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 17:59:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DFF2206DA
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 17:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAfLmzHa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFF2206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNgtD-000287-Qn
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 13:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNgsP-0001Vm-2y
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 13:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNgsN-0004OQ-SJ
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 13:58:37 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40133)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNgsK-0004LJ-SJ; Sun, 12 Apr 2020 13:58:33 -0400
Received: by mail-wr1-x443.google.com with SMTP id s8so8066146wrt.7;
 Sun, 12 Apr 2020 10:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Tqd9AUY7sf7jpL/VRx5RQMosFX++9TLHSqoWaE8MkYM=;
 b=IAfLmzHaacOBypj96+tkxl7WgORE6520jad+vd5aGMzeK2bHIgNwxJ8Rp9NPye6kKZ
 EnbsbrxYE8zWdjWmAOAAjzY73N1Kjz7U73YOuoiJxopzlrF3XZWkG+BQtdSFsdtYPaMl
 0iE2buVvJ1dxShOJKEOFm4rVkcQqjB3DvejcBsL8l0ODPkKY6Tc4w1VNE+F1a/gAkmr/
 v++Oom294D2tMjR+QWAXHGcCYAsJB8ceayEhr0yd+BsYftRKRjjqcOHWijWYhUIrnp++
 evCinTSmclo4XZ9d7wGSgKdMNmQPvRtG4o5Vr98iw//RLa9oFC1R7H+iKUg8TGZFatIc
 zKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Tqd9AUY7sf7jpL/VRx5RQMosFX++9TLHSqoWaE8MkYM=;
 b=juQt+TqTL5DOdS8xiob1cVEXgaZHF4KnvWp6ju7y1U+Mfg2FI518YSFvnsztBHzb46
 BIuxAfFqdudt4iBhewQTIUVKP4DmWUFbHHRjMFVyaheP0FBx2yATGAcHGGuVBPi7xsNb
 aNcy+jwYv1AL/sXu5HbQvqnXwrNp8OXSrboQTeYFOhKOJvXZMCkaqOJxWJI3Aq6uzDxN
 gMubtUq4YD4aqWQm1PTQydlbr/qrwu/Ui26N8SmnqNNVZNXln6P3cReB5mSXIdgyxLj3
 e/psR/Ah6/a9zrILWA+kfhWXm78yNG3Qsih1bo3UiMH9WVkn98O+4kQUD4VeIpyN+//C
 9w8w==
X-Gm-Message-State: AGi0PubSJLWL6g+AukfUkBy1ZZugd8XdTDdwvE6IworcFA5cg59hG6/W
 ZtSClT6pyIGccH5yb55UgI1M/ep2FVo=
X-Google-Smtp-Source: APiQypJ/Wpj7Dy+THc4nlbJnpH7Jr+TZISujKR6MaITnFqihLeHqyGZldqoXlYwugXibxnwS5TrtAw==
X-Received: by 2002:adf:f187:: with SMTP id h7mr15209517wro.331.1586714311059; 
 Sun, 12 Apr 2020 10:58:31 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm11836116wmc.30.2020.04.12.10.58.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2020 10:58:30 -0700 (PDT)
Subject: Re: [Qemu devel PATCH v4 2/3] msf2: Add EMAC block to SmartFusion2 SoC
To: sundeep.lkml@gmail.com, jasowang@redhat.com, peter.maydell@linaro.org,
 philmd@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <1586529926-11441-1-git-send-email-sundeep.lkml@gmail.com>
 <1586529926-11441-3-git-send-email-sundeep.lkml@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <09d13b7c-7a48-4405-fbcd-558e71871ddf@amsat.org>
Date: Sun, 12 Apr 2020 19:58:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1586529926-11441-3-git-send-email-sundeep.lkml@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/10/20 4:45 PM, sundeep.lkml@gmail.com wrote:
> From: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> 
> With SmartFusion2 Ethernet MAC model in
> place this patch adds the same to SoC.
> 
> Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> ---
>  hw/arm/msf2-soc.c         | 21 ++++++++++++++++++++-
>  include/hw/arm/msf2-soc.h |  3 +++
>  2 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
> index 588d643..2f2db6d 100644
> --- a/hw/arm/msf2-soc.c
> +++ b/hw/arm/msf2-soc.c
> @@ -35,6 +35,7 @@

Maybe you also want:

- * Copyright (c) 2017 Subbaraya Sundeep <sundeep.lkml@gmail.com>
+ * Copyright (c) 2017-2020 Subbaraya Sundeep <sundeep.lkml@gmail.com>

>  
>  #define MSF2_TIMER_BASE       0x40004000
>  #define MSF2_SYSREG_BASE      0x40038000
> +#define MSF2_EMAC_BASE        0x40041000
>  
>  #define ENVM_BASE_ADDRESS     0x60000000
>  
> @@ -55,6 +56,7 @@ static const uint32_t uart_addr[MSF2_NUM_UARTS] = { 0x40000000 , 0x40010000 };
>  static const int spi_irq[MSF2_NUM_SPIS] = { 2, 3 };
>  static const int uart_irq[MSF2_NUM_UARTS] = { 10, 11 };
>  static const int timer_irq[MSF2_NUM_TIMERS] = { 14, 15 };
> +static const int emac_irq[MSF2_NUM_EMACS] = { 12 };

Correct.

>  
>  static void do_sys_reset(void *opaque, int n, int level)
>  {
> @@ -81,6 +83,13 @@ static void m2sxxx_soc_initfn(Object *obj)
>          sysbus_init_child_obj(obj, "spi[*]", &s->spi[i], sizeof(s->spi[i]),
>                            TYPE_MSS_SPI);
>      }
> +
> +    sysbus_init_child_obj(obj, "eth", &s->emac, sizeof(s->emac),

"eth" -> "tsemac" (or "emac")?

> +                          TYPE_MSS_EMAC);
> +    if (nd_table[0].used) {
> +        qemu_check_nic_model(&nd_table[0], TYPE_MSS_EMAC);
> +        qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
> +    }
>  }
>  
>  static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
> @@ -192,6 +201,17 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
>          g_free(bus_name);
>      }
>  
> +    dev = DEVICE(&s->emac);

Can you pass the DMA memory via a link property please?

       object_property_set_link(OBJECT(&s->emac),
                                OBJECT(get_system_memory()),
                                "ahb-bus", &error_abort);

> +    object_property_set_bool(OBJECT(&s->emac), true, "realized", &err);
> +    if (err != NULL) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    busdev = SYS_BUS_DEVICE(dev);
> +    sysbus_mmio_map(busdev, 0, MSF2_EMAC_BASE);
> +    sysbus_connect_irq(busdev, 0,
> +                           qdev_get_gpio_in(armv7m, emac_irq[0]));

Indentation is off.

> +
>      /* Below devices are not modelled yet. */
>      create_unimplemented_device("i2c_0", 0x40002000, 0x1000);
>      create_unimplemented_device("dma", 0x40003000, 0x1000);
> @@ -202,7 +222,6 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
>      create_unimplemented_device("can", 0x40015000, 0x1000);
>      create_unimplemented_device("rtc", 0x40017000, 0x1000);
>      create_unimplemented_device("apb_config", 0x40020000, 0x10000);
> -    create_unimplemented_device("emac", 0x40041000, 0x1000);
>      create_unimplemented_device("usb", 0x40043000, 0x1000);
>  }
>  
> diff --git a/include/hw/arm/msf2-soc.h b/include/hw/arm/msf2-soc.h
> index 3cfe5c7..296ed03 100644
> --- a/include/hw/arm/msf2-soc.h
> +++ b/include/hw/arm/msf2-soc.h
> @@ -29,12 +29,14 @@
>  #include "hw/timer/mss-timer.h"
>  #include "hw/misc/msf2-sysreg.h"
>  #include "hw/ssi/mss-spi.h"
> +#include "hw/net/msf2-emac.h"
>  
>  #define TYPE_MSF2_SOC     "msf2-soc"
>  #define MSF2_SOC(obj)     OBJECT_CHECK(MSF2State, (obj), TYPE_MSF2_SOC)
>  
>  #define MSF2_NUM_SPIS         2
>  #define MSF2_NUM_UARTS        2
> +#define MSF2_NUM_EMACS        1
>  
>  /*
>   * System timer consists of two programmable 32-bit
> @@ -62,6 +64,7 @@ typedef struct MSF2State {
>      MSF2SysregState sysreg;
>      MSSTimerState timer;
>      MSSSpiState spi[MSF2_NUM_SPIS];
> +    MSF2EmacState emac;

You used 'emac_irq[MSF2_NUM_EMACS]', either use emac[MSF2_NUM_EMACS]
here or drop MSF2_NUM_EMACS?

>  } MSF2State;
>  
>  #endif
>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

