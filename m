Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7CEC432C3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 10:20:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FDCB2146E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 10:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMiy7QEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FDCB2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibMLK-0005IT-NF
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 05:20:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ibMKb-0004mL-0P
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 05:19:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ibMKZ-0002qq-HK
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 05:19:56 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36588)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ibMKZ-0002mm-AD
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 05:19:55 -0500
Received: by mail-wr1-x441.google.com with SMTP id z3so40430179wru.3
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 02:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0zRmDC5MdELUsc6swPlk9apYe+B4UWww1hNpMahiujQ=;
 b=YMiy7QEUpDLabgq5rlkCreoOtF1b43BdOzLalcoIaWMAZSEaQGHLQs/HwCtyHqSsKT
 lhketPCqTLcKDyLWuZpFJMH4u78kMdASnZfJVf5m850Ih06qSX7QkSfjXasCchnA5O3w
 kQr/47abmLl1/zYMUniu4u13ADkdqoQcqahiMJZinPKMEQkiGXsVi4ehBvAbdqmFJnTW
 FVNUJVeO+T5jIX4nnzVTd/YizOYNiv0HwyEsc7uZsB3PaqtiiUsw2r8Dwz/gePAbfTtb
 LhsD/6EQzVJnL+RWEAQSL839GvMkZiKdlYsvrcaubZ8irfl0FxcRlxKX/eiBfx3Fhvgk
 1c5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0zRmDC5MdELUsc6swPlk9apYe+B4UWww1hNpMahiujQ=;
 b=lMLBMvd5NRldgTM9AD7vcDknmoLKr2QXfzPDqPUz+CmtsQkDb9Tg5KDMBzfEYR5o5f
 Nq+U7smHZLW8K0bK52P1jnsdX4tv/kvCnAV/iZq1MplEwd4UB1m9IIkV0A4+FIjpWcZf
 SEAkrnD8cWzv8l2Qa07frpRNsyQDVeRT1L+RkY0GWtGK9GTfl7fm4uyAW78oIAkO+uQH
 imYX1MmKztk3DYe42Ixu5WNeFWHod7xYw/NCi6N0BIqT+gJRqWD2GnMG7UnOTUrdr5nt
 8PjW44EdGuZ3pXfF2OsECeM7QV7OsmHB0+rBk8nD35yYkjHB7cE1XA8tocZgVWN3izVT
 N4qA==
X-Gm-Message-State: APjAAAWY/SGnW2HiCQnr4EGCv8i+0l0Ir4vszDR8BY1MKVxnVcNo3TvG
 drFdshj9CMDG/hIpbl8S5ObjwtnISIIZr6xlL3pDLfy9Css=
X-Google-Smtp-Source: APXvYqzuIMf48RANpyVUBgnI0/aGoN6RwGBX+/tPqlz/tS89dt5YOPcfpFMGtj3VaphaycJjroPfGoEFA3boM4eB7zE=
X-Received: by 2002:a5d:66c3:: with SMTP id k3mr2590254wrw.370.1575195591979; 
 Sun, 01 Dec 2019 02:19:51 -0800 (PST)
MIME-Version: 1.0
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
In-Reply-To: <20191120152442.26657-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sun, 1 Dec 2019 14:19:38 +0400
Message-ID: <CAJ+F1CLV_JRhXX=tB7ZXYxa1En4LzYgJr+7egKzVRNBOLY2nSA@mail.gmail.com>
Subject: Re: [PATCH v4 00/37] Clean-ups: qom-ify serial and remove
 QDEV_PROP_PTR
To: QEMU <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Nov 20, 2019 at 7:25 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi,
>
> QDEV_PROP_PTR is marked in multiple places as "FIXME/TODO/remove
> me". In most cases, it can be easily replaced with QDEV_PROP_LINK when
> the pointer points to an Object.
>
> There are a few places where such substitution isn't possible. For
> those places, it seems reasonable to use a specific setter method
> instead, and keep the user_creatable =3D false. In other places,
> proper usage of qdev or other facilies is the solution.
>
> The serial code wasn't converted to qdev, which makes it a bit more
> archaic to deal with. Let's convert it first, so we can more easily
> embed it from other devices, and re-export some properties and drop
> QDEV_PROP_PTR usage.

Before v5, is there any other comment for the following patches:

- "qdev: remove unused qdev_prop_int64"

I spotted dead-code, never used. Peter would rather keep it. Worth it?

- "chardev: generate an internal id when none given"

As explained, this is necessary for qdev_prop_set_chr()

- "serial: register vmsd with DeviceClass"

This is standard qdev-ification, however it breaks backward migration,
but that's just how qdev_set_legacy_instance_id() works.

- "RFC: mips/cps: fix setting saar property"

Perhaps I should have used FIX instead of RFC, because this should
actually be a real fix. However I could use someone help to exercise
the code path.

- "sm501: make SerialMM a child, export chardev property"

review?

- "qdev/qom: remove some TODO limitations now that PROP_PTR is gone"

This should be straightforward.

