Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894ABC32771
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 00:20:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52EAD2081E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 00:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVb7As/Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52EAD2081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irstm-0002oY-BC
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 19:20:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1irst7-0002Dt-IO
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 19:19:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1irst6-0005ER-GU
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 19:19:53 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:45012)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1irst6-0005Dm-9j; Wed, 15 Jan 2020 19:19:52 -0500
Received: by mail-lj1-x243.google.com with SMTP id u71so20546362lje.11;
 Wed, 15 Jan 2020 16:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UerpdH8qP3g09zrjSHt1MAgeDc1zRn7uxgSjjIeF8zc=;
 b=UVb7As/Y0GKsccaEGgHpdupb1keeOOH/LiOjZh/HlFIl0keilCavi4DkdaGKIQBj7T
 eWkqxFujoW06O0YD0oKoFrszjATouRtW6mKgRSByED/gvR0CflI5JBB/+n8hHmgW1fQ7
 DXkB0LUvM3lFoCnPyVoT36UN8bW/MNLpoXGok0VCAY9oASLIQ+xrqhsaSbdJrb2Q9i+N
 nvnYweQeXfjJtn1aPEyd+6XfCSa3pnYTPxXklVAP0udxUIGp0cdibRx6stE2LEGBVBVH
 M8paLHrkFmmuifhECsunIep5KFCF/00bm5tjUDfsB+4kq3iMqv+9lSXkwvJJ3qKhmQOM
 wGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UerpdH8qP3g09zrjSHt1MAgeDc1zRn7uxgSjjIeF8zc=;
 b=UC+aaHZUy2oOLgOw/1A0cwxfWSFxgiQvChwYqzyHJefHedd2cBQTMTFiLyCLf65RjS
 uLSwjCRM9svhiH0NC1bc/bjRQawzoyQZc20sEHcT6MAJCVIdM1tYSvihpaV1+bilJdhO
 5PD2NdyId3K5ESBxNEGgrKqG9q8Okw62y0NtyF2aeNIrM5XfXwLbH4s9wyvT8d7RkKpr
 csGWO0mwXuMofpGk+qusqghMTO9rVJv4UVuKkGvG9G6w1c9M8XwCn/G/vojBE1gdiZ5k
 QqwXIDerSvUaGP0oq2FB5RIxFXrg1P0rImX6GTnYCERTfk4HrRs3H5OGJKCPHdSY+7Iw
 9/IQ==
X-Gm-Message-State: APjAAAXobalHEhEgt3QDAsRAZdA1EA9CL0FtgyPu5J3fwhTSiZG9meaJ
 vWJW1zT6slRc4FNw7MLAsD79SPLqDAsFDURbxFQ=
X-Google-Smtp-Source: APXvYqzI5CA+jcHKOwLdvlwrrPy5+8YpRTgC9awc8jULOLgdRdSrjkV2WWbjfSHAZ5sqELeQEfKgXfWMAAd4Xc7LpE0=
X-Received: by 2002:a2e:9157:: with SMTP id q23mr591405ljg.196.1579133990898; 
 Wed, 15 Jan 2020 16:19:50 -0800 (PST)
MIME-Version: 1.0
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-38-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579100861-73692-38-git-send-email-imammedo@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 Jan 2020 10:19:24 +1000
Message-ID: <CAKmqyKMOTaGG8tU_eQ2CpC1ZA6OpoykKJS2KCeWgRZYUFsab+A@mail.gmail.com>
Subject: Re: [PATCH v2 37/86] arm:xlnx-zcu102: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
Cc: Edgar Iglesias <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 16, 2020 at 1:39 AM Igor Mammedov <imammedo@redhat.com> wrote:
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
> CC: alistair@alistair23.me
> CC: edgar.iglesias@gmail.com
> CC: peter.maydell@linaro.org
> CC: qemu-arm@nongnu.org
> ---
>  hw/arm/xlnx-zcu102.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
> index 53cfe7c..bd645ad 100644
> --- a/hw/arm/xlnx-zcu102.c
> +++ b/hw/arm/xlnx-zcu102.c
> @@ -28,7 +28,6 @@ typedef struct XlnxZCU102 {
>      MachineState parent_obj;
>
>      XlnxZynqMPState soc;
> -    MemoryRegion ddr_ram;
>
>      bool secure;
>      bool virt;
> @@ -87,13 +86,10 @@ static void xlnx_zcu102_init(MachineState *machine)
>                   ram_size);
>      }
>
> -    memory_region_allocate_system_memory(&s->ddr_ram, NULL, "ddr-ram",
> -                                         ram_size);
> -
>      object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
>                              TYPE_XLNX_ZYNQMP, &error_abort, NULL);
>
> -    object_property_set_link(OBJECT(&s->soc), OBJECT(&s->ddr_ram),
> +    object_property_set_link(OBJECT(&s->soc), OBJECT(machine->ram),
>                           "ddr-ram", &error_abort);
>      object_property_set_bool(OBJECT(&s->soc), s->secure, "secure",
>                               &error_fatal);
> @@ -211,6 +207,7 @@ static void xlnx_zcu102_machine_class_init(ObjectClass *oc, void *data)
>      mc->ignore_memory_transaction_failures = true;
>      mc->max_cpus = XLNX_ZYNQMP_NUM_APU_CPUS + XLNX_ZYNQMP_NUM_RPU_CPUS;
>      mc->default_cpus = XLNX_ZYNQMP_NUM_APU_CPUS;
> +    mc->default_ram_id = "ddr-ram";
>  }
>
>  static const TypeInfo xlnx_zcu102_machine_init_typeinfo = {
> --
> 2.7.4
>
>

