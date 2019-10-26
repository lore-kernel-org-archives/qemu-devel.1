Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A09CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 14:40:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BB592070B
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 14:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BB592070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iONEh-0005gd-Eh
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 10:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iONDs-0002t6-6o
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 10:39:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iONDp-0000xh-HO
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 10:39:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46738)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iONDp-0000xN-95
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 10:39:17 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7FEA9C049E10
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 14:39:15 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id 92so3063005wro.14
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 07:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uIlXA8ZsiBUSke4/t5PmYaz3QyBp2HF7Hvs//PtEvFY=;
 b=LU26/9XMUUwjgUGOg8f3Bk1/6xBxyapcU0+n+Y2el7wpI4SBvGZTpEkI6cCEQaQlsQ
 NMR8cXLdRdj20nAX5k71wOUl9jYCkh6PU7nl3bSoFbDUHr51VFCNw19CADdXFXJ05ogm
 ots+h9jA/ZfNYFd1ahSZNkaWdW9FzNt9JCvam0UelWDq/IKLPLoi1nwSSAcu3qKPbX71
 WJwckU8MpMi8HFMmwidR9WUPydsBATzlrDpidQT1JnqlmJ+26EqIyTI+x9ljTOdfB8Dq
 hGbpsAfahwCEuslgyaNqX61/aWsWcBwtOj8YMKhnOB6P7/a1fzHAEpiSxWY/GdW9hUbL
 r6BA==
X-Gm-Message-State: APjAAAWSQRdvGQB4xaMqRaNsEO+PoiVBNFrPI5/qmnySO5fLvCkU4fjG
 h60bLQFSUHz5+EopXCNOoJnoFAb5w5Q39XaUGluVa6qwPmatIjFiwT4X4JpWb3RrW91g6tuzpRC
 scUlsQYW9k+PZMc4=
X-Received: by 2002:adf:a54e:: with SMTP id j14mr8253373wrb.265.1572100754173; 
 Sat, 26 Oct 2019 07:39:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyq2LlWVBT19YgF/awo7HX5HOrvvEzW+W8xNXM/hbe/HiyESFHHMWtNL/gpp+GntnU4PUQgfA==
X-Received: by 2002:adf:a54e:: with SMTP id j14mr8253348wrb.265.1572100753895; 
 Sat, 26 Oct 2019 07:39:13 -0700 (PDT)
Received: from [192.168.1.33] (62.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.62])
 by smtp.gmail.com with ESMTPSA id f143sm8982667wme.40.2019.10.26.07.39.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Oct 2019 07:39:13 -0700 (PDT)
Subject: Re: [PATCH v2 00/20] hw/i386/pc: Split PIIX3 southbridge from i440FX
 northbridge
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191018134754.16362-1-philmd@redhat.com>
 <CAL1e-=ipp6u=qPj4UEWj+SB=KmDyVnJeOJwH1bQiQmQv1YyANQ@mail.gmail.com>
 <CAL1e-=jnjn-n=h3mDN+1z14H9WmGjp95thPQ7bYkW7095wHCKA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bc8bf8fc-7140-8762-3061-0068ade6ef89@redhat.com>
Date: Sat, 26 Oct 2019 16:39:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=jnjn-n=h3mDN+1z14H9WmGjp95thPQ7bYkW7095wHCKA@mail.gmail.com>
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
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

Hi Aleksandar,

On 10/25/19 12:51 PM, Aleksandar Markovic wrote:
> On Thursday, October 24, 2019, Aleksandar Markovic=20
> <aleksandar.m.mail@gmail.com <mailto:aleksandar.m.mail@gmail.com>> wrot=
e:
>=20
>=20
>=20
>     On Friday, October 18, 2019, Philippe Mathieu-Daud=C3=A9
>     <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
>=20
>         Changes since v1 [0]:
>         - Removed patch reintroducing DO_UPCAST() use (thuth)
>         - Took various patches out to reduce series (thuth)
>         - Added review tags (thanks all for reviewing!)
>=20
>=20
>     Philippe,
>=20
>     Do you intend to submit v3? The softfreeze is close.
>=20
>     A.
>=20
>=20
> Philippe,
>=20
> It looks you are very busy these days. Do you mind my integrating this=20
> series in next Mips queue, in its present v2 state? (You can certainly=20
> do further refinements later on.)

I addressed the review comments from this version, however it can not
be merged yet ...

