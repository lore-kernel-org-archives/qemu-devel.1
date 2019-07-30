Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93CCC0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 16:38:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7547220693
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 16:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n12rHZex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7547220693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsV8l-0007dl-Fy
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 12:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53980)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hsV81-0006ma-KE
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 12:37:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hsV80-0004I1-E1
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 12:37:33 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:41784)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hsV7x-0004GM-Uz; Tue, 30 Jul 2019 12:37:30 -0400
Received: by mail-ed1-x542.google.com with SMTP id p15so63095144eds.8;
 Tue, 30 Jul 2019 09:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=q05HFV4rBCNFkmWOp6EN0tG/5WsbjW6PV1n9UTQXHLw=;
 b=n12rHZexv2/swQz+QDqDh/WI5lHYYFGX357zdhdk8/dw+hCp/OCndDJhn0dS/SmNkP
 CBpFyIIRcC3kyqPuRN20uUjUFZqg40+DimXtn8OWC4YtCf5BXrZJlfrs6YIhwmwQ/UX4
 A/+ZK//5dZkeoocXenUINFs5hOsqNNjMIeqvpmFCqrZCSBvpwNieHPFLg3kmW+KV2yrz
 q9BfyC7DUOQRaaGwS6X6T8cG/wb2TIQbE/Bup50pak9ic73Y1l18coG9Q8zIY0WWjYgA
 8v1zouPi1sR3Ydcor2wipva7pkwn+d/bWfXtIz3Md7QZBpCG/jRgd3pvNsMaPA8kWqOg
 eaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=q05HFV4rBCNFkmWOp6EN0tG/5WsbjW6PV1n9UTQXHLw=;
 b=mzdU0L5GXqkRjXS1qKDTsYtaeRfR/t1vdGBAfUidVxX1kzWxInXD5WS6hWoPNTkg0q
 liKdCBiSBgUahX0ay1gtjfiNFyAD+Q4wemPfIdnhgXUlGLiyVWXUwNTXgjiOUwAwHMjs
 wKCBNEPx152sc3M6tbwfSg955pZwsAxwzF97isSg9KvZt41GR5Yatzg00tqfX8jP+Tib
 owegGOmPBh2P30nnC95f7t2ZjHuN6Kj1ocbQw1yClQeOlokup87PVnl+Ao55yDiRqne9
 GRk+RVNy0qvDH8yLjxUBT0mlVaL3vGxgK9bPCE3KUKVzT/F2MkmKljvz815y+evry5ou
 +tKg==
X-Gm-Message-State: APjAAAUjW+ElWsR7UQVKH0ue05frhKlYtnoAjbk//0iQyPGbYq3g0cGp
 FXqYYiV0wpwjT8RjYr/g2RVbcWmxiQoFnzh2nJ0=
X-Google-Smtp-Source: APXvYqx9jHbCMIZtrZ8HHSWJljkDhhcSuwpJ3gtSFYVbx8e1wJn8CAMyru4rOXiLMvMaDnkSed3nYSdJ8lpAZO3CEHw=
X-Received: by 2002:a50:886a:: with SMTP id c39mr35399946edc.214.1564504647726; 
 Tue, 30 Jul 2019 09:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUhbmWfS8TPTRa-Ovc1gnPUC-3ofA4G+sR7PaSNzfWT-fPNfQ@mail.gmail.com>
 <mhng-2dc6a880-670f-449e-9361-9cf2ae4af4ee@palmer-si-x1e>
In-Reply-To: <mhng-2dc6a880-670f-449e-9361-9cf2ae4af4ee@palmer-si-x1e>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 31 Jul 2019 00:37:16 +0800
Message-ID: <CAEUhbmXb_rOcBUT8dqtzf+LCGqiuDf-wqHts79HVy-xQf-KXig@mail.gmail.com>
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 30, 2019 at 3:47 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Mon, 22 Jul 2019 22:30:15 PDT (-0700), bmeng.cn@gmail.com wrote:
> > Hi Palmer,
> >
> > On Sat, Jul 20, 2019 at 9:47 AM Palmer Dabbelt <palmer@sifive.com> wrote:
> >>
> >> On Fri, 14 Jun 2019 08:15:51 PDT (-0700), bmeng.cn@gmail.com wrote:
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
> >> >  };
> >> >
> >> >  DeviceState *sifive_test_create(hwaddr addr);
> >>
> >> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> >
> > Thanks a lot!
> >
> >> Sorry this took a while, but it's in the hardware now.  I'll merge this, but
> >> I'm considering it a new feature so it'll be held off a bit.
> >
> > "but it's in the hardware now", do you mean the code I added (0x7777)
> > is now supported by a newer version SiFive test device with compatible
> > string "sifive,test1", and can actually do the system wide reset?
>
> No, the hardware is still a "sifive,test0" as plumbing through the reset is
> trickier than I wanted to take on.  I just reserved the 0x7777 code and
> implemented it by triggering an unsupported function error, so we don't
> accidentally use it for something else later.

OK, thanks for the clarifications!

Regards,
Bin

