Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CC4C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 14:34:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F58D20771
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 14:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dB7V2D8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F58D20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k58sC-0006q3-Gj
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 10:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1k58rH-0006JQ-2u; Mon, 10 Aug 2020 10:33:03 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:36419)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1k58rF-0000Fk-Do; Mon, 10 Aug 2020 10:33:02 -0400
Received: by mail-lj1-x242.google.com with SMTP id t23so9829675ljc.3;
 Mon, 10 Aug 2020 07:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=AQy5INVxtOXiNwI3ldrbpCbVxXaG2Xs0h1i3hzH8jHo=;
 b=dB7V2D8FH8PsJYXqI1zJx+0ymO+TkwW3kEwjmmQQIQPBSpX3WhSuApviryWhMySB6v
 EBUZ9wOqx/PcfhdzmyOVCIdAWhYKbWB6iKND8DAD4Bw9uWkEWBON7E3Ibx/De29oT60C
 7JSjxvm55G5NkYW7yQwSli+pded009QfhyLCTmhWAPfLzxYjCw3Mq6ID50TOX6LJxCUQ
 M5drww2f6HSU5I3P85wtal+5zpkBSGkafnjky9liHf0U0URXwWv20b7wZa/ob+vyHsum
 C+kEmvKDb37MyHt82r5OwEMMfEUZw30m79tSP73ztNIJZU2Tx3iWJHHr5PN/fV/AnpF5
 yZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AQy5INVxtOXiNwI3ldrbpCbVxXaG2Xs0h1i3hzH8jHo=;
 b=czSa49uGsu9kfUSl7NkLttAiApP1dfBPBLLN4Cclljmmkc6fqc4uavvdkc3Hey9kdh
 EFNA+7bb/CmftTDN2v0VzDS8S0i5jdP39rx29V6oun900knsVe2JgA7QODu/ueYnDg6d
 T6adBdOySNUk0agMziXmHe8gcS/T4GAg45SMQyeSXhBF9P1xBCIXM0qfFKaKymGOV25/
 P/tCuCWB5DrIRf7732Pk+w2MNxT5ow502aDKk1ywcmGFJohLYQQj4IIGyb9rzvbQ2IqR
 +QoILmpjRGowV5psptTPnh7ZKErtCkRQ1QXQRyvyytCVS3+DknXSV29SMeuHHX0Bdo9T
 67nw==
X-Gm-Message-State: AOAM532xZ4z1p0/uqJ9zy0hvQhWB2E5jmM4JbSi2B0pWlFirc29bsH4G
 Hjxh9xyvAk2l+NCM3eIl9pl8LYVi500=
X-Google-Smtp-Source: ABdhPJzmIX0EatZnhdNc6cYHJTSRTe9yv2Quey4y2rBmBCmygpN+cjsH8QSBmXQXGnqbRatrM1RPtA==
X-Received: by 2002:a2e:95c3:: with SMTP id y3mr812076ljh.224.1597069976751;
 Mon, 10 Aug 2020 07:32:56 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id o2sm10700992lfi.50.2020.08.10.07.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 07:32:55 -0700 (PDT)
Date: Mon, 10 Aug 2020 16:32:55 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Vikram Garhwal <fnu.vikram@xilinx.com>
Subject: Re: [PATCH v8 2/4] xlnx-zynqmp: Connect Xilinx ZynqMP CAN controllers
Message-ID: <20200810143255.GB2954729@toto>
References: <1596575505-163040-1-git-send-email-fnu.vikram@xilinx.com>
 <1596575505-163040-3-git-send-email-fnu.vikram@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596575505-163040-3-git-send-email-fnu.vikram@xilinx.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: francisco.iglesias@xilinx.com, Alistair Francis <alistair@alistair23.me>,
 qemu-devel@nongnu.org, "open list:Xilinx ZynqMP" <qemu-arm@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 04, 2020 at 02:11:43PM -0700, Vikram Garhwal wrote:
