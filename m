Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CABC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 21:19:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D84120768
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 21:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwEFO2d/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D84120768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFl1W-0006vn-7v
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 17:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFl0c-00065m-Up
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 17:18:36 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:56017)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFl0Z-0005Rk-N9
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 17:18:34 -0400
Received: by mail-wm1-x343.google.com with SMTP id a65so342217wme.5
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 14:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DNtg6WTqFCuemPs6RAk88ioP+esSDEtazE+v4OEESos=;
 b=IwEFO2d/G5YWZs7MiSrpfYzxztkD15ry3ZPNdQ+1lK/uVWZ9zJkIlXwxDUzws4I6Yu
 aPrHWnzaBNsnApArZCQ2kpuoCQo73J6dNr5jlnC3ai0TbD3gUOYYwpcUxpM/FJKpStn0
 PADwcmNoPRjFnprOBxC4eEmxOPh9t5LxeTAQmoPZb28e2iOWs2BVjVbcYrSNEjyUwuR6
 Sogf8GUEMsHOBDKxajok0+EzVbYZxfYCcRSYFtSk5/xn/wTyocQEQ6G0J1/1ufpYVui/
 VSgufVJ5p+lY5VDYCioaNFPvsfkSFH/d/8JLQovzUR9RNkqQy6S36MuC/2OjOp8tIwNw
 DfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DNtg6WTqFCuemPs6RAk88ioP+esSDEtazE+v4OEESos=;
 b=Gq0dktGjQstqRGmARq8aWABNyT3DbzWTQPHFK1M7sL17x7Ovc1r1LA42xTVrIL8eGv
 3gGVtWM1PXR0TIIPR6sxQzs2YlbTtdlPu42QsWi0W+3oEK9nTaWo5+66dma7WwAligEv
 I+YKPlrvHmfAw/irFVWtLHDnax/wzxY+prF+oubbavib9rhnd1DhQOOtBDKT2w/QrOc6
 Gz+lxs9zPMa7qmfVWrdmCPbdyxQhXirXGIo/ei9kuulQvyEegZkfsAc3NA99sFcZJk2v
 plujGmtX4FMs8PI1dyW2qoJw3vlH4IR5fj487HaOWGYv17y3J8ca8Bx2sVNSDJEMYsCt
 9Yew==
X-Gm-Message-State: AOAM532ZqsNbhCFu4MghDBn+G3aXq+IpYwBUuXHKwCiXhsL7yRp1sw0B
 cnJoDDwN2NqfFWRZdke3dyS9DsONKvI=
X-Google-Smtp-Source: ABdhPJyPDiSF/WCawBoEZ/jQVTkyS5TxQk6+FIIy08YnUMMBhmx2HcKlZ0iixgGclO809woAGA+3cw==
X-Received: by 2002:a7b:c5cf:: with SMTP id n15mr306901wmk.93.1599599909320;
 Tue, 08 Sep 2020 14:18:29 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id q12sm945609wrp.17.2020.09.08.14.18.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2020 14:18:28 -0700 (PDT)
Subject: Re: [PATCH 18/20] hw/rx: Add Tokudenkairo TKDN-RX62N-BRD
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20200827123859.81793-1-ysato@users.sourceforge.jp>
 <20200827123859.81793-19-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <754ceb7c-4da9-bf68-bb44-b343b4f41b67@amsat.org>
