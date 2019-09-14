Return-Path: <SRS0=fVwN=XJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD29C4CEC9
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 19:03:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 292A320692
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 19:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292A320692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9DK5-0003Jg-5T
	for qemu-devel@archiver.kernel.org; Sat, 14 Sep 2019 15:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i9DHl-0002lZ-SO
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 15:00:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i9DHk-0001vY-Et
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 15:00:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39893)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i9DHk-0001v8-8z
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 15:00:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id i1so11190532pfa.6
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2019 12:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=Q+ZtLM++dtjWC3FwNLOVxw/kKAndyJKMVCk+RAU58YA=;
 b=raZuQOQnEqcMhhaDE3av1bKEPS3sOwGFbEuauvgtGm9BawRpjlDZKgfEEJzzHKD1xp
 vkaiOzZt+0beh5kamvUWQdx6gtL+TyZqFRJpKz0i1TWg7IwC2DvM/XMI+LRwbPTIwueH
 ddT/f0EWdTlxqoidTCjzrp/GXBlOVkkLGvQg7dJycZSPlVSLsZmgJW8cFJYcilforXLE
 IGzMxbxscVX3L+Bku3rezLSx92HLDq4tflnUrflsBKfOlFbkvH6TXIkEaEUP1yW+NcGS
 ED5gEKJXMCF/99dAVGEragSRxLd729oP66woS360VaRI9MoLlIRDSL26ed3+Df1dtNFp
 pfCg==
X-Gm-Message-State: APjAAAWXeBiv+kT+LkdRBfL0Ek9Mbn722yQFNiFIqGcw8QpdMFKf6e0d
 Jpgqw0BzyV+SAPK0WNuU2IUZHg==
X-Google-Smtp-Source: APXvYqxp61xa6q5WJXeDgHu6godzYQIzCGF/Auzz5QzwereCL5qmpi78AzClM0NV1a+UJtkvV6ZIsQ==
X-Received: by 2002:a63:590f:: with SMTP id n15mr37897296pgb.190.1568487638232; 
 Sat, 14 Sep 2019 12:00:38 -0700 (PDT)
Received: from localhost (amx-tls3.starhub.net.sg. [203.116.164.13])
 by smtp.gmail.com with ESMTPSA id q22sm38030167pgh.49.2019.09.14.12.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Sep 2019 12:00:37 -0700 (PDT)
Date: Sat, 14 Sep 2019 12:00:37 -0700 (PDT)
X-Google-Original-Date: Sat, 14 Sep 2019 11:54:31 PDT (-0700)
In-Reply-To: <CAEUhbmUksfEiGLZ0qzsWkaDOaocTvkEYefiSUmGZT7TftYfmEg@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: bmeng.cn@gmail.com
Message-ID: <mhng-165ebd8f-3595-48d3-a614-79f52d81c14c@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.196
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

On Fri, 13 Sep 2019 08:25:21 PDT (-0700), bmeng.cn@gmail.com wrote:
> Hi Palmer,
>
> On Fri, Sep 13, 2019 at 10:33 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> On Fri, 06 Sep 2019 09:20:05 PDT (-0700), bmeng.cn@gmail.com wrote:
>> > It is not useful if we only have one management CPU.
>> >
>> > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> >
>> > ---
>> >
>> > Changes in v8: None
>> > Changes in v7: None
>> > Changes in v6: None
>> > Changes in v5: None
>> > Changes in v4: None
>> > Changes in v3:
>> > - use management cpu count + 1 for the min_cpus
>> >
>> > Changes in v2:
>> > - update the file header to indicate at least 2 harts are created
>> >
>> >  hw/riscv/sifive_u.c         | 4 +++-
>> >  include/hw/riscv/sifive_u.h | 2 ++
>> >  2 files changed, 5 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
>> > index 2947e06..2023b71 100644
>> > --- a/hw/riscv/sifive_u.c
>> > +++ b/hw/riscv/sifive_u.c
>> > @@ -10,7 +10,8 @@
>> >   * 1) CLINT (Core Level Interruptor)
>> >   * 2) PLIC (Platform Level Interrupt Controller)
>> >   *
>> > - * This board currently uses a hardcoded devicetree that indicates one hart.
>> > + * This board currently generates devicetree dynamically that indicates at least
>> > + * two harts.
>> >   *
>> >   * This program is free software; you can redistribute it and/or modify it
>> >   * under the terms and conditions of the GNU General Public License,
>> > @@ -433,6 +434,7 @@ static void riscv_sifive_u_machine_init(MachineClass *mc)
>> >       * management CPU.
>> >       */
>> >      mc->max_cpus = 4;
>> > +    mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
>> >  }
>> >
>> >  DEFINE_MACHINE("sifive_u", riscv_sifive_u_machine_init)
>> > diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
>> > index f25bad8..6d22741 100644
>> > --- a/include/hw/riscv/sifive_u.h
>> > +++ b/include/hw/riscv/sifive_u.h
>> > @@ -69,6 +69,8 @@ enum {
>> >      SIFIVE_U_GEM_CLOCK_FREQ = 125000000
>> >  };
>> >
>> > +#define SIFIVE_U_MANAGEMENT_CPU_COUNT   1
>> > +
>> >  #define SIFIVE_U_PLIC_HART_CONFIG "MS"
>> >  #define SIFIVE_U_PLIC_NUM_SOURCES 54
>> >  #define SIFIVE_U_PLIC_NUM_PRIORITIES 7
>>
>> This fails "make check", so I'm going to squash in this
>>
>> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
>> index ca9f7fea41..adecbf1dd9 100644
>> --- a/hw/riscv/sifive_u.c
>> +++ b/hw/riscv/sifive_u.c
>> @@ -528,6 +528,7 @@ static void riscv_sifive_u_machine_init(MachineClass *mc)
>>      mc->init = riscv_sifive_u_init;
>>      mc->max_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + SIFIVE_U_COMPUTE_CPU_COUNT;
>>      mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
>> +    mc->default_cpus = mc->max_cpus;
>
> Thank you for fixing the 'make check'. Shouldn't it be:
>
> mc->default_cpus = mc->min_cpus;

We have 5 harts on the board that this matches, so I figured that'd be the 
better default.

>
> ?
>
>>  }
>>
>>  DEFINE_MACHINE("sifive_u", riscv_sifive_u_machine_init)
>
> Regards,
> Bin

