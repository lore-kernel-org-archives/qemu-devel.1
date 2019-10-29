Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8833CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 17:06:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCA0A20656
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 17:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA0A20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPUwU-0008I7-UZ
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 13:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iPUus-0006RO-KK
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 13:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iPUuq-0004EY-Ox
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 13:04:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14286)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iPUuq-0004Dk-Fy
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 13:04:20 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1B30A8553B
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 17:04:18 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id k10so8817867wrl.22
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 10:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mzTXs9+JYvqiPYK2J5PUZnQVrjKZuEbQQFrpjg8pI4k=;
 b=M7ipFplENMV7GA84OpHf8jzVbXn1JBHo58M6kc3dcxDiWZa+NAap2Ly1FOD0MJ/0bG
 uM0rxiEPt5rR1c/rvZ9k5/l1cJq/cUKVMbAVAsuwBzV6dSBuc2oOASjOKHgGc4zDtjJT
 IChML0mC0BHvvaBHKOzN3lmah8I7L8ZGUySPwvqtNmMWOR9Fs1PK6K+1EjyyVifqxzoC
 Ky5Hi9aCjFZbMeLUy8L+1VHoXxUf+f3vrhLsL5fKmL9q1WN8cSqxceIqxOCppimXany2
 7Ah9VOnqcHka8U0Cm4LiPHUSnJC1tfpTdgJJe8ZVoqJZwk7CtPLkZqs3n5Z790B9GTyD
 GFdw==
X-Gm-Message-State: APjAAAWTcQwKUZ+FOsf/zkE4N0r5uiIaXU/va2aOd1LC/XJqTZIDO6pH
 XNHLWuUv+RnrY6vrBnYkXoIvU38qw54KqyepjQ0xmzN5PeNJEkW0e9H84kvKNesRRWT46cbBfiK
 A6IvpXERA+hCh9Lw=
X-Received: by 2002:adf:ef4f:: with SMTP id c15mr21331217wrp.296.1572368656841; 
 Tue, 29 Oct 2019 10:04:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyxXAcrTWvlbBV0yF/P+gF7N8LpqEmHIyQYMLMYOAl4jWrNRTGKUw79Ey5KFeOn+jR6/E7dIg==
X-Received: by 2002:adf:ef4f:: with SMTP id c15mr21331191wrp.296.1572368656521; 
 Tue, 29 Oct 2019 10:04:16 -0700 (PDT)
