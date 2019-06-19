Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1059BC31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 15:18:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3AD621880
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 15:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uLa3oqbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3AD621880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39320 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdcMA-0005Oh-30
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 11:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39951)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hdcJs-00044T-QP
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:16:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hdcJr-00053G-HT
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:16:16 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:45837)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hdcJr-00051K-B2; Wed, 19 Jun 2019 11:16:15 -0400
Received: by mail-ed1-x542.google.com with SMTP id a14so27704706edv.12;
 Wed, 19 Jun 2019 08:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CUcAH5CsXUAkg9VQuHl1C6HetctEYF20Kq7+gMk+jKw=;
 b=uLa3oqbP81fGKr8ZnPIekXNo+YEBTvLe/fe0p3288y/zjHNfVlPQwJOXrABDKv4uTe
 gqVG76RWZRliwof70STHOnm9B9CGw1HSrb9hlwOQ8Gt8kKAQi43w6iDDW8/QBwuQUiOd
 kO7cm4G28gqSr4R+MmRJdAYPJSwxG9iudX82gi1gUkfRHO21WmaJFBeKxh5euopyAMc9
 MvcfDbVRO3KU4F6abmA+0wECV6iVfuXup1UVOf6m74WSSzr3B9Dg6dtkoz1gqt2GZfvb
 VdL9QFR3WlB38u8P06wYFoOtxZRRe4YpTzQzIKifVf5qGwKZngz5GtwaGDxguKPyicyD
 rggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CUcAH5CsXUAkg9VQuHl1C6HetctEYF20Kq7+gMk+jKw=;
 b=UHQ/ZON2XvCSaeDmzWAbsnRM05ivpp/SHAuGvUHkNb+bIo7xSlhhLFPzw77G4AbWKM
 V/utBFTDDn00cr6EQkoG5tDGbRyzWLb4qvtM1b5XIu/UIhLLzesp0hGPSqo74VKP2zrJ
 fJCq60j1U8G0BPCjxZhkjqp9fxJGHI8+EURqbIqgUFEM8xucvLEyrrSMkihWRz0W+gT0
 64DuEu4Md0gzJzUrjKH5oEPrmFF2StLTqvwEljggcku5RRTKPeYocBgpecxx9e1phD99
 b4RwUw4vC/Z1XkvNCq+ySOPBMKyCwx+Trl56JWEeHRDSjc2eEf5Q9vzrSGD+5D1uHERs
 S0nA==
X-Gm-Message-State: APjAAAWKsPgumm1t4x37ztb9qjYjHmg1606THk5KkHl60dId30tKrOoX
 JO0N83c0w/28Q37O0GBWPnJfDrH6r+DENuDJcqY=
X-Google-Smtp-Source: APXvYqyIqd1LLLUSaUwp7hVuG4OX+WrjlwIV1EdWgSTfTWNB21e1iOCtgU7Nul1GMVfGlzaNPBonEMgZsqhzmt+1GNg=
X-Received: by 2002:a50:c28a:: with SMTP id o10mr64395139edf.182.1560957374091; 
 Wed, 19 Jun 2019 08:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560904640.git.alistair.francis@wdc.com>
 <b511243b947debd710ea225699a4d7e312568da8.1560904640.git.alistair.francis@wdc.com>
In-Reply-To: <b511243b947debd710ea225699a4d7e312568da8.1560904640.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 19 Jun 2019 23:16:02 +0800
Message-ID: <CAEUhbmWpxLHu3Tf9k+UT9K-6dqLGtDkybTb4S8beCQ0nv9Ghqw@mail.gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
Subject: Re: [Qemu-devel] [RFC v1 1/5] hw/riscv: Split out the boot functions
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
Cc: Alistair Francis <alistair23@gmail.com>, Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 19, 2019 at 8:51 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Split the common RISC-V boot functions into a seperate file. This allows
> us to share the common code.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/Makefile.objs  |  1 +
>  hw/riscv/boot.c         | 69 +++++++++++++++++++++++++++++++++++++++++
>  hw/riscv/sifive_e.c     | 17 ++--------
>  hw/riscv/sifive_u.c     | 17 ++--------
>  hw/riscv/spike.c        | 21 +++----------
>  hw/riscv/virt.c         | 51 +++---------------------------
>  include/hw/riscv/boot.h | 27 ++++++++++++++++
>  7 files changed, 110 insertions(+), 93 deletions(-)
>  create mode 100644 hw/riscv/boot.c
>  create mode 100644 include/hw/riscv/boot.h
>
> diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
> index a65027304a..eb9d4f9ffc 100644
> --- a/hw/riscv/Makefile.objs
> +++ b/hw/riscv/Makefile.objs
> @@ -1,3 +1,4 @@
> +obj-y += boot.o
>  obj-$(CONFIG_SPIKE) += riscv_htif.o
>  obj-$(CONFIG_HART) += riscv_hart.o
>  obj-$(CONFIG_SIFIVE_E) += sifive_e.o
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> new file mode 100644
> index 0000000000..62f94aaf8a
> --- /dev/null
> +++ b/hw/riscv/boot.c
> @@ -0,0 +1,69 @@
> +/*
> + * QEMU RISC-V Boot Helper
> + *
> + * Copyright (c) 2017 SiFive, Inc.
> + * Copyright (c) 2019 Alistair Francis <alistair.francis@wdc.com>
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
> +#include "qemu/units.h"
> +#include "qemu/error-report.h"
> +#include "exec/cpu-defs.h"
> +#include "hw/loader.h"
> +#include "hw/riscv/boot.h"
> +#include "elf.h"
> +
> +target_ulong riscv_load_kernel(const char *kernel_filename)
> +{
> +    uint64_t kernel_entry, kernel_high;
> +
> +    if (load_elf(kernel_filename, NULL, NULL, NULL,
> +                 &kernel_entry, NULL, &kernel_high,
> +                 0, EM_RISCV, 1, 0) < 0) {
> +        error_report("could not load kernel '%s'", kernel_filename);
> +        exit(1);
> +    }
> +
> +    return kernel_entry;
> +}
> +
> +hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
> +                         uint64_t kernel_entry, hwaddr *start)
> +{
> +    int size;
> +
> +    /* We want to put the initrd far enough into RAM that when the

nits: /* should be on a separate line

> +     * kernel is uncompressed it will not clobber the initrd. However
> +     * on boards without much RAM we must ensure that we still leave
> +     * enough room for a decent sized initrd, and on boards with large
> +     * amounts of RAM we must avoid the initrd being so far up in RAM
> +     * that it is outside lowmem and inaccessible to the kernel.
> +     * So for boards with less  than 256MB of RAM we put the initrd
> +     * halfway into RAM, and for boards with 256MB of RAM or more we put
> +     * the initrd at 128MB.
> +     */

[snip]

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Tested-by: Bin Meng <bmeng.cn@gmail.com>

