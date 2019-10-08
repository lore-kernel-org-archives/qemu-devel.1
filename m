Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F61C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 20:15:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45F1A206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 20:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F1A206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHvsv-0005PP-0d
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 16:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59143)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iHvqI-0003WP-7x
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 16:12:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iHvqF-0002Kc-Ni
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 16:12:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39840)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iHvqC-0002H5-PS
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 16:12:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id e1so10890155pgj.6
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 13:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=aThD0x6UFYPktJOEJAqWVZoA7jk9LW2iErdUgQ0f3WE=;
 b=eHyGcZHhTyR8sDboCzt43MJMbOmHTIzHeX5/nOebE3TWG9xsb0l3MjWjNWOF8UHRc+
 B6+WM53pVW0hPZ9TThNwkqHUWZqW5CpjCaXgEsbWQHradjjuKs2QxSRTqDQhOrM004Wr
 /3AP8coGfkjG7nQ44fECY9jXoJwT/7ngPKa0+EouS9D8hZzkza3smOr5wtU7jxTIjq4b
 IiO4oQL4jMPFQFDqNIkQFkrZ1TpS5TZ4REqS8rIHlz9NHyDlhXg1Uy+geHdcStjHukbq
 /QO2SzhwO660wXqv1KCPSvJTN6b+tM8eOGqNRstEtkoisMK9a13/9Mgp1URhb5zk0wLD
 NR5w==
X-Gm-Message-State: APjAAAVvWqw/hP5gbjrA906vAo5D0GjOZM83jjxV6eitOylVjM3+/K1J
 If4O/kTKGPTTBvlA6zBxV+bFGA==
X-Google-Smtp-Source: APXvYqyvUG0tGBfIUBcjgigNfCTFo+mSG9AGIa0/fKPgOXMsm5DMKNX/EglMY9Y1xqrI7UZS+nPHhA==
X-Received: by 2002:aa7:9f43:: with SMTP id h3mr41669199pfr.215.1570565533190; 
 Tue, 08 Oct 2019 13:12:13 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id s1sm38267pjs.31.2019.10.08.13.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 13:12:12 -0700 (PDT)
Date: Tue, 08 Oct 2019 13:12:12 -0700 (PDT)
X-Google-Original-Date: Tue, 08 Oct 2019 13:11:55 PDT (-0700)
Subject: Re: [PATCH v2 4/7] riscv/sifive_u: Add the start-in-flash property
In-Reply-To: <CAKmqyKPMOAq3oeU-_MQHBAbzTv__iKr=uR8WkCfGbH8yk4afFg@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: alistair23@gmail.com
Message-ID: <mhng-1d294790-a5b7-4fa7-8b5e-9adf550c5d1a@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.196
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
Cc: qemu-riscv@nongnu.org, bmeng.cn@gmail.com,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 30 Sep 2019 11:04:45 PDT (-0700), alistair23@gmail.com wrote:
> On Fri, Sep 27, 2019 at 12:57 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>>
>> On Fri, Sep 27, 2019 at 8:55 AM Alistair Francis
>> <alistair.francis@wdc.com> wrote:
>> >
>> > Add a property that when set to true QEMU will jump from the ROM code to
>> > the start of flash memory instead of DRAM which is the default
>> > behaviour.
>> >
>> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> > ---
>> >  hw/riscv/sifive_u.c         | 27 +++++++++++++++++++++++++++
>> >  include/hw/riscv/sifive_u.h |  2 ++
>> >  2 files changed, 29 insertions(+)
>> >
>> > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
>> > index f5741e9a38..33b55d0d5b 100644
>> > --- a/hw/riscv/sifive_u.c
>> > +++ b/hw/riscv/sifive_u.c
>> > @@ -373,6 +373,10 @@ static void riscv_sifive_u_init(MachineState *machine)
>> >                                         /* dtb: */
>> >      };
>> >
>> > +    if (s->start_in_flash) {
>> > +        reset_vec[6] = memmap[SIFIVE_U_FLASH0].base; /* start: .dword FLASH0_BASE */
>> > +    }
>>
>> Please change to use the way that patch "[v2,7/7] riscv/virt: Jump to
>> pflash if specified" does for consistency, ie:
>>
>>     if (s->start_in_flash) {
>>         start_addr = memmap[SIFIVE_U_FLASH0].base; /* start: .dword
>> FLASH0_BASE */
>>     }
>>
>> > +
>> >      /* copy in the reset vector in little_endian byte order */
>> >      for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
>> >          reset_vec[i] = cpu_to_le32(reset_vec[i]);
>> > @@ -432,8 +436,31 @@ static void riscv_sifive_u_soc_init(Object *obj)
>> >                            TYPE_CADENCE_GEM);
>> >  }
>> >
>> > +static bool virt_get_start_in_flash(Object *obj, Error **errp)
>>
>> sifive_u_get_start_in_flash()
>>
>> > +{
>> > +    SiFiveUState *s = RISCV_U_MACHINE(obj);
>> > +
>> > +    return s->start_in_flash;
>> > +}
>> > +
>> > +static void virt_set_start_in_flash(Object *obj, bool value, Error **errp)
>>
>> sifive_u_set_start_in_flash()
>
> Yep, I have fixed all of these.

Did I miss the v3?

>
> Alistair
>
>>
>> > +{
>> > +    SiFiveUState *s = RISCV_U_MACHINE(obj);
>> > +
>> > +    s->start_in_flash = value;
>> > +}
>> > +
>> >  static void riscv_sifive_u_machine_instance_init(Object *obj)
>> >  {
>> > +    SiFiveUState *s = RISCV_U_MACHINE(obj);
>> > +
>> > +    s->start_in_flash = false;
>> > +    object_property_add_bool(obj, "start-in-flash", virt_get_start_in_flash,
>> > +                             virt_set_start_in_flash, NULL);
>> > +    object_property_set_description(obj, "start-in-flash",
>> > +                                    "Set on to tell QEMU's ROM to jump to " \
>> > +                                    "flash. Otherwise QEMU will jump to DRAM",
>> > +                                    NULL);
>> >  }
>> >
>> >  static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
>> > diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
>> > index a921079fbe..2656b43c58 100644
>> > --- a/include/hw/riscv/sifive_u.h
>> > +++ b/include/hw/riscv/sifive_u.h
>> > @@ -57,6 +57,8 @@ typedef struct SiFiveUState {
>> >
>> >      void *fdt;
>> >      int fdt_size;
>> > +
>> > +    bool start_in_flash;
>> >  } SiFiveUState;
>> >
>>
>> Regards,
>> Bin