Received: from [192.168.20.70] (94.222.26.109.rev.sfr.net. [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id w17sm17509467wra.34.2019.10.29.10.04.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Oct 2019 10:04:15 -0700 (PDT)
Subject: Re: [PULL 00/20] hw/i386/pc: Split PIIX3 southbridge from i440FX
 northbridge
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191028163447.18541-1-philmd@redhat.com>
 <CAL1e-=gK_Lf+ipsJxRPgyp01AuQiOeOn9QvzRxaR6LkTJiqhLA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dce5d2a5-1474-c4fe-0572-67b0dc6924c1@redhat.com>
Date: Tue, 29 Oct 2019 18:04:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=gK_Lf+ipsJxRPgyp01AuQiOeOn9QvzRxaR6LkTJiqhLA@mail.gmail.com>
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 10/29/19 6:18 AM, Aleksandar Markovic wrote:
>=20
>=20
> On Monday, October 28, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com=20
> <mailto:philmd@redhat.com>> wrote:
>=20
>     Hi Peter,
>=20
>     This is a X86/MIPS pull, Paolo and Aleksandar are OK I send it:
>=20
>     https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg04959.html
>     <https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg04959.htm=
l>
>=20
>     Regards,
>=20
>     Phil.
>=20
>=20
> Does this pull request apply on the current code base directly, or is=20
> dependant on prior application of other pull requests?

I'm not sure I understand the question, this is a pull request, so it=20
has been tested on the commit on the last master commit (yesterday),
the cover says commit '9bb7350232'. Is there a problem?

>     The following changes since commit
>     9bb73502321d46f4d320fa17aa38201445783fc4:
>=20
>      =C2=A0 Merge remote-tracking branch 'remotes/mst/tags/for_upstream=
' into
>     staging (2019-10-28 13:32:40 +0000)
>=20
>     are available in the Git repository at:
>=20
>     https://gitlab.com/philmd/qemu.git
>     <https://gitlab.com/philmd/qemu.git>
>     tags/pc_split_i440fx_piix-pull-request
>=20
>     for you to fetch changes up to d1389352cde824ce8dab7c1a2ded150df6ad=
d124:
>=20
>      =C2=A0 hw/pci-host/i440fx: Remove the last PIIX3 traces (2019-10-2=
8
>     16:12:29 +0100)
>=20
>     ----------------------------------------------------------------
>     The i440FX northbridge is only used by the PC machine, while the
>     PIIX southbridge is also used by the Malta MIPS machine.
>=20
>     Split the PIIX3 southbridge from i440FX northbridge.
>=20
>     ----------------------------------------------------------------
>=20
>     Herv=C3=A9 Poussineau (5):
>      =C2=A0 piix4: Add the Reset Control Register
>      =C2=A0 piix4: Add an i8259 Interrupt Controller as specified in da=
tasheet
>      =C2=A0 piix4: Rename PIIX4 object to piix4-isa
>      =C2=A0 piix4: Add an i8257 DMA Controller as specified in datashee=
t
>      =C2=A0 piix4: Add an i8254 PIT Controller as specified in datashee=
t
>=20
>     Philippe Mathieu-Daud=C3=A9 (15):
>      =C2=A0 MAINTAINERS: Keep PIIX4 South Bridge separate from PC Chips=
ets
>      =C2=A0 Revert "irq: introduce qemu_irq_proxy()"
>      =C2=A0 piix4: Add a MC146818 RTC Controller as specified in datash=
eet
>      =C2=A0 hw/mips/mips_malta: Create IDE hard drive array dynamically
>      =C2=A0 hw/mips/mips_malta: Extract the PIIX4 creation code as piix=
4_create()
>      =C2=A0 hw/isa/piix4: Move piix4_create() to hw/isa/piix4.c
>      =C2=A0 hw/i386: Remove obsolete LoadStateHandler::load_state_old h=
andlers
>      =C2=A0 hw/pci-host/piix: Extract piix3_create()
>      =C2=A0 hw/pci-host/piix: Move RCR_IOPORT register definition
>      =C2=A0 hw/pci-host/piix: Define and use the PIIX IRQ Route Control=
 Registers
>      =C2=A0 hw/pci-host/piix: Move i440FX declarations to hw/pci-host/i=
440fx.h
>      =C2=A0 hw/pci-host/piix: Fix code style issues
>      =C2=A0 hw/pci-host/piix: Extract PIIX3 functions to hw/isa/piix3.c
>      =C2=A0 hw/pci-host: Rename incorrectly named 'piix' as 'i440fx'
>      =C2=A0 hw/pci-host/i440fx: Remove the last PIIX3 traces
>=20
>      =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 14 +-
>      =C2=A0hw/acpi/pcihp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-
>      =C2=A0hw/acpi/piix4.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 42 +--
>      =C2=A0hw/core/irq.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 14 -
>      =C2=A0hw/i386/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +-
>      =C2=A0hw/i386/acpi-build.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A05 +-
>      =C2=A0hw/i386/pc_piix.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 10 +-
>      =C2=A0hw/i386/xen/xen-hvm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 =C2=A05 +-
>      =C2=A0hw/intc/apic_common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 49 ----
>      =C2=A0hw/isa/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +
>      =C2=A0hw/isa/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A01 +
>      =C2=A0hw/isa/piix3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0| 399 +++++++++++++++++++++++++++++
>      =C2=A0hw/isa/piix4.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0| 151 ++++++++++-
>      =C2=A0hw/mips/gt64xxx_pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 =C2=A05 +-
>      =C2=A0hw/mips/mips_malta.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 46 +---
>      =C2=A0hw/pci-host/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 =C2=A03 +-
>      =C2=A0hw/pci-host/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 =C2=A02 +-
>      =C2=A0hw/pci-host/{piix.c =3D> i440fx.c} | 424 +------------------=
------------
>      =C2=A0hw/timer/i8254_common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 40 ---
>      =C2=A0include/hw/acpi/piix4.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A06 -
>      =C2=A0include/hw/i386/pc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 37 ---
>      =C2=A0include/hw/irq.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 -
>      =C2=A0include/hw/isa/isa.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A02 +
>      =C2=A0include/hw/pci-host/i440fx.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 36 +=
++
>      =C2=A0include/hw/southbridge/piix.h=C2=A0 =C2=A0 |=C2=A0 74 ++++++
>      =C2=A0stubs/pci-host-piix.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 =C2=A03 +-
>      =C2=A026 files changed, 699 insertions(+), 683 deletions(-)
>      =C2=A0create mode 100644 hw/isa/piix3.c
>      =C2=A0rename hw/pci-host/{piix.c =3D> i440fx.c} (58%)
>      =C2=A0delete mode 100644 include/hw/acpi/piix4.h
>      =C2=A0create mode 100644 include/hw/pci-host/i440fx.h
>      =C2=A0create mode 100644 include/hw/southbridge/piix.h
>=20
>     --=20
>     2.21.0
>=20
>=20

