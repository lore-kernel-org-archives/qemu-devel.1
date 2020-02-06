Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD01C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 22:27:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3D1321775
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 22:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMmOdgwl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D1321775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izpcQ-000822-RI
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 17:27:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1izpbg-0006L3-FS
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 17:26:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1izpbe-0004Ps-Td
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 17:26:44 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:33616)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1izpbb-0003wf-J5; Thu, 06 Feb 2020 17:26:39 -0500
Received: by mail-lf1-x142.google.com with SMTP id n25so204897lfl.0;
 Thu, 06 Feb 2020 14:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3b5htaa0jYgY/fVlTdFYwXBIPWv+NnvM27DOHClygGs=;
 b=JMmOdgwl4L36VTMz3ndaEYyoYYzpJP7zD/3Y8azgNx98YJpOumE59/YoofjxWvHDmZ
 UAi8Gmf3vPcTD/AAvEsOFU8F+LZvSEpcwBFnUJayYohvBIn5LkOnHv0tZ6HcYWzZUgPY
 +szPo1age8JtLINExhnd3AEBhvSY7gjHDqGlWnnx0amzMu3CAz0CDs1mkKr5LEdDYZRY
 AiTqQ/U8B2nELel0zImBfY0IR+5NEMjr4NhxCLrqZhqGYkedGc/goHpEDPOeRtk8Jt/7
 8mxnFLeSw+lrf0mDB7paixOw59mmwDzWTQJBuQzrT362hsK4SoiQS0fbMKqXXcqChttS
 eMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3b5htaa0jYgY/fVlTdFYwXBIPWv+NnvM27DOHClygGs=;
 b=dQXeqNqqEMWEwV6aMQsUuASd94or8+iHZDl3En/7cZgLxG8EiXapXNcSshbw6t9108
 VwmIl8AMVykNxWCccBD+oq+vQv0Aqq7ybX9/T8jMaFdsxUgXfxKcl1tagEEgYOyf7ca6
 GH5DxeEmkRSKW52+SzdDmfPbhpVjw/kORuQnlwKRYyoNOcjXJ6//T4a1QPbUei7rB8o2
 6/n4k/2M8elCjKjeiIqM6Lu3g2k3K3j/PPtrj+TefCKB4VV/+pG08W7DT30/bc+rWyhs
 jgkSXn1ciD4vMBIuByT3gha51qjxENNDWtMuaE0yMCWrnv/UiAwNT8AL2U9f4ztVjDza
 XobQ==
X-Gm-Message-State: APjAAAW2B58VguuFXIxk7adjKnemA5c8pIWXxLpirHOQAVYEUlD5OTzF
 qqOHgkiq7ZBkHvl1XgHEgGpD7Ha0UAaKIJWjFqQ=
X-Google-Smtp-Source: APXvYqyT1FyJZq3QFAD4WYDQJGm23Yx9ogOG0Uj/BD90SicOrpXfM4Ube6Wje0rc7YMX28GqWNaax0DUuq/v2R2cP+0=
X-Received: by 2002:ac2:5f68:: with SMTP id c8mr2826103lfc.196.1581027997328; 
 Thu, 06 Feb 2020 14:26:37 -0800 (PST)
MIME-Version: 1.0
References: <20200206183219.3756-1-linux@roeck-us.net>
In-Reply-To: <20200206183219.3756-1-linux@roeck-us.net>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Feb 2020 14:19:25 -0800
Message-ID: <CAKmqyKP+xFJoWyOemBQ1vnc77vJ24jHPC3cSfsth3JALc6uTyQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] m25p80: Convert to support tracing
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Qemu-block <qemu-block@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 6, 2020 at 10:33 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> While at it, add some trace messages to help debug problems
> seen when running the latest Linux kernel.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

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
> --
> 2.17.1
>
>

