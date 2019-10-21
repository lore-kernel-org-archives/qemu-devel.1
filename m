Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAB8CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:57:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A44A82084B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44A82084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMa3f-0006Oc-R1
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 11:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMa2s-0005gy-Ed
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:56:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMa2p-00005q-Nj
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:56:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54114)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMa2p-00004q-Fe
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:56:31 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 337A78535D
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 15:56:29 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id v8so6620949wrt.16
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 08:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fCo8epeB07g14wJcxGAOGTwUjr6BSErnYOWlDkDuG1k=;
 b=PFKa3HKDA38zoTTMU0g1QqfMnkhWdtMvRi0eBrdV7VghdT/3OtfFrS8a5bK2WZtouO
 3x75359P3QtYMKwJ6uU3YJcBZEX2ccw7SqkY53Rs2MJaOJeB6vGG5toljhjHJMUCPDUo
 jPCoTytAPmNYGeWyO4oMZh5DA/AC1KRD6LJrfMBItTV4rVxd17AiSbtgKgm9y60idDJ8
 fAwu+RXdqNUgCjaPA738aAbMiJ1IEQRl1xTkozLF6cWxCSLRPTq2ZhX1uRHyEiS5mYeM
 xhA34t1T7BS3QAfgGuqV5oTFUJnKroNmWcWqkol9TwMjih+rxlvOqm9pmVbg5T6aO1oM
 zRaQ==
X-Gm-Message-State: APjAAAXYnH5OlcgX9BNF540EUzGpIu1nB7Pf+hYyWOeV4kohrfkvglDs
 xQMJUt4ynjjpQW4eKIjs52TwvPAJaV865b4ou7QImEqeERKRaoTyrtq48kvW5wXecboQttoif08
 UJkEhS0jlS7ER9JI=
X-Received: by 2002:a1c:990a:: with SMTP id b10mr19476615wme.39.1571673387807; 
 Mon, 21 Oct 2019 08:56:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz8h9QT1OMoiObhND4cXnd932RWn4nisRCw5izziNOh+97I2bnJ44dvTjpgmLRvastYeWsv/A==
X-Received: by 2002:a1c:990a:: with SMTP id b10mr19476590wme.39.1571673387473; 
 Mon, 21 Oct 2019 08:56:27 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id f8sm14697365wmb.37.2019.10.21.08.56.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2019 08:56:26 -0700 (PDT)
Subject: Re: [PATCH v2 06/20] piix4: Add a i8257 DMA Controller as specified
 in datasheet
To: Li Qiang <liq3ea@gmail.com>
References: <20191018134754.16362-1-philmd@redhat.com>
 <20191018134754.16362-7-philmd@redhat.com>
 <CAKXe6SL6GX_eL4yXfmdbGaYd0=Pbpo1vx1P+NbWM_eZ3GCYgBA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <56d26cdd-795e-0707-4335-c94e5af119b5@redhat.com>
