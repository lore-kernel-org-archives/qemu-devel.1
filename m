Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3460AC32771
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 01:49:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00AB2207E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 01:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="aWr3SRO3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00AB2207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iruHO-0006GM-U1
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 20:49:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iruE8-0004v1-RE
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 20:45:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iruE6-0001ID-FV
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 20:45:40 -0500
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:36348)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iruE5-0001HD-VU; Wed, 15 Jan 2020 20:45:38 -0500
Received: by mail-qv1-xf44.google.com with SMTP id m14so8372733qvl.3;
 Wed, 15 Jan 2020 17:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ua8duYP8yA9XTvJJ75SbTiBbb4oyC0VTSk6idRgcdRc=;
 b=aWr3SRO3XG1R+GPRfzKkZoE5YCouEgAf/F3RVdHXHXHpFQwUR5Qia/+mBHMzK+IWVZ
 8cqEXpfB3KT/1kGP7nQz7tGn19+JcZ9FnwgQBFcDaepzJem2rj4hTjYB2MvbvEInoO5T
 HHVowSTSVyKVgfrB4ZTMh36HzMGw871Mv5iu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ua8duYP8yA9XTvJJ75SbTiBbb4oyC0VTSk6idRgcdRc=;
 b=fEhPeYqtpqS4R+IrB/LUpqmxjy1ORpXEx2qaGZwK4iCoWRTxcxmmedSdPrRAR9k3f4
 XLVJbrBuRWAJmDe6lHngDfOzG7LiPyZf12Zke4z6NwVdAHE1taBCpz0UqIMgDL7nIynd
 lsHfFLshLbLcX/tyvpoTYhHhjUqhWKsaoCPadcML54i5Wo+PNVXrhZcNO1QIzHw85IVE
 ZfDLWfwStCriH7DTJrpf0Ni52Tb1ssrBMAbed3iTKEczGDiFZbjXHTXrcwVoY3baJCvo
 7oFix00WNndYOniMHH2K0yn6ggPSQoyFN6U5uKh/bXpTbtWR7tkScsUurboHyo+OInMe
 PImg==
X-Gm-Message-State: APjAAAX0jc3UGMpZUPZmDr7fP1+PP6xrI0MGxhInAnP/KqRZrwVoc8B+
 mfGE0q2WmBmca9O6VgcpmfxeuZSniPLWnsvWZrU=
X-Google-Smtp-Source: APXvYqzLqAaqOx1Z0ORIFyHY9F1HCW73e9bItrW1nQzFZ8ERWvBqvD2NtY7OMnwo+vS5xGZmtuJqDUqauK+JjBIixzg=
X-Received: by 2002:a0c:b2c7:: with SMTP id d7mr286380qvf.111.1579139136269;
 Wed, 15 Jan 2020 17:45:36 -0800 (PST)
MIME-Version: 1.0
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-8-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579100861-73692-8-git-send-email-imammedo@redhat.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 16 Jan 2020 01:45:24 +0000
Message-ID: <CACPK8XfqZQ+6D=XJ8h2jb_LCPW=8OVSqnrRWVAUXGywJManA9g@mail.gmail.com>
Subject: Re: [PATCH v2 07/86] arm:aspeed: convert valid RAM sizes to data
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f44
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 Jan 2020 at 15:10, Igor Mammedov <imammedo@redhat.com> wrote:
>
> various foo_rambits() hardcode mapping of RAM sizes to RAM feature bits,
> which is hard to reuse and repeats over and over.
>
> Convert maps into GLib's hash tables and perform mapping using
> common mapping function.

Thanks for the patch.

I find the existing code straight forward to understand, and for this
reason I would prefer to leave it as it is. Would you mind dropping
this patch from your series?

