Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3A3C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:51:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7BE420679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QL+OSl7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7BE420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDvm1-0002Js-6H
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1jDvlS-0001ur-Bh
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:51:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1jDvlQ-0000vI-Td
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:51:06 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36451)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jDvlQ-0000ro-Ob
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:51:04 -0400
Received: by mail-oi1-x242.google.com with SMTP id k18so19194883oib.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 12:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XfP6g/CgoXzXfQwEe29COf5Du2Wj9Ri79dwBaxsFKOo=;
 b=QL+OSl7mp+Z0jzwop0F22rMfloMbsE4oR9iURh7wZn5KvEyx4ATFvx6vSBUBez8Txb
 hkF/Nil0uCeNehQPBbkrXPB+FoaKzds0OV8yM8bbVGgRs5GZdsB93SXb0TMtQjS2+Ooh
 DC3vSmdDDeS8jJ1HcoxWHh7rh3r4Tyvd7rDGCcksisqu2AHk7gGFbIJq6rvD+vv64IqB
 mYYT01b3mHFPt7VL8audTs/4kzV1C9Y+bar+Lot0ArvyehOMrmULryvSlax/p+IkQvvX
 WIDAQARMn4Bvzp9nXlek7IxGC3PU4tqVyYOhv7Th+FHOx3FJGcouek0Nlb9X+7uhD/gL
 /BiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XfP6g/CgoXzXfQwEe29COf5Du2Wj9Ri79dwBaxsFKOo=;
 b=fBJgh75ahP/d22Hhv8h15cXz4nBvS8Ly12iq1gOg+P7ECJG76xXHSsJHIEjsetuSie
 nCvRjG6WTusMUmdoMTJp0EKeSiD7jA+KtUqGLETYl3l7bBPYxYbdNHewGzo6RV+BFb8Y
 JrenjCyIFiWWCGmHCvYJa9nta3palq82YpndtKJrNJSgR0tUDtwUxIdwYnXMm9lVRqPH
 hFcrPIAWOBIbOu1yiaqNxl4U4ebsM4CBkRYnbH9txeAnqTOzwCnkY1lAa5UYVBMnTp9m
 WuT9fvttkSVB4DOoXrT2qAIxuHsE3lOxfO7XR/wqvmEds0iG3pGBOVAIBaD+kngKThlH
 tMmw==
X-Gm-Message-State: ANhLgQ0M46lHTkAwoI/zBcmzlAZLzWbAhc7JlGXczF778xcNUsVcEk1l
 6BYuzJc+3LTMcAoJFMYGoMtpwftpqGln6Giz7v0=
X-Google-Smtp-Source: ADFU+vt+jbPF2yzVe1vrpGdysU0coKzbtJ62PJFnFXsvjgvkl6GpeUCIWGuhxi0b0RTqebkCqHsqK9BoG0vyAe9ZMbM=
X-Received: by 2002:aca:c596:: with SMTP id v144mr903618oif.136.1584388263818; 
 Mon, 16 Mar 2020 12:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200316185006.576-1-philmd@redhat.com>
In-Reply-To: <20200316185006.576-1-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 16 Mar 2020 20:50:52 +0100
Message-ID: <CAL1e-=gymJ+t6nHZhtRdqZrT53kaK0Y+bz8an9W-Eiw+ysSnZw@mail.gmail.com>
Subject: Re: [PATCH v3 00/25] hw: Sanitize various MemoryRegion calls
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 16, 2020 at 8:15 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> This series simplifies various memory API calls when creating
> memory regions.
>
> Most of the patches are generated with Coccinelle semantic
> patches (provided).
> Few more cleanups added while writting the patches have been
> added.
>

FWIW, for the whole series:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

