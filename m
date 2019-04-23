Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B36CC10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 18:40:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D28A6217D9
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 18:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D28A6217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58114 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ0LW-0001Lp-5X
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 14:40:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hJ0Jx-00007A-0L
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:39:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hJ0Ju-00012H-MN
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:39:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>)
	id 1hJ0Js-0000zj-TO; Tue, 23 Apr 2019 14:39:05 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1A2F986677;
	Tue, 23 Apr 2019 18:39:03 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-125-214.rdu2.redhat.com
	[10.10.125.214])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8F4BB60198;
	Tue, 23 Apr 2019 18:38:48 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org
References: <20190422195020.1494-1-philmd@redhat.com>
	<20190422195020.1494-4-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <0f78535e-e137-67f1-17bd-7a4ca4b03cae@redhat.com>
Date: Tue, 23 Apr 2019 20:38:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190422195020.1494-4-philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Tue, 23 Apr 2019 18:39:03 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 3/7] hw/i386: Extract fw_cfg definitions
 to local "fw_cfg.h"
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423183847.RZzob3jTtsBP2wwWyfP2lRSFj7i22x7Q_NM8JLidaLQ@z>

On 04/22/19 21:50, Philippe Mathieu-Daud=C3=A9 wrote:
> Extract the architecture-specific fw_cfg definitions to "fw_cfg.h".
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/i386/fw_cfg.h | 20 ++++++++++++++++++++
>  hw/i386/pc.c     |  7 +------
>  2 files changed, 21 insertions(+), 6 deletions(-)
>  create mode 100644 hw/i386/fw_cfg.h
>=20
> diff --git a/hw/i386/fw_cfg.h b/hw/i386/fw_cfg.h
> new file mode 100644
> index 00000000000..17a4bc32f22
> --- /dev/null
> +++ b/hw/i386/fw_cfg.h
> @@ -0,0 +1,20 @@
> +/*
> + * QEMU fw_cfg helpers (X86 specific)
> + *
> + * Copyright (c) 2003-2004 Fabrice Bellard
> + *
> + * SPDX-License-Identifier: MIT
> + */

(1) This is a new file -- I understand it could be plain code movement,
but shouldn't you add your (=3D RH's) copyright notice too (beyond Fabric=
e's)?

(2) I admit I'm confused by the difference between:
- include/hw/i386/*.h
- hw/i386/*.h

One could say that the latter is "internal" (compare e.g.
"intel_iommu.h" from the former and "intel_iommu_internal.h" from the
latter) -- but then, as a counter-example, we have *both* "ioapic.h" and
"ioapic_internal.h" under the former!

> +
> +#ifndef HW_I386_FW_CFG_H
> +#define HW_I386_FW_CFG_H
> +
> +#include "hw/nvram/fw_cfg.h"
> +
> +#define FW_CFG_ACPI_TABLES      (FW_CFG_ARCH_LOCAL + 0)
> +#define FW_CFG_SMBIOS_ENTRIES   (FW_CFG_ARCH_LOCAL + 1)
> +#define FW_CFG_IRQ0_OVERRIDE    (FW_CFG_ARCH_LOCAL + 2)
> +#define FW_CFG_E820_TABLE       (FW_CFG_ARCH_LOCAL + 3)
> +#define FW_CFG_HPET             (FW_CFG_ARCH_LOCAL + 4)
> +
> +#endif
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f2c15bf1f2c..acb8fd9667d 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -30,6 +30,7 @@
>  #include "hw/char/parallel.h"
>  #include "hw/i386/apic.h"
>  #include "hw/i386/topology.h"
> +#include "hw/i386/fw_cfg.h"
>  #include "sysemu/cpus.h"
>  #include "hw/block/fdc.h"
>  #include "hw/ide.h"
> @@ -88,12 +89,6 @@
>  #define DPRINTF(fmt, ...)
>  #endif
> =20
> -#define FW_CFG_ACPI_TABLES (FW_CFG_ARCH_LOCAL + 0)
> -#define FW_CFG_SMBIOS_ENTRIES (FW_CFG_ARCH_LOCAL + 1)
> -#define FW_CFG_IRQ0_OVERRIDE (FW_CFG_ARCH_LOCAL + 2)
> -#define FW_CFG_E820_TABLE (FW_CFG_ARCH_LOCAL + 3)
> -#define FW_CFG_HPET (FW_CFG_ARCH_LOCAL + 4)
> -
>  #define E820_NR_ENTRIES		16
> =20
>  struct e820_entry {
>=20

I'm not insisting on any particular code changes here, just please
consider (1) and (2) above in some way. (Stating why the code is fine
as-is is OK by me too.)

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo

