Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FE5C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:55:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C59B820885
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="O2XefHde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C59B820885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Cx9-0003uf-09
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 14:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <figlesia@xilinx.com>)
 id 1k5CwP-0003Ml-Go; Mon, 10 Aug 2020 14:54:37 -0400
Received: from mail-dm6nam10on2088.outbound.protection.outlook.com
 ([40.107.93.88]:51808 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <figlesia@xilinx.com>)
 id 1k5CwL-0007DH-HF; Mon, 10 Aug 2020 14:54:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdaq8+MPoL9ToP0IWL9U60TLz89SXl4denfYYFtPBccsGoBMxWCsmbtzNxJPxMGxdfnWvDky2c53feBgqusAo8kXG03FDfammhY7KKdWULunRk/0q6tHFL7NJNf1YWnfunp7coZ1kvN/xplq8I5H5YNarJh6xeWhRjb7RIDJ4sWd88grXnHWFO+HCBZ/eJ0oAmZXSJpNdvcp3hPmuAiy1B/AT4aj9W5lPwQVZexjrp/ou7VzKjC+yOvnlrd0ETtPSki5RykBIddyBnDoxycNP+yrTyH4hT9xlH20bY0xfupN4cbHT7wSMME+/Lmxti6dl6Qxt662Cv0DNf3W+LHKjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoI4sJQjHThztSJSxKDQrbl8MRq7r4wNfHnrBpGQ3Dw=;
 b=GgaaCUBl8YNO8vsd4nnZ2ULONyXJe7xtWPgGUi05Qo/WLHlRQq1jdNpdtYSU1ZRlgl+PCFCa/YRGNIJaWPCoYBKmAtfcR7VGjBalxnF3gnvo64zOZHzNc0e7tIzT4rEkeleip9UTbHv0JOnjKVxz72NoORVzhkj5u2EMlDzGVRllIthXtC2w6h3AXgOAUCuII5qSCV5p12gDAjwP2khUOATLyQ4xARy/7BXM+a4hv3Dg7jbOeSwHmFRaCf9S2Suz2d5ZBNoNomhWfLHnq63wjj5gyj6jjDkNdIDelAt1goBLtYGWpUAnCL5iOiTaQXIoOkLBUKuf7+7vfcROjCgX9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoI4sJQjHThztSJSxKDQrbl8MRq7r4wNfHnrBpGQ3Dw=;
 b=O2XefHdeA1dWx95gLiqeha+eirNizjb5wszsWzTjD5p9VhPG4ZutxPhC9ExZt05W/PwW/Fue5Jo5eDHIfUr068FCmSkuZAc3JdjH+daiuSqUGu6JFbcAm0vJ8YAMhSsY8bCPJ89fJUREyd7pVqoro+VILPHF6FV4t4kPW9lq5sY=
Received: from MN2PR07CA0018.namprd07.prod.outlook.com (2603:10b6:208:1a0::28)
 by SN6PR02MB4429.namprd02.prod.outlook.com (2603:10b6:805:a9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Mon, 10 Aug
 2020 18:54:29 +0000
Received: from BL2NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:1a0:cafe::b9) by MN2PR07CA0018.outlook.office365.com
 (2603:10b6:208:1a0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15 via Frontend
 Transport; Mon, 10 Aug 2020 18:54:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT035.mail.protection.outlook.com (10.152.77.157) with Microsoft SMTP
 Server id 15.20.3261.19 via Frontend Transport; Mon, 10 Aug 2020 18:54:29
 +0000
Received: from [149.199.38.66] (port=58446 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <francisco.iglesias@xilinx.com>)
 id 1k5CwB-000130-3u; Mon, 10 Aug 2020 11:54:23 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <francisco.iglesias@xilinx.com>)
 id 1k5CwH-0002i1-5l; Mon, 10 Aug 2020 11:54:29 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 07AIsK3R001679; 
 Mon, 10 Aug 2020 11:54:20 -0700
Received: from [10.23.120.191] (helo=debian)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <francisco.iglesias@xilinx.com>)
 id 1k5Cw8-0002hW-A5; Mon, 10 Aug 2020 11:54:20 -0700
Date: Mon, 10 Aug 2020 19:54:18 +0100
From: Francisco Iglesias <francisco.iglesias@xilinx.com>
To: Vikram Garhwal <fnu.vikram@xilinx.com>
Subject: Re: [PATCH v8 2/4] xlnx-zynqmp: Connect Xilinx ZynqMP CAN controllers
Message-ID: <20200810185417.hczwuzgluwrffigv@debian>
References: <1596575505-163040-1-git-send-email-fnu.vikram@xilinx.com>
 <1596575505-163040-3-git-send-email-fnu.vikram@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1596575505-163040-3-git-send-email-fnu.vikram@xilinx.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c4883b9-0920-483f-ba08-08d83d5ecfc9
X-MS-TrafficTypeDiagnostic: SN6PR02MB4429:
X-Microsoft-Antispam-PRVS: <SN6PR02MB4429C057C4FBF2E479562355AD440@SN6PR02MB4429.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:155;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p3T9xvMzCuvFMJqu0r74g7tQQqT1P3nxloT9dtNNbEaEHliWZ1b3v5kf1sxzKvfncUKpPVZ5DB2MuLI5gwhJUYG1iX7K4KKybsYRo4OastfQdKumPJmgWUYA6jj569BeVfdF3pFUdkAx4/6ydRsnxCruYoJufM3+E/fA4CQ4tMkhhRIROeO38BXcGBSSEOaD13ekwUDwBgJIPXPuiuwV8QgkSRUFjh86Mz4Xj1XbyctMFkNkoGq3dpYRoF6NPzbUZtBuMpTUkXniobd8IGWJ6Os/m9UddANGMeFiNXsVSILOJVbraBJVOZ8MqViWCJ6NqZpyA2KJVaNVYnZVOZcUVuuKM6dDiquQwvgf2PSdYl/TwpCDEwbnsCj2IYpQFwcdgAXxdkhG3thdpFIaWCZBng==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(39860400002)(396003)(136003)(376002)(346002)(46966005)(5660300002)(47076004)(9786002)(426003)(186003)(8676002)(82310400002)(478600001)(356005)(82740400003)(6862004)(44832011)(1076003)(2906002)(8936002)(26005)(70586007)(316002)(70206006)(9576002)(3716004)(9686003)(4326008)(54906003)(6636002)(81166007)(336012)(33716001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2020 18:54:29.5169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4883b9-0920-483f-ba08-08d83d5ecfc9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT035.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4429
Received-SPF: pass client-ip=40.107.93.88; envelope-from=figlesia@xilinx.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 14:54:30
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 "open list:Xilinx ZynqMP" <qemu-arm@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 04, 2020 at 02:11:43PM -0700, Vikram Garhwal wrote:
> Connect CAN0 and CAN1 on the ZynqMP.
> 
> Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@xilinx.com>

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

