Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30EEC10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 18:42:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E70121738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 18:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E70121738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58130 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ0Mv-0002ne-Gf
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 14:42:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hJ0LT-0001b3-1y
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:40:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hJ0LR-0002Ex-Qy
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:40:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>)
	id 1hJ0LR-0002CJ-Ha; Tue, 23 Apr 2019 14:40:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B0F6AC079900;
	Tue, 23 Apr 2019 18:40:39 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-125-214.rdu2.redhat.com
	[10.10.125.214])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BB43F1001DE7;
	Tue, 23 Apr 2019 18:40:30 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org
References: <20190422195020.1494-1-philmd@redhat.com>
	<20190422195020.1494-5-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <459e61c4-a4e0-defa-9617-14a54a289766@redhat.com>
Date: Tue, 23 Apr 2019 20:40:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190422195020.1494-5-philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Tue, 23 Apr 2019 18:40:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 4/7] hw/i386: Implement
 fw_cfg_arch_key_name()
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
Message-ID: <20190423184029.MWPNcaJnkHO_svCojBpu7E5q7VPd70gBIXVqyVm578g@z>

On 04/22/19 21:50, Philippe Mathieu-Daud=C3=A9 wrote:
> Implement fw_cfg_arch_key_name(), which returns the name of a
> i386-specific key.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/i386/Makefile.objs |  2 +-
>  hw/i386/fw_cfg.c      | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+), 1 deletion(-)
>  create mode 100644 hw/i386/fw_cfg.c
>=20
> diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
> index 27248a0777c..5d9c9efd5fa 100644
> --- a/hw/i386/Makefile.objs
> +++ b/hw/i386/Makefile.objs
> @@ -3,7 +3,7 @@ obj-y +=3D multiboot.o
>  obj-y +=3D pc.o
>  obj-$(CONFIG_I440FX) +=3D pc_piix.o
>  obj-$(CONFIG_Q35) +=3D pc_q35.o
> -obj-y +=3D pc_sysfw.o
> +obj-y +=3D fw_cfg.o pc_sysfw.o
>  obj-y +=3D x86-iommu.o
>  obj-$(CONFIG_VTD) +=3D intel_iommu.o
>  obj-$(CONFIG_AMD_IOMMU) +=3D amd_iommu.o
> diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
> new file mode 100644
> index 00000000000..c5e8b4ead0b
> --- /dev/null
> +++ b/hw/i386/fw_cfg.c
> @@ -0,0 +1,38 @@
> +/*
> + * QEMU fw_cfg helpers (X86 specific)
> + *
> + * Copyright (c) 2019 Red Hat, Inc.
> + *
> + * Author:
> + *   Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/i386/fw_cfg.h"
> +#include "hw/nvram/fw_cfg.h"
> +
> +const char *fw_cfg_arch_key_name(uint16_t key)
> +{
> +    static const struct {
> +        uint16_t key;
> +        const char *name;
> +    } fw_cfg_arch_wellknown_keys[] =3D {
> +        {FW_CFG_ACPI_TABLES, "acpi_tables"},
> +        {FW_CFG_SMBIOS_ENTRIES, "smbios_entries"},
> +        {FW_CFG_IRQ0_OVERRIDE, "irq0_override"},
> +        {FW_CFG_E820_TABLE, "e820_tables"},

s/e820_tables/e820_table/

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo

> +        {FW_CFG_HPET, "hpet"},
> +    };
> +
> +    for (size_t i =3D 0; i < ARRAY_SIZE(fw_cfg_arch_wellknown_keys); i=
++) {
> +        if (fw_cfg_arch_wellknown_keys[i].key =3D=3D key) {
> +            return fw_cfg_arch_wellknown_keys[i].name;
> +        }
> +    }
> +    return NULL;
> +}
>=20


