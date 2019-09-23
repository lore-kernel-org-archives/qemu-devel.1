Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B549FC4CEC4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 20:10:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A8F7207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 20:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lK7Lk0re"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A8F7207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCUem-00021g-D5
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 16:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iCUdy-0001Yq-79
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 16:09:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iCUdw-0006g8-Sx
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 16:09:10 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:41967)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iCUdw-0006ft-JV; Mon, 23 Sep 2019 16:09:08 -0400
Received: by mail-lf1-x142.google.com with SMTP id r2so11118725lfn.8;
 Mon, 23 Sep 2019 13:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZF1KUTZJcXM9LfX7+T1t8fDj2BRmNGXMx083Eh8oPEQ=;
 b=lK7Lk0relsQ4CXWHenQp4gr60qmdBXZyvrrnWEqBnGhSprm3eDMgBQxWtn181cjN5Z
 GMpOgnP6QQ2g9653Z3qEc62jszNzN/ZQs1RQLEDc7go0BXyBbmKQSbQ0LmFGH7YmDVXn
 BwlDMns1Bg2O6Nzd1LOh+97hWyb75pWkCGU1ldFRpdqimRkWfC/xoYFFAYGPpmliF4dP
 042GDiksOr03728EqSJ8mYenjE7WT/eKl8cgaDW0VCS8x9eN//WuJ4LLIOQda+JI4N3k
 5V5ho/f189RbRV5KFgks+Sz7eUNYjVjv1absvJv5xP0QsbVVUAWI14BP6uJ6nBcY4Oam
 LTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZF1KUTZJcXM9LfX7+T1t8fDj2BRmNGXMx083Eh8oPEQ=;
 b=U8SZ9FIFWZEC2VHI0vUVrgbGmpxi65ld0/YI5gd8KMgEVu/eDrR95hMIz5GHEwT+tO
 SPUtTRtkvjt6gYow13Goq0cA00sGC1Jsca0HNRGrmBTeUGGptI85qkDUymXK27y8nQXT
 ipVioa8KqomWt0b+vv4juY29BkLQytHG3nsBlJwILFeD91VveRZNONRygHej8UON2CZg
 T11GSAud/ShfB4v4wQ0ciyErGkwm7vV0EvgDhT/lR7J+JxsYmc0X/dUM84luHJG3050z
 /fnhLsENacP9T9W2Z8HGI7W0tgwgDX1TgkdQsyOTCJpmQ7n7Wci8JIJZG0TqMR/1t3JA
 /wlg==
X-Gm-Message-State: APjAAAXzO/wmbz5wvv3FDHBjwT7L/3RdKN81CMDjFsODeIhc7l1kjJUi
 h/1MzI23C8d8TzAC+wsz5nJQSVcU6s7tEDwMcUk=
X-Google-Smtp-Source: APXvYqyVwsaLtj0JUYdFdfixP5PYzxz4vwvLzdJxLntDdxJV1RDctFPRQLgj3zX+QiHiZt9im/5Q478g8wUiqbovdFU=
X-Received: by 2002:a19:f11c:: with SMTP id p28mr796050lfh.44.1569269347466;
 Mon, 23 Sep 2019 13:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568931866.git.alistair.francis@wdc.com>
 <0a5c141a26fada6d93d06e996a2f24e1b269ec50.1568931866.git.alistair.francis@wdc.com>
 <CAEUhbmVvDKQqQYE-riq=cvSrCe_NMoW_KDsLjh8CVHRUhJvk9A@mail.gmail.com>
 <CAKmqyKOofA3U+8kjMkzQ0sNd1=uwJHq3c9eaLZdoNCb7=e-PAw@mail.gmail.com>
 <CAEUhbmWu_OTGmUBTcMg9uvm36-fDQheSSiwH5mjnokJSrLvoBA@mail.gmail.com>
In-Reply-To: <CAEUhbmWu_OTGmUBTcMg9uvm36-fDQheSSiwH5mjnokJSrLvoBA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 23 Sep 2019 13:08:41 -0700
Message-ID: <CAKmqyKN8g767av=FeCe_UsapPd7cPCNGWzEx7ByF9QYu-3NbxQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] riscv/virt: Add the PFlash CFI01 device
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
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
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Sep 21, 2019 at 7:15 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Sat, Sep 21, 2019 at 6:16 AM Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Thu, Sep 19, 2019 at 10:15 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> > >
> > > On Fri, Sep 20, 2019 at 6:36 AM Alistair Francis
> > > <alistair.francis@wdc.com> wrote:
> > > >
> > > > Add the CFI01 PFlash to the RISC-V virt board. This is the same PFlash
> > > > from the ARM Virt board and the implementation is based on the ARM Virt
> > > > board. This allows users to specify flash files from the command line.
> > > >
> > > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > > ---
> > > >  hw/riscv/Kconfig        |  1 +
> > > >  hw/riscv/virt.c         | 81 +++++++++++++++++++++++++++++++++++++++++
> > > >  include/hw/riscv/virt.h |  3 ++
> > > >  3 files changed, 85 insertions(+)
> > > >
> > > > diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> > > > index fb19b2df3a..b12660b9f8 100644
> > > > --- a/hw/riscv/Kconfig
> > > > +++ b/hw/riscv/Kconfig
> > > > @@ -36,4 +36,5 @@ config RISCV_VIRT
> > > >      select SERIAL
> > > >      select VIRTIO_MMIO
> > > >      select PCI_EXPRESS_GENERIC_BRIDGE
> > > > +    select PFLASH_CFI01
> > > >      select SIFIVE
> > > > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > > > index d36f5625ec..ca002ecea7 100644
> > > > --- a/hw/riscv/virt.c
> > > > +++ b/hw/riscv/virt.c
> > > > @@ -26,6 +26,7 @@
> > > >  #include "hw/boards.h"
> > > >  #include "hw/loader.h"
> > > >  #include "hw/sysbus.h"
> > > > +#include "hw/qdev-properties.h"
> > > >  #include "hw/char/serial.h"
> > > >  #include "target/riscv/cpu.h"
> > > >  #include "hw/riscv/riscv_hart.h"
> > > > @@ -61,12 +62,72 @@ static const struct MemmapEntry {
> > > >      [VIRT_PLIC] =        {  0xc000000,     0x4000000 },
> > > >      [VIRT_UART0] =       { 0x10000000,         0x100 },
> > > >      [VIRT_VIRTIO] =      { 0x10001000,        0x1000 },
> > > > +    [VIRT_FLASH] =       { 0x20000000,     0x2000000 },
> > > >      [VIRT_DRAM] =        { 0x80000000,           0x0 },
> > > >      [VIRT_PCIE_MMIO] =   { 0x40000000,    0x40000000 },
> > > >      [VIRT_PCIE_PIO] =    { 0x03000000,    0x00010000 },
> > > >      [VIRT_PCIE_ECAM] =   { 0x30000000,    0x10000000 },
> > > >  };
> > > >
> > > > +#define VIRT_FLASH_SECTOR_SIZE (256 * KiB)
> > > > +
> > > > +static PFlashCFI01 *virt_flash_create1(RISCVVirtState *s,
> > > > +                                       const char *name,
> > > > +                                       const char *alias_prop_name)
> > > > +{
> > > > +    /*
> > > > +     * Create a single flash device.  We use the same parameters as
> > > > +     * the flash devices on the ARM virt board.
> > > > +     */
> > > > +    DeviceState *dev = qdev_create(NULL, TYPE_PFLASH_CFI01);
> > > > +
> > > > +    qdev_prop_set_uint64(dev, "sector-length", VIRT_FLASH_SECTOR_SIZE);
> > > > +    qdev_prop_set_uint8(dev, "width", 4);
> > > > +    qdev_prop_set_uint8(dev, "device-width", 2);
> > > > +    qdev_prop_set_bit(dev, "big-endian", false);
> > > > +    qdev_prop_set_uint16(dev, "id0", 0x89);
> > > > +    qdev_prop_set_uint16(dev, "id1", 0x18);
> > > > +    qdev_prop_set_uint16(dev, "id2", 0x00);
> > > > +    qdev_prop_set_uint16(dev, "id3", 0x00);
> > > > +    qdev_prop_set_string(dev, "name", name);
> > >
> > > alias_prop_name is unused? ARM virt has 2 more calls in the same function here.
> >
> > Yep, you are right. I have removed this.
>
> Any reason of removing this?

The way the virt machine was structured didn't work with the options.
I have fixed that in v2 of the series.

Alistair

>
> >
> > >
> > > > +
> > > > +    return PFLASH_CFI01(dev);
> > > > +}
> > > > +
> > > > +static void virt_flash_create(RISCVVirtState *s)
> > > > +{
> > > > +    s->flash[0] = virt_flash_create1(s, "virt.flash0", "pflash0");
> > > > +    s->flash[1] = virt_flash_create1(s, "virt.flash1", "pflash1");
> > >
> > > I don't think we should mirror what is used on ARM virt board to
> > > create 2 flash for sifive_u. For ARM virt, there are 2 flashes because
> > > they need distinguish secure and non-secure. For sifive_u, only one is
> > > enough.
> >
> > I went back and forward about 1 or 2. Two seems more usable as maybe
> > someone wants to include two pflash files? The Xilinx machine also has
> > two so I'm kind of used to 2, but I'm not really fussed.
> >
> > Unless anyone else wants two I will change it to 1.
>
> Regards,
> Bin

