Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3752EC4CECC
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 17:32:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E14E214AF
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 17:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E14E214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9YNu-00018T-4P
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 13:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i9YNF-0000fE-Rg
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 13:31:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i9YNE-0000pk-Dh
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 13:31:45 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46077)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i9YNE-0000pC-7Q
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 13:31:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id x3so15565317plr.12
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2019 10:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=AcZuMAvo6Y6ynYqFbcdB5Oswg+L/1Zt69yJpjOGhBlI=;
 b=SedGwvzs6UWzWRsuVLr9XU1qvi4kr52Q4LlKUVud5Dnse85GU5+gLcPEFhbzd9BKYQ
 5Rekdb629XXRGlVABlMMQT10qPcGQvAJkoJeOveqq4GsUjAc9WdnnWjeH5vHdcZpmj3R
 wDeudUOUCYwwiZInZr0vqxKcpmd7Xmqy/Go0Tg/r7q5tPUcmT9GPQbNqgY8wl7JgktTV
 BT8G1X6ieEk4J/1AFkDr0THAsDyunXv/Ghl0v+SxouHdtaLUbTK02VWa/XDmhTRk/Wxl
 FhIrQ3kHe6xrvvVZkhihPplzdOjsm7fJx+3i2eulGQJ+Iho6c36MlPmvhxE+UqWTJTJF
 bvFw==
X-Gm-Message-State: APjAAAVrazt2EvlLcsDVbZKYpXSsZBkuleo+Em7F2LT8XzTB4HFUuWOd
 rYdJFizHERd9JwArPijXK+cykw==
X-Google-Smtp-Source: APXvYqwErCSc7/WepDYAhTkz9V2MOuuRCfybMYaVCzOFxsNC4UaGyq5tDCazIbBw7MkveBqo3S0NxA==
X-Received: by 2002:a17:902:868a:: with SMTP id
 g10mr50253088plo.220.1568568702912; 
 Sun, 15 Sep 2019 10:31:42 -0700 (PDT)
Received: from localhost (amx-tls3.starhub.net.sg. [203.116.164.13])
 by smtp.gmail.com with ESMTPSA id j126sm36399350pfb.186.2019.09.15.10.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2019 10:31:42 -0700 (PDT)
Date: Sun, 15 Sep 2019 10:31:42 -0700 (PDT)
X-Google-Original-Date: Sun, 15 Sep 2019 10:25:20 PDT (-0700)
In-Reply-To: <CAEUhbmV=v62a0CAHe2mt1Qzz0n+fESgVYDtjdoXfyhH6_j5zFw@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: bmeng.cn@gmail.com
Message-ID: <mhng-da766f03-2535-4a8c-97aa-1f85f986bee3@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.194
Subject: Re: [Qemu-devel] [PATCH v8 18/32] riscv: sifive_u: Set the minimum
 number of cpus to 2
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
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 15 Sep 2019 06:07:18 PDT (-0700), bmeng.cn@gmail.com wrote:
> Hi Palmer,
>
> On Sun, Sep 15, 2019 at 3:00 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> On Fri, 13 Sep 2019 08:25:21 PDT (-0700), bmeng.cn@gmail.com wrote:
>> > Hi Palmer,
>> >
>> > On Fri, Sep 13, 2019 at 10:33 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>> >>
>> >> On Fri, 06 Sep 2019 09:20:05 PDT (-0700), bmeng.cn@gmail.com wrote:
>> >> > It is not useful if we only have one management CPU.
>> >> >
>> >> > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>> >> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> >> >
>> >> > ---
>> >> >
>> >> > Changes in v8: None
>> >> > Changes in v7: None
>> >> > Changes in v6: None
>> >> > Changes in v5: None
>> >> > Changes in v4: None
>> >> > Changes in v3:
>> >> > - use management cpu count + 1 for the min_cpus
>> >> >
>> >> > Changes in v2:
>> >> > - update the file header to indicate at least 2 harts are created
>> >> >
>> >> >  hw/riscv/sifive_u.c         | 4 +++-
>> >> >  include/hw/riscv/sifive_u.h | 2 ++
>> >> >  2 files changed, 5 insertions(+), 1 deletion(-)
>> >> >
>> >> > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
>> >> > index 2947e06..2023b71 100644
>> >> > --- a/hw/riscv/sifive_u.c
>> >> > +++ b/hw/riscv/sifive_u.c
>> >> > @@ -10,7 +10,8 @@
>> >> >   * 1) CLINT (Core Level Interruptor)
>> >> >   * 2) PLIC (Platform Level Interrupt Controller)
>> >> >   *
>> >> > - * This board currently uses a hardcoded devicetree that indicates one hart.
>> >> > + * This board currently generates devicetree dynamically that indicates at least
>> >> > + * two harts.
>> >> >   *
>> >> >   * This program is free software; you can redistribute it and/or modify it
>> >> >   * under the terms and conditions of the GNU General Public License,
>> >> > @@ -433,6 +434,7 @@ static void riscv_sifive_u_machine_init(MachineClass *mc)
>> >> >       * management CPU.
>> >> >       */
>> >> >      mc->max_cpus = 4;
>> >> > +    mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
>> >> >  }
>> >> >
>> >> >  DEFINE_MACHINE("sifive_u", riscv_sifive_u_machine_init)
>> >> > diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
>> >> > index f25bad8..6d22741 100644
>> >> > --- a/include/hw/riscv/sifive_u.h
>> >> > +++ b/include/hw/riscv/sifive_u.h
>> >> > @@ -69,6 +69,8 @@ enum {
>> >> >      SIFIVE_U_GEM_CLOCK_FREQ = 125000000
>> >> >  };
>> >> >
>> >> > +#define SIFIVE_U_MANAGEMENT_CPU_COUNT   1
>> >> > +
>> >> >  #define SIFIVE_U_PLIC_HART_CONFIG "MS"
>> >> >  #define SIFIVE_U_PLIC_NUM_SOURCES 54
>> >> >  #define SIFIVE_U_PLIC_NUM_PRIORITIES 7
>> >>
>> >> This fails "make check", so I'm going to squash in this
>> >>
>> >> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
>> >> index ca9f7fea41..adecbf1dd9 100644
>> >> --- a/hw/riscv/sifive_u.c
>> >> +++ b/hw/riscv/sifive_u.c
>> >> @@ -528,6 +528,7 @@ static void riscv_sifive_u_machine_init(MachineClass *mc)
>> >>      mc->init = riscv_sifive_u_init;
>> >>      mc->max_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + SIFIVE_U_COMPUTE_CPU_COUNT;
>> >>      mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
>> >> +    mc->default_cpus = mc->max_cpus;
>> >
>> > Thank you for fixing the 'make check'. Shouldn't it be:
>> >
>> > mc->default_cpus = mc->min_cpus;
>>
>> We have 5 harts on the board that this matches, so I figured that'd be the
>> better default.
>>
>
> Per my understanding mc->default_cpus is used when invoking QEMU
> without passing '-smp n' (that's what 'make check' uses), and with the
> updated sifive_u machine, '-smp 2' is the actual useful configuration
> to boot Linux. For consistency with user experience on other machines,
> without '-smp' means we want a uni-processor machine hence I would
> suggest we set "mc->default_cpus = mc->min_cpus".

OK, I've spun a v3.  I never sent out v2 but I had tagged it, unless there's 
any opposition I'll send this out when I'm back on normal internet.