>
> Follow up patch will reuse tables for actually checking ram-size
> property.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: clg@kaod.org
> CC: peter.maydell@linaro.org
> CC: andrew@aj.id.au
> CC: joel@jms.id.au
> CC: qemu-arm@nongnu.org
> ---
>  include/hw/misc/aspeed_sdmc.h |   2 +
>  hw/misc/aspeed_sdmc.c         | 116 ++++++++++++++++--------------------------
>  2 files changed, 47 insertions(+), 71 deletions(-)
>
> diff --git a/include/hw/misc/aspeed_sdmc.h b/include/hw/misc/aspeed_sdmc.h
> index 5dbde59..de1501f 100644
> --- a/include/hw/misc/aspeed_sdmc.h
> +++ b/include/hw/misc/aspeed_sdmc.h
> @@ -39,6 +39,8 @@ typedef struct AspeedSDMCState {
>  typedef struct AspeedSDMCClass {
>      SysBusDeviceClass parent_class;
>
> +    GHashTable *ram2feat;
> +    int fallback_ram_size;
>      uint64_t max_ram_size;
>      uint32_t (*compute_conf)(AspeedSDMCState *s, uint32_t data);
>      void (*write)(AspeedSDMCState *s, uint32_t reg, uint32_t data);
> diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
> index 2df3244..3fc80f0 100644
> --- a/hw/misc/aspeed_sdmc.c
> +++ b/hw/misc/aspeed_sdmc.c
> @@ -148,72 +148,6 @@ static const MemoryRegionOps aspeed_sdmc_ops = {
>      .valid.max_access_size = 4,
>  };
>
> -static int ast2400_rambits(AspeedSDMCState *s)
> -{
> -    switch (s->ram_size >> 20) {
> -    case 64:
> -        return ASPEED_SDMC_DRAM_64MB;
> -    case 128:
> -        return ASPEED_SDMC_DRAM_128MB;
> -    case 256:
> -        return ASPEED_SDMC_DRAM_256MB;
> -    case 512:
> -        return ASPEED_SDMC_DRAM_512MB;
> -    default:
> -        break;
> -    }
> -
> -    /* use a common default */
> -    warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 256M",
> -                s->ram_size);
> -    s->ram_size = 256 << 20;
> -    return ASPEED_SDMC_DRAM_256MB;
> -}
> -
> -static int ast2500_rambits(AspeedSDMCState *s)
> -{
> -    switch (s->ram_size >> 20) {
> -    case 128:
> -        return ASPEED_SDMC_AST2500_128MB;
> -    case 256:
> -        return ASPEED_SDMC_AST2500_256MB;
> -    case 512:
> -        return ASPEED_SDMC_AST2500_512MB;
> -    case 1024:
> -        return ASPEED_SDMC_AST2500_1024MB;
> -    default:
> -        break;
> -    }
> -
> -    /* use a common default */
> -    warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 512M",
> -                s->ram_size);
> -    s->ram_size = 512 << 20;
> -    return ASPEED_SDMC_AST2500_512MB;
> -}
> -
> -static int ast2600_rambits(AspeedSDMCState *s)
> -{
> -    switch (s->ram_size >> 20) {
> -    case 256:
> -        return ASPEED_SDMC_AST2600_256MB;
> -    case 512:
> -        return ASPEED_SDMC_AST2600_512MB;
> -    case 1024:
> -        return ASPEED_SDMC_AST2600_1024MB;
> -    case 2048:
> -        return ASPEED_SDMC_AST2600_2048MB;
> -    default:
> -        break;
> -    }
> -
> -    /* use a common default */
> -    warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 1024M",
> -                s->ram_size);
> -    s->ram_size = 1024 << 20;
> -    return ASPEED_SDMC_AST2600_1024MB;
> -}
> -
>  static void aspeed_sdmc_reset(DeviceState *dev)
>  {
>      AspeedSDMCState *s = ASPEED_SDMC(dev);
> @@ -257,11 +191,14 @@ static Property aspeed_sdmc_properties[] = {
>  static void aspeed_sdmc_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> +    AspeedSDMCClass *asc = ASPEED_SDMC_CLASS(klass);
> +
>      dc->realize = aspeed_sdmc_realize;
>      dc->reset = aspeed_sdmc_reset;
>      dc->desc = "ASPEED SDRAM Memory Controller";
>      dc->vmsd = &vmstate_aspeed_sdmc;
>      dc->props = aspeed_sdmc_properties;
> +    asc->ram2feat = g_hash_table_new(g_direct_hash, g_direct_equal);
>  }
>
>  static const TypeInfo aspeed_sdmc_info = {
> @@ -273,10 +210,28 @@ static const TypeInfo aspeed_sdmc_info = {
>      .abstract   = true,
>  };
>
> +static int aspeed_get_ram_feat(AspeedSDMCState *s)
> +{
> +    AspeedSDMCClass *asc = ASPEED_SDMC_GET_CLASS(s);
> +    int ram_mb = s->ram_size >> 20;
> +    gpointer val;
> +
> +    if (g_hash_table_contains(asc->ram2feat, GINT_TO_POINTER(ram_mb))) {
> +        val = g_hash_table_lookup(asc->ram2feat, GINT_TO_POINTER(ram_mb));
> +        return GPOINTER_TO_INT(val);
> +    }
> +
> +    warn_report("Invalid RAM size 0x%" PRIx64 ". Using default %dM",
> +                 s->ram_size, asc->fallback_ram_size);
> +    s->ram_size = asc->fallback_ram_size << 20;
> +    val = g_hash_table_lookup(asc->ram2feat, &asc->fallback_ram_size);
> +    return GPOINTER_TO_INT(val);
> +}
> +
>  static uint32_t aspeed_2400_sdmc_compute_conf(AspeedSDMCState *s, uint32_t data)
>  {
> -    uint32_t fixed_conf = ASPEED_SDMC_VGA_COMPAT |
> -        ASPEED_SDMC_DRAM_SIZE(ast2400_rambits(s));
> +    int ram_f = aspeed_get_ram_feat(s);
> +    uint32_t fixed_conf = ASPEED_SDMC_VGA_COMPAT | ASPEED_SDMC_DRAM_SIZE(ram_f);
>
>      /* Make sure readonly bits are kept */
>      data &= ~ASPEED_SDMC_READONLY_MASK;
> @@ -298,6 +253,9 @@ static void aspeed_2400_sdmc_write(AspeedSDMCState *s, uint32_t reg,
>      s->regs[reg] = data;
>  }
>
> +#define REGISTER_RAM_SIZE(h, k, v) \
> +    g_hash_table_insert(h->ram2feat, GINT_TO_POINTER(k), GINT_TO_POINTER(v))
> +
>  static void aspeed_2400_sdmc_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -307,6 +265,11 @@ static void aspeed_2400_sdmc_class_init(ObjectClass *klass, void *data)
>      asc->max_ram_size = 512 << 20;
>      asc->compute_conf = aspeed_2400_sdmc_compute_conf;
>      asc->write = aspeed_2400_sdmc_write;
> +    asc->fallback_ram_size = 256;
> +    REGISTER_RAM_SIZE(asc, 64, ASPEED_SDMC_DRAM_64MB);
> +    REGISTER_RAM_SIZE(asc, 128, ASPEED_SDMC_DRAM_128MB);
> +    REGISTER_RAM_SIZE(asc, 256, ASPEED_SDMC_DRAM_256MB);
> +    REGISTER_RAM_SIZE(asc, 512, ASPEED_SDMC_DRAM_512MB);
>  }
>
>  static const TypeInfo aspeed_2400_sdmc_info = {
> @@ -317,10 +280,10 @@ static const TypeInfo aspeed_2400_sdmc_info = {
>
>  static uint32_t aspeed_2500_sdmc_compute_conf(AspeedSDMCState *s, uint32_t data)
>  {
> +    int ram_f = aspeed_get_ram_feat(s);
>      uint32_t fixed_conf = ASPEED_SDMC_HW_VERSION(1) |
>          ASPEED_SDMC_VGA_APERTURE(ASPEED_SDMC_VGA_64MB) |
> -        ASPEED_SDMC_CACHE_INITIAL_DONE |
> -        ASPEED_SDMC_DRAM_SIZE(ast2500_rambits(s));
> +        ASPEED_SDMC_CACHE_INITIAL_DONE | ASPEED_SDMC_DRAM_SIZE(ram_f);
>
>      /* Make sure readonly bits are kept */
>      data &= ~ASPEED_SDMC_AST2500_READONLY_MASK;
> @@ -360,6 +323,11 @@ static void aspeed_2500_sdmc_class_init(ObjectClass *klass, void *data)
>      asc->max_ram_size = 1024 << 20;
>      asc->compute_conf = aspeed_2500_sdmc_compute_conf;
>      asc->write = aspeed_2500_sdmc_write;
> +    asc->fallback_ram_size = 512;
> +    REGISTER_RAM_SIZE(asc, 128, ASPEED_SDMC_AST2500_128MB);
> +    REGISTER_RAM_SIZE(asc, 256, ASPEED_SDMC_AST2500_256MB);
> +    REGISTER_RAM_SIZE(asc, 512, ASPEED_SDMC_AST2500_512MB);
> +    REGISTER_RAM_SIZE(asc, 1024, ASPEED_SDMC_AST2500_1024MB);
>  }
>
>  static const TypeInfo aspeed_2500_sdmc_info = {
> @@ -370,9 +338,10 @@ static const TypeInfo aspeed_2500_sdmc_info = {
>
>  static uint32_t aspeed_2600_sdmc_compute_conf(AspeedSDMCState *s, uint32_t data)
>  {
> +    int ram_f = aspeed_get_ram_feat(s);
>      uint32_t fixed_conf = ASPEED_SDMC_HW_VERSION(3) |
>          ASPEED_SDMC_VGA_APERTURE(ASPEED_SDMC_VGA_64MB) |
> -        ASPEED_SDMC_DRAM_SIZE(ast2600_rambits(s));
> +        ASPEED_SDMC_DRAM_SIZE(ram_f);
>
>      /* Make sure readonly bits are kept (use ast2500 mask) */
>      data &= ~ASPEED_SDMC_AST2500_READONLY_MASK;
> @@ -413,6 +382,11 @@ static void aspeed_2600_sdmc_class_init(ObjectClass *klass, void *data)
>      asc->max_ram_size = 2048 << 20;
>      asc->compute_conf = aspeed_2600_sdmc_compute_conf;
>      asc->write = aspeed_2600_sdmc_write;
> +    asc->fallback_ram_size = 512;
> +    REGISTER_RAM_SIZE(asc, 256, ASPEED_SDMC_AST2600_256MB);
> +    REGISTER_RAM_SIZE(asc, 512, ASPEED_SDMC_AST2600_512MB);
> +    REGISTER_RAM_SIZE(asc, 1024, ASPEED_SDMC_AST2600_1024MB);
> +    REGISTER_RAM_SIZE(asc, 2048, ASPEED_SDMC_AST2600_2048MB);
>  }
>
>  static const TypeInfo aspeed_2600_sdmc_info = {
> --
> 2.7.4
>

