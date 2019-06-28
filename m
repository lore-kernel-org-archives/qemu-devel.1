Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F352CC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:30:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD8D12086D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD8D12086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hguhW-0005Yc-0g
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 13:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52786)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hgufu-00046D-Rh
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:28:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hgufp-0004la-B0
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:28:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35633)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hgufm-0004jO-Tv
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:28:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id c6so9718821wml.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 10:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YLFQHD2qzsN42g+w41OHTcwmz/TjxJcjWJCvxZAPkoI=;
 b=g3FQGaElUhauWkJkcUcAlEGUNVCKoq+S3BRCz0WvncLx0QutxsWNw37QlPRDqCJhpG
 dsYAEOKCLH+jF/GVfow7SctVnCERaQ5Ds2PLxB5+9/HJo2Z47E2QFY3abJcw3PSkSf3s
 +Bee8GLI9ciEHOr/h4YMRRmJudDPMt6C5KTYu6wWThCQOZA5iHo/vAayJM/m71+oCufU
 WmCMIsMfvDFHeWJN8Qd+g4dqlBCbIh1rv5cgfVM267Vq8Uc7PEfsM5subJOUjTkHy9kt
 eG1Wa0vWBjomRQNNgmtG93waLanZYCySDwXh0+EVUtB4EVqOj4xhZ38dVYyQ58wWyRp/
 zn0A==
X-Gm-Message-State: APjAAAVRpZmRoB6qcOfaEPdJ581OHUfuM6ITVJEWNO+DHDAaM0O7+YH5
 HI/mhF61VznrDRhknIsP5+iemA==
X-Google-Smtp-Source: APXvYqzT7StLr9jyR28rAeuB0HPRtTqFPujQLRkpq9ZzzeSFoHHAL+hRi5pJKCmyWGiDx+j7yDgaCA==
X-Received: by 2002:a1c:b6d4:: with SMTP id g203mr7957373wmf.19.1561742909051; 
 Fri, 28 Jun 2019 10:28:29 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id f2sm3454733wrq.48.2019.06.28.10.28.27
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Jun 2019 10:28:28 -0700 (PDT)
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>, qemu-devel@nongnu.org
References: <20190627202719.17739-1-philmd@redhat.com>
 <20190627202719.17739-19-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <241eaafa-e5fa-1653-e789-2ef9ac5ae592@redhat.com>
Date: Fri, 28 Jun 2019 19:28:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190627202719.17739-19-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v5 18/28] hw/block/pflash_cfi02: Implement
 nonuniform sector sizes
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Antony Pavlov <antonynpavlov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Jan Kiszka <jan.kiszka@web.de>,
 John Snow <jsnow@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/27/19 10:27 PM, Philippe Mathieu-Daudé wrote:
> From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
> 
> Some flash chips support sectors of different sizes. For example, the
> AMD AM29LV160DT has 31 64 kB sectors, one 32 kB sector, two 8 kB
> sectors, and a 16 kB sector, in that order. The AM29LV160DB has those in
> the reverse order.
> 
> The `num-blocks` and `sector-length` properties work exactly as they did
> before: a flash device with uniform sector lengths. To get non-uniform
> sector lengths for up to four regions, the following properties may be
> set
> - region 0. `num-blocks0` and `sector-length0`;
> - region 1. `num-blocks1` and `sector-length1`;
> - region 2. `num-blocks2` and `sector-length2`; and
> - region 3. `num-blocks3` and `sector-length3`.
> 
> If the uniform and nonuniform properties are set, then both must specify
> a flash device with the same total size. It would be better to disallow
> both being set, or make `num-blocks0` and `sector-length0` alias
> `num-blocks` and `sector-length`, but that would make testing currently
> impossible.
> 
> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
> Acked-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20190426162624.55977-6-stephen.checkoway@oberlin.edu>
> [PMD: Rebased, add assert() on pri_offset]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/block/pflash_cfi02.c   | 141 +++++++++++++++++++++++++++-------
>  tests/pflash-cfi02-test.c | 155 ++++++++++++++++++++++++++++----------
>  2 files changed, 231 insertions(+), 65 deletions(-)
> 
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index 01d9c5d75a..1f096ec185 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -29,7 +29,6 @@
>   * - CFI queries
>   *
>   * It does not support flash interleaving.
> - * It does not implement boot blocs with reduced size
>   * It does not implement software data protection as found in many real chips
>   * It does not implement erase suspend/resume commands
>   * It does not implement multiple sectors erase
> @@ -57,6 +56,13 @@ do {                                                       \
>  
>  #define PFLASH_LAZY_ROMD_THRESHOLD 42
>  
> +/*
> + * The size of the cfi_table indirectly depends on this and the start of the
> + * PRI table directly depends on it. 4 is the maximum size (and also what
> + * seems common) without changing the PRT table address.
> + */
> +#define PFLASH_MAX_ERASE_REGIONS 4
> +
>  /* Special write cycles for CFI queries. */
>  enum {
>      WCYCLE_CFI              = 7,
> @@ -68,8 +74,10 @@ struct PFlashCFI02 {
>      /*< public >*/
>  
>      BlockBackend *blk;
> -    uint32_t sector_len;
> -    uint32_t nb_blocs;
> +    uint32_t uniform_nb_blocs;
> +    uint32_t uniform_sector_len;
> +    uint32_t nb_blocs[PFLASH_MAX_ERASE_REGIONS];
> +    uint32_t sector_len[PFLASH_MAX_ERASE_REGIONS];

I think we can drop the 'uniform' variables, and only use the indexed ones.

>      uint32_t chip_len;
>      uint8_t mappings;
>      uint8_t width;
> @@ -86,7 +94,7 @@ struct PFlashCFI02 {
>      uint16_t ident3;
>      uint16_t unlock_addr0;
>      uint16_t unlock_addr1;
> -    uint8_t cfi_table[0x52];
> +    uint8_t cfi_table[0x4d];
>      QEMUTimer timer;
>      /* The device replicates the flash memory across its memory space.  Emulate
>       * that by having a container (.mem) filled with an array of aliases
> @@ -177,6 +185,25 @@ static uint64_t pflash_data_read(PFlashCFI02 *pfl, hwaddr offset,
>      return ret;
>  }
>  
> +/*
> + * offset should be a byte offset of the QEMU device and _not_ a device
> + * offset.
> + */
> +static uint32_t pflash_sector_len(PFlashCFI02 *pfl, hwaddr offset)

Hmm I'd rather have a more generic pflash_sector_index(pfl, offset).

> +{
> +    assert(offset < pfl->chip_len);
> +    int nb_regions = pfl->cfi_table[0x2C];
> +    hwaddr addr = 0;
> +    for (int i = 0; i < nb_regions; ++i) {
> +        uint64_t region_size = (uint64_t)pfl->nb_blocs[i] * pfl->sector_len[i];
> +        if (addr <= offset && offset < addr + region_size) {
> +            return pfl->sector_len[i];
> +        }
> +        addr += region_size;
> +    }
> +    abort();
> +}
> +
>  static uint64_t pflash_read(void *opaque, hwaddr offset, unsigned int width)
>  {
>      PFlashCFI02 *pfl = opaque;
> @@ -191,10 +218,11 @@ static uint64_t pflash_read(void *opaque, hwaddr offset, unsigned int width)
>      }
>      offset &= pfl->chip_len - 1;
>      boff = offset & 0xFF;
> -    if (pfl->width == 2)
> +    if (pfl->width == 2) {
>          boff = boff >> 1;
> -    else if (pfl->width == 4)
> +    } else if (pfl->width == 4) {
>          boff = boff >> 2;
> +    }

Simple style, ok.

>      switch (pfl->cmd) {
>      default:
>          /* This should never happen : reset state & treat it as a read*/
> @@ -273,6 +301,7 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
>      hwaddr boff;
>      uint8_t *p;
>      uint8_t cmd;
> +    uint32_t sector_len;
>  
>      trace_pflash_io_write(offset, width, width << 1, value, pfl->wcycle);
>      cmd = value;
> @@ -282,10 +311,11 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
>      offset &= pfl->chip_len - 1;
>  
>      boff = offset;
> -    if (pfl->width == 2)
> +    if (pfl->width == 2) {
>          boff = boff >> 1;
> -    else if (pfl->width == 4)
> +    } else if (pfl->width == 4) {
>          boff = boff >> 2;
> +    }

Style again.

>      /* Only the least-significant 11 bits are used in most cases. */
>      boff &= 0x7FF;
>      switch (pfl->wcycle) {
> @@ -420,12 +450,14 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
>          case 0x30:
>              /* Sector erase */
>              p = pfl->storage;
> -            offset &= ~(pfl->sector_len - 1);
> -            DPRINTF("%s: start sector erase at " TARGET_FMT_plx "\n", __func__,
> -                    offset);
> +            sector_len = pflash_sector_len(pfl, offset);
> +            offset &= ~(sector_len - 1);
> +            DPRINTF("%s: start sector erase at %0*" PRIx64 "-%0*" PRIx64 "\n",
> +                    __func__, pfl->width * 2, offset,
> +                    pfl->width * 2, offset + sector_len - 1);
>              if (!pfl->ro) {
> -                memset(p + offset, 0xFF, pfl->sector_len);
> -                pflash_update(pfl, offset, pfl->sector_len);
> +                memset(p + offset, 0xff, sector_len);
> +                pflash_update(pfl, offset, sector_len);
>              }
>              set_dq7(pfl, 0x00);
>              /* Let's wait 1/2 second before sector erase is done */
> @@ -493,11 +525,11 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
>      int ret;
>      Error *local_err = NULL;
>  
> -    if (pfl->sector_len == 0) {
> +    if (pfl->uniform_sector_len == 0 && pfl->sector_len[0] == 0) {
>          error_setg(errp, "attribute \"sector-length\" not specified or zero.");
>          return;
>      }
> -    if (pfl->nb_blocs == 0) {
> +    if (pfl->uniform_nb_blocs == 0 && pfl->nb_blocs[0] == 0) {
>          error_setg(errp, "attribute \"num-blocks\" not specified or zero.");
>          return;
>      }
> @@ -506,7 +538,51 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> -    pfl->chip_len = pfl->sector_len * pfl->nb_blocs;
> +    int nb_regions;
> +    pfl->chip_len = 0;
> +    for (nb_regions = 0; nb_regions < PFLASH_MAX_ERASE_REGIONS; ++nb_regions) {
> +        if (pfl->nb_blocs[nb_regions] == 0) {
> +            break;
> +        }
> +        uint64_t sector_len_per_device = pfl->sector_len[nb_regions];
> +
> +        /*
> +         * The size of each flash sector must be a power of 2 and it must be
> +         * aligned at the same power of 2.
> +         */
> +        if (sector_len_per_device & 0xff ||
> +            sector_len_per_device >= (1 << 24) ||
> +            !is_power_of_2(sector_len_per_device))
> +        {
> +            error_setg(errp, "unsupported configuration: "
> +                       "sector length[%d] per device = %" PRIx64 ".",
> +                       nb_regions, sector_len_per_device);
> +            return;
> +        }
> +        if (pfl->chip_len & (sector_len_per_device - 1)) {
> +            error_setg(errp, "unsupported configuration: "
> +                       "flash region %d not correctly aligned.",
> +                       nb_regions);
> +            return;
> +        }
> +
> +        pfl->chip_len += (uint64_t)pfl->sector_len[nb_regions] *
> +                          pfl->nb_blocs[nb_regions];
> +    }
> +
> +    uint64_t uniform_len = (uint64_t)pfl->uniform_nb_blocs *
> +                           pfl->uniform_sector_len;
> +    if (nb_regions == 0) {
> +        nb_regions = 1;
> +        pfl->nb_blocs[0] = pfl->uniform_nb_blocs;
> +        pfl->sector_len[0] = pfl->uniform_sector_len;
> +        pfl->chip_len = uniform_len;
> +    } else if (uniform_len != 0 && uniform_len != pfl->chip_len) {
> +        error_setg(errp, "\"num-blocks\"*\"sector-length\" "
> +                   "different from \"num-blocks0\"*\'sector-length0\" + ... + "
> +                   "\"num-blocks3\"*\"sector-length3\"");
> +        return;
> +    }
>  
>      memory_region_init_rom_device(&pfl->orig_mem, OBJECT(pfl),
>                                    &pflash_cfi02_ops, pfl, pfl->name,
> @@ -552,7 +628,7 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
>      pfl->status = 0;
>  
>      /* Hardcoded CFI table (mostly from SG29 Spansion flash) */
> -    const uint16_t pri_ofs = 0x31;
> +    const uint16_t pri_ofs = 0x40;
>      /* Standard "QRY" string */
>      pfl->cfi_table[0x10] = 'Q';
>      pfl->cfi_table[0x11] = 'R';
> @@ -603,14 +679,17 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
>      //    pfl->cfi_table[0x2A] = 0x05;
>      pfl->cfi_table[0x2A] = 0x00;
>      pfl->cfi_table[0x2B] = 0x00;
> -    /* Number of erase block regions (uniform) */
> -    pfl->cfi_table[0x2C] = 0x01;
> -    /* Erase block region 1 */
> -    pfl->cfi_table[0x2D] = pfl->nb_blocs - 1;
> -    pfl->cfi_table[0x2E] = (pfl->nb_blocs - 1) >> 8;
> -    pfl->cfi_table[0x2F] = pfl->sector_len >> 8;
> -    pfl->cfi_table[0x30] = pfl->sector_len >> 16;
> -    assert(0x30 < pri_ofs);
> +    /* Number of erase block regions */
> +    pfl->cfi_table[0x2c] = nb_regions;
> +    /* Erase block regions */
> +    for (int i = 0; i < nb_regions; ++i) {
> +        uint32_t sector_len_per_device = pfl->sector_len[i];
> +        pfl->cfi_table[0x2d + 4 * i] = pfl->nb_blocs[i] - 1;
> +        pfl->cfi_table[0x2e + 4 * i] = (pfl->nb_blocs[i] - 1) >> 8;
> +        pfl->cfi_table[0x2f + 4 * i] = sector_len_per_device >> 8;
> +        pfl->cfi_table[0x30 + 4 * i] = sector_len_per_device >> 16;
> +    }

OK.

> +    assert(0x2c + 4 * nb_regions < pri_ofs);
>  
>      /* Extended */
>      pfl->cfi_table[0x00 + pri_ofs] = 'P';
> @@ -644,8 +723,16 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
>  
>  static Property pflash_cfi02_properties[] = {
>      DEFINE_PROP_DRIVE("drive", PFlashCFI02, blk),
> -    DEFINE_PROP_UINT32("num-blocks", PFlashCFI02, nb_blocs, 0),
> -    DEFINE_PROP_UINT32("sector-length", PFlashCFI02, sector_len, 0),
> +    DEFINE_PROP_UINT32("num-blocks", PFlashCFI02, uniform_nb_blocs, 0),
> +    DEFINE_PROP_UINT32("sector-length", PFlashCFI02, uniform_sector_len, 0),
> +    DEFINE_PROP_UINT32("num-blocks0", PFlashCFI02, nb_blocs[0], 0),
> +    DEFINE_PROP_UINT32("sector-length0", PFlashCFI02, sector_len[0], 0),
> +    DEFINE_PROP_UINT32("num-blocks1", PFlashCFI02, nb_blocs[1], 0),
> +    DEFINE_PROP_UINT32("sector-length1", PFlashCFI02, sector_len[1], 0),
> +    DEFINE_PROP_UINT32("num-blocks2", PFlashCFI02, nb_blocs[2], 0),
> +    DEFINE_PROP_UINT32("sector-length2", PFlashCFI02, sector_len[2], 0),
> +    DEFINE_PROP_UINT32("num-blocks3", PFlashCFI02, nb_blocs[3], 0),
> +    DEFINE_PROP_UINT32("sector-length3", PFlashCFI02, sector_len[3], 0),
>      DEFINE_PROP_UINT8("width", PFlashCFI02, width, 0),
>      DEFINE_PROP_UINT8("mappings", PFlashCFI02, mappings, 0),
>      DEFINE_PROP_UINT8("big-endian", PFlashCFI02, be, 0),
> diff --git a/tests/pflash-cfi02-test.c b/tests/pflash-cfi02-test.c
> index b00f5ca2e7..1659eaebce 100644
> --- a/tests/pflash-cfi02-test.c
> +++ b/tests/pflash-cfi02-test.c
> @@ -17,9 +17,11 @@
>   */
>  
>  #define MP_FLASH_SIZE_MAX (32 * 1024 * 1024)
> -#define FLASH_SIZE (8 * 1024 * 1024)
>  #define BASE_ADDR (0x100000000ULL - MP_FLASH_SIZE_MAX)
>  
> +#define UNIFORM_FLASH_SIZE (8 * 1024 * 1024)
> +#define UNIFORM_FLASH_SECTOR_SIZE (64 * 1024)
> +
>  /* Use a newtype to keep flash addresses separate from byte addresses. */
>  typedef struct {
>      uint64_t addr;
> @@ -44,6 +46,10 @@ typedef struct {
>  typedef struct {
>      int bank_width;
>  
> +    /* Nonuniform block size. */
> +    int nb_blocs[4];
> +    int sector_len[4];
> +
>      QTestState *qtest;
>  } FlashConfig;
>  
> @@ -62,6 +68,10 @@ static FlashConfig expand_config_defaults(const FlashConfig *c)
>      if (ret.bank_width == 0) {
>          ret.bank_width = 2;
>      }
> +    if (ret.nb_blocs[0] == 0 && ret.sector_len[0] == 0) {
> +        ret.sector_len[0] = UNIFORM_FLASH_SECTOR_SIZE;
> +        ret.nb_blocs[0] = UNIFORM_FLASH_SIZE / UNIFORM_FLASH_SECTOR_SIZE;

See, here you use index=0 for the uniform config.

> +    }
>  
>      /* XXX: Limitations of test harness. */
>      assert(ret.bank_width == 2);
> @@ -230,13 +240,41 @@ static void chip_erase(const FlashConfig *c)
>      flash_cmd(c, UNLOCK0_ADDR, CHIP_ERASE_CMD);
>  }
>  
> -static void test_flash(const void *opaque)
> +/*
> + * Test flash commands with a variety of device geometry.
> + */
> +static void test_geometry(const void *opaque)
>  {
>      const FlashConfig *config = opaque;
>      QTestState *qtest;
>      qtest = qtest_initf("-M musicpal,accel=qtest"
> -                        " -drive if=pflash,file=%s,format=raw,copy-on-read",
> -                        image_path);
> +                        " -drive if=pflash,file=%s,format=raw,copy-on-read"
> +                        /* Device geometry properties. */
> +                        " -global driver=cfi.pflash02,"
> +                        "property=num-blocks0,value=%d"
> +                        " -global driver=cfi.pflash02,"
> +                        "property=sector-length0,value=%d"
> +                        " -global driver=cfi.pflash02,"
> +                        "property=num-blocks1,value=%d"
> +                        " -global driver=cfi.pflash02,"
> +                        "property=sector-length1,value=%d"
> +                        " -global driver=cfi.pflash02,"
> +                        "property=num-blocks2,value=%d"
> +                        " -global driver=cfi.pflash02,"
> +                        "property=sector-length2,value=%d"
> +                        " -global driver=cfi.pflash02,"
> +                        "property=num-blocks3,value=%d"
> +                        " -global driver=cfi.pflash02,"
> +                        "property=sector-length3,value=%d",
> +                        image_path,
> +                        config->nb_blocs[0],
> +                        config->sector_len[0],
> +                        config->nb_blocs[1],
> +                        config->sector_len[1],
> +                        config->nb_blocs[2],
> +                        config->sector_len[2],
> +                        config->nb_blocs[3],
> +                        config->sector_len[3]);
>      FlashConfig explicit_config = expand_config_defaults(config);
>      explicit_config.qtest = qtest;
>      const FlashConfig *c = &explicit_config;
> @@ -264,39 +302,56 @@ static void test_flash(const void *opaque)
>      g_assert_cmphex(flash_query(c, FLASH_ADDR(0x12)), ==, replicate(c, 'Y'));
>  
>      /* Num erase regions. */
> -    g_assert_cmphex(flash_query_1(c, FLASH_ADDR(0x2C)), >=, 1);
> +    int nb_erase_regions = flash_query_1(c, FLASH_ADDR(0x2C));
> +    g_assert_cmphex(nb_erase_regions, ==,
> +                    !!c->nb_blocs[0] + !!c->nb_blocs[1] + !!c->nb_blocs[2] +
> +                    !!c->nb_blocs[3]);
> +
> +    /* Check device length. */
> +    uint32_t device_len = 1 << flash_query_1(c, FLASH_ADDR(0x27));
> +    g_assert_cmphex(device_len, ==, UNIFORM_FLASH_SIZE);
>  
> -    uint32_t nb_sectors = flash_query_1(c, FLASH_ADDR(0x2D)) +
> -                          (flash_query_1(c, FLASH_ADDR(0x2E)) << 8) + 1;
> -    uint32_t sector_len = (flash_query_1(c, FLASH_ADDR(0x2F)) << 8) +
> -                          (flash_query_1(c, FLASH_ADDR(0x30)) << 16);
>      reset(c);
>  
>      const uint64_t dq7 = replicate(c, 0x80);
>      const uint64_t dq6 = replicate(c, 0x40);
> -    /* Erase and program sector. */
> -    for (uint32_t i = 0; i < nb_sectors; ++i) {
> -        uint64_t byte_addr = i * sector_len;
> -        sector_erase(c, byte_addr);
> -        /* Read toggle. */
> -        uint64_t status0 = flash_read(c, byte_addr);
> -        /* DQ7 is 0 during an erase. */
> -        g_assert_cmphex(status0 & dq7, ==, 0);
> -        uint64_t status1 = flash_read(c, byte_addr);
> -        /* DQ6 toggles during an erase. */
> -        g_assert_cmphex(status0 & dq6, ==, ~status1 & dq6);
> -        /* Wait for erase to complete. */
> -        qtest_clock_step_next(c->qtest);
> -        /* Ensure DQ6 has stopped toggling. */
> -        g_assert_cmphex(flash_read(c, byte_addr), ==, flash_read(c, byte_addr));
> -        /* Now the data should be valid. */
> -        g_assert_cmphex(flash_read(c, byte_addr), ==, bank_mask(c));
> +    uint64_t byte_addr = 0;
> +    for (int region = 0; region < nb_erase_regions; ++region) {
> +        uint64_t base = 0x2D + 4 * region;
> +        flash_cmd(c, CFI_ADDR, CFI_CMD);
> +        uint32_t nb_sectors = flash_query_1(c, FLASH_ADDR(base + 0)) +
> +                              (flash_query_1(c, FLASH_ADDR(base + 1)) << 8) + 1;
> +        uint32_t sector_len = (flash_query_1(c, FLASH_ADDR(base + 2)) << 8) +
> +                              (flash_query_1(c, FLASH_ADDR(base + 3)) << 16);
> +        g_assert_cmphex(nb_sectors, ==, c->nb_blocs[region]);
> +        g_assert_cmphex(sector_len, ==, c->sector_len[region]);
> +        reset(c);
>  
> -        /* Program a bit pattern. */
> -        program(c, byte_addr, 0x55);
> -        g_assert_cmphex(flash_read(c, byte_addr) & 0xFF, ==, 0x55);
> -        program(c, byte_addr, 0xA5);
> -        g_assert_cmphex(flash_read(c, byte_addr) & 0xFF, ==, 0x05);
> +        /* Erase and program sector. */
> +        for (uint32_t i = 0; i < nb_sectors; ++i) {
> +            sector_erase(c, byte_addr);
> +            /* Read toggle. */
> +            uint64_t status0 = flash_read(c, byte_addr);
> +            /* DQ7 is 0 during an erase. */
> +            g_assert_cmphex(status0 & dq7, ==, 0);
> +            uint64_t status1 = flash_read(c, byte_addr);
> +            /* DQ6 toggles during an erase. */
> +            g_assert_cmphex(status0 & dq6, ==, ~status1 & dq6);
> +            /* Wait for erase to complete. */
> +            qtest_clock_step_next(c->qtest);
> +            /* Ensure DQ6 has stopped toggling. */
> +            g_assert_cmphex(flash_read(c, byte_addr), ==,
> +                            flash_read(c, byte_addr));
> +            /* Now the data should be valid. */
> +            g_assert_cmphex(flash_read(c, byte_addr), ==, bank_mask(c));
> +
> +            /* Program a bit pattern. */
> +            program(c, byte_addr, 0x55);
> +            g_assert_cmphex(flash_read(c, byte_addr) & 0xFF, ==, 0x55);
> +            program(c, byte_addr, 0xA5);
> +            g_assert_cmphex(flash_read(c, byte_addr) & 0xFF, ==, 0x05);
> +            byte_addr += sector_len;
> +        }
>      }
>  
>      /* Erase the chip. */
> @@ -314,9 +369,11 @@ static void test_flash(const void *opaque)
>      g_assert_cmphex(flash_read(c, 0), ==, flash_read(c, 0));
>      /* Now the data should be valid. */
>  
> -    for (uint32_t i = 0; i < nb_sectors; ++i) {
> -        uint64_t byte_addr = i * sector_len;
> -        g_assert_cmphex(flash_read(c, byte_addr), ==, bank_mask(c));
> +    for (int region = 0; region < nb_erase_regions; ++region) {
> +        for (uint32_t i = 0; i < c->nb_blocs[region]; ++i) {
> +            uint64_t byte_addr = i * c->sector_len[region];
> +            g_assert_cmphex(flash_read(c, byte_addr), ==, bank_mask(c));
> +        }
>      }
>  
>      /* Unlock bypass */
> @@ -364,6 +421,18 @@ static const FlashConfig configuration[] = {
>      {
>          .bank_width = 2,
>      },
> +    /* Nonuniform sectors (top boot). */
> +    {
> +        .bank_width = 2,
> +        .nb_blocs = { 127, 1, 2, 1 },
> +        .sector_len = { 0x10000, 0x08000, 0x02000, 0x04000 },
> +    },
> +    /* Nonuniform sectors (bottom boot). */
> +    {
> +        .bank_width = 2,
> +        .nb_blocs = { 1, 2, 1, 127 },
> +        .sector_len = { 0x04000, 0x02000, 0x08000, 0x10000 },
> +    },
>  };
>  
>  int main(int argc, char **argv)
> @@ -374,12 +443,12 @@ int main(int argc, char **argv)
>                     strerror(errno));
>          exit(EXIT_FAILURE);
>      }
> -    if (ftruncate(fd, FLASH_SIZE) < 0) {
> +    if (ftruncate(fd, UNIFORM_FLASH_SIZE) < 0) {
>          int error_code = errno;
>          close(fd);
>          unlink(image_path);
>          g_printerr("Failed to truncate file %s to %u MB: %s\n", image_path,
> -                   FLASH_SIZE, strerror(error_code));
> +                   UNIFORM_FLASH_SIZE, strerror(error_code));
>          exit(EXIT_FAILURE);
>      }
>      close(fd);
> @@ -390,9 +459,19 @@ int main(int argc, char **argv)
>      size_t nb_configurations = sizeof configuration / sizeof configuration[0];
>      for (size_t i = 0; i < nb_configurations; ++i) {
>          const FlashConfig *config = &configuration[i];
> -        char *path = g_strdup_printf("pflash-cfi02/%d",
> +        char *path = g_strdup_printf("pflash-cfi02"
> +                                     "/geometry/%dx%x-%dx%x-%dx%x-%dx%x"
> +                                     "/%d",
> +                                     config->nb_blocs[0],
> +                                     config->sector_len[0],
> +                                     config->nb_blocs[1],
> +                                     config->sector_len[1],
> +                                     config->nb_blocs[2],
> +                                     config->sector_len[2],
> +                                     config->nb_blocs[3],
> +                                     config->sector_len[3],
>                                       config->bank_width);
> -        qtest_add_data_func(path, config, test_flash);
> +        qtest_add_data_func(path, config, test_geometry);
>          g_free(path);
>      }
>      int result = g_test_run();
> 