> v1 was 'Let devices own the MemoryRegion they create':
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg681960.html
>
> Since v2:
> - only keep generated/automatic patches
> - add reviewers tags
>
> Since v1:
> - understood a bit more Peter Maydell comments regarding
>   how memory devices are migrated.
>
> Philippe Mathieu-Daud=C3=A9 (25):
>   memory: Correctly return alias region type
>   memory: Simplify memory_region_init_rom_nomigrate() to ease review
>   scripts/cocci: Rename memory-region-{init-ram -> housekeeping}
>   scripts/cocci: Patch to replace memory_region_init_{ram,readonly ->
>     rom}
>   hw/arm: Use memory_region_init_rom() with read-only regions
>   hw/display: Use memory_region_init_rom() with read-only regions
>   hw/m68k: Use memory_region_init_rom() with read-only regions
>   hw/net: Use memory_region_init_rom() with read-only regions
>   hw/pci-host: Use memory_region_init_rom() with read-only regions
>   hw/ppc: Use memory_region_init_rom() with read-only regions
>   hw/riscv: Use memory_region_init_rom() with read-only regions
>   hw/sh4: Use memory_region_init_rom() with read-only regions
>   hw/sparc: Use memory_region_init_rom() with read-only regions
>   scripts/cocci: Patch to detect potential use of memory_region_init_rom
>   scripts/cocci: Patch to remove unnecessary
>     memory_region_set_readonly()
>   scripts/cocci: Patch to let devices own their MemoryRegions
>   hw/core: Let devices own the MemoryRegion they create
>   hw/display: Let devices own the MemoryRegion they create
>   hw/dma: Let devices own the MemoryRegion they create
>   hw/riscv: Let devices own the MemoryRegion they create
>   hw/char: Let devices own the MemoryRegion they create
>   hw/arm/stm32: Use memory_region_init_rom() with read-only regions
>   hw/ppc/ppc405: Use memory_region_init_rom() with read-only regions
>   hw/arm: Remove unnecessary memory_region_set_readonly() on ROM alias
>   hw/arm: Let devices own the MemoryRegion they create
>
>  .../memory-region-housekeeping.cocci          | 159 ++++++++++++++++++
>  .../coccinelle/memory-region-init-ram.cocci   |  38 -----
>  hw/arm/exynos4210.c                           |  14 +-
>  hw/arm/fsl-imx25.c                            |  10 +-
>  hw/arm/fsl-imx31.c                            |   6 +-
>  hw/arm/fsl-imx6.c                             |   6 +-
>  hw/arm/fsl-imx6ul.c                           |   9 +-
>  hw/arm/mainstone.c                            |   3 +-
>  hw/arm/msf2-soc.c                             |   6 +-
>  hw/arm/nrf51_soc.c                            |   2 +-
>  hw/arm/omap_sx1.c                             |   6 +-
>  hw/arm/palm.c                                 |   3 +-
>  hw/arm/spitz.c                                |   3 +-
>  hw/arm/stellaris.c                            |   3 +-
>  hw/arm/stm32f205_soc.c                        |  11 +-
>  hw/arm/stm32f405_soc.c                        |  12 +-
>  hw/arm/tosa.c                                 |   3 +-
>  hw/arm/xlnx-zynqmp.c                          |  11 +-
>  hw/char/serial.c                              |   7 +-
>  hw/core/platform-bus.c                        |   3 +-
>  hw/display/cg3.c                              |   5 +-
>  hw/display/g364fb.c                           |   3 +-
>  hw/display/macfb.c                            |   4 +-
>  hw/display/tcx.c                              |   5 +-
>  hw/dma/i8257.c                                |   2 +-
>  hw/dma/rc4030.c                               |   4 +-
>  hw/m68k/q800.c                                |   3 +-
>  hw/net/dp8393x.c                              |   5 +-
>  hw/pci-host/prep.c                            |   5 +-
>  hw/ppc/mac_newworld.c                         |   3 +-
>  hw/ppc/mac_oldworld.c                         |   3 +-
>  hw/ppc/ppc405_boards.c                        |   6 +-
>  hw/riscv/sifive_e.c                           |   9 +-
>  hw/riscv/sifive_u.c                           |   2 +-
>  hw/sh4/shix.c                                 |   3 +-
>  hw/sparc/leon3.c                              |   3 +-
>  memory.c                                      |  16 +-
>  MAINTAINERS                                   |   1 +
>  38 files changed, 244 insertions(+), 153 deletions(-)
>  create mode 100644 scripts/coccinelle/memory-region-housekeeping.cocci
>  delete mode 100644 scripts/coccinelle/memory-region-init-ram.cocci
>
> --
> 2.21.1
>
>

