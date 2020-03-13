Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32890C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 19:58:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF5AE206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 19:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PrQeKPQz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5AE206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCqS1-00048k-3i
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 15:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCqQw-0002sh-CP
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 15:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCqQt-0000vS-PS
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 15:57:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53630
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCqQt-0000q9-Lq
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 15:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584129443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9UFKTi1jkHxCDRgfhLIXb2EAUsNxhIhfkcd+L8LX5Sk=;
 b=PrQeKPQzils7Z5T0fHFLIT9Ns0jwhj2W9vO1/Ai14h2wyxCr2JDw69bQZuEhsrffLgtO/t
 /nS02eA0qHgP1dOAB+ukw87T3ZLaSUIN9Zj+hMPJEpPkyIhOoNjMOSF2z9pHVzIEzsrlyH
 FAOuFBXRrKvxwg8CjAA0+BPTRFzl4kM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-gjxSffxGPUO1guJmJWLXcw-1; Fri, 13 Mar 2020 15:57:21 -0400
X-MC-Unique: gjxSffxGPUO1guJmJWLXcw-1
Received: by mail-wm1-f72.google.com with SMTP id s15so1772243wmc.0
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 12:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lUjd4xxVbhE6YF9T5EkQrO4WbvP2UBVOAbNFXlKIq70=;
 b=pADPehzKM0NC7cQx1hkHMtLC4MXDKovM4NZ2elqL5q2mcDUdGTn+DVH04k1PiscyH2
 Klpdedus/ChskCZRFF7z8hptEI0FlWlvzn6OnqsYZt3VhSqQCjAmong9v56rrKOFcVY6
 0wh8E8wXRtSQmrcx2DNjVxUPiVo0/fWh6U4eVatczs8p4nBpVXZ23N/HoLQQxqsACgg0
 +8wXYFztMm9zRGB7iyUDC+SYns+viWY83zsdAdzyvQMqQN8OFGj9NYyjkzFIfY156J/+
 Zy3IcOCk6XE/eWnZkCEZBSEhrFJlnlIpfmuWo6Dm+CuXlAf+WRYPYzB+oyhwtHW2PRiC
 6dMA==
X-Gm-Message-State: ANhLgQ1TCb8c2L6/1jrXgLPeV8ReAqOHAXIeKQ3FEaSSay3Rb+HGfRx5
 cVKDe7CnJBSDSTNV1reEgb9sHXG8Cu+YdL1qYkHq0Y+8SdwMelyCqMFMK65jZc447BFsm9HMM9Z
 GgipbqByFqIU90yk=
X-Received: by 2002:a05:600c:2c06:: with SMTP id
 q6mr7040411wmg.52.1584129440089; 
 Fri, 13 Mar 2020 12:57:20 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtGNAnISMgpGmBLF0qt2v93YeGFuvutbQkQAZ2mFj7EwlH7zEtLtpEtgRD2UU1H9Kmm95W7VQ==
X-Received: by 2002:a05:600c:2c06:: with SMTP id
 q6mr7040393wmg.52.1584129439803; 
 Fri, 13 Mar 2020 12:57:19 -0700 (PDT)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id a1sm22662329wro.72.2020.03.13.12.57.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2020 12:57:19 -0700 (PDT)
Subject: Re: [PATCH v3 07/16] hw/i386/vmport: Introduce vmport.h
To: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org
References: <20200312165431.82118-1-liran.alon@oracle.com>
 <20200312165431.82118-8-liran.alon@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <13b98a16-6465-e1c9-5f52-0f338c60fbd5@redhat.com>
Date: Fri, 13 Mar 2020 20:57:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312165431.82118-8-liran.alon@oracle.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 5:54 PM, Liran Alon wrote:
> No functional change. This is mere refactoring.
>=20
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> ---
>   hw/i386/pc.c             |  1 +
>   hw/i386/vmmouse.c        |  1 +
>   hw/i386/vmport.c         |  1 +
>   include/hw/i386/pc.h     | 13 -------------
>   include/hw/i386/vmport.h | 16 ++++++++++++++++

What about moving it to hw/i386/vmport.h (no under include/)?

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>   5 files changed, 19 insertions(+), 13 deletions(-)
>   create mode 100644 include/hw/i386/vmport.h
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 6ab4acb0c62e..6ac71e1af32b 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -31,6 +31,7 @@
>   #include "hw/i386/apic.h"
>   #include "hw/i386/topology.h"
>   #include "hw/i386/fw_cfg.h"
> +#include "hw/i386/vmport.h"
>   #include "sysemu/cpus.h"
>   #include "hw/block/fdc.h"
>   #include "hw/ide.h"
> diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
> index e8e62bd96b8c..49a546fd3bb6 100644
> --- a/hw/i386/vmmouse.c
> +++ b/hw/i386/vmmouse.c
> @@ -26,6 +26,7 @@
>   #include "qapi/error.h"
>   #include "ui/console.h"
>   #include "hw/i386/pc.h"
> +#include "hw/i386/vmport.h"
>   #include "hw/input/i8042.h"
>   #include "hw/qdev-properties.h"
>   #include "migration/vmstate.h"
> diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
> index ead2f2d5326f..e9ea5fe7f765 100644
> --- a/hw/i386/vmport.c
> +++ b/hw/i386/vmport.c
> @@ -31,6 +31,7 @@
>   #include "qemu/osdep.h"
>   #include "hw/isa/isa.h"
>   #include "hw/i386/pc.h"
> +#include "hw/i386/vmport.h"
>   #include "hw/input/i8042.h"
>   #include "hw/qdev-properties.h"
>   #include "sysemu/hw_accel.h"
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index d5ac76d54e1f..60c988c4a5aa 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -134,19 +134,6 @@ typedef struct PCMachineClass {
>  =20
>   GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
>  =20
> -/* vmport.c */
> -#define TYPE_VMPORT "vmport"
> -typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t address);
> -
> -static inline void vmport_init(ISABus *bus)
> -{
> -    isa_create_simple(bus, TYPE_VMPORT);
> -}
> -
> -void vmport_register(unsigned char command, VMPortReadFunc *func, void *=
opaque);
> -void vmmouse_get_data(uint32_t *data);
> -void vmmouse_set_data(const uint32_t *data);
> -
>   /* pc.c */
>   extern int fd_bootchk;
>  =20
> diff --git a/include/hw/i386/vmport.h b/include/hw/i386/vmport.h
> new file mode 100644
> index 000000000000..f0c1e985ca08
> --- /dev/null
> +++ b/include/hw/i386/vmport.h
> @@ -0,0 +1,16 @@
> +#ifndef HW_VMPORT_H
> +#define HW_VMPORT_H
> +
> +#define TYPE_VMPORT "vmport"
> +typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t address);
> +
> +static inline void vmport_init(ISABus *bus)
> +{
> +    isa_create_simple(bus, TYPE_VMPORT);
> +}
> +
> +void vmport_register(unsigned char command, VMPortReadFunc *func, void *=
opaque);
> +void vmmouse_get_data(uint32_t *data);
> +void vmmouse_set_data(const uint32_t *data);
> +
> +#endif
>=20


