Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7234DC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 02:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B7FD2070B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 02:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7FD2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54352 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he9hW-0004xB-DW
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 22:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34308)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1he9fz-0004QQ-62
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 22:53:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1he9fx-00035N-Te
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 22:53:19 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33792)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1he9fx-00031y-Lw
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 22:53:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id c85so2789697pfc.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 19:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=1sg7t4xVmFFuHBhmUA6Os6hJRKuxDj/Ex9oY3/bsjjI=;
 b=DhjULsqG158VjDrRMUsgR2BQaxJ12/XPWRAJXZZ0kCNaYhjAJJzuMOo3EUwxIgkeW0
 OIy6RHHSMimAFtfvR30NPaf20ezVNexAGKmF+REDHa47LdY/im+zyqcLbg92qz7PZXO6
 EHsoVoCBuui+hy5IHBaF6PbgsTVlupCpYuNDgi0gXbCeT1uTEu3o7MDxETiOad772f5f
 z7WJYoHtcjmE2gy24sfyB21JnJjpuQ6JhqYnnP1eGyj2wBQPK1Z9lSU0CjhlXTyrC+8e
 KNKKsuLWpxhXOin46qjvVlQzkD2udvQGdZnXmtMsqceyfCC2plTiCmclGWClZi6YCxei
 TQDQ==
X-Gm-Message-State: APjAAAUaq3hKsN2mQl5hu85bGmcAZddaai7mUSKV3pmsdeTJJOa3doDx
 k4AZTkiuWTILAznu+r703Sc00w==
X-Google-Smtp-Source: APXvYqz8z/bib8XbyJo4M6R/NWdCl4LDm2nD/3prLsl2GYZOGLt6dMeRHUliLKil+31uatJubdXvTQ==
X-Received: by 2002:a17:90a:2506:: with SMTP id
 j6mr3386592pje.129.1561085591310; 
 Thu, 20 Jun 2019 19:53:11 -0700 (PDT)
Received: from localhost (amx-tls3.starhub.net.sg. [203.116.164.13])
 by smtp.gmail.com with ESMTPSA id d19sm880546pjs.22.2019.06.20.19.53.09
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 20 Jun 2019 19:53:10 -0700 (PDT)
Date: Thu, 20 Jun 2019 19:53:10 -0700 (PDT)
X-Google-Original-Date: Thu, 20 Jun 2019 19:39:53 PDT (-0700)
In-Reply-To: <CAEUhbmVf8jTtsZD-+2jcGah-kS+bPM6xdkSML2Qq_NTmeoU3zA@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: bmeng.cn@gmail.com
Message-ID: <mhng-b2b4a62d-2575-4933-a1c9-dea2c5881abc@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.195
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
Cc: alistair23@gmail.com, Alistair Francis <Alistair.Francis@wdc.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 19 Jun 2019 06:42:21 PDT (-0700), bmeng.cn@gmail.com wrote:
> Hi Alistair,
>
> On Tue, Jun 18, 2019 at 1:15 AM Alistair Francis <alistair23@gmail.com> wrote:
>>
>> On Fri, Jun 14, 2019 at 8:30 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>> >
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
>>
>> Do you mind sharing where you got this value from? I can't find
>> details on this device in the SiFive manuals.
>>
>
> I don't think this is a device that actually exists on SiFive's
> chipset. It's hypothetical.

The device actually does exist in the hardware, but that's just an
implementation quirk.  Essentially what's going on here is that the RTL
contains this device, which has a register and then a behavioral verilog block
that causes simulations to terminate.  This is how we exit from tests in RTL
simulation, and we've just gone ahead and implemented the same device in QEMU
in order to make it easy to have compatibility with those bare-metal tests.
Due to how our design flow is set up we end up with exactly the same block in
the ASIC.  The register is still there, but the behavioral code to exit
simulations doesn't do anything so it's essentially just a useless device.
Since it's useless we don't bother writing it up in the ASIC documentation, but
it should be in the RTL documentation.

I'm not opposed to extending the interface in the suggested fashion, but I
wanted to check with the hardware team first to see if they're doing anything
with the other numbers.  I'm out of the office (and somewhat backed up on code
review) until July, so it might take a bit to dig through this.