>
> v4: (after Peter & Philippe reviews)
>  - replaced "self" variable names with abbreviations
>  - split "mips: inline serial_init()"
>  - new patches: "mips: use sysbus_mmio_get_region() instead of internal
>    fields", "leon3: use qdev gpio facilities for the PIL", "qdev: use
>    g_strcmp0() instead of open-coding it", "qdev/qom: remove some TODO
>    limitations now that PROP_PTR is gone"
>  - dropped patches: "sparc: move PIL irq handling to cpu.c" & "serial:
>    add "instance-id" property"
>  - various comments / commit message tweaks
>  - added r-b tags
>
> v3:
>  - introduce SerialMM and SerialIO sysbus devices
>  - remove serial_mm_connect introduced in v2
>  - replace "base" property introduced in v2, use "instance-id" for
>    vmstate purpose only
>  - add a few preliminary clean-ups
>
> v2:
>  - qom-ify serial
>  - embed the serial from sm501, and expose a "chardev" property
>  - add "leon3: use qemu_irq framework instead of callback as property"
>  - add "sparc: move PIL irq handling to cpu.c"
>  - add "cris: improve passing PIC interrupt vector to the CPU"
>  - misc comment/todo changes, add r-b tags
>
> Marc-Andr=C3=A9 Lureau (37):
>   qdev: remove unused qdev_prop_int64
>   sysbus: remove unused sysbus_try_create*
>   sysbus: remove outdated comment
>   chardev: generate an internal id when none given
>   serial-pci-multi: factor out multi_serial_get_port_count()
>   serial: initial qom-ification
>   serial: register vmsd with DeviceClass
>   serial: add "chardev" property
>   serial: add "baudbase" property
>   serial: realize the serial device
>   serial: replace serial_exit_core() with unrealize
>   serial: start making SerialMM a sysbus device
>   serial-mm: add "regshift" property
>   serial-mm: add endianness property
>   serial-mm: use sysbus facilities
>   serial: make SerialIO a sysbus device
>   mips: inline serial_init()
>   mips: baudbase is 115200 by default
>   mips: use sysbus_add_io()
>   mips: use sysbus_mmio_get_region() instead of internal fields
>   sm501: make SerialMM a child, export chardev property
>   vmmouse: replace PROP_PTR with PROP_LINK
>   lance: replace PROP_PTR with PROP_LINK
>   etraxfs: remove PROP_PTR usage
>   dp8393x: replace PROP_PTR with PROP_LINK
>   leon3: use qemu_irq framework instead of callback as property
>   leon3: use qdev gpio facilities for the PIL
>   qdev: use g_strcmp0() instead of open-coding it
>   RFC: mips/cps: fix setting saar property
>   cris: improve passing PIC interrupt vector to the CPU
>   smbus-eeprom: remove PROP_PTR
>   omap-intc: remove PROP_PTR
>   omap-i2c: remove PROP_PTR
>   omap-gpio: remove PROP_PTR
>   qdev: remove PROP_MEMORY_REGION
>   qdev: remove QDEV_PROP_PTR
>   qdev/qom: remove some TODO limitations now that PROP_PTR is gone
>
>  chardev/char.c               |  32 +++++--
>  hw/arm/omap1.c               |   8 +-
>  hw/arm/omap2.c               |  25 +++---
>  hw/char/omap_uart.c          |   2 +-
>  hw/char/serial-isa.c         |  12 ++-
>  hw/char/serial-pci-multi.c   |  55 +++++++-----
>  hw/char/serial-pci.c         |  18 +++-
>  hw/char/serial.c             | 170 ++++++++++++++++++++++++++++-------
>  hw/core/qdev-properties.c    |  50 -----------
>  hw/core/qdev.c               |  15 +---
>  hw/core/sysbus.c             |  32 -------
>  hw/cris/axis_dev88.c         |   4 -
>  hw/display/sm501.c           |  33 +++++--
>  hw/dma/sparc32_dma.c         |   2 +-
>  hw/gpio/omap_gpio.c          |  42 ++++-----
>  hw/i2c/omap_i2c.c            |  19 ++--
>  hw/i2c/smbus_eeprom.c        |  17 ++--
>  hw/i386/pc.c                 |   7 +-
>  hw/i386/vmmouse.c            |   8 +-
>  hw/input/pckbd.c             |   8 +-
>  hw/intc/etraxfs_pic.c        |  26 +-----
>  hw/intc/grlib_irqmp.c        |  35 +-------
>  hw/intc/omap_intc.c          |  17 ++--
>  hw/m68k/q800.c               |   3 +-
>  hw/mips/boston.c             |   2 +-
>  hw/mips/cps.c                |   2 +-
>  hw/mips/mips_jazz.c          |   3 +-
>  hw/mips/mips_malta.c         |   2 +-
>  hw/mips/mips_mipssim.c       |  14 ++-
>  hw/net/dp8393x.c             |   7 +-
>  hw/net/etraxfs_eth.c         |  44 ++++++---
>  hw/net/lance.c               |   5 +-
>  hw/net/pcnet-pci.c           |   2 +-
>  hw/net/pcnet.h               |   2 +-
>  hw/sh4/r2d.c                 |   2 +-
>  hw/sparc/leon3.c             |  15 +++-
>  include/hw/arm/omap.h        |  52 +++++++++++
>  include/hw/char/serial.h     |  43 ++++++---
>  include/hw/cris/etraxfs.h    |  20 +----
>  include/hw/input/i8042.h     |   4 +-
>  include/hw/qdev-properties.h |  27 ------
>  include/hw/sysbus.h          |  13 +--
>  include/qemu/id.h            |   1 +
>  qom/qom-qmp-cmds.c           |  10 ---
>  target/cris/cpu.c            |   8 ++
>  target/cris/cpu.h            |   1 +
>  util/id.c                    |   1 +
>  47 files changed, 497 insertions(+), 423 deletions(-)
>
> --
> 2.24.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

