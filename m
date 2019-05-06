Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB23C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 07:35:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B11C52082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 07:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11C52082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51834 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNYAE-0002ES-Le
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 03:35:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNY96-0001FZ-8N
	for qemu-devel@nongnu.org; Mon, 06 May 2019 03:34:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNY92-0007HH-FB
	for qemu-devel@nongnu.org; Mon, 06 May 2019 03:34:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34599)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hNY90-0007G8-LS
	for qemu-devel@nongnu.org; Mon, 06 May 2019 03:34:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id m20so4790629wmg.1
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 00:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=wbGHMmQqTA1t/CsP9AVzh43f5ajvujLgQ1emU/HQIHs=;
	b=qFkBbYmWidwKkVBEQYnmATfK4HGeRyKyAA6SpPdz1b38snnLUWLKpGw08TKUiuW95J
	20x4xAevl/bGEBt3cOWJ7J9o9KD8ZCAt4hYxQl57VuHAci0XVYv63jHlLF4vG4ECnZ7P
	v4oWueJi00CddlGpaGKz2XlRJc4b0nsQUIB6YdCF9vtpNpP+2KFuQJgViPQHVPoAN4Zy
	hDCqCY7R3JAAMTx9RV1cOpcW/RqX3YBbmwcvOmYad38m9UFldYPcKcfOTxM1TN/M2mJi
	YrV+kgkBbaHCJxmfJ10Ylkj9JUsMSukLjhUQWRNr3NpShRGOOV+Hhlsym4pUr91Offpb
	MHpA==
X-Gm-Message-State: APjAAAVU7p5mualuidBiA+l/nL+fiG8XEua4w0pff7AABTiGIrKgAbIP
	HKrrn9eop/nMOK1yk9g7JkYCxw==
X-Google-Smtp-Source: APXvYqwnzFoECiu+ACplnZxXcNzWB3UUFI76cElIt+/bmd5viMLyG4uw/Zs9tUWbUXZJCBjk9LEZqA==
X-Received: by 2002:a7b:cc12:: with SMTP id f18mr15858358wmh.40.1557128077495; 
	Mon, 06 May 2019 00:34:37 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	b12sm16882780wrf.21.2019.05.06.00.34.36
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 00:34:36 -0700 (PDT)
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
	"open list:Block layer core" <qemu-block@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20190426162624.55977-1-stephen.checkoway@oberlin.edu>
	<20190426162624.55977-3-stephen.checkoway@oberlin.edu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7ae88ff9-aed2-15e1-8716-5ca674b16059@redhat.com>
Date: Mon, 6 May 2019 09:34:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190426162624.55977-3-stephen.checkoway@oberlin.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v4 02/10] block/pflash_cfi02: Refactor,
 NFC intended
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/26/19 6:26 PM, Stephen Checkoway wrote:
> Simplify and refactor for upcoming commits. In particular, pull out all
> of the code to modify the status into simple helper functions. Status
> handling becomes more complex once multiple chips are interleaved to
> produce a single device.
> 
> No change in functionality is intended with this commit.

As this patch is hard to digest, I splitted it in various atomic changes
in another series:
https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg00975.html

