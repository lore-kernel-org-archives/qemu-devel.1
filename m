Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCB5C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 18:34:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E211C20693
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 18:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E211C20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58012 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ0Ex-0006ED-2W
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 14:33:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hJ0Dr-0005cB-GW
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:32:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hJ0Dn-0003fU-JG
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:32:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>)
	id 1hJ0Dk-0003av-B5; Tue, 23 Apr 2019 14:32:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 32687308621E;
	Tue, 23 Apr 2019 18:32:39 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-125-214.rdu2.redhat.com
	[10.10.125.214])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 11545608C2;
	Tue, 23 Apr 2019 18:32:25 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org
References: <20190422195020.1494-1-philmd@redhat.com>
	<20190422195020.1494-3-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <00f90419-6e5b-ff37-276f-c37ebc017dae@redhat.com>
Date: Tue, 23 Apr 2019 20:32:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190422195020.1494-3-philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Tue, 23 Apr 2019 18:32:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 2/7] hw/nvram/fw_cfg: Add
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
Message-ID: <20190423183224.UqIGGRNbkcuJwF267Tp3nIhCAbg1YTdDgwTcLYPjWPE@z>

On 04/22/19 21:50, Philippe Mathieu-Daud=C3=A9 wrote:
> Add fw_cfg_arch_key_name() which returns the name of
> an architecture-specific key.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  MAINTAINERS               |  1 +
>  hw/nvram/fw_cfg.c         |  2 +-
>  include/hw/nvram/fw_cfg.h | 11 +++++++++++
>  stubs/Makefile.objs       |  1 +
>  stubs/fw_cfg.c            | 21 +++++++++++++++++++++
>  5 files changed, 35 insertions(+), 1 deletion(-)
>  create mode 100644 stubs/fw_cfg.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 56139ac8ab0..444783bb652 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1675,6 +1675,7 @@ R: Gerd Hoffmann <kraxel@redhat.com>
>  S: Supported
>  F: docs/specs/fw_cfg.txt
>  F: hw/nvram/fw_cfg.c
> +F: stubs/fw_cfg.c
>  F: include/hw/nvram/fw_cfg.h
>  F: include/standard-headers/linux/qemu_fw_cfg.h
>  F: tests/libqos/fw_cfg.c
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index d374a970fea..b2dc0a80cbc 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -100,7 +100,7 @@ static const char *key_name(uint16_t key)
>      };
> =20
>      if (key & FW_CFG_ARCH_LOCAL) {
> -        return NULL;
> +        return fw_cfg_arch_key_name(key);
>      }
>      if (key < FW_CFG_FILE_FIRST) {
>          return fw_cfg_wellknown_keys[key];
> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> index f5a6895a740..828ad9dedc6 100644
> --- a/include/hw/nvram/fw_cfg.h
> +++ b/include/hw/nvram/fw_cfg.h
> @@ -226,4 +226,15 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
>  FWCfgState *fw_cfg_find(void);
>  bool fw_cfg_dma_enabled(void *opaque);
> =20
> +/**
> + * fw_cfg_arch_key_name:
> + *
> + * @key: The uint16 selector key.
> + *
> + * Returns: The stringified architecture-specific name if the selector
> + *          refers to a well-known numerically defined item, or NULL o=
n
> + *          key lookup failure.
> + */

We might want to document that we expect FW_CFG_ARCH_LOCAL to be set in
"key", but I really don't insist.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo

> +const char *fw_cfg_arch_key_name(uint16_t key);
> +
>  #endif
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index 269dfa58326..73452ad2657 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -39,3 +39,4 @@ stub-obj-y +=3D xen-hvm.o
>  stub-obj-y +=3D pci-host-piix.o
>  stub-obj-y +=3D ram-block.o
>  stub-obj-y +=3D ramfb.o
> +stub-obj-y +=3D fw_cfg.o
> diff --git a/stubs/fw_cfg.c b/stubs/fw_cfg.c
> new file mode 100644
> index 00000000000..bb1e3c8aa95
> --- /dev/null
> +++ b/stubs/fw_cfg.c
> @@ -0,0 +1,21 @@
> +/*
> + * fw_cfg stubs
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
> +#include "hw/nvram/fw_cfg.h"
> +
> +const char *fw_cfg_arch_key_name(uint16_t key)
> +{
> +    return NULL;
> +}
>=20


