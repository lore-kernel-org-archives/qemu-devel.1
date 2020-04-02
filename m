Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C3FC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 22:54:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AB012072E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 22:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGNGhERq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB012072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK8iv-0007tk-Jc
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 18:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jK8iC-00072r-TN
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 18:53:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jK8iB-0004jy-Mi
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 18:53:24 -0400
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41]:40832)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jK8iB-0004hk-Gj
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 18:53:23 -0400
Received: by mail-vs1-xe41.google.com with SMTP id w14so3743396vsf.7
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 15:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DyaHOBqcyLyHNDo2qYUchooJ7RL3/VvYZYFexnWAhN8=;
 b=dGNGhERqUNByk7SGLAiFadrh3fxy/lvOHy9FJt3qpxiQa0a3gse1X6MyDjlBGGqIDN
 +qLLSSoe3XY0DI5F4a10IDzWdYgRMTe35XF6E7RlHiOJ+MAvuTaVD3SLM2cKwV80O7qs
 tkWPNfT9mqdJbZ+IhH+leqVFP3pVO32iQjVtlno9o6dnJmU8JWH6Fqy6UQh/QkFUgTGf
 f9GMdNnSOCTGj9l1+yExOV3MK+FtT5ITfQJ4LAAryXhjwixKFJzFHJvYq/quYBNYyFQ0
 6TCWW1DfaoxJACbkH6IEQlK26uIQ2XrCaNN4TfRW6yIJYl0JGENfhAgbpCL3TuhozPOt
 mqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DyaHOBqcyLyHNDo2qYUchooJ7RL3/VvYZYFexnWAhN8=;
 b=DPvfWyzLOCsb+ysBxBP4U8mLaPZ2rtHFG/p/04MIt+CbYjiwziIA3fNRZlO9bhrUII
 gqj5cW0MeraT0YhyGKvgmFr8GQ5SNnDILKcxYnL4OCwgUWYN+TnFVAMNG5KO4ha7AHJe
 Hm5vP8JLeFQP5JqIOqrUeeNJWO4LpvrIO4RSALOrvUML5UOiv9ZOIeU6q6XO5WVLmb5E
 f2ugOdXg+A0+N+U4edt4JxPkHb+N/BFrsDHrx50j6SuCFFiRlRg1x0tNsgfeaBHu/HvK
 kgMc4GzXwysNcrkcYoG6/UrvWadSHLXz1PKPDr5IOoOIQ52sbWKiU4X5iyPmFWPFzt4R
 long==
X-Gm-Message-State: AGi0PuZ6/Lh+eoKw0WZ9Wf7qmGTijAQ4/0eWxPUNGwC7YZVaTKWFPsrj
 CWbIuCUUvWjSXVSo2sJXNiGlBmw6TirIuGfYPvE=
X-Google-Smtp-Source: APiQypJmWurAV4wUR4URR9eT9AHp/N0w/ZTKnZzatogGRW9XEPD1Hni7qJd+g/08Hqhx1b4C4wiyzNQIZ+v12de6E1Q=
X-Received: by 2002:a67:1b81:: with SMTP id b123mr4278597vsb.172.1585868002655; 
 Thu, 02 Apr 2020 15:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200402162839.76636-1-me@xcancerberox.com.ar>
In-Reply-To: <20200402162839.76636-1-me@xcancerberox.com.ar>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 Apr 2020 15:45:10 -0700
Message-ID: <CAKmqyKMrH=4X-ryFYBgSenaM4H4+HZ-uWbCf2hx8oYiHovFbng@mail.gmail.com>
Subject: Re: [PATCH-for-5.1 v2] hw/core/register: Add register_init_block8
 helper.