> 
> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
> ---
>  hw/block/pflash_cfi02.c | 221 +++++++++++++++++-----------------------
>  1 file changed, 95 insertions(+), 126 deletions(-)
> 
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index f2c6201f81..4b7af71806 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -46,18 +46,19 @@
>  #include "hw/sysbus.h"
>  #include "trace.h"
>  
> -//#define PFLASH_DEBUG
> -#ifdef PFLASH_DEBUG
> +#define PFLASH_DEBUG false
>  #define DPRINTF(fmt, ...)                                  \
>  do {                                                       \
> -    fprintf(stderr, "PFLASH: " fmt , ## __VA_ARGS__);       \
> +    if (PFLASH_DEBUG) {                                    \
> +        fprintf(stderr, "PFLASH: " fmt, ## __VA_ARGS__);   \
> +    }                                                      \
>  } while (0)
> -#else
> -#define DPRINTF(fmt, ...) do { } while (0)
> -#endif
>  
>  #define PFLASH_LAZY_ROMD_THRESHOLD 42
>  
> +/* Special write cycle for CFI queries. */
> +#define WCYCLE_CFI 7
> +
>  struct PFlashCFI02 {
>      /*< private >*/
>      SysBusDevice parent_obj;
> @@ -97,6 +98,31 @@ struct PFlashCFI02 {
>      void *storage;
>  };
>  
> +/*
> + * Toggle status bit DQ7.
> + */
> +static inline void toggle_dq7(PFlashCFI02 *pfl)
> +{
> +    pfl->status ^= 0x80;
> +}
> +
> +/*
> + * Set status bit DQ7 to bit 7 of value.
> + */
> +static inline void set_dq7(PFlashCFI02 *pfl, uint8_t value)
> +{
> +    pfl->status &= 0x7F;
> +    pfl->status |= value & 0x80;
> +}
> +
> +/*
> + * Toggle status bit DQ6.
> + */
> +static inline void toggle_dq6(PFlashCFI02 *pfl)
> +{
> +    pfl->status ^= 0x40;
> +}
> +
>  /*
>   * Set up replicated mappings of the same region.
>   */
> @@ -126,7 +152,7 @@ static void pflash_timer (void *opaque)
>  
>      trace_pflash_timer_expired(pfl->cmd);
>      /* Reset flash */
> -    pfl->status ^= 0x80;
> +    toggle_dq7(pfl);
>      if (pfl->bypass) {
>          pfl->wcycle = 2;
>      } else {
> @@ -136,12 +162,34 @@ static void pflash_timer (void *opaque)
>      pfl->cmd = 0;
>  }
>  
> -static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr offset,
> -                            int width, int be)
> +/*
> + * Read data from flash.
> + */
> +static uint64_t pflash_data_read(PFlashCFI02 *pfl, hwaddr offset,
> +                                 unsigned int width)
>  {
> +    uint8_t *p = (uint8_t *)pfl->storage + offset;
> +    uint64_t ret = pfl->be ? ldn_be_p(p, width) : ldn_le_p(p, width);
> +    /* XXX: Need a trace_pflash_data_read(offset, ret, width) */
> +    switch (width) {
> +    case 1:
> +        trace_pflash_data_read8(offset, ret);
> +        break;
> +    case 2:
> +        trace_pflash_data_read16(offset, ret);
> +        break;
> +    case 4:
> +        trace_pflash_data_read32(offset, ret);
> +        break;
> +    }
> +    return ret;
> +}
> +
> +static uint64_t pflash_read(void *opaque, hwaddr offset, unsigned int width)
> +{
> +    PFlashCFI02 *pfl = opaque;
>      hwaddr boff;
> -    uint32_t ret;
> -    uint8_t *p;
> +    uint64_t ret;
>  
>      ret = -1;
>      trace_pflash_read(offset, pfl->cmd, width, pfl->wcycle);
> @@ -166,39 +214,8 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr offset,
>      case 0x80:
>          /* We accept reads during second unlock sequence... */
>      case 0x00:
> -    flash_read:
>          /* Flash area read */
> -        p = pfl->storage;
> -        switch (width) {
> -        case 1:
> -            ret = p[offset];
> -            trace_pflash_data_read8(offset, ret);
> -            break;
> -        case 2:
> -            if (be) {
> -                ret = p[offset] << 8;
> -                ret |= p[offset + 1];
> -            } else {
> -                ret = p[offset];
> -                ret |= p[offset + 1] << 8;
> -            }
> -            trace_pflash_data_read16(offset, ret);
> -            break;
> -        case 4:
> -            if (be) {
> -                ret = p[offset] << 24;
> -                ret |= p[offset + 1] << 16;
> -                ret |= p[offset + 2] << 8;
> -                ret |= p[offset + 3];
> -            } else {
> -                ret = p[offset];
> -                ret |= p[offset + 1] << 8;
> -                ret |= p[offset + 2] << 16;
> -                ret |= p[offset + 3] << 24;
> -            }
> -            trace_pflash_data_read32(offset, ret);
> -            break;
> -        }
> +        ret = pflash_data_read(pfl, offset, width);
>          break;
>      case 0x90:
>          /* flash ID read */
> @@ -213,23 +230,23 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr offset,
>          case 0x0E:
>          case 0x0F:
>              ret = boff & 0x01 ? pfl->ident3 : pfl->ident2;
> -            if (ret == (uint8_t)-1) {
> -                goto flash_read;
> +            if (ret != (uint8_t)-1) {
> +                break;
>              }
> -            break;
> +            /* Fall through to data read. */
>          default:
> -            goto flash_read;
> +            ret = pflash_data_read(pfl, offset, width);
>          }
> -        DPRINTF("%s: ID " TARGET_FMT_plx " %x\n", __func__, boff, ret);
> +        DPRINTF("%s: ID " TARGET_FMT_plx " %" PRIx64 "\n", __func__, boff, ret);
>          break;
>      case 0xA0:
>      case 0x10:
>      case 0x30:
>          /* Status register read */
>          ret = pfl->status;
> -        DPRINTF("%s: status %x\n", __func__, ret);
> +        DPRINTF("%s: status %" PRIx64 "\n", __func__, ret);
>          /* Toggle bit 6 */
> -        pfl->status ^= 0x40;
> +        toggle_dq6(pfl);
>          break;
>      case 0x98:
>          /* CFI query mode */
> @@ -245,8 +262,7 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr offset,
>  }
>  
>  /* update flash content on disk */
> -static void pflash_update(PFlashCFI02 *pfl, int offset,
> -                          int size)
> +static void pflash_update(PFlashCFI02 *pfl, int offset, int size)
>  {
>      int offset_end;
>      if (pfl->blk) {
> @@ -259,9 +275,10 @@ static void pflash_update(PFlashCFI02 *pfl, int offset,
>      }
>  }
>  
> -static void pflash_write(PFlashCFI02 *pfl, hwaddr offset,
> -                         uint32_t value, int width, int be)
> +static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
> +                         unsigned int width)
>  {
> +    PFlashCFI02 *pfl = opaque;
>      hwaddr boff;
>      uint8_t *p;
>      uint8_t cmd;
> @@ -277,7 +294,7 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr offset,
>      trace_pflash_write(offset, value, width, pfl->wcycle);
>      offset &= pfl->chip_len - 1;
>  
> -    DPRINTF("%s: offset " TARGET_FMT_plx " %08x %d\n", __func__,
> +    DPRINTF("%s: offset " TARGET_FMT_plx " %08" PRIx64 " %d\n", __func__,
>              offset, value, width);
>      boff = offset & (pfl->sector_len - 1);
>      if (pfl->width == 2)
> @@ -295,7 +312,7 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr offset,
>          if (boff == 0x55 && cmd == 0x98) {
>          enter_CFI_mode:
>              /* Enter CFI query mode */
> -            pfl->wcycle = 7;
> +            pfl->wcycle = WCYCLE_CFI;
>              pfl->cmd = 0x98;
>              return;
>          }
> @@ -345,40 +362,22 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr offset,
>              goto check_unlock0;
>          case 0xA0:
>              trace_pflash_data_write(offset, value, width, 0);
> -            p = pfl->storage;
>              if (!pfl->ro) {
> -                switch (width) {
> -                case 1:
> -                    p[offset] &= value;
> -                    pflash_update(pfl, offset, 1);
> -                    break;
> -                case 2:
> -                    if (be) {
> -                        p[offset] &= value >> 8;
> -                        p[offset + 1] &= value;
> -                    } else {
> -                        p[offset] &= value;
> -                        p[offset + 1] &= value >> 8;
> -                    }
> -                    pflash_update(pfl, offset, 2);
> -                    break;
> -                case 4:
> -                    if (be) {
> -                        p[offset] &= value >> 24;
> -                        p[offset + 1] &= value >> 16;
> -                        p[offset + 2] &= value >> 8;
> -                        p[offset + 3] &= value;
> -                    } else {
> -                        p[offset] &= value;
> -                        p[offset + 1] &= value >> 8;
> -                        p[offset + 2] &= value >> 16;
> -                        p[offset + 3] &= value >> 24;
> -                    }
> -                    pflash_update(pfl, offset, 4);
> -                    break;
> +                p = (uint8_t *)pfl->storage + offset;
> +                if (pfl->be) {
> +                    uint64_t current = ldn_be_p(p, width);
> +                    stn_be_p(p, width, current & value);
> +                } else {
> +                    uint64_t current = ldn_le_p(p, width);
> +                    stn_le_p(p, width, current & value);
>                  }
> +                pflash_update(pfl, offset, width);
>              }
> -            pfl->status = 0x00 | ~(value & 0x80);
> +            /*
> +             * While programming, status bit DQ7 should hold the opposite
> +             * value from how it was programmed.
> +             */
> +            set_dq7(pfl, ~value);
>              /* Let's pretend write is immediate */
>              if (pfl->bypass)
>                  goto do_bypass;
> @@ -426,7 +425,7 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr offset,
>                  memset(pfl->storage, 0xFF, pfl->chip_len);
>                  pflash_update(pfl, 0, pfl->chip_len);
>              }
> -            pfl->status = 0x00;
> +            set_dq7(pfl, 0x00);
>              /* Let's wait 5 seconds before chip erase is done */
>              timer_mod(&pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
>                        (NANOSECONDS_PER_SECOND * 5));
> @@ -441,7 +440,7 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr offset,
>                  memset(p + offset, 0xFF, pfl->sector_len);
>                  pflash_update(pfl, offset, pfl->sector_len);
>              }
> -            pfl->status = 0x00;
> +            set_dq7(pfl, 0x00);
>              /* Let's wait 1/2 second before sector erase is done */
>              timer_mod(&pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
>                        (NANOSECONDS_PER_SECOND / 2));
> @@ -467,7 +466,7 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr offset,
>              goto reset_flash;
>          }
>          break;
> -    case 7: /* Special value for CFI queries */
> +    case WCYCLE_CFI: /* Special value for CFI queries */
>          DPRINTF("%s: invalid write in CFI query mode\n", __func__);
>          goto reset_flash;
>      default:
> @@ -492,39 +491,9 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr offset,
>      pfl->cmd = 0;
>  }
>  
> -static uint64_t pflash_be_readfn(void *opaque, hwaddr addr, unsigned size)
> -{
> -    return pflash_read(opaque, addr, size, 1);
> -}
> -
> -static void pflash_be_writefn(void *opaque, hwaddr addr,
> -                              uint64_t value, unsigned size)
> -{
> -    pflash_write(opaque, addr, value, size, 1);
> -}
> -
> -static uint64_t pflash_le_readfn(void *opaque, hwaddr addr, unsigned size)
> -{
> -    return pflash_read(opaque, addr, size, 0);
> -}
> -
> -static void pflash_le_writefn(void *opaque, hwaddr addr,
> -                              uint64_t value, unsigned size)
> -{
> -    pflash_write(opaque, addr, value, size, 0);
> -}
> -
> -static const MemoryRegionOps pflash_cfi02_ops_be = {
> -    .read = pflash_be_readfn,
> -    .write = pflash_be_writefn,
> -    .valid.min_access_size = 1,
> -    .valid.max_access_size = 4,
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> -};
> -
> -static const MemoryRegionOps pflash_cfi02_ops_le = {
> -    .read = pflash_le_readfn,
> -    .write = pflash_le_writefn,
> +static const MemoryRegionOps pflash_cfi02_ops = {
> +    .read = pflash_read,
> +    .write = pflash_write,
>      .valid.min_access_size = 1,
>      .valid.max_access_size = 4,
>      .endianness = DEVICE_NATIVE_ENDIAN,
> @@ -552,9 +521,9 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
>  
>      chip_len = pfl->sector_len * pfl->nb_blocs;
>  
> -    memory_region_init_rom_device(&pfl->orig_mem, OBJECT(pfl), pfl->be ?
> -                                  &pflash_cfi02_ops_be : &pflash_cfi02_ops_le,
> -                                  pfl, pfl->name, chip_len, &local_err);
> +    memory_region_init_rom_device(&pfl->orig_mem, OBJECT(pfl),
> +                                  &pflash_cfi02_ops, pfl, pfl->name,
> +                                  chip_len, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> 

