Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9BDC33CB2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 00:21:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0DFB207FF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 00:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nq1Ll5Qo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0DFB207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irsui-0003pD-4w
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 19:21:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1irsu2-0003E0-I9
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 19:20:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1irsu1-0005dI-EV
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 19:20:50 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:37637)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1irsu1-0005cn-7b; Wed, 15 Jan 2020 19:20:49 -0500
Received: by mail-lj1-x242.google.com with SMTP id o13so20582671ljg.4;
 Wed, 15 Jan 2020 16:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=x6priJw6+QrEtabMGVbDfowA8nF2er6fYbgYQFpCTGs=;
 b=nq1Ll5QofaeXwzrT+Cg4HWWsTpP3TR5yiU2nnYzmffpQQFNx5hhpUcExnrC9hq0n6i
 Et61UHK+6b4TJuuq5821W/QjfLrV6kEzgeJgeNh/SlQLGhkDlh3/YzAg7HhxtZioQ4h5
 wzN/OCrSy57jIpTbvNqF4QtR47Qr0WTRlxEhr3M5Yj7YA9BcCZHb30OKcmWOlr4IBVg+
 BH6xVwxCMNrSz1LP6xF8kmuYdNPuTqGJAcH9j1/edM6LU8cWia+2m91RIqfKgbCF5sAa
 DwZ14VUBapeSfYeYXWnnLzY77Y0l18B5+Ts4ki/qf4s3A+WO/dWNMvOcxB/Hg2brV+7F
 jhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x6priJw6+QrEtabMGVbDfowA8nF2er6fYbgYQFpCTGs=;
 b=cFsjaUFeWbZ1VejPDSnsnN5EGVX/wJslevej/PiLGg4QSa5LSXQP/OhG1DhLBDewok
 eqPVgEkpctLR2QHlDvYh7QUHv6Ji3B+vT8eQ/JsBu0r31OzPs/rzaJbfVVYdZw7rn16h
 nTt6OJuffgrFYz6mBm45NjpClWtyslPmmh2BlVti7ZDrDhRIqco+ARDU1FdMSJFjHLJ2
 uG99npDd555dX/w28sPITMO1YpDQkKn0Fifp2vqgj+illBuWXIc52Dy92QZhXX0N1tfg
 cxihi1FNWFdcvQ5kJ2lq2CiA9Ptpe3J2PQ7/j6TfyORGrsKxy8puz/HSFgj3rFru7Vjl
 JFbw==
X-Gm-Message-State: APjAAAUZhjdG4hn1I7GQwuJ5wjc5tdl/zxq8c2WVAvZa7MYqYJth/YzO
 L6Lv2uk0yv6VC+4PSL/XY1Tusyxs4/99elZTIuM=
X-Google-Smtp-Source: APXvYqzF7aNKfA+Tv62TQjV+AhwJBcWB6xTb5jxoh1Qdcd3Fh4m2oQ2y7IAXo+NWLEFnxbM9b0U6dc/E67TPSOf9JlI=
X-Received: by 2002:a2e:461a:: with SMTP id t26mr572786lja.204.1579134047672; 
 Wed, 15 Jan 2020 16:20:47 -0800 (PST)
MIME-Version: 1.0
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-36-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579100861-73692-36-git-send-email-imammedo@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 Jan 2020 10:20:20 +1000
Message-ID: <CAKmqyKPS0i5P1Tgsu6bVidsAD-JjHMxE-10Pa72Z+dbXJWowdg@mail.gmail.com>
Subject: Re: [PATCH v2 35/86] arm:xilinx_zynq: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 Edgar Iglesias <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 16, 2020 at 1:29 AM Igor Mammedov <imammedo@redhat.com> wrote:
>
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>   MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> CC: peter.maydell@linaro.org
> CC: qemu-arm@nongnu.org
> CC: edgar.iglesias@gmail.com
> CC: alistair@alistair23.me
> ---
>  hw/arm/xilinx_zynq.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> index df950fc..0ef9688 100644
> --- a/hw/arm/xilinx_zynq.c
> +++ b/hw/arm/xilinx_zynq.c
> @@ -160,7 +160,6 @@ static void zynq_init(MachineState *machine)
>  {
>      ARMCPU *cpu;
>      MemoryRegion *address_space_mem = get_system_memory();
> -    MemoryRegion *ext_ram = g_new(MemoryRegion, 1);
>      MemoryRegion *ocm_ram = g_new(MemoryRegion, 1);
>      DeviceState *dev;
>      SysBusDevice *busdev;
> @@ -190,9 +189,7 @@ static void zynq_init(MachineState *machine)
>      object_property_set_bool(OBJECT(cpu), true, "realized", &error_fatal);
>
>      /* DDR remapped to address zero.  */
> -    memory_region_allocate_system_memory(ext_ram, NULL, "zynq.ext_ram",
> -                                         machine->ram_size);
> -    memory_region_add_subregion(address_space_mem, 0, ext_ram);
> +    memory_region_add_subregion(address_space_mem, 0, machine->ram);
>
>      /* 256K of on-chip memory */
>      memory_region_init_ram(ocm_ram, NULL, "zynq.ocm_ram", 256 * KiB,
> @@ -318,6 +315,7 @@ static void zynq_machine_init(MachineClass *mc)
>      mc->no_sdcard = 1;
>      mc->ignore_memory_transaction_failures = true;
>      mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
> +    mc->default_ram_id = "zynq.ext_ram";
>  }
>
>  DEFINE_MACHINE("xilinx-zynq-a9", zynq_machine_init)
> --
> 2.7.4
>
>