To: Joaquin de Andres <me@xcancerberox.com.ar>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e41
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
Cc: Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 2, 2020 at 9:29 AM Joaquin de Andres <me@xcancerberox.com.ar> wrote:
>
> There was no support for 8 bits block registers. Changed
> register_init_block32 to be generic and static, adding register
> size in bits as parameter. Created one helper for each size.
>
> Signed-off-by: Joaquin de Andres <me@xcancerberox.com.ar>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> This patch is small and I could see that there is not much movement with
> the release, so, I let my self send this. Also this is my first patch :)
> Reviews are welcome.
> ---
>  hw/core/register.c    | 46 +++++++++++++++++++++++++++++++++----------
>  include/hw/register.h |  8 ++++++++
>  2 files changed, 44 insertions(+), 10 deletions(-)
>
> diff --git a/hw/core/register.c b/hw/core/register.c
> index 3c77396587..ddf91eb445 100644
> --- a/hw/core/register.c
> +++ b/hw/core/register.c
> @@ -246,16 +246,18 @@ uint64_t register_read_memory(void *opaque, hwaddr addr,
>      return extract64(read_val, 0, size * 8);
>  }
>
> -RegisterInfoArray *register_init_block32(DeviceState *owner,
> -                                         const RegisterAccessInfo *rae,
> -                                         int num, RegisterInfo *ri,
> -                                         uint32_t *data,
> -                                         const MemoryRegionOps *ops,
> -                                         bool debug_enabled,
> -                                         uint64_t memory_size)
> +static RegisterInfoArray *register_init_block(DeviceState *owner,
> +                                              const RegisterAccessInfo *rae,
> +                                              int num, RegisterInfo *ri,
> +                                              void *data,
> +                                              const MemoryRegionOps *ops,
> +                                              bool debug_enabled,
> +                                              uint64_t memory_size,
> +                                              size_t data_size_bits)
>  {
>      const char *device_prefix = object_get_typename(OBJECT(owner));
>      RegisterInfoArray *r_array = g_new0(RegisterInfoArray, 1);
> +    int data_size = data_size_bits >> 3;
>      int i;
>
>      r_array->r = g_new0(RegisterInfo *, num);
> @@ -264,12 +266,12 @@ RegisterInfoArray *register_init_block32(DeviceState *owner,
>      r_array->prefix = device_prefix;
>
>      for (i = 0; i < num; i++) {
> -        int index = rae[i].addr / 4;
> +        int index = rae[i].addr / data_size;
>          RegisterInfo *r = &ri[index];
>
>          *r = (RegisterInfo) {
> -            .data = &data[index],
> -            .data_size = sizeof(uint32_t),
> +            .data = data + data_size * index,
> +            .data_size = data_size,
>              .access = &rae[i],
>              .opaque = owner,
>          };
> @@ -284,6 +286,30 @@ RegisterInfoArray *register_init_block32(DeviceState *owner,
>      return r_array;
>  }
>
> +RegisterInfoArray *register_init_block8(DeviceState *owner,
> +                                        const RegisterAccessInfo *rae,
> +                                        int num, RegisterInfo *ri,
> +                                        uint8_t *data,
> +                                        const MemoryRegionOps *ops,
> +                                        bool debug_enabled,
> +                                        uint64_t memory_size)
> +{
> +    return register_init_block(owner, rae, num, ri, (void *)
> +                               data, ops, debug_enabled, memory_size, 8);
> +}
> +
> +RegisterInfoArray *register_init_block32(DeviceState *owner,
> +                                         const RegisterAccessInfo *rae,
> +                                         int num, RegisterInfo *ri,
> +                                         uint32_t *data,
> +                                         const MemoryRegionOps *ops,
> +                                         bool debug_enabled,
> +                                         uint64_t memory_size)
> +{
> +    return register_init_block(owner, rae, num, ri, (void *)
> +                               data, ops, debug_enabled, memory_size, 32);
> +}
> +
>  void register_finalize_block(RegisterInfoArray *r_array)
>  {
>      object_unparent(OBJECT(&r_array->mem));
> diff --git a/include/hw/register.h b/include/hw/register.h
> index 5796584588..5d2c565ae0 100644
> --- a/include/hw/register.h
> +++ b/include/hw/register.h
> @@ -185,6 +185,14 @@ uint64_t register_read_memory(void *opaque, hwaddr addr, unsigned size);
>   *          memory region (r_array->mem) the caller should add to a container.
>   */
>
> +RegisterInfoArray *register_init_block8(DeviceState *owner,
> +                                        const RegisterAccessInfo *rae,
> +                                        int num, RegisterInfo *ri,
> +                                        uint8_t *data,
> +                                        const MemoryRegionOps *ops,
> +                                        bool debug_enabled,
> +                                        uint64_t memory_size);
> +
>  RegisterInfoArray *register_init_block32(DeviceState *owner,
>                                           const RegisterAccessInfo *rae,
>                                           int num, RegisterInfo *ri,
> --
> 2.26.0
>
>

