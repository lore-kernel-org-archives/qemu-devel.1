Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02418C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 05:42:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCB14205C9
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 05:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQe1Ugv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB14205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54862 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heCJd-0004X4-GN
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 01:42:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39532)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1heCI0-0003yZ-KU
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 01:40:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1heCHx-0000QJ-V9
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 01:40:44 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:39924)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1heCHt-0000Km-JO; Fri, 21 Jun 2019 01:40:37 -0400
Received: by mail-ed1-x542.google.com with SMTP id m10so8252149edv.6;
 Thu, 20 Jun 2019 22:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=o59gUalJo4RKw6pqJfxFJsqsjRMfLXyqE1ZDiXHrwW4=;
 b=NQe1Ugv6GxRUsh4W9Jwu0kBJM0RvcQgvSZ9K/zJrIg2eO25IF9K5f/af8iZJISN5LB
 k/dz1UPjNDqO3PAIilh8WM9PbEWtBCRDpL7mvIzptK7TwqBx/DZp3fxRmTlKMubgJ9ez
 jEVpFxZJhl+WLDJ5Y509jf8kCgP5obRDzINMsnp4vF0lJpd7ij4WB+igtu4qFJqifYHm
 urnIXgnVJcsi+PiX9O2ffQ0oRx+vSOrgGjJXXVUIJklcMscaPCCEN4Tfuuo66EhxgADO
 gz7nDN34vQeVjuMGJ+urbBkRsppSvEwQlJi4QeEFCvxRZHFcnUYYq8tRx1qNOoSl8UuN
 Yx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o59gUalJo4RKw6pqJfxFJsqsjRMfLXyqE1ZDiXHrwW4=;
 b=byQa6GVy3PRg1N5FfgYsfEAomEvAPGP841USeBKF/h7VmkZgM0prsLP4ym1RElRY9/
 8JRDYxEIKMbx9sk4HsUBZOoKr5xAv+OIzLFVUH2bKEohtFGfmYKHPVrp9yOBP/rVeCgS
 ZDO21ga+vmw2YjPU+9aQqoG/Ws/+5XcJ3458JbWV5WZfHrgbWWgOmxrPsWovy2sHTiwm
 ++ygs4LfutNB0uGnfp0IaoqyZQvxssh5dKQe2PkTB9Zpj5326m6nZGfLAS4kzvTSbevX
 fRmkdGESfpvOFMXDv5XTNQ8yryhiCVDA5WoKGMyTSHB/jJ4LLUNiHMe4qNDfVUq1rjIH
 7DAw==
X-Gm-Message-State: APjAAAXYcr6X4LA1Xj9T9v0HS4g/p/snqdEGb/Kt+OyvqLNOlVIosHGk
 x7LB+bdP0Bm2LlqivkAhFddN5Z2XXuhDat8rg3k=
X-Google-Smtp-Source: APXvYqxv9BQl0mDVkGKsPEjDLMSr6OAoTxdGezFx2EbZSPDQOts9nMIOsJHZTlOMY15VujtyGW4z+MYAYmLxd/EieAI=
X-Received: by 2002:a17:906:4f8f:: with SMTP id
 o15mr15003739eju.129.1561095635464; 
 Thu, 20 Jun 2019 22:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUhbmVf8jTtsZD-+2jcGah-kS+bPM6xdkSML2Qq_NTmeoU3zA@mail.gmail.com>
 <mhng-b2b4a62d-2575-4933-a1c9-dea2c5881abc@palmer-si-x1e>
In-Reply-To: <mhng-b2b4a62d-2575-4933-a1c9-dea2c5881abc@palmer-si-x1e>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 21 Jun 2019 13:40:24 +0800
Message-ID: <CAEUhbmWJYE+BUfE5v-TrmQ=xzhV8HuxFhBQrtU74T6TKfTZXCw@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
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
Cc: Alistair Francis <alistair23@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Palmer,

On Fri, Jun 21, 2019 at 10:53 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Wed, 19 Jun 2019 06:42:21 PDT (-0700), bmeng.cn@gmail.com wrote:
> > Hi Alistair,
> >
> > On Tue, Jun 18, 2019 at 1:15 AM Alistair Francis <alistair23@gmail.com> wrote:
> >>
> >> On Fri, Jun 14, 2019 at 8:30 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >> >
> >> > This adds a reset opcode for sifive_test device to trigger a system
> >> > reset for testing purpose.
> >> >
> >> > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> >> > ---
> >> >
> >> >  hw/riscv/sifive_test.c         | 4 ++++
> >> >  include/hw/riscv/sifive_test.h | 3 ++-
> >> >  2 files changed, 6 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
> >> > index 24a04d7..cd86831 100644
> >> > --- a/hw/riscv/sifive_test.c
> >> > +++ b/hw/riscv/sifive_test.c
> >> > @@ -21,6 +21,7 @@
> >> >  #include "qemu/osdep.h"
> >> >  #include "hw/sysbus.h"
> >> >  #include "qemu/module.h"
> >> > +#include "sysemu/sysemu.h"
> >> >  #include "target/riscv/cpu.h"
> >> >  #include "hw/riscv/sifive_test.h"
> >> >
> >> > @@ -40,6 +41,9 @@ static void sifive_test_write(void *opaque, hwaddr addr,
> >> >              exit(code);
> >> >          case FINISHER_PASS:
> >> >              exit(0);
> >> > +        case FINISHER_RESET:
> >> > +            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> >> > +            return;
> >> >          default:
> >> >              break;
> >> >          }
> >> > diff --git a/include/hw/riscv/sifive_test.h b/include/hw/riscv/sifive_test.h
> >> > index 71d4c9f..c186a31 100644
> >> > --- a/include/hw/riscv/sifive_test.h
> >> > +++ b/include/hw/riscv/sifive_test.h
> >> > @@ -34,7 +34,8 @@ typedef struct SiFiveTestState {
> >> >
> >> >  enum {
> >> >      FINISHER_FAIL = 0x3333,
> >> > -    FINISHER_PASS = 0x5555
> >> > +    FINISHER_PASS = 0x5555,
> >> > +    FINISHER_RESET = 0x7777
> >>
> >> Do you mind sharing where you got this value from? I can't find
> >> details on this device in the SiFive manuals.
> >>
> >
> > I don't think this is a device that actually exists on SiFive's
> > chipset. It's hypothetical.
>
> The device actually does exist in the hardware, but that's just an
> implementation quirk.  Essentially what's going on here is that the RTL
> contains this device, which has a register and then a behavioral verilog block
> that causes simulations to terminate.  This is how we exit from tests in RTL
> simulation, and we've just gone ahead and implemented the same device in QEMU
> in order to make it easy to have compatibility with those bare-metal tests.
> Due to how our design flow is set up we end up with exactly the same block in
> the ASIC.  The register is still there, but the behavioral code to exit
> simulations doesn't do anything so it's essentially just a useless device.
> Since it's useless we don't bother writing it up in the ASIC documentation, but
> it should be in the RTL documentation.
>
> I'm not opposed to extending the interface in the suggested fashion, but I
> wanted to check with the hardware team first to see if they're doing anything
> with the other numbers.  I'm out of the office (and somewhat backed up on code
> review) until July, so it might take a bit to dig through this.

Thanks for the clarification. The main reason of adding this
functionality is to provide software a way of rebooting the whole
system. Please provide update after you consult SiFive hardware guys
:)

Regards,
Bin

