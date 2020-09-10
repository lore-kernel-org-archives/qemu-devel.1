Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEA9C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:26:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21EBF207DE
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21EBF207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGSDY-0000q4-5B
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 15:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kGSCi-00005m-Qd; Thu, 10 Sep 2020 15:25:56 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:32825)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kGSCg-0005h3-BJ; Thu, 10 Sep 2020 15:25:56 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.35])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 1B47359BDFDA;
 Thu, 10 Sep 2020 21:25:42 +0200 (CEST)
Received: from kaod.org (37.59.142.95) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 10 Sep
 2020 21:25:40 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G001c7ff4359-2a02-48c5-be83-c4d2a64ddcce,
 8FE11AEDAF16247B821E16C08928A26F58BE1972) smtp.auth=clg@kaod.org
Subject: Re: [PATCH 1/6] hw/ssi/aspeed_smc: Rename max_slaves as max_devices
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 <qemu-devel@nongnu.org>
References: <20200910070131.435543-1-philmd@redhat.com>
 <20200910070131.435543-2-philmd@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6ed7ad28-107a-65a2-489d-1cd15cd372dd@kaod.org>
Date: Thu, 10 Sep 2020 21:25:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200910070131.435543-2-philmd@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.95]
X-ClientProxiedBy: DAG9EX1.mxp5.local (172.16.2.81) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: e9a3d5e1-decd-4ded-bacf-ec1395775ed2
X-Ovh-Tracer-Id: 9058427701944224528
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudehjedgudefudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeejkeduueduveelgeduueegkeelffevledujeetffeivdelvdfgkeeufeduheehfeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehphhhilhhmugesrhgvughhrghtrdgtohhm
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 15:25:43
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.576,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 Jason Wang <jasowang@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-trivial@nongnu.org, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/10/20 9:01 AM, Philippe Mathieu-Daudé wrote:
> In order to use inclusive terminology, rename max_slaves
> as max_devices.>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Cédric Le Goater <clg@kaod.org>