Date: Tue, 8 Sep 2020 23:18:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200827123859.81793-19-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-1.626,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/27/20 2:38 PM, Yoshinori Sato wrote:
> Hardware information.
> http://www.tokudenkairo.co.jp/rx62n/
> (Japanese)
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  default-configs/rx-softmmu.mak |   1 +
>  hw/rx/tkdn-rx62n.c             | 192 +++++++++++++++++++++++++++++++++
>  hw/rx/Kconfig                  |   6 ++
>  hw/rx/meson.build              |   1 +
>  4 files changed, 200 insertions(+)
>  create mode 100644 hw/rx/tkdn-rx62n.c
> 
> diff --git a/default-configs/rx-softmmu.mak b/default-configs/rx-softmmu.mak
> index df2b4e4f42..ea8731d67b 100644
> --- a/default-configs/rx-softmmu.mak
> +++ b/default-configs/rx-softmmu.mak
> @@ -1,3 +1,4 @@
>  # Default configuration for rx-softmmu
>  
>  CONFIG_RX_GDBSIM=y
> +CONFIG_TKDN_RX62N=y
> diff --git a/hw/rx/tkdn-rx62n.c b/hw/rx/tkdn-rx62n.c
> new file mode 100644
> index 0000000000..3db0fc8294
> --- /dev/null
> +++ b/hw/rx/tkdn-rx62n.c
> @@ -0,0 +1,192 @@
> +/*
> + * Tokushudenshikairo TKDN-RX62N-BRD
> + *
> + * Copyright (c) 2020 Yoshinori Sato
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/cutils.h"
> +#include "qapi/error.h"
> +#include "qemu-common.h"
> +#include "cpu.h"
> +#include "hw/hw.h"
> +#include "hw/sysbus.h"
> +#include "hw/loader.h"
> +#include "hw/rx/loader.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/rx/rx62n.h"
> +#include "net/net.h"
> +#include "hw/net/mii.h"
> +#include "hw/boards.h"
> +#include "sysemu/sysemu.h"
> +#include "sysemu/qtest.h"
> +#include "sysemu/device_tree.h"
> +
> +typedef struct {
> +    /*< private >*/
> +    MachineState parent_obj;
> +    /*< public >*/
> +    RX62NState mcu;
> +    PHYState phy;
> +    MDIOState mdio;
> +} TKDN_RX62NMachineState;
> +
> +#define TYPE_TKDN_RX62N_MACHINE MACHINE_TYPE_NAME("tkdn-rx62n-brd")
> +
> +#define TKDN_RX62N_MACHINE(obj) \
> +    OBJECT_CHECK(TKDN_RX62NMachineState, (obj), TYPE_TKDN_RX62N_MACHINE)
> +
> +#define TINYBOOT_TOP (0xffffff00)
> +
> +static void set_bootstrap(hwaddr entry, hwaddr dtb)
> +{
> +    /* Minimal hardware initialize for kernel requirement */
> +    /* linux kernel only works little-endian mode */
> +    static uint8_t tinyboot[256] = {
> +        0xfb, 0x2e, 0x20, 0x00, 0x08,       /* mov.l #0x80020, r2 */
> +        0xf8, 0x2e, 0x00, 0x01, 0x01,       /* mov.l #0x00010100, [r2] */
> +        0xfb, 0x2e, 0x10, 0x00, 0x08,       /* mov.l #0x80010, r2 */
> +        0xf8, 0x22, 0xdf, 0x7d, 0xff, 0xff, /* mov.l #0xffff7ddf, [r2] */
> +        0x62, 0x42,                         /* add #4, r2 */
> +        0xf8, 0x22, 0xff, 0x7f, 0xff, 0x7f, /* mov.l #0x7fff7fff, [r2] */
> +        0xfb, 0x2e, 0x40, 0x82, 0x08,       /* mov.l #0x88240, r2 */
> +        0x3c, 0x22, 0x00,                   /* mov.b #0, 2[r2] */
> +        0x3c, 0x21, 0x4e,                   /* mov.b #78, 1[r2] */
> +        0xfb, 0x22, 0x70, 0xff, 0xff, 0xff, /* mov.l #0xffffff70, r2 */
> +        0xec, 0x21,                         /* mov.l [r2], r1 */
> +        0xfb, 0x22, 0x74, 0xff, 0xff, 0xff, /* mov.l #0xffffff74, r2 */
> +        0xec, 0x22,                         /* mov.l [r2], r2 */
> +        0x7f, 0x02,                         /* jmp r2 */
> +    };
> +    int i;
> +
> +    *((uint32_t *)&tinyboot[0x70]) = cpu_to_le32(dtb);

Please use the ld/st API (docs/devel/loads-stores.rst) instead:

       stl_le_p(&tinyboot[0x70], dtb);

> +    *((uint32_t *)&tinyboot[0x74]) = cpu_to_le32(entry);
> +
> +    /* setup exception trap trampoline */
> +    for (i = 0; i < 31; i++) {
> +        *((uint32_t *)&tinyboot[0x80 + i * 4]) = cpu_to_le32(0x10 + i * 4);
> +    }
> +    *((uint32_t *)&tinyboot[0xfc]) = cpu_to_le32(TINYBOOT_TOP);
> +    rom_add_blob_fixed("tinyboot", tinyboot, sizeof(tinyboot), TINYBOOT_TOP);
> +}
> +
> +/* Link 100BaseTX-FD */
> +#define BMSR (MII_BMSR_100TX_FD | MII_BMSR_100TX_HD |                   \
> +              MII_BMSR_10T_FD | MII_BMSR_10T_HD | MII_BMSR_MFPS |       \
> +              MII_BMSR_AN_COMP | MII_BMSR_AUTONEG)
> +#define ANLPAR (MII_ANLPAR_TXFD | MII_ANAR_CSMACD)
> +
> +static void tkdn_rx62n_net_init(MachineState *m, RX62NState *s,
> +                                      NICInfo *nd)
> +{
> +    TKDN_RX62NMachineState *t = TKDN_RX62N_MACHINE(m);
> +    object_initialize_child(OBJECT(t), "ether-phy",
> +                            &t->phy, TYPE_ETHER_PHY);
> +    qdev_prop_set_uint32(DEVICE(&t->phy), "phy-id", 0x0007c0f0); /* LAN8720A */
> +    qdev_prop_set_uint32(DEVICE(&t->phy), "link-out-pol", phy_out_p);
> +    qdev_prop_set_uint16(DEVICE(&t->phy), "bmsr", BMSR);
> +    qdev_prop_set_uint16(DEVICE(&t->phy), "anlpar", ANLPAR);
> +    qdev_realize(DEVICE(&t->phy), NULL, &error_abort);
> +
> +    object_initialize_child(OBJECT(t), "mdio-bb",
> +                            &t->mdio, TYPE_ETHER_MDIO_BB);
> +    object_property_set_link(OBJECT(&t->mdio), "phy",
> +                             OBJECT(&t->phy), &error_abort);
> +    qdev_prop_set_int32(DEVICE(&t->mdio), "address", 0);
> +    qdev_realize(DEVICE(&t->mdio), NULL, &error_abort);
> +}
> +
> +#define SDRAM_BASE 0x08000000
> +
> +static void tkdn_rx62n_init(MachineState *machine)
> +{
> +    MachineClass *mc = MACHINE_GET_CLASS(machine);
> +    TKDN_RX62NMachineState *s = TKDN_RX62N_MACHINE(machine);
> +    RX62NClass *rx62nc;
> +    MemoryRegion *sysmem = get_system_memory();
> +    const char *kernel_filename = machine->kernel_filename;
> +    const char *dtb_filename = machine->dtb;
> +    rx_kernel_info_t kernel_info;
> +
> +    if (machine->ram_size < mc->default_ram_size) {
> +        char *sz = size_to_str(mc->default_ram_size);
> +        error_report("Invalid RAM size, should be more than %s", sz);
> +        g_free(sz);

Missing exit()?

Otherwise patch is good.

> +    }
> +
> +    /* Allocate memory space */
> +    memory_region_add_subregion(sysmem, SDRAM_BASE, machine->ram);
> +
> +    /* Initialize MCU */
> +    object_initialize_child(OBJECT(machine), "mcu",
> +                            &s->mcu, TYPE_R5F562N8_MCU);
> +    rx62nc = RX62N_MCU_GET_CLASS(&s->mcu);
> +    object_property_set_link(OBJECT(&s->mcu), "main-bus", OBJECT(sysmem),
> +                             &error_abort);
> +    object_property_set_uint(OBJECT(&s->mcu), "xtal-frequency-hz",
> +                             12 * 1000 * 1000, &error_abort);
> +    tkdn_rx62n_net_init(machine, &s->mcu, nd_table);
> +    object_property_set_link(OBJECT(&s->mcu), "mdiodev",
> +                             OBJECT(&s->mdio), &error_abort);
> +    /* Load kernel and dtb */
> +    if (kernel_filename) {
> +        kernel_info.ram_start = SDRAM_BASE;
> +        kernel_info.ram_size = machine->ram_size;
> +        kernel_info.filename = kernel_filename;
> +        kernel_info.dtbname = dtb_filename;
> +        kernel_info.cmdline = machine->kernel_cmdline;
> +        if (!load_kernel(&kernel_info)) {
> +            exit(1);
> +        }
> +        set_bootstrap(kernel_info.entry, kernel_info.dtb_address);
> +    } else {
> +        if (bios_name) {
> +            if (!load_bios(bios_name, rx62nc->rom_flash_size, &error_abort)) {
> +                exit(0);
> +            }
> +        } else if (!qtest_enabled()) {
> +            error_report("No bios or kernel specified");
> +            exit(1);
> +        }
> +    }
> +    qdev_realize(DEVICE(&s->mcu), NULL, &error_abort);
> +}
> +
> +static void tkdn_rx62n_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
> +    mc->desc = "TokushuDenshiKairo Inc, TKDN-RX62N-BRD";
> +    mc->init = tkdn_rx62n_init;
> +    mc->is_default = 0;
> +    mc->default_cpu_type = TYPE_RX62N_CPU;
> +    mc->default_ram_size = 16 * MiB;
> +    mc->default_ram_id = "ext-sdram";
> +}
> +
> +static const TypeInfo tkdn_rx62n_type = {
> +    .name = TYPE_TKDN_RX62N_MACHINE,
> +    .parent = TYPE_MACHINE,
> +    .instance_size  = sizeof(TKDN_RX62NMachineState),
> +    .class_init = tkdn_rx62n_class_init,
> +};
> +
> +static void tkdn_rx62n_machine_init(void)
> +{
> +    type_register_static(&tkdn_rx62n_type);
> +}
> +
> +type_init(tkdn_rx62n_machine_init)
> diff --git a/hw/rx/Kconfig b/hw/rx/Kconfig
> index f20ea63fd9..0ef20d0c3c 100644
> --- a/hw/rx/Kconfig
> +++ b/hw/rx/Kconfig
> @@ -11,3 +11,9 @@ config RX_GDBSIM
>      bool
>      select RX62N_MCU
>      select FITLOADER
> +
> +config TKDN_RX62N
> +    bool
> +    select RX62N_MCU
> +    select FITLOADER
> +
> diff --git a/hw/rx/meson.build b/hw/rx/meson.build
> index 3a81d85a53..0a741e091c 100644
> --- a/hw/rx/meson.build
> +++ b/hw/rx/meson.build
> @@ -1,6 +1,7 @@
>  rx_ss = ss.source_set()
>  rx_ss.add(files('loader.c'))
>  rx_ss.add(when: 'CONFIG_RX_GDBSIM', if_true: files('rx-gdbsim.c'))
> +rx_ss.add(when: 'CONFIG_TKDN_RX62N', if_true: files('tkdn-rx62n.c'))
>  rx_ss.add(when: 'CONFIG_RX62N_MCU', if_true: files('rx62n.c', 'rx62n-cpg.c'))
>  
>  hw_arch += {'rx': rx_ss}
> 


