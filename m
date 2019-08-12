Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A4FC31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 22:45:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30EAA20665
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 22:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30EAA20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxJ3v-0001It-Hf
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 18:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55147)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hxJ3X-0000qk-Ok
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 18:44:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hxJ3W-0006Rl-Kp
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 18:44:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42802)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hxJ3W-0006RH-FM
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 18:44:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id t132so50200530pgb.9
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 15:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=VRLnfTSmpbAwWsgfsAvbH2bJEn8ECtiUgsox1iOBdZY=;
 b=WWPaCOgYHTj9peNl826OeHJIDWJMGlGm6fsoK4loVo8h2v6WboPGeH9eKmQYK0/DTG
 5YIY6jhJa/H+jXBGNs1KsJehm4Wofd8ENdzUyLlLFWQcXgYP6o+8ni4R5RPPTnpRvq/l
 9nwTQxwNufXmdY6pSacJ4ccTHwBlmEzus9f9wUILNvIX2c6rwMbKTjveQaGtyTbgbynh
 mhpoqeO05K6iq0FjVCmHSp7zOOM8etzph+p9kp9vu98N3IoL8svGK7htyCeMpQse2sm7
 Q/BLPdIh232F34p1XnZzTHqLtc6BXMzXlxw8LuURJ8VuMwr+37WdKvR5ZYHFGzDFfDs1
 Scrg==
X-Gm-Message-State: APjAAAWeTTDESFxZk+/0y67s9UXvMH2bW7ckUwP2ZraAaGDu2vg8ryU7
 BViNCqPYTLQg9HP9K9dMFpsf4Q==
X-Google-Smtp-Source: APXvYqyEPA92VZhS3xxQeFKScVEsUj7mIQ8rFuTx0ebpXyWIj6ArhDkXBEq/yZKbA0DxdhRp247jmg==
X-Received: by 2002:a17:90a:256d:: with SMTP id
 j100mr1398633pje.126.1565649884352; 
 Mon, 12 Aug 2019 15:44:44 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id y16sm7675156pfc.36.2019.08.12.15.44.43
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 12 Aug 2019 15:44:43 -0700 (PDT)
Date: Mon, 12 Aug 2019 15:44:43 -0700 (PDT)
X-Google-Original-Date: Mon, 12 Aug 2019 15:41:46 PDT (-0700)
In-Reply-To: <1563543645-20804-1-git-send-email-linux@roeck-us.net>
From: Palmer Dabbelt <palmer@sifive.com>
To: linux@roeck-us.net
Message-ID: <mhng-ed1aa538-1ac8-4013-a274-f9c3a9a71fd0@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.194
Subject: Re: [Qemu-devel] [PATCH 1/3] riscv: sifive_u: Add support for
 loading initrd
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
Cc: qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, linux@roeck-us.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 19 Jul 2019 06:40:43 PDT (-0700), linux@roeck-us.net wrote:
> Add support for loading initrd with "-initrd <filename>"
> to the sifive_u machine. This lets us boot into Linux without
> disk drive.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  hw/riscv/sifive_u.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 71b8083..0657046 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -67,7 +67,7 @@ static const struct MemmapEntry {
>
>  #define GEM_REVISION        0x10070109
>
> -static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
> +static void *create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      uint64_t mem_size, const char *cmdline)
>  {
>      void *fdt;
> @@ -244,11 +244,14 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>          qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
>      }
>      g_free(nodename);
> +
> +    return fdt;
>  }
>
>  static void riscv_sifive_u_init(MachineState *machine)
>  {
>      const struct MemmapEntry *memmap = sifive_u_memmap;
> +    void *fdt;
>
>      SiFiveUState *s = g_new0(SiFiveUState, 1);
>      MemoryRegion *system_memory = get_system_memory();
> @@ -269,13 +272,24 @@ static void riscv_sifive_u_init(MachineState *machine)
>                                  main_mem);
>
>      /* create device tree */
> -    create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
> +    fdt = create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
>
>      riscv_find_and_load_firmware(machine, BIOS_FILENAME,
>                                   memmap[SIFIVE_U_DRAM].base);
>
>      if (machine->kernel_filename) {
> -        riscv_load_kernel(machine->kernel_filename);
> +        uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename);
> +
> +        if (machine->initrd_filename) {
> +            hwaddr start;
> +            hwaddr end = riscv_load_initrd(machine->initrd_filename,
> +                                           machine->ram_size, kernel_entry,
> +                                           &start);
> +            qemu_fdt_setprop_cell(fdt, "/chosen",
> +                                  "linux,initrd-start", start);
> +            qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
> +                                  end);
> +        }
>      }
>
>      /* reset vector */

Thanks.  I've queued all three of these.