> ---
>  include/hw/ssi/aspeed_smc.h |  2 +-
>  hw/ssi/aspeed_smc.c         | 40 ++++++++++++++++++-------------------
>  2 files changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
> index 6fbbb238f15..52ae34e38d1 100644
> --- a/include/hw/ssi/aspeed_smc.h
> +++ b/include/hw/ssi/aspeed_smc.h
> @@ -42,7 +42,7 @@ typedef struct AspeedSMCController {
>      uint8_t r_timings;
>      uint8_t nregs_timings;
>      uint8_t conf_enable_w0;
> -    uint8_t max_slaves;
> +    uint8_t max_devices;
>      const AspeedSegments *segments;
>      hwaddr flash_window_base;
>      uint32_t flash_window_size;
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index 795784e5f36..8219272016c 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -259,7 +259,7 @@ static const AspeedSMCController controllers[] = {
>          .r_timings         = R_TIMINGS,
>          .nregs_timings     = 1,
>          .conf_enable_w0    = CONF_ENABLE_W0,
> -        .max_slaves        = 1,
> +        .max_devices       = 1,
>          .segments          = aspeed_segments_legacy,
>          .flash_window_base = ASPEED_SOC_SMC_FLASH_BASE,
>          .flash_window_size = 0x6000000,
> @@ -275,7 +275,7 @@ static const AspeedSMCController controllers[] = {
>          .r_timings         = R_TIMINGS,
>          .nregs_timings     = 1,
>          .conf_enable_w0    = CONF_ENABLE_W0,
> -        .max_slaves        = 5,
> +        .max_devices       = 5,
>          .segments          = aspeed_segments_fmc,
>          .flash_window_base = ASPEED_SOC_FMC_FLASH_BASE,
>          .flash_window_size = 0x10000000,
> @@ -293,7 +293,7 @@ static const AspeedSMCController controllers[] = {
>          .r_timings         = R_SPI_TIMINGS,
>          .nregs_timings     = 1,
>          .conf_enable_w0    = SPI_CONF_ENABLE_W0,
> -        .max_slaves        = 1,
> +        .max_devices       = 1,
>          .segments          = aspeed_segments_spi,
>          .flash_window_base = ASPEED_SOC_SPI_FLASH_BASE,
>          .flash_window_size = 0x10000000,
> @@ -309,7 +309,7 @@ static const AspeedSMCController controllers[] = {
>          .r_timings         = R_TIMINGS,
>          .nregs_timings     = 1,
>          .conf_enable_w0    = CONF_ENABLE_W0,
> -        .max_slaves        = 3,
> +        .max_devices       = 3,
>          .segments          = aspeed_segments_ast2500_fmc,
>          .flash_window_base = ASPEED_SOC_FMC_FLASH_BASE,
>          .flash_window_size = 0x10000000,
> @@ -327,7 +327,7 @@ static const AspeedSMCController controllers[] = {
>          .r_timings         = R_TIMINGS,
>          .nregs_timings     = 1,
>          .conf_enable_w0    = CONF_ENABLE_W0,
> -        .max_slaves        = 2,
> +        .max_devices       = 2,
>          .segments          = aspeed_segments_ast2500_spi1,
>          .flash_window_base = ASPEED_SOC_SPI_FLASH_BASE,
>          .flash_window_size = 0x8000000,
> @@ -343,7 +343,7 @@ static const AspeedSMCController controllers[] = {
>          .r_timings         = R_TIMINGS,
>          .nregs_timings     = 1,
>          .conf_enable_w0    = CONF_ENABLE_W0,
> -        .max_slaves        = 2,
> +        .max_devices       = 2,
>          .segments          = aspeed_segments_ast2500_spi2,
>          .flash_window_base = ASPEED_SOC_SPI2_FLASH_BASE,
>          .flash_window_size = 0x8000000,
> @@ -359,7 +359,7 @@ static const AspeedSMCController controllers[] = {
>          .r_timings         = R_TIMINGS,
>          .nregs_timings     = 1,
>          .conf_enable_w0    = CONF_ENABLE_W0,
> -        .max_slaves        = 3,
> +        .max_devices       = 3,
>          .segments          = aspeed_segments_ast2600_fmc,
>          .flash_window_base = ASPEED26_SOC_FMC_FLASH_BASE,
>          .flash_window_size = 0x10000000,
> @@ -377,7 +377,7 @@ static const AspeedSMCController controllers[] = {
>          .r_timings         = R_TIMINGS,
>          .nregs_timings     = 2,
>          .conf_enable_w0    = CONF_ENABLE_W0,
> -        .max_slaves        = 2,
> +        .max_devices       = 2,
>          .segments          = aspeed_segments_ast2600_spi1,
>          .flash_window_base = ASPEED26_SOC_SPI_FLASH_BASE,
>          .flash_window_size = 0x10000000,
> @@ -395,7 +395,7 @@ static const AspeedSMCController controllers[] = {
>          .r_timings         = R_TIMINGS,
>          .nregs_timings     = 3,
>          .conf_enable_w0    = CONF_ENABLE_W0,
> -        .max_slaves        = 3,
> +        .max_devices       = 3,
>          .segments          = aspeed_segments_ast2600_spi2,
>          .flash_window_base = ASPEED26_SOC_SPI2_FLASH_BASE,
>          .flash_window_size = 0x10000000,
> @@ -476,7 +476,7 @@ static bool aspeed_smc_flash_overlap(const AspeedSMCState *s,
>      AspeedSegments seg;
>      int i;
>  
> -    for (i = 0; i < s->ctrl->max_slaves; i++) {
> +    for (i = 0; i < s->ctrl->max_devices; i++) {
>          if (i == cs) {
>              continue;
>          }
> @@ -537,7 +537,7 @@ static void aspeed_smc_flash_set_segment(AspeedSMCState *s, int cs,
>       */
>      if ((s->ctrl->segments == aspeed_segments_ast2500_spi1 ||
>           s->ctrl->segments == aspeed_segments_ast2500_spi2) &&
> -        cs == s->ctrl->max_slaves &&
> +        cs == s->ctrl->max_devices &&
>          seg.addr + seg.size != s->ctrl->segments[cs].addr +
>          s->ctrl->segments[cs].size) {
>          qemu_log_mask(LOG_GUEST_ERROR,
> @@ -948,7 +948,7 @@ static void aspeed_smc_reset(DeviceState *d)
>      }
>  
>      /* setup the default segment register values and regions for all */
> -    for (i = 0; i < s->ctrl->max_slaves; ++i) {
> +    for (i = 0; i < s->ctrl->max_devices; ++i) {
>          aspeed_smc_flash_set_segment_region(s, i,
>                      s->ctrl->segment_to_reg(s, &s->ctrl->segments[i]));
>      }
> @@ -995,8 +995,8 @@ static uint64_t aspeed_smc_read(void *opaque, hwaddr addr, unsigned int size)
>          (s->ctrl->has_dma && addr == R_DMA_DRAM_ADDR) ||
>          (s->ctrl->has_dma && addr == R_DMA_LEN) ||
>          (s->ctrl->has_dma && addr == R_DMA_CHECKSUM) ||
> -        (addr >= R_SEG_ADDR0 && addr < R_SEG_ADDR0 + s->ctrl->max_slaves) ||
> -        (addr >= s->r_ctrl0 && addr < s->r_ctrl0 + s->ctrl->max_slaves)) {
> +        (addr >= R_SEG_ADDR0 && addr < R_SEG_ADDR0 + s->ctrl->max_devices) ||
> +        (addr >= s->r_ctrl0 && addr < s->r_ctrl0 + s->ctrl->max_devices)) {
>  
>          trace_aspeed_smc_read(addr, size, s->regs[addr]);
>  
> @@ -1270,7 +1270,7 @@ static void aspeed_smc_write(void *opaque, hwaddr addr, uint64_t data,
>          int cs = addr - s->r_ctrl0;
>          aspeed_smc_flash_update_ctrl(&s->flashes[cs], value);
>      } else if (addr >= R_SEG_ADDR0 &&
> -               addr < R_SEG_ADDR0 + s->ctrl->max_slaves) {
> +               addr < R_SEG_ADDR0 + s->ctrl->max_devices) {
>          int cs = addr - R_SEG_ADDR0;
>  
>          if (value != s->regs[R_SEG_ADDR0 + cs]) {
> @@ -1341,10 +1341,10 @@ static void aspeed_smc_realize(DeviceState *dev, Error **errp)
>      s->conf_enable_w0 = s->ctrl->conf_enable_w0;
>  
>      /* Enforce some real HW limits */
> -    if (s->num_cs > s->ctrl->max_slaves) {
> +    if (s->num_cs > s->ctrl->max_devices) {
>          qemu_log_mask(LOG_GUEST_ERROR, "%s: num_cs cannot exceed: %d\n",
> -                      __func__, s->ctrl->max_slaves);
> -        s->num_cs = s->ctrl->max_slaves;
> +                      __func__, s->ctrl->max_devices);
> +        s->num_cs = s->ctrl->max_devices;
>      }
>  
>      /* DMA irq. Keep it first for the initialization in the SoC */
> @@ -1376,7 +1376,7 @@ static void aspeed_smc_realize(DeviceState *dev, Error **errp)
>                            s->ctrl->flash_window_size);
>      sysbus_init_mmio(sbd, &s->mmio_flash);
>  
> -    s->flashes = g_new0(AspeedSMCFlash, s->ctrl->max_slaves);
> +    s->flashes = g_new0(AspeedSMCFlash, s->ctrl->max_devices);
>  
>      /*
>       * Let's create a sub memory region for each possible slave. All
> @@ -1385,7 +1385,7 @@ static void aspeed_smc_realize(DeviceState *dev, Error **errp)
>       * module behind to handle the memory accesses. This depends on
>       * the board configuration.
>       */
> -    for (i = 0; i < s->ctrl->max_slaves; ++i) {
> +    for (i = 0; i < s->ctrl->max_devices; ++i) {
>          AspeedSMCFlash *fl = &s->flashes[i];
>  
>          snprintf(name, sizeof(name), "%s.%d", s->ctrl->name, i);
> 