> Connect CAN0 and CAN1 on the ZynqMP.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> 
> Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
> ---
>  hw/arm/xlnx-zcu102.c         | 20 ++++++++++++++++++++
>  hw/arm/xlnx-zynqmp.c         | 34 ++++++++++++++++++++++++++++++++++
>  include/hw/arm/xlnx-zynqmp.h |  8 ++++++++
>  3 files changed, 62 insertions(+)
> 
> diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
> index 5997262..c3e3420 100644
> --- a/hw/arm/xlnx-zcu102.c
> +++ b/hw/arm/xlnx-zcu102.c
> @@ -24,6 +24,7 @@
>  #include "qemu/log.h"
>  #include "sysemu/qtest.h"
>  #include "sysemu/device_tree.h"
> +#include "net/can_emu.h"
>  
>  typedef struct XlnxZCU102 {
>      MachineState parent_obj;
> @@ -33,6 +34,8 @@ typedef struct XlnxZCU102 {
>      bool secure;
>      bool virt;
>  
> +    CanBusState *canbus[XLNX_ZYNQMP_NUM_CAN];
> +
>      struct arm_boot_info binfo;
>  } XlnxZCU102;
>  
> @@ -125,6 +128,14 @@ static void xlnx_zcu102_init(MachineState *machine)
>      object_property_set_bool(OBJECT(&s->soc), "virtualization", s->virt,
>                               &error_fatal);
>  
> +    for (i = 0; i < XLNX_ZYNQMP_NUM_CAN; i++) {
> +        gchar *bus_name = g_strdup_printf("canbus%d", i);
> +
> +        object_property_set_link(OBJECT(&s->soc), bus_name,
> +                                 OBJECT(s->canbus[i]), &error_fatal);
> +        g_free(bus_name);
> +    }
> +
>      qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
>  
>      /* Create and plug in the SD cards */
> @@ -220,6 +231,15 @@ static void xlnx_zcu102_machine_instance_init(Object *obj)
>                                      "Set on/off to enable/disable emulating a "
>                                      "guest CPU which implements the ARM "
>                                      "Virtualization Extensions");
> +    object_property_add_link(obj, "xlnx-zcu102.canbus0", TYPE_CAN_BUS,
> +                             (Object **)&s->canbus[0],
> +                             object_property_allow_set_link,
> +                             0);
> +
> +    object_property_add_link(obj, "xlnx-zcu102.canbus1", TYPE_CAN_BUS,
> +                             (Object **)&s->canbus[1],
> +                             object_property_allow_set_link,
> +                             0);
>  }
>  
>  static void xlnx_zcu102_machine_class_init(ObjectClass *oc, void *data)
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index c435b9d..adad3e7 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -81,6 +81,14 @@ static const int uart_intr[XLNX_ZYNQMP_NUM_UARTS] = {
>      21, 22,
>  };
>  
> +static const uint64_t can_addr[XLNX_ZYNQMP_NUM_CAN] = {
> +    0xFF060000, 0xFF070000,
> +};
> +
> +static const int can_intr[XLNX_ZYNQMP_NUM_CAN] = {
> +    23, 24,
> +};
> +
>  static const uint64_t sdhci_addr[XLNX_ZYNQMP_NUM_SDHCI] = {
>      0xFF160000, 0xFF170000,
>  };
> @@ -243,6 +251,11 @@ static void xlnx_zynqmp_init(Object *obj)
>                                  TYPE_CADENCE_UART);
>      }
>  
> +    for (i = 0; i < XLNX_ZYNQMP_NUM_CAN; i++) {
> +        object_initialize_child(obj, "can[*]", &s->can[i],
> +                                TYPE_XLNX_ZYNQMP_CAN);
> +    }
> +
>      object_initialize_child(obj, "sata", &s->sata, TYPE_SYSBUS_AHCI);
>  
>      for (i = 0; i < XLNX_ZYNQMP_NUM_SDHCI; i++) {
> @@ -480,6 +493,23 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>                             gic_spi[uart_intr[i]]);
>      }
>  
> +    for (i = 0; i < XLNX_ZYNQMP_NUM_CAN; i++) {
> +        object_property_set_int(OBJECT(&s->can[i]), "ext_clk_freq",
> +                                XLNX_ZYNQMP_CAN_REF_CLK, &error_abort);
> +
> +        object_property_set_link(OBJECT(&s->can[i]), "canbus",
> +                                 OBJECT(s->canbus[i]), &error_fatal);
> +
> +        sysbus_realize(SYS_BUS_DEVICE(&s->can[i]), &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->can[i]), 0, can_addr[i]);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->can[i]), 0,
> +                           gic_spi[can_intr[i]]);
> +    }
> +
>      object_property_set_int(OBJECT(&s->sata), "num-ports", SATA_NUM_PORTS,
>                              &error_abort);
>      if (!sysbus_realize(SYS_BUS_DEVICE(&s->sata), errp)) {
> @@ -617,6 +647,10 @@ static Property xlnx_zynqmp_props[] = {
>      DEFINE_PROP_BOOL("has_rpu", XlnxZynqMPState, has_rpu, false),
>      DEFINE_PROP_LINK("ddr-ram", XlnxZynqMPState, ddr_ram, TYPE_MEMORY_REGION,
>                       MemoryRegion *),
> +    DEFINE_PROP_LINK("canbus0", XlnxZynqMPState, canbus[0], TYPE_CAN_BUS,
> +                     CanBusState *),
> +    DEFINE_PROP_LINK("canbus1", XlnxZynqMPState, canbus[1], TYPE_CAN_BUS,
> +                     CanBusState *),
>      DEFINE_PROP_END_OF_LIST()
>  };
>  
> diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
> index 53076fa..8cada69 100644
> --- a/include/hw/arm/xlnx-zynqmp.h
> +++ b/include/hw/arm/xlnx-zynqmp.h
> @@ -22,6 +22,7 @@
>  #include "hw/intc/arm_gic.h"
>  #include "hw/net/cadence_gem.h"
>  #include "hw/char/cadence_uart.h"
> +#include "hw/net/xlnx-zynqmp-can.h"
>  #include "hw/ide/ahci.h"
>  #include "hw/sd/sdhci.h"
>  #include "hw/ssi/xilinx_spips.h"
> @@ -32,6 +33,7 @@
>  #include "hw/rtc/xlnx-zynqmp-rtc.h"
>  #include "hw/cpu/cluster.h"
>  #include "target/arm/cpu.h"
> +#include "net/can_emu.h"
>  
>  #define TYPE_XLNX_ZYNQMP "xlnx,zynqmp"
>  #define XLNX_ZYNQMP(obj) OBJECT_CHECK(XlnxZynqMPState, (obj), \
> @@ -41,6 +43,8 @@
>  #define XLNX_ZYNQMP_NUM_RPU_CPUS 2
>  #define XLNX_ZYNQMP_NUM_GEMS 4
>  #define XLNX_ZYNQMP_NUM_UARTS 2
> +#define XLNX_ZYNQMP_NUM_CAN 2
> +#define XLNX_ZYNQMP_CAN_REF_CLK (24 * 1000 * 1000)
>  #define XLNX_ZYNQMP_NUM_SDHCI 2
>  #define XLNX_ZYNQMP_NUM_SPIS 2
>  #define XLNX_ZYNQMP_NUM_GDMA_CH 8
> @@ -92,6 +96,7 @@ typedef struct XlnxZynqMPState {
>  
>      CadenceGEMState gem[XLNX_ZYNQMP_NUM_GEMS];
>      CadenceUARTState uart[XLNX_ZYNQMP_NUM_UARTS];
> +    XlnxZynqMPCANState can[XLNX_ZYNQMP_NUM_CAN];
>      SysbusAHCIState sata;
>      SDHCIState sdhci[XLNX_ZYNQMP_NUM_SDHCI];
>      XilinxSPIPS spi[XLNX_ZYNQMP_NUM_SPIS];
> @@ -112,6 +117,9 @@ typedef struct XlnxZynqMPState {
>      bool virt;
>      /* Has the RPU subsystem?  */
>      bool has_rpu;
> +
> +    /* CAN bus. */
> +    CanBusState *canbus[XLNX_ZYNQMP_NUM_CAN];
>  }  XlnxZynqMPState;
>  
>  #endif
> -- 
> 2.7.4
> 