>=20
> Aleksandar
>=20
>         $ git backport-diff -u pc_split_i440fx_piix-v1 -r mc146818rtc_i=
nit..
>         Key:
>         [----] : patches are identical
>         [####] : number of functional differences between
>         upstream/downstream patch
>         [down] : patch is downstream-only
>         The flags [FC] indicate (F)unctional and (C)ontextual
>         differences, respectively
>=20
>         001/20:[----] [--] 'MAINTAINERS: Keep PIIX4 South Bridge
>         separate from PC Chipsets'
>         002/20:[0011] [FC] 'piix4: add Reset Control Register'
>         003/20:[0014] [FC] 'piix4: add a i8259 interrupt controller as
>         specified in datasheet'
>         004/20:[----] [--] 'Revert "irq: introduce qemu_irq_proxy()"'
>         005/20:[----] [--] 'piix4: rename PIIX4 object to piix4-isa'
>         006/20:[----] [-C] 'piix4: add a i8257 dma controller as
>         specified in datasheet'
>         007/20:[----] [-C] 'piix4: add a i8254 pit controller as
>         specified in datasheet'
>         008/20:[----] [-C] 'piix4: add a mc146818rtc controller as
>         specified in datasheet'
>         009/20:[----] [--] 'hw/mips/mips_malta: Create IDE hard drive
>         array dynamically'
>         010/20:[----] [--] 'hw/mips/mips_malta: Extract the PIIX4
>         creation code as piix4_create()'
>         011/20:[----] [--] 'hw/isa/piix4: Move piix4_create() to
>         hw/isa/piix4.c'
>         012/20:[----] [--] 'hw/i386: Remove obsolete
>         LoadStateHandler::load_state_old handlers'
>         013/20:[----] [--] 'hw/pci-host/piix: Extract piix3_create()'
>         014/20:[0010] [FC] 'hw/pci-host/piix: Move RCR_IOPORT register
>         definition'
>         015/20:[----] [--] 'hw/pci-host/piix: Define and use the PIIX
>         IRQ Route Control Registers'
>         016/20:[----] [--] 'hw/pci-host/piix: Move i440FX declarations
>         to hw/pci-host/i440fx.h'
>         017/20:[----] [--] 'hw/pci-host/piix: Fix code style issues'
>         018/20:[0012] [FC] 'hw/pci-host/piix: Extract PIIX3 functions t=
o
>         hw/isa/piix3.c'
>         019/20:[----] [--] 'hw/pci-host: Rename incorrectly named 'piix=
'
>         as 'i440fx''
>         020/20:[----] [-C] 'hw/pci-host/i440fx: Remove the last PIIX3
>         traces'
>=20
>         Previous cover:
>=20
>         This series is a rework of "piix4: cleanup and improvements" [1=
]
>         from Herv=C3=A9, and my "remove i386/pc dependency: PIIX cleanu=
p" [2].
>=20
>         Still trying to remove the strong X86/PC dependency 2 years lat=
er,
>         one step at a time.
>         Here we split the PIIX3 southbridge from i440FX northbridge.
>         The i440FX northbridge is only used by the PC machine, while th=
e
>         PIIX southbridge is also used by the Malta MIPS machine.
>=20
>         This is also a step forward using KConfig with the Malta board.
>         Without this split, it was impossible to compile the Malta with=
out
>         pulling various X86 pieces of code.
>=20
>         The overall design cleanup is not yet perfect, but enough to po=
st
>         as a series.
>=20
>         Now that the PIIX3 code is extracted, the code duplication with=
 the
>         PIIX4 chipset is obvious. Not worth improving for now because i=
t
>         isn't broken.
>=20
>         [0]
>         https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg03685.=
html
>         <https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg03685=
.html>
>         [1]
>         https://www.mail-archive.com/qemu-devel@nongnu.org/msg500737.ht=
ml <https://www.mail-archive.com/qemu-devel@nongnu.org/msg500737.html>
>         [2]
>         https://www.mail-archive.com/qemu-devel@nongnu.org/msg504081.ht=
ml <https://www.mail-archive.com/qemu-devel@nongnu.org/msg504081.html>
>=20
>         Based-on: <20191018133547.10936-1-philmd@redhat.com
>         <mailto:20191018133547.10936-1-philmd@redhat.com>>
>         mc146818rtc: Allow call object_initialize(MC146818_RTC) instead
>         of rtc_init()

... because it depends on this series which has been queued by Paolo but=20
is not yet merged.

>         https://mid.mail-archive.com/20191018133547.10936-1-philmd@redh=
at.com
>         <https://mid.mail-archive.com/20191018133547.10936-1-philmd@red=
hat.com>
>=20
>         Herv=C3=A9 Poussineau (5):
>          =C2=A0 piix4: Add the Reset Control Register
>          =C2=A0 piix4: Add a i8259 Interrupt Controller as specified in=
 datasheet
>          =C2=A0 piix4: Rename PIIX4 object to piix4-isa
>          =C2=A0 piix4: Add a i8257 DMA Controller as specified in datas=
heet
>          =C2=A0 piix4: Add a i8254 PIT Controller as specified in datas=
heet
>=20
>         Philippe Mathieu-Daud=C3=A9 (15):
>          =C2=A0 MAINTAINERS: Keep PIIX4 South Bridge separate from PC C=
hipsets
>          =C2=A0 Revert "irq: introduce qemu_irq_proxy()"
>          =C2=A0 piix4: Add a MC146818 RTC Controller as specified in da=
tasheet
>          =C2=A0 hw/mips/mips_malta: Create IDE hard drive array dynamic=
ally
>          =C2=A0 hw/mips/mips_malta: Extract the PIIX4 creation code as
>         piix4_create()
>          =C2=A0 hw/isa/piix4: Move piix4_create() to hw/isa/piix4.c
>          =C2=A0 hw/i386: Remove obsolete LoadStateHandler::load_state_o=
ld
>         handlers
>          =C2=A0 hw/pci-host/piix: Extract piix3_create()
>          =C2=A0 hw/pci-host/piix: Move RCR_IOPORT register definition
>          =C2=A0 hw/pci-host/piix: Define and use the PIIX IRQ Route Con=
trol
>         Registers
>          =C2=A0 hw/pci-host/piix: Move i440FX declarations to
>         hw/pci-host/i440fx.h
>          =C2=A0 hw/pci-host/piix: Fix code style issues
>          =C2=A0 hw/pci-host/piix: Extract PIIX3 functions to hw/isa/pii=
x3.c
>          =C2=A0 hw/pci-host: Rename incorrectly named 'piix' as 'i440fx=
'
>          =C2=A0 hw/pci-host/i440fx: Remove the last PIIX3 traces
>=20
>          =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 14 +-
>          =C2=A0hw/acpi/pcihp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-
>          =C2=A0hw/acpi/piix4.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 42 +--
>          =C2=A0hw/core/irq.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 14 -
>          =C2=A0hw/i386/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +-
>          =C2=A0hw/i386/acpi-build.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A05 +-
>          =C2=A0hw/i386/pc_piix.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 10 +-
>          =C2=A0hw/i386/xen/xen-hvm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A05 +-
>          =C2=A0hw/intc/apic_common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 49 ----
>          =C2=A0hw/isa/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +
>          =C2=A0hw/isa/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A01 +
>          =C2=A0hw/isa/piix3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 399
>         +++++++++++++++++++++++++++++
>          =C2=A0hw/isa/piix4.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 151 ++++++++++-
>          =C2=A0hw/mips/gt64xxx_pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A05 +-
>          =C2=A0hw/mips/mips_malta.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 46 +---
>          =C2=A0hw/pci-host/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A03 +-
>          =C2=A0hw/pci-host/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A02 +-
>          =C2=A0hw/pci-host/{piix.c =3D> i440fx.c} | 424
>         +------------------------------
>          =C2=A0hw/timer/i8254_common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 40 ---
>          =C2=A0include/hw/acpi/piix4.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 =C2=A06 -
>          =C2=A0include/hw/i386/pc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 37 ---
>          =C2=A0include/hw/irq.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 -
>          =C2=A0include/hw/isa/isa.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A02 +
>          =C2=A0include/hw/pci-host/i440fx.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
36 +++
>          =C2=A0include/hw/southbridge/piix.h=C2=A0 =C2=A0 |=C2=A0 74 ++=
++++
>          =C2=A0stubs/pci-host-piix.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A03 +-
>          =C2=A026 files changed, 699 insertions(+), 683 deletions(-)
>          =C2=A0create mode 100644 hw/isa/piix3.c
>          =C2=A0rename hw/pci-host/{piix.c =3D> i440fx.c} (58%)
>          =C2=A0delete mode 100644 include/hw/acpi/piix4.h
>          =C2=A0create mode 100644 include/hw/pci-host/i440fx.h
>          =C2=A0create mode 100644 include/hw/southbridge/piix.h
>=20
>         --=20
>         2.21.0
>=20
>=20

