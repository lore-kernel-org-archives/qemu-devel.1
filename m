Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763A8C4360C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 21:42:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D8B6207FF
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 21:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nor2pZDG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D8B6207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFmOY-0008C2-D9
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 17:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iFmLB-0006HK-Li
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 17:39:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iFmLA-0005SC-Hw
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 17:39:21 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:36599)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iFmL7-0005Kl-6p; Wed, 02 Oct 2019 17:39:17 -0400
Received: by mail-lf1-x143.google.com with SMTP id x80so205104lff.3;
 Wed, 02 Oct 2019 14:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vZKlbTduLF2cPxxODGoHTEB0qasz0XgHBOjFEGr2muw=;
 b=Nor2pZDG/rmrp0lrG/Rodbq//hWtWrULGpbzYlyxBkwkgSff0tDMrbxOk28JXyCbld
 H8OZC/OV6z+VNny46JDrngxgfVoht0WPn9vcEoD2f1qlE+NRonaTkqn+wswETp/7a4pM
 YelMyXf6m/1lw4dVsyPHp7+RxNzZ0T7AGwlqrzRJRO1kHvBUpMBOga7m0tZRMoN6glvd
 G5/FFU1LyVEDA8Se/x4juaogvCICwzK6xm1/i53bDgqlOSkLVNyU6zLg0jFWV90WUTX/
 EftjvpOq/JS/O2g6FKTHr/BQcrv+vSdJJdfp4/vHteYi9G5+nTPJTkFaCGuBiU3CPgx8
 kIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vZKlbTduLF2cPxxODGoHTEB0qasz0XgHBOjFEGr2muw=;
 b=fm7DWzCtY6Ya0Un/TQU4aFLBSRvaCz+0rt3nkHpQw1h8YY7bYXZVZBDrVBYU8E0lZa
 4IMsd0iZNOSFKE4Oc6sYSPpdF3NcW6RQBhE43BClKJCUUl/Psqe0hppSWvdnhidy70lz
 FajpijRZWZlt5E+3SMEyqRb1yfPnow876VeUzWAqBLswGDDfnsOXU0SQn72FbFt3ojWI
 1VHzdIqJB51s9uLoA7b3t1t8x5j4146glFEDGXA0eJAu2QRVx89Lj7E7xUWCzJ3HZTDl
 a33TG3AHaefRZR61ZGH8D03lkg1q8spS9vSA7CvanGNuj8/21Qylo9lsOHgyCBR0B04Q
 8hrg==
X-Gm-Message-State: APjAAAUwfOYnCWGAP9lh0i01hrzGM8DLFTRWksye2hk3RvC+Odm7lUQ0
 BpGu59578VW9EZvueZbfE/evVFBAQiUoO6XeP5s=
X-Google-Smtp-Source: APXvYqxhnt6+qAz7fX4GSRB99IcbPPsogqoTaQf+K1HlGuudKkfedzo8mtj7Eyz/rkaWC/G3sKpgwaOv7psoetKshdo=
X-Received: by 2002:ac2:4a69:: with SMTP id q9mr3419052lfp.86.1570052353574;
 Wed, 02 Oct 2019 14:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190918145640.17349-1-palmer@sifive.com>
 <20190918145640.17349-12-palmer@sifive.com>
 <CAFEAcA_6AuqCvbvHVS9Vdwd3AOrp16Fy7Xj29497-xGMw+aXkQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_6AuqCvbvHVS9Vdwd3AOrp16Fy7Xj29497-xGMw+aXkQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 2 Oct 2019 14:38:47 -0700
Message-ID: <CAKmqyKPWg9rsUp9uMPJZiQ89wb2uFuaKud2V5fcsVm7ESegu1g@mail.gmail.com>
Subject: Re: [PULL 11/48] riscv: Resolve full path of the given bios image
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 24, 2019 at 3:18 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 18 Sep 2019 at 16:35, Palmer Dabbelt <palmer@sifive.com> wrote:
> >
> > From: Bin Meng <bmeng.cn@gmail.com>
> >
> > At present when "-bios image" is supplied, we just use the straight
> > path without searching for the configured data directories. Like
> > "-bios default", we add the same logic so that "-L" actually works.
> >
> > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> > ---
> >  hw/riscv/boot.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> > index 10f7991490..2e92fb0680 100644
> > --- a/hw/riscv/boot.c
> > +++ b/hw/riscv/boot.c
> > @@ -72,14 +72,14 @@ void riscv_find_and_load_firmware(MachineState *machine,
> >          firmware_filename = riscv_find_firmware(default_machine_firmware);
> >      } else {
> >          firmware_filename = machine->firmware;
> > +        if (strcmp(firmware_filename, "none")) {
> > +            firmware_filename = riscv_find_firmware(firmware_filename);
> > +        }
> >      }
> >
> >      if (strcmp(firmware_filename, "none")) {
> >          /* If not "none" load the firmware */
> >          riscv_load_firmware(firmware_filename, firmware_load_addr);
> > -    }
> > -
> > -    if (!strcmp(machine->firmware, "default")) {
> >          g_free(firmware_filename);
> >      }
> >  }
>
> Hi; Coverity (CID 1405786) thinks this introduces a possible
> memory leak, because it's not sure that memory allocated
> and returned by the call to riscv_find_firmware() is
> guaranteed to be freed before the end of the function.
> I think it might be a false positive, but I wasn't entirely
> sure, so maybe this code could be rephrased to be clearer?
> I think the root of the problem is that we have a local
> variable 'firmware_filename' which might point to memory
> allocated-and-to-be-freed, or might point to memory which
> must not be freed (machine->firmware), and then you have
> to check the flow of logic through the code quite carefully
> to figure out whether the condition under which we choose
> to call g_free() is exactly equivalent to the condition
> where we set firmware_filename to point to allocated memory...

Patch sent!

Alistair

>
> thanks
> -- PMM
>

