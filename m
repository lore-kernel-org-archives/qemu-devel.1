Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0619CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 19:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77CCD2070B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 19:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHt/PFkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77CCD2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNjE1-0003HU-Ji
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 15:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iNjD0-0002HX-NR
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 15:55:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iNjCy-0000wn-H2
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 15:55:46 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40203)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iNjCy-0000wc-Aw
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 15:55:44 -0400
Received: by mail-ot1-x342.google.com with SMTP id d8so75866otc.7
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 12:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=fykRTiJrJh2Q/7cxmdXAZWGJ5jxlbp/w3VpVVrogzhQ=;
 b=kHt/PFkF0OmPK/J3E6NQRzjnFevl1IYJtC50avOWbZ4kPYbiyQoklrkslxw3/v2M6x
 s+4xICfG94MeGwX5xxxejPkq4haVUuGyH5mYJyIYrzB5iAQuIYkqNIaIuVfJ9ldrDtOH
 WpEIkzfdI202I4njmb5ra7B/6B2Y4Oy8XmKcH/n6IglPVT0UtkX3ne1J4ALV56BwBhDx
 A5SsqYdSFjm0tJQWdZNrCiseG9FOdQ0AA86GKKv3RzoWDhVLikl4gHFYtVcwlf6aeRS8
 G3MonhkYW+6eUq+dZCsuCkwkPOSdyLrzABXZoroKR5ec9xelmJLuaRCi/zp5f9ggQ64x
 2Ibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=fykRTiJrJh2Q/7cxmdXAZWGJ5jxlbp/w3VpVVrogzhQ=;
 b=XV840SP8+4NFRsIut/AY9/XbaKSw6KsE1OXxfQAyGVJozBqMKV8L3WDnREB4kUbzpz
 OVnqp5A3sD5osVa2dbswRw3e973vqo6oDczqJrZNfUgsIFfRQQEIqNCSOHmlFOc2QJgo
 zQxkox8KF/LYyY511SDWqbUyQXj33LKLTLgKJRKxXFlzqRb5L1hFzSs2nVpHuLMCuKeQ
 qS0/Os6tKa/uFRYQQayUfdGCOXSdhqcqV72DdBm2R3zrwkNDJK/kzG1kaQhI8BPj5o45
 OmEWnp0uJ7VjiMMmCAfn2YaW/mUW8WyeUSp7nP+3gdS8PR+x83t3F2NKe5gKZZKv30YW
 vlTA==
X-Gm-Message-State: APjAAAU/idRvS/eWnDt+yWiZyTe2o+PqX9Dcf3SyTJu99JFhdwNHDoXy
 UH5+Y5JR4DPM5+UNATToJvkR4uY/9JwIAo0QfeM=
X-Google-Smtp-Source: APXvYqzs6ZdNbuheUCFoQA7h/o3Cut+uGOCavjus4kvOIP2D95wUM62jpI4Ju5AKQbx+q7K2ulanL0bs3rUb9BW8d4U=
X-Received: by 2002:a05:6830:452:: with SMTP id
 d18mr13512798otc.295.1571946943485; 
 Thu, 24 Oct 2019 12:55:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Thu, 24 Oct 2019 12:55:43
 -0700 (PDT)
In-Reply-To: <20191018134754.16362-1-philmd@redhat.com>
References: <20191018134754.16362-1-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 24 Oct 2019 21:55:43 +0200
Message-ID: <CAL1e-=ipp6u=qPj4UEWj+SB=KmDyVnJeOJwH1bQiQmQv1YyANQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] hw/i386/pc: Split PIIX3 southbridge from i440FX
 northbridge
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002c35490595ad6bd0"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002c35490595ad6bd0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Friday, October 18, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
>
wrote:

> Changes since v1 [0]:
> - Removed patch reintroducing DO_UPCAST() use (thuth)
> - Took various patches out to reduce series (thuth)
> - Added review tags (thanks all for reviewing!)
>
>
Philippe,

Do you intend to submit v3? The softfreeze is close.

A.



