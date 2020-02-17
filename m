Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0828BC34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:49:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C150A20679
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C150A20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3idy-0002yb-VW
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 10:49:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1j3idA-0002Iq-Kb
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:48:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1j3id9-0003LY-48
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:48:20 -0500
Received: from 1.mo177.mail-out.ovh.net ([178.33.107.143]:39406)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1j3id8-0003Ks-Ty
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:48:19 -0500
Received: from player771.ha.ovh.net (unknown [10.108.42.119])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id AE1E3122C2E
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 16:48:16 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player771.ha.ovh.net (Postfix) with ESMTPSA id BA131F8A6E35;
 Mon, 17 Feb 2020 15:47:57 +0000 (UTC)
Subject: Re: [PATCH v2 1/4] m25p80: Convert to support tracing
To: Guenter Roeck <linux@roeck-us.net>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>
References: <20200206183219.3756-1-linux@roeck-us.net>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <488b3355-4467-e01e-d6a0-a2d5bc959428@kaod.org>
Date: Mon, 17 Feb 2020 16:47:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206183219.3756-1-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 13096467718066768816
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrjeeigdekudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdduleehrddvuddvrddvledrudeiieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjedurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.107.143
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello all, 

On 2/6/20 7:32 PM, Guenter Roeck wrote:
> While at it, add some trace messages to help debug problems
> seen when running the latest Linux kernel.

Through which tree do you think it is best to merge this patchset ? 
block or arm ? 

Thanks,

C.


> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Print pointer to Flash data structure as flash ID with each trace
>     message to support systems with more than one instantiated flash.
> 
>  hw/block/m25p80.c     | 48 ++++++++++++++++++++-----------------------
>  hw/block/trace-events | 16 +++++++++++++++
>  2 files changed, 38 insertions(+), 26 deletions(-)
> 
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 61f2fb8f8f..5ff8d270c4 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -32,17 +32,7 @@
>  #include "qemu/module.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> -
> -#ifndef M25P80_ERR_DEBUG
> -#define M25P80_ERR_DEBUG 0
> -#endif
> -
> -#define DB_PRINT_L(level, ...) do { \
> -    if (M25P80_ERR_DEBUG > (level)) { \
> -        fprintf(stderr,  ": %s: ", __func__); \
> -        fprintf(stderr, ## __VA_ARGS__); \
> -    } \
> -} while (0)
> +#include "trace.h"
>  
>  /* Fields for FlashPartInfo->flags */
>  
> @@ -574,7 +564,8 @@ static void flash_erase(Flash *s, int offset, FlashCMD cmd)
>          abort();
>      }
>  
> -    DB_PRINT_L(0, "offset = %#x, len = %d\n", offset, len);
> +    trace_m25p80_flash_erase(s, offset, len);
> +
>      if ((s->pi->flags & capa_to_assert) != capa_to_assert) {
>          qemu_log_mask(LOG_GUEST_ERROR, "M25P80: %d erase size not supported by"
>                        " device\n", len);
> @@ -607,8 +598,7 @@ void flash_write8(Flash *s, uint32_t addr, uint8_t data)
>      }
>  
>      if ((prev ^ data) & data) {
> -        DB_PRINT_L(1, "programming zero to one! addr=%" PRIx32 "  %" PRIx8
> -                   " -> %" PRIx8 "\n", addr, prev, data);
> +        trace_m25p80_programming_zero_to_one(s, addr, prev, data);
>      }
>  
>      if (s->pi->flags & EEPROM) {
> @@ -662,6 +652,9 @@ static void complete_collecting_data(Flash *s)
>  
>      s->state = STATE_IDLE;
>  
> +    trace_m25p80_complete_collecting(s, s->cmd_in_progress, n, s->ear,
> +                                     s->cur_addr);
> +
>      switch (s->cmd_in_progress) {
>      case DPP:
>      case QPP:
> @@ -825,7 +818,7 @@ static void reset_memory(Flash *s)
>          break;
>      }
>  
> -    DB_PRINT_L(0, "Reset done.\n");
> +    trace_m25p80_reset_done(s);
>  }
>  
>  static void decode_fast_read_cmd(Flash *s)
> @@ -941,9 +934,10 @@ static void decode_qio_read_cmd(Flash *s)
>  
>  static void decode_new_cmd(Flash *s, uint32_t value)
>  {
> -    s->cmd_in_progress = value;
>      int i;
> -    DB_PRINT_L(0, "decoded new command:%x\n", value);
> +
> +    s->cmd_in_progress = value;
> +    trace_m25p80_command_decoded(s, value);
>  
>      if (value != RESET_MEMORY) {
>          s->reset_enable = false;
> @@ -1042,7 +1036,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>          break;
>  
>      case JEDEC_READ:
> -        DB_PRINT_L(0, "populated jedec code\n");
> +        trace_m25p80_populated_jedec(s);
>          for (i = 0; i < s->pi->id_len; i++) {
>              s->data[i] = s->pi->id[i];
>          }
> @@ -1063,7 +1057,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>      case BULK_ERASE_60:
>      case BULK_ERASE:
>          if (s->write_enable) {
> -            DB_PRINT_L(0, "chip erase\n");
> +            trace_m25p80_chip_erase(s);
>              flash_erase(s, 0, BULK_ERASE);
>          } else {
>              qemu_log_mask(LOG_GUEST_ERROR, "M25P80: chip erase with write "
> @@ -1184,7 +1178,7 @@ static int m25p80_cs(SSISlave *ss, bool select)
>          s->data_read_loop = false;
>      }
>  
> -    DB_PRINT_L(0, "%sselect\n", select ? "de" : "");
> +    trace_m25p80_select(s, select ? "de" : "");
>  
>      return 0;
>  }
> @@ -1194,19 +1188,20 @@ static uint32_t m25p80_transfer8(SSISlave *ss, uint32_t tx)
>      Flash *s = M25P80(ss);
>      uint32_t r = 0;
>  
> +    trace_m25p80_transfer(s, s->state, s->len, s->needed_bytes, s->pos,
> +                          s->cur_addr, (uint8_t)tx);
> +
>      switch (s->state) {
>  
>      case STATE_PAGE_PROGRAM:
> -        DB_PRINT_L(1, "page program cur_addr=%#" PRIx32 " data=%" PRIx8 "\n",
> -                   s->cur_addr, (uint8_t)tx);
> +        trace_m25p80_page_program(s, s->cur_addr, (uint8_t)tx);
>          flash_write8(s, s->cur_addr, (uint8_t)tx);
>          s->cur_addr = (s->cur_addr + 1) & (s->size - 1);
>          break;
>  
>      case STATE_READ:
>          r = s->storage[s->cur_addr];
> -        DB_PRINT_L(1, "READ 0x%" PRIx32 "=%" PRIx8 "\n", s->cur_addr,
> -                   (uint8_t)r);
> +        trace_m25p80_read_byte(s, s->cur_addr, (uint8_t)r);
>          s->cur_addr = (s->cur_addr + 1) & (s->size - 1);
>          break;
>  
> @@ -1244,6 +1239,7 @@ static uint32_t m25p80_transfer8(SSISlave *ss, uint32_t tx)
>          }
>  
>          r = s->data[s->pos];
> +        trace_m25p80_read_data(s, s->pos, (uint8_t)r);
>          s->pos++;
>          if (s->pos == s->len) {
>              s->pos = 0;
> @@ -1281,7 +1277,7 @@ static void m25p80_realize(SSISlave *ss, Error **errp)
>              return;
>          }
>  
> -        DB_PRINT_L(0, "Binding to IF_MTD drive\n");
> +        trace_m25p80_binding(s);
>          s->storage = blk_blockalign(s->blk, s->size);
>  
>          if (blk_pread(s->blk, 0, s->storage, s->size) != s->size) {
> @@ -1289,7 +1285,7 @@ static void m25p80_realize(SSISlave *ss, Error **errp)
>              return;
>          }
>      } else {
> -        DB_PRINT_L(0, "No BDRV - binding to RAM\n");
> +        trace_m25p80_binding_no_bdrv(s);
>          s->storage = blk_blockalign(NULL, s->size);
>          memset(s->storage, 0xFF, s->size);
>      }
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index c03e80c2c9..f78939fa9d 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -134,3 +134,19 @@ xen_block_blockdev_add(char *str) "%s"
>  xen_block_blockdev_del(const char *node_name) "%s"
>  xen_block_device_create(unsigned int number) "%u"
>  xen_block_device_destroy(unsigned int number) "%u"
> +
> +# m25p80.c
> +m25p80_flash_erase(void *s, int offset, uint32_t len) "[%p] offset = 0x%"PRIx32", len = %u"
> +m25p80_programming_zero_to_one(void *s, uint32_t addr, uint8_t prev, uint8_t data) "[%p] programming zero to one! addr=0x%"PRIx32"  0x%"PRIx8" -> 0x%"PRIx8
> +m25p80_reset_done(void *s) "[%p] Reset done."
> +m25p80_command_decoded(void *s, uint32_t cmd) "[%p] new command:0x%"PRIx32
> +m25p80_complete_collecting(void *s, uint32_t cmd, int n, uint8_t ear, uint32_t cur_addr) "[%p] decode cmd: 0x%"PRIx32" len %d ear 0x%"PRIx8" addr 0x%"PRIx32
> +m25p80_populated_jedec(void *s) "[%p] populated jedec code"
> +m25p80_chip_erase(void *s) "[%p] chip erase"
> +m25p80_select(void *s, const char *what) "[%p] %sselect"
> +m25p80_page_program(void *s, uint32_t addr, uint8_t tx) "[%p] page program cur_addr=0x%"PRIx32" data=0x%"PRIx8
> +m25p80_transfer(void *s, uint8_t state, uint32_t len, uint8_t needed, uint32_t pos, uint32_t cur_addr, uint8_t t) "[%p] Transfer state 0x%"PRIx8" len 0x%"PRIx32" needed 0x%"PRIx8" pos 0x%"PRIx32" addr 0x%"PRIx32" tx 0x%"PRIx8
> +m25p80_read_byte(void *s, uint32_t addr, uint8_t v) "[%p] Read byte 0x%"PRIx32"=0x%"PRIx8
> +m25p80_read_data(void *s, uint32_t pos, uint8_t v) "[%p] Read data 0x%"PRIx32"=0x%"PRIx8
> +m25p80_binding(void *s) "[%p] Binding to IF_MTD drive"
> +m25p80_binding_no_bdrv(void *s) "[%p] No BDRV - binding to RAM"
> 


