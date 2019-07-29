Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD67C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 19:47:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9090A2054F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 19:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9090A2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsBcj-0005L8-OT
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 15:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38875)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hsBc4-0004nL-RE
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 15:47:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hsBc1-000310-P0
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 15:47:15 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34285)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hsBby-0002zi-5X
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 15:47:10 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so27925850plt.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 12:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=W/z83AzHFaw3DGAxqhEjaZdGLVFWMoRJnIy84bro/BA=;
 b=GEuEgCrpASPoIY7/TJrpIKe0vYyOZH9FnWMPGY55TMsJTP2tPLE16LN4r5bSkhIULr
 iY8xJphDs8sP+9VXeo5JO5ci5RfC16d/hXs9K2oxaFTCJVuE19FtlGKR76M02WRbQ3yt
 feyhbTB2Vj0xCMlzs0oExeGIbyadOHNN4uIVqg6Gwnu++S997aDFyjTplkpUpQAVLrLD
 WYT27TvYjIUbpv9rtF8oCZNgNzPF1sNqYvqTySvLHLI8ifL+5ID7VYiHFCrWI25O7G/5
 pJaLh33EmCRXVi/cpi+SQJeYXsgVO3pNzPcb+EBJ1WO03/ihIpSRp/BVVt+z0eNpUoJb
 a1rg==
X-Gm-Message-State: APjAAAWhhsJf9efEsoE4Fk/Ef/674V2KsOV4KNtQs2gzMgCVXWdUKq0g
 PQ+Q1v0z3yTzRHC+EcXkc9U=
X-Google-Smtp-Source: APXvYqzut3i/aGaWphpOb2tpNZduIsZZe2FObezlR1A5+vg9ZVe9PdQwlpGjnhYnqOB8LpU1+Wd6cA==
X-Received: by 2002:a17:902:2983:: with SMTP id
 h3mr112554620plb.45.1564429628364; 
 Mon, 29 Jul 2019 12:47:08 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id x26sm80575076pfq.69.2019.07.29.12.47.07
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 29 Jul 2019 12:47:07 -0700 (PDT)
Date: Mon, 29 Jul 2019 12:47:07 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Jul 2019 12:46:56 PDT (-0700)
In-Reply-To: <CAEUhbmWfS8TPTRa-Ovc1gnPUC-3ofA4G+sR7PaSNzfWT-fPNfQ@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: bmeng.cn@gmail.com
Message-ID: <mhng-2dc6a880-670f-449e-9361-9cf2ae4af4ee@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.196
Subject: Re: [Qemu-devel] [PATCH] riscv: sifive_test: Add reset functionality
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 22 Jul 2019 22:30:15 PDT (-0700), bmeng.cn@gmail.com wrote:
> Hi Palmer,
>
> On Sat, Jul 20, 2019 at 9:47 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> On Fri, 14 Jun 2019 08:15:51 PDT (-0700), bmeng.cn@gmail.com wrote:
>> > This adds a reset opcode for sifive_test device to trigger a system
>> > reset for testing purpose.
>> >
>> > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>> > ---
>> >
>> >  hw/riscv/sifive_test.c         | 4 ++++
>> >  include/hw/riscv/sifive_test.h | 3 ++-
>> >  2 files changed, 6 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
>> > index 24a04d7..cd86831 100644
>> > --- a/hw/riscv/sifive_test.c
>> > +++ b/hw/riscv/sifive_test.c
>> > @@ -21,6 +21,7 @@
>> >  #include "qemu/osdep.h"
>> >  #include "hw/sysbus.h"
>> >  #include "qemu/module.h"
>> > +#include "sysemu/sysemu.h"
>> >  #include "target/riscv/cpu.h"
>> >  #include "hw/riscv/sifive_test.h"
>> >
>> > @@ -40,6 +41,9 @@ static void sifive_test_write(void *opaque, hwaddr addr,
>> >              exit(code);
>> >          case FINISHER_PASS:
>> >              exit(0);
>> > +        case FINISHER_RESET:
>> > +            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>> > +            return;
>> >          default:
>> >              break;
>> >          }
>> > diff --git a/include/hw/riscv/sifive_test.h b/include/hw/riscv/sifive_test.h
>> > index 71d4c9f..c186a31 100644
>> > --- a/include/hw/riscv/sifive_test.h
>> > +++ b/include/hw/riscv/sifive_test.h
>> > @@ -34,7 +34,8 @@ typedef struct SiFiveTestState {
>> >
>> >  enum {
>> >      FINISHER_FAIL = 0x3333,
>> > -    FINISHER_PASS = 0x5555
>> > +    FINISHER_PASS = 0x5555,
>> > +    FINISHER_RESET = 0x7777
>> >  };
>> >
>> >  DeviceState *sifive_test_create(hwaddr addr);
>>
>> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
>
> Thanks a lot!
>
>> Sorry this took a while, but it's in the hardware now.  I'll merge this, but
>> I'm considering it a new feature so it'll be held off a bit.
>
> "but it's in the hardware now", do you mean the code I added (0x7777)
> is now supported by a newer version SiFive test device with compatible
> string "sifive,test1", and can actually do the system wide reset?

No, the hardware is still a "sifive,test0" as plumbing through the reset is
trickier than I wanted to take on.  I just reserved the 0x7777 code and
implemented it by triggering an unsupported function error, so we don't
accidentally use it for something else later.