> $ git backport-diff -u pc_split_i440fx_piix-v1 -r mc146818rtc_init..
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream pat=
ch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences,
> respectively
>
> 001/20:[----] [--] 'MAINTAINERS: Keep PIIX4 South Bridge separate from PC
> Chipsets'
> 002/20:[0011] [FC] 'piix4: add Reset Control Register'
> 003/20:[0014] [FC] 'piix4: add a i8259 interrupt controller as specified
> in datasheet'
> 004/20:[----] [--] 'Revert "irq: introduce qemu_irq_proxy()"'
> 005/20:[----] [--] 'piix4: rename PIIX4 object to piix4-isa'
> 006/20:[----] [-C] 'piix4: add a i8257 dma controller as specified in
> datasheet'
> 007/20:[----] [-C] 'piix4: add a i8254 pit controller as specified in
> datasheet'
> 008/20:[----] [-C] 'piix4: add a mc146818rtc controller as specified in
> datasheet'
> 009/20:[----] [--] 'hw/mips/mips_malta: Create IDE hard drive array
> dynamically'
> 010/20:[----] [--] 'hw/mips/mips_malta: Extract the PIIX4 creation code a=
s
> piix4_create()'
> 011/20:[----] [--] 'hw/isa/piix4: Move piix4_create() to hw/isa/piix4.c'
> 012/20:[----] [--] 'hw/i386: Remove obsolete LoadStateHandler::load_state=
_old
> handlers'
> 013/20:[----] [--] 'hw/pci-host/piix: Extract piix3_create()'
> 014/20:[0010] [FC] 'hw/pci-host/piix: Move RCR_IOPORT register definition=
'
> 015/20:[----] [--] 'hw/pci-host/piix: Define and use the PIIX IRQ Route
> Control Registers'
> 016/20:[----] [--] 'hw/pci-host/piix: Move i440FX declarations to
> hw/pci-host/i440fx.h'
> 017/20:[----] [--] 'hw/pci-host/piix: Fix code style issues'
> 018/20:[0012] [FC] 'hw/pci-host/piix: Extract PIIX3 functions to
> hw/isa/piix3.c'
> 019/20:[----] [--] 'hw/pci-host: Rename incorrectly named 'piix' as
> 'i440fx''
> 020/20:[----] [-C] 'hw/pci-host/i440fx: Remove the last PIIX3 traces'
>
> Previous cover:
>
> This series is a rework of "piix4: cleanup and improvements" [1]
> from Herv=C3=A9, and my "remove i386/pc dependency: PIIX cleanup" [2].
>
> Still trying to remove the strong X86/PC dependency 2 years later,
> one step at a time.
> Here we split the PIIX3 southbridge from i440FX northbridge.
> The i440FX northbridge is only used by the PC machine, while the
> PIIX southbridge is also used by the Malta MIPS machine.
>
> This is also a step forward using KConfig with the Malta board.
> Without this split, it was impossible to compile the Malta without
> pulling various X86 pieces of code.
>
> The overall design cleanup is not yet perfect, but enough to post
> as a series.
>
> Now that the PIIX3 code is extracted, the code duplication with the
> PIIX4 chipset is obvious. Not worth improving for now because it
> isn't broken.
>
> [0] https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg03685.html
> [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg500737.html
> [2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg504081.html
>
> Based-on: <20191018133547.10936-1-philmd@redhat.com>
> mc146818rtc: Allow call object_initialize(MC146818_RTC) instead of
> rtc_init()
> https://mid.mail-archive.com/20191018133547.10936-1-philmd@redhat.com
>
> Herv=C3=A9 Poussineau (5):
>   piix4: Add the Reset Control Register
>   piix4: Add a i8259 Interrupt Controller as specified in datasheet
>   piix4: Rename PIIX4 object to piix4-isa
>   piix4: Add a i8257 DMA Controller as specified in datasheet
>   piix4: Add a i8254 PIT Controller as specified in datasheet
>
> Philippe Mathieu-Daud=C3=A9 (15):
>   MAINTAINERS: Keep PIIX4 South Bridge separate from PC Chipsets
>   Revert "irq: introduce qemu_irq_proxy()"
>   piix4: Add a MC146818 RTC Controller as specified in datasheet
>   hw/mips/mips_malta: Create IDE hard drive array dynamically
>   hw/mips/mips_malta: Extract the PIIX4 creation code as piix4_create()
>   hw/isa/piix4: Move piix4_create() to hw/isa/piix4.c
>   hw/i386: Remove obsolete LoadStateHandler::load_state_old handlers
>   hw/pci-host/piix: Extract piix3_create()
>   hw/pci-host/piix: Move RCR_IOPORT register definition
>   hw/pci-host/piix: Define and use the PIIX IRQ Route Control Registers
>   hw/pci-host/piix: Move i440FX declarations to hw/pci-host/i440fx.h
>   hw/pci-host/piix: Fix code style issues
>   hw/pci-host/piix: Extract PIIX3 functions to hw/isa/piix3.c
>   hw/pci-host: Rename incorrectly named 'piix' as 'i440fx'
>   hw/pci-host/i440fx: Remove the last PIIX3 traces
>
>  MAINTAINERS                      |  14 +-
>  hw/acpi/pcihp.c                  |   2 +-
>  hw/acpi/piix4.c                  |  42 +--
>  hw/core/irq.c                    |  14 -
>  hw/i386/Kconfig                  |   3 +-
>  hw/i386/acpi-build.c             |   5 +-
>  hw/i386/pc_piix.c                |  10 +-
>  hw/i386/xen/xen-hvm.c            |   5 +-
>  hw/intc/apic_common.c            |  49 ----
>  hw/isa/Kconfig                   |   4 +
>  hw/isa/Makefile.objs             |   1 +
>  hw/isa/piix3.c                   | 399 +++++++++++++++++++++++++++++
>  hw/isa/piix4.c                   | 151 ++++++++++-
>  hw/mips/gt64xxx_pci.c            |   5 +-
>  hw/mips/mips_malta.c             |  46 +---
>  hw/pci-host/Kconfig              |   3 +-
>  hw/pci-host/Makefile.objs        |   2 +-
>  hw/pci-host/{piix.c =3D> i440fx.c} | 424 +------------------------------
>  hw/timer/i8254_common.c          |  40 ---
>  include/hw/acpi/piix4.h          |   6 -
>  include/hw/i386/pc.h             |  37 ---
>  include/hw/irq.h                 |   5 -
>  include/hw/isa/isa.h             |   2 +
>  include/hw/pci-host/i440fx.h     |  36 +++
>  include/hw/southbridge/piix.h    |  74 ++++++
>  stubs/pci-host-piix.c            |   3 +-
>  26 files changed, 699 insertions(+), 683 deletions(-)
>  create mode 100644 hw/isa/piix3.c
>  rename hw/pci-host/{piix.c =3D> i440fx.c} (58%)
>  delete mode 100644 include/hw/acpi/piix4.h
>  create mode 100644 include/hw/pci-host/i440fx.h
>  create mode 100644 include/hw/southbridge/piix.h
>
> --
> 2.21.0
>
>
>

--0000000000002c35490595ad6bd0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, October 18, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a hre=
f=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">Changes since v1 [0]:<br>
- Removed patch reintroducing DO_UPCAST() use (thuth)<br>
- Took various patches out to reduce series (thuth)<br>
- Added review tags (thanks all for reviewing!)<br>
<br></blockquote><div><br></div><div>Philippe,</div><div><br></div><div>Do =
you intend to submit v3? The softfreeze is close.</div><div><br></div><div>=
A.</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
$ git backport-diff -u pc_split_i440fx_piix-v1 -r mc146818rtc_init..<br>
Key:<br>
[----] : patches are identical<br>
[####] : number of functional differences between upstream/downstream patch=
<br>
[down] : patch is downstream-only<br>
The flags [FC] indicate (F)unctional and (C)ontextual differences, respecti=
vely<br>
<br>
001/20:[----] [--] &#39;MAINTAINERS: Keep PIIX4 South Bridge separate from =
PC Chipsets&#39;<br>
002/20:[0011] [FC] &#39;piix4: add Reset Control Register&#39;<br>
003/20:[0014] [FC] &#39;piix4: add a i8259 interrupt controller as specifie=
d in datasheet&#39;<br>
004/20:[----] [--] &#39;Revert &quot;irq: introduce qemu_irq_proxy()&quot;&=
#39;<br>
005/20:[----] [--] &#39;piix4: rename PIIX4 object to piix4-isa&#39;<br>
006/20:[----] [-C] &#39;piix4: add a i8257 dma controller as specified in d=
atasheet&#39;<br>
007/20:[----] [-C] &#39;piix4: add a i8254 pit controller as specified in d=
atasheet&#39;<br>
008/20:[----] [-C] &#39;piix4: add a mc146818rtc controller as specified in=
 datasheet&#39;<br>
009/20:[----] [--] &#39;hw/mips/mips_malta: Create IDE hard drive array dyn=
amically&#39;<br>
010/20:[----] [--] &#39;hw/mips/mips_malta: Extract the PIIX4 creation code=
 as piix4_create()&#39;<br>
011/20:[----] [--] &#39;hw/isa/piix4: Move piix4_create() to hw/isa/piix4.c=
&#39;<br>
012/20:[----] [--] &#39;hw/i386: Remove obsolete LoadStateHandler::load_sta=
te_<wbr>old handlers&#39;<br>
013/20:[----] [--] &#39;hw/pci-host/piix: Extract piix3_create()&#39;<br>
014/20:[0010] [FC] &#39;hw/pci-host/piix: Move RCR_IOPORT register definiti=
on&#39;<br>
015/20:[----] [--] &#39;hw/pci-host/piix: Define and use the PIIX IRQ Route=
 Control Registers&#39;<br>
016/20:[----] [--] &#39;hw/pci-host/piix: Move i440FX declarations to hw/pc=
i-host/i440fx.h&#39;<br>
017/20:[----] [--] &#39;hw/pci-host/piix: Fix code style issues&#39;<br>
018/20:[0012] [FC] &#39;hw/pci-host/piix: Extract PIIX3 functions to hw/isa=
/piix3.c&#39;<br>
019/20:[----] [--] &#39;hw/pci-host: Rename incorrectly named &#39;piix&#39=
; as &#39;i440fx&#39;&#39;<br>
020/20:[----] [-C] &#39;hw/pci-host/i440fx: Remove the last PIIX3 traces&#3=
9;<br>
<br>
Previous cover:<br>
<br>
This series is a rework of &quot;piix4: cleanup and improvements&quot; [1]<=
br>
from Herv=C3=A9, and my &quot;remove i386/pc dependency: PIIX cleanup&quot;=
 [2].<br>
<br>
Still trying to remove the strong X86/PC dependency 2 years later,<br>
one step at a time.<br>
Here we split the PIIX3 southbridge from i440FX northbridge.<br>
The i440FX northbridge is only used by the PC machine, while the<br>
PIIX southbridge is also used by the Malta MIPS machine.<br>
<br>
This is also a step forward using KConfig with the Malta board.<br>
Without this split, it was impossible to compile the Malta without<br>
pulling various X86 pieces of code.<br>
<br>
The overall design cleanup is not yet perfect, but enough to post<br>
as a series.<br>
<br>
Now that the PIIX3 code is extracted, the code duplication with the<br>
PIIX4 chipset is obvious. Not worth improving for now because it<br>
isn&#39;t broken.<br>
<br>
[0] <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg036=
85.html" target=3D"_blank">https://lists.gnu.org/archive/<wbr>html/qemu-dev=
el/2019-10/<wbr>msg03685.html</a><br>
[1] <a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg500737=
.html" target=3D"_blank">https://www.mail-archive.com/<wbr>qemu-devel@nongn=
u.org/<wbr>msg500737.html</a><br>
[2] <a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg504081=
.html" target=3D"_blank">https://www.mail-archive.com/<wbr>qemu-devel@nongn=
u.org/<wbr>msg504081.html</a><br>
<br>
Based-on: &lt;<a href=3D"mailto:20191018133547.10936-1-philmd@redhat.com">2=
0191018133547.10936-1-philmd@redhat.com</a>&gt;<br>
mc146818rtc: Allow call object_initialize(MC146818_<wbr>RTC) instead of rtc=
_init()<br>
<a href=3D"https://mid.mail-archive.com/20191018133547.10936-1-philmd@redha=
t.com" target=3D"_blank">https://mid.mail-archive.com/<wbr>20191018133547.1=
0936-1-philmd@<wbr>redhat.com</a><br>
<br>
Herv=C3=A9 Poussineau (5):<br>
=C2=A0 piix4: Add the Reset Control Register<br>
=C2=A0 piix4: Add a i8259 Interrupt Controller as specified in datasheet<br=
>
=C2=A0 piix4: Rename PIIX4 object to piix4-isa<br>
=C2=A0 piix4: Add a i8257 DMA Controller as specified in datasheet<br>
=C2=A0 piix4: Add a i8254 PIT Controller as specified in datasheet<br>
<br>
Philippe Mathieu-Daud=C3=A9 (15):<br>
=C2=A0 MAINTAINERS: Keep PIIX4 South Bridge separate from PC Chipsets<br>
=C2=A0 Revert &quot;irq: introduce qemu_irq_proxy()&quot;<br>
=C2=A0 piix4: Add a MC146818 RTC Controller as specified in datasheet<br>
=C2=A0 hw/mips/mips_malta: Create IDE hard drive array dynamically<br>
=C2=A0 hw/mips/mips_malta: Extract the PIIX4 creation code as piix4_create(=
)<br>
=C2=A0 hw/isa/piix4: Move piix4_create() to hw/isa/piix4.c<br>
=C2=A0 hw/i386: Remove obsolete LoadStateHandler::load_state_<wbr>old handl=
ers<br>
=C2=A0 hw/pci-host/piix: Extract piix3_create()<br>
=C2=A0 hw/pci-host/piix: Move RCR_IOPORT register definition<br>
=C2=A0 hw/pci-host/piix: Define and use the PIIX IRQ Route Control Register=
s<br>
=C2=A0 hw/pci-host/piix: Move i440FX declarations to hw/pci-host/i440fx.h<b=
r>
=C2=A0 hw/pci-host/piix: Fix code style issues<br>
=C2=A0 hw/pci-host/piix: Extract PIIX3 functions to hw/isa/piix3.c<br>
=C2=A0 hw/pci-host: Rename incorrectly named &#39;piix&#39; as &#39;i440fx&=
#39;<br>
=C2=A0 hw/pci-host/i440fx: Remove the last PIIX3 traces<br>
<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 14 +-<br>
=C2=A0hw/acpi/pcihp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0hw/acpi/piix4.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 42 +--<br>
=C2=A0hw/core/irq.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 14 -<br>
=C2=A0hw/i386/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A03 +-<br>
=C2=A0hw/i386/acpi-build.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A05 +-<br>
=C2=A0hw/i386/pc_piix.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 10 +-<br>
=C2=A0hw/i386/xen/xen-hvm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A05 +-<br>
=C2=A0hw/intc/apic_common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 49 ----<br>
=C2=A0hw/isa/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +<br>
=C2=A0hw/isa/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A01 +<br>
=C2=A0hw/isa/piix3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| 399 +++++++++++++++++++++++++++++<br>
=C2=A0hw/isa/piix4.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| 151 ++++++++++-<br>
=C2=A0hw/mips/gt64xxx_pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A05 +-<br>
=C2=A0hw/mips/mips_malta.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 46 +---<br>
=C2=A0hw/pci-host/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A03 +-<br>
=C2=A0hw/pci-host/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 =
+-<br>
=C2=A0hw/pci-host/{piix.c =3D&gt; i440fx.c} | 424 +------------------------=
-----<wbr>-<br>
=C2=A0hw/timer/i8254_common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 40 =
---<br>
=C2=A0include/hw/acpi/piix4.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A06 -<br>
=C2=A0include/hw/i386/pc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 37 ---<br>
=C2=A0include/hw/irq.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A05 -<br>
=C2=A0include/hw/isa/isa.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A02 +<br>
=C2=A0include/hw/pci-host/i440fx.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 36 +++<br>
=C2=A0include/hw/southbridge/piix.h=C2=A0 =C2=A0 |=C2=A0 74 ++++++<br>
=C2=A0stubs/pci-host-piix.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A03 +-<br>
=C2=A026 files changed, 699 insertions(+), 683 deletions(-)<br>
=C2=A0create mode 100644 hw/isa/piix3.c<br>
=C2=A0rename hw/pci-host/{piix.c =3D&gt; i440fx.c} (58%)<br>
=C2=A0delete mode 100644 include/hw/acpi/piix4.h<br>
=C2=A0create mode 100644 include/hw/pci-host/i440fx.h<br>
=C2=A0create mode 100644 include/hw/southbridge/piix.h<br>
<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--0000000000002c35490595ad6bd0--