Date: Mon, 21 Oct 2019 17:56:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAKXe6SL6GX_eL4yXfmdbGaYd0=Pbpo1vx1P+NbWM_eZ3GCYgBA@mail.gmail.com>
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/19 5:25 PM, Li Qiang wrote:
>=20
>=20
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com <mailto:philmd@redhat.co=
m>> =E4=BA=8E=20
> 2019=E5=B9=B410=E6=9C=8818=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=88=
9:55=E5=86=99=E9=81=93=EF=BC=9A
>=20
>     From: Herv=C3=A9 Poussineau <hpoussin@reactos.org
>     <mailto:hpoussin@reactos.org>>
>=20
>     Remove i8257 instantiated in malta board, to not have it twice.
>=20
>     Acked-by: Michael S. Tsirkin <mst@redhat.com <mailto:mst@redhat.com=
>>
>     Acked-by: Paolo Bonzini <pbonzini@redhat.com
>     <mailto:pbonzini@redhat.com>>
>     Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org
>     <mailto:hpoussin@reactos.org>>
>     Message-Id: <20171216090228.28505-9-hpoussin@reactos.org
>     <mailto:20171216090228.28505-9-hpoussin@reactos.org>>
>     Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com
>     <mailto:amarkovic@wavecomp.com>>
>     [PMD: rebased]
>     Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>     <mailto:philmd@redhat.com>>
>     ---
>      =C2=A0hw/isa/piix4.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 4 ++++
>      =C2=A0hw/mips/mips_malta.c | 2 --
>      =C2=A02 files changed, 4 insertions(+), 2 deletions(-)
>=20
>     diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
>     index ac9383a658..0b24d8323c 100644
>     --- a/hw/isa/piix4.c
>     +++ b/hw/isa/piix4.c
>     @@ -29,6 +29,7 @@
>      =C2=A0#include "hw/pci/pci.h"
>      =C2=A0#include "hw/isa/isa.h"
>      =C2=A0#include "hw/sysbus.h"
>     +#include "hw/dma/i8257.h"
>      =C2=A0#include "migration/vmstate.h"
>      =C2=A0#include "sysemu/reset.h"
>      =C2=A0#include "sysemu/runstate.h"
>     @@ -167,6 +168,9 @@ static void piix4_realize(PCIDevice *dev, Error
>     **errp)
>      =C2=A0 =C2=A0 =C2=A0/* initialize ISA irqs */
>      =C2=A0 =C2=A0 =C2=A0isa_bus_irqs(isa_bus, s->isa);
>=20
>     +=C2=A0 =C2=A0 /* DMA */
>     +=C2=A0 =C2=A0 i8257_dma_init(isa_bus, 0);
>     +
>      =C2=A0 =C2=A0 =C2=A0piix4_dev =3D dev;
>      =C2=A0}
>=20
>=20
> Could you please explain why this is better calling 'i8257_dma_init' in=
=20
> piix4 realize function
> instead of calling it in mips_malta_init.

i8257_dma_init() is a bit misnamed as it instantiate 2x i8257.

The PIIX4 integrates 2x i8237 (very similar to the i8257).

The i8237 are parts of the PIIX4 chip, and are not chips on the Malta=20
board PCB.

So when you instantiate a PIIX4 in QEMU, one expects them integrated,=20
and should not have to manually manage them outside of the southbridge=20
chipset.

> I'm still a little of which things should be done in realize and which=20
> should be done in qom instance init function.

I remember a thread started by Peter Maydell when he was working on the=20
MPS2 boards, but I can't find it.

Anyway this thread is more recent:
"Object instantiation vs. device realization: what to do when?"
https://www.mail-archive.com/qemu-devel@nongnu.org/msg596361.html

>=20
> Thanks,
> Li Qiang
>=20
>     diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
>     index e499b7a6bb..df247177ca 100644
>     --- a/hw/mips/mips_malta.c
>     +++ b/hw/mips/mips_malta.c
>     @@ -28,7 +28,6 @@
>      =C2=A0#include "cpu.h"
>      =C2=A0#include "hw/i386/pc.h"
>      =C2=A0#include "hw/isa/superio.h"
>     -#include "hw/dma/i8257.h"
>      =C2=A0#include "hw/char/serial.h"
>      =C2=A0#include "net/net.h"
>      =C2=A0#include "hw/boards.h"
>     @@ -1430,7 +1429,6 @@ void mips_malta_init(MachineState *machine)
>      =C2=A0 =C2=A0 =C2=A0smbus =3D piix4_pm_init(pci_bus, piix4_devfn +=
 3, 0x1100,
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0isa_get_irq(NULL, 9), NULL, 0, NULL);
>      =C2=A0 =C2=A0 =C2=A0pit =3D i8254_pit_init(isa_bus, 0x40, 0, NULL)=
;
>     -=C2=A0 =C2=A0 i8257_dma_init(isa_bus, 0);
>      =C2=A0 =C2=A0 =C2=A0mc146818_rtc_init(isa_bus, 2000, NULL);
>=20
>      =C2=A0 =C2=A0 =C2=A0/* generate SPD EEPROM data */
>     --=20
>     2.21.0
>=20
>=20

