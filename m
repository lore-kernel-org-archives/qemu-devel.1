Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9FDCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 10:14:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 785AC21D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 10:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 785AC21D7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLPH5-0004OD-M8
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 06:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iLPGK-0003uc-DW
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iLPGF-0000qy-Dj
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:13:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43592)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iLPGD-0000qZ-Hc
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:13:31 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DBA9F81F0E
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 10:13:27 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id v7so464222wrf.4
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 03:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TtpeVOU0CB3Z5Pi14TfQb3eoNoka1C+7OsdVoDAEyJQ=;
 b=QimlzNV6h1866NCfinJiBfnG95Eyn2ClH6E2IbYOCPYbE31vhqSGnS5OOCNYzKeK7F
 wGsrYI8gAueKjIN6kiFmmduqwhDiCYgkWBhuUF0abMtAduZSB1Ob8Cy0P8q/mChQxS8h
 malrRs4Nt8N+gnQHp20H2J76MCGtimXRcTj5gFr3Oifz9EAh8kvWb+USyGljJ4K3oGoq
 7ipBVqlbGpiCjxMrBgnfqJMbEy3Zl9lTAJ/T5IfH7Ikd8MRHR3EOnOsqS9lofKzV53mg
 wtFLcSlnI2ifjc4QpqQMN1oUPqokKvDLk1z9FoXy9PdhxzFsfv12hRWflwVUDAsOn3v2
 4Ogw==
X-Gm-Message-State: APjAAAW7Rsz9v4mpzv1ThmoK6G7AgzkpG23dGVMq8xWO3KfApPMOHScm
 ta2HjUAsspcoYHcYrJxck41tvqzSYy2VQnOPTvkZhlFRJhHNcDcebt+E/T1vl1JalDK3bk75cNn
 by/eDJtpdMhvc6aE=
X-Received: by 2002:adf:f342:: with SMTP id e2mr7526501wrp.61.1571393606554;
 Fri, 18 Oct 2019 03:13:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz+3NzNQn9FvsIQOtta1OOWdkuNxGj4MR/rBLllahR05nKUHca1ThqhXDg1PMLWRrtb4OsFgQ==
X-Received: by 2002:adf:f342:: with SMTP id e2mr7526470wrp.61.1571393606316;
 Fri, 18 Oct 2019 03:13:26 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id y3sm9244642wro.36.2019.10.18.03.13.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Oct 2019 03:13:25 -0700 (PDT)
Subject: Re: [PATCH 26/32] hw/pci-host/piix: Move RCR_IOPORT register
 definition
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191015162705.28087-1-philmd@redhat.com>
 <20191015162705.28087-27-philmd@redhat.com>
 <CAL1e-=jVr+idQKNdOGSrODeq7XU-0JcCFTwapqk9-JvAKxk6Pw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e149d24f-8d77-4126-8fc8-012b114dfe37@redhat.com>
Date: Fri, 18 Oct 2019 12:13:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=jVr+idQKNdOGSrODeq7XU-0JcCFTwapqk9-JvAKxk6Pw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/18/19 11:19 AM, Aleksandar Markovic wrote:
> On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com=20
> <mailto:philmd@redhat.com>> wrote:
>=20
>     From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org <mailto:f4bug@am=
sat.org>>
>=20
>     The RCR_IOPORT register belongs to the PIIX chipset.
>     Move the definition to "piix.h".
>=20
>     Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>     <mailto:philmd@redhat.com>>
>     ---
>      =C2=A0hw/pci-host/piix.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
| 1 +
>      =C2=A0include/hw/i386/pc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 6 -=
-----
>      =C2=A0include/hw/southbridge/piix.h | 6 ++++++
>      =C2=A03 files changed, 7 insertions(+), 6 deletions(-)
>=20
>=20
> Does it make sense to add prefix PIIX_ or a similar one to the register=
=20
> name?

Good idea, it will make the comment in hw/i386/acpi-build.c:213 cleaner:

     /* The above need not be conditional on machine type because the=20
reset port
      * happens to be the same on PIIX (pc) and ICH9 (q35). */
     QEMU_BUILD_BUG_ON(ICH9_RST_CNT_IOPORT !=3D RCR_IOPORT);

>=20
> In any case:
>=20
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com=20
> <mailto:amarkovic@wavecomp.com>>

Thanks!

>=20
>     diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
>     index 3292703de7..3770575c1a 100644
>     --- a/hw/pci-host/piix.c
>     +++ b/hw/pci-host/piix.c
>     @@ -27,6 +27,7 @@
>      =C2=A0#include "hw/irq.h"
>      =C2=A0#include "hw/pci/pci.h"
>      =C2=A0#include "hw/pci/pci_host.h"
>     +#include "hw/southbridge/piix.h"
>      =C2=A0#include "hw/qdev-properties.h"
>      =C2=A0#include "hw/isa/isa.h"
>      =C2=A0#include "hw/sysbus.h"
>     diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>     index 183326d9fe..1c20b96571 100644
>     --- a/include/hw/i386/pc.h
>     +++ b/include/hw/i386/pc.h
>     @@ -257,12 +257,6 @@ typedef struct PCII440FXState PCII440FXState;
>=20
>      =C2=A0#define TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE
>     "igd-passthrough-i440FX"
>=20
>     -/*
>     - * Reset Control Register: PCI-accessible ISA-Compatible Register
>     at address
>     - * 0xcf9, provided by the PCI/ISA bridge (PIIX3 PCI function 0,
>     8086:7000).
>     - */
>     -#define RCR_IOPORT 0xcf9
>     -
>      =C2=A0PCIBus *i440fx_init(const char *host_type, const char *pci_t=
ype,
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0PCII440FXState **pi440fx_state, int *piix_devfn,
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ISABus **isa_bus, qemu_irq *pic,
>     diff --git a/include/hw/southbridge/piix.h
>     b/include/hw/southbridge/piix.h
>     index add352456b..79ebe0089b 100644
>     --- a/include/hw/southbridge/piix.h
>     +++ b/include/hw/southbridge/piix.h
>     @@ -18,6 +18,12 @@ I2CBus *piix4_pm_init(PCIBus *bus, int devfn,
>     uint32_t smb_io_base,
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0qemu_irq sci_irq, qemu_irq smi_irq,
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0int smm_enabled, DeviceState **piix4_pm);
>=20
>     +/*
>     + * Reset Control Register: PCI-accessible ISA-Compatible Register
>     at address
>     + * 0xcf9, provided by the PCI/ISA bridge (PIIX3 PCI function 0,
>     8086:7000).
>     + */
>     +#define RCR_IOPORT 0xcf9
>     +
>      =C2=A0extern PCIDevice *piix4_dev;
>=20
>      =C2=A0DeviceState *piix4_create(PCIBus *pci_bus, ISABus **isa_bus,
>     --=20
>     2.21.0
>=20
>=20

