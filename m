Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC39CA9EC3
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 22:12:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A5A42087F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 22:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giD7DvJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A5A42087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPZj0-0000xG-Tr
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 18:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iPZgy-0007YC-On
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 18:10:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iPZgq-0004yB-N5
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 18:10:17 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:43081)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iPZgq-0004xE-FG
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 18:10:12 -0400
Received: by mail-ot1-x333.google.com with SMTP id b19so305505otq.10
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 15:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=dXkCB5T5E0985FQuDB92Qou+ufz0WIG6+B8hqx2MdqM=;
 b=giD7DvJhiP/PtUXN29lw7cV+bLQY5kaE1NpWSEJX7xlXoKqQK4LbsfoOVBHVcWY1nX
 dr8i3UipVxdbpWpW3q9y27nKMmTk2CnhHh7nW2MiSYSFP5e0mixn8krFb6UU7H4c1o5j
 Jt04lkZvm8Uh1tTjmsBrqr3Em2fDebAWagnLN7cX3mj0xgLpYWJVCPCuDYijlTuUTK1K
 qgrqY0X5Vi13FootIknW/NDfHhsUIGVcCg7b720cWA1kD768hPVWN4QKbpJ5tog+rXdo
 RCvv34TAxJBqbS0aFCdnUZbJ9dw4brcvcuiRi95zrCgTr2gwK43pNsITLw7kYgnthmPc
 +u7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=dXkCB5T5E0985FQuDB92Qou+ufz0WIG6+B8hqx2MdqM=;
 b=Rj/L7zUKJY84YY955J7UTp41+GTqJVxBk65AuKtU2q1sijsCz/r1LR6KMBNYDQLqvd
 Bu9jdnmf6drCvLUsM6zkvBwM4rgc/QvbwfbmNVpww1A+NG+cKaQxcO9t/C3Cu5OknSyM
 zdRKf6q86QmD4IeIUmC8Rlu6w1Fum7suVnySv245Y7lG2/VM+K3UBCz+lS31lLBi1nvc
 sL7eKStjFG0nV1+QlHEWw5U/WVUw4iWWwAMbYRKoOF14m5lcV23a0RJ0oipR+7/usM5S
 dCiMYynrsbnT7jbMljSSUYzo5i7mI1JB3ggWqIuCu9TK3I0v/75xuIopsDbsTin9+1uu
 PZCA==
X-Gm-Message-State: APjAAAWdMxENkX37Fd3inHw6Ey7AxL+woGgoYbyylDXrrMFSQ2WnMpv7
 eVDQQ931IJWtAtCx/ZiQcS/H3WoR3v9uwr7DdtlAW4+l
X-Google-Smtp-Source: APXvYqxj+9Q3v5iFP95JUVw4s3HpUa4KUzTxcWvI8JrFeqDN89mzNrLcZVtUXACcvFchY5yepYqXMpWW6jxsyCj44RA=
X-Received: by 2002:a05:6830:1d8f:: with SMTP id
 y15mr11095267oti.121.1572387010588; 
 Tue, 29 Oct 2019 15:10:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Tue, 29 Oct 2019 15:10:10
 -0700 (PDT)
In-Reply-To: <dce5d2a5-1474-c4fe-0572-67b0dc6924c1@redhat.com>
References: <20191028163447.18541-1-philmd@redhat.com>
 <CAL1e-=gK_Lf+ipsJxRPgyp01AuQiOeOn9QvzRxaR6LkTJiqhLA@mail.gmail.com>
 <dce5d2a5-1474-c4fe-0572-67b0dc6924c1@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 29 Oct 2019 23:10:10 +0100
Message-ID: <CAL1e-=g9v8hg3EdwpBh4oYO40N5MrzqH=xijCa_1W+JxkdgY9g@mail.gmail.com>
Subject: Re: [PULL 00/20] hw/i386/pc: Split PIIX3 southbridge from i440FX
 northbridge
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000374a3d059613e1ff"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::333
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
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000374a3d059613e1ff
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, October 29, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m>
wrote:

> Hi Aleksandar,
>
> On 10/29/19 6:18 AM, Aleksandar Markovic wrote:
>
>>
>>
>> On Monday, October 28, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com
>> <mailto:philmd@redhat.com>> wrote:
>>
>>     Hi Peter,
>>
>>     This is a X86/MIPS pull, Paolo and Aleksandar are OK I send it:
>>
>>     https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg04959.html
>>     <https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg04959.html=
>
>>
>>     Regards,
>>
>>     Phil.
>>
>>
>> Does this pull request apply on the current code base directly, or is
>> dependant on prior application of other pull requests?
>>
>
> I'm not sure I understand the question, this is a pull request, so it has
> been tested on the commit on the last master commit (yesterday),
> the cover says commit '9bb7350232'. Is there a problem?


My question was crystal clear, I can't believe you couldn't understand it.

There is no problem in that case (if your request applies on the master at
the moment of the submission),, but you for unknown reason mentioned in
another message that you plan to submit your pull request AFTER merging
Paolo's pull request, creating a confusion whether these pull request
depend each on another.

I am happy if this pull request is finally merged.

I supported this series from the outset, and I still support it, and think
it is a truly valuable reorganization of involved QEMU segment, and I
salute its integration. But I did not like the process of integration that
I thought would be a smooth sailing, but because of surrounding
self-imposed circumstances, it became at times very rocky road. I advise
you that, in future, you try to do one thing at the time, and I think you
can achieve far more that way, even if this does not look that way at furst
glance.

Still, you deserve all kudos for the series!

Yours,
Aleksandar



>
>     The following changes since commit
>>     9bb73502321d46f4d320fa17aa38201445783fc4:
>>
>>        Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into
>>     staging (2019-10-28 13:32:40 +0000)
>>
>>     are available in the Git repository at:
>>
>>     https://gitlab.com/philmd/qemu.git
>>     <https://gitlab.com/philmd/qemu.git>
>>     tags/pc_split_i440fx_piix-pull-request
>>
>>     for you to fetch changes up to d1389352cde824ce8dab7c1a2ded15
>> 0df6add124:
>>
>>        hw/pci-host/i440fx: Remove the last PIIX3 traces (2019-10-28
>>     16:12:29 +0100)
>>
>>     ----------------------------------------------------------------
>>     The i440FX northbridge is only used by the PC machine, while the
>>     PIIX southbridge is also used by the Malta MIPS machine.
>>
>>     Split the PIIX3 southbridge from i440FX northbridge.
>>
>>     ----------------------------------------------------------------
>>
>>     Herv=C3=A9 Poussineau (5):
>>        piix4: Add the Reset Control Register
>>        piix4: Add an i8259 Interrupt Controller as specified in datashee=
t
>>        piix4: Rename PIIX4 object to piix4-isa
>>        piix4: Add an i8257 DMA Controller as specified in datasheet
>>        piix4: Add an i8254 PIT Controller as specified in datasheet
>>
>>     Philippe Mathieu-Daud=C3=A9 (15):
>>        MAINTAINERS: Keep PIIX4 South Bridge separate from PC Chipsets
>>        Revert "irq: introduce qemu_irq_proxy()"
>>        piix4: Add a MC146818 RTC Controller as specified in datasheet
>>        hw/mips/mips_malta: Create IDE hard drive array dynamically
>>        hw/mips/mips_malta: Extract the PIIX4 creation code as
>> piix4_create()
>>        hw/isa/piix4: Move piix4_create() to hw/isa/piix4.c
>>        hw/i386: Remove obsolete LoadStateHandler::load_state_old handler=
s
>>        hw/pci-host/piix: Extract piix3_create()
>>        hw/pci-host/piix: Move RCR_IOPORT register definition
>>        hw/pci-host/piix: Define and use the PIIX IRQ Route Control
>> Registers
>>        hw/pci-host/piix: Move i440FX declarations to hw/pci-host/i440fx.=
h
>>        hw/pci-host/piix: Fix code style issues
>>        hw/pci-host/piix: Extract PIIX3 functions to hw/isa/piix3.c
>>        hw/pci-host: Rename incorrectly named 'piix' as 'i440fx'
>>        hw/pci-host/i440fx: Remove the last PIIX3 traces
>>
>>       MAINTAINERS                      |  14 +-
>>       hw/acpi/pcihp.c                  |   2 +-
>>       hw/acpi/piix4.c                  |  42 +--
>>       hw/core/irq.c                    |  14 -
>>       hw/i386/Kconfig                  |   3 +-
>>       hw/i386/acpi-build.c             |   5 +-
>>       hw/i386/pc_piix.c                |  10 +-
>>       hw/i386/xen/xen-hvm.c            |   5 +-
>>       hw/intc/apic_common.c            |  49 ----
>>       hw/isa/Kconfig                   |   4 +
>>       hw/isa/Makefile.objs             |   1 +
>>       hw/isa/piix3.c                   | 399 +++++++++++++++++++++++++++=
++
>>       hw/isa/piix4.c                   | 151 ++++++++++-
>>       hw/mips/gt64xxx_pci.c            |   5 +-
>>       hw/mips/mips_malta.c             |  46 +---
>>       hw/pci-host/Kconfig              |   3 +-
>>       hw/pci-host/Makefile.objs        |   2 +-
>>       hw/pci-host/{piix.c =3D> i440fx.c} | 424
>> +------------------------------
>>       hw/timer/i8254_common.c          |  40 ---
>>       include/hw/acpi/piix4.h          |   6 -
>>       include/hw/i386/pc.h             |  37 ---
>>       include/hw/irq.h                 |   5 -
>>       include/hw/isa/isa.h             |   2 +
>>       include/hw/pci-host/i440fx.h     |  36 +++
>>       include/hw/southbridge/piix.h    |  74 ++++++
>>       stubs/pci-host-piix.c            |   3 +-
>>       26 files changed, 699 insertions(+), 683 deletions(-)
>>       create mode 100644 hw/isa/piix3.c
>>       rename hw/pci-host/{piix.c =3D> i440fx.c} (58%)
>>       delete mode 100644 include/hw/acpi/piix4.h
>>       create mode 100644 include/hw/pci-host/i440fx.h
>>       create mode 100644 include/hw/southbridge/piix.h
>>
>>     --     2.21.0
>>
>>
>>

--000000000000374a3d059613e1ff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, October 29, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">Hi Aleksandar,<br>
<br>
On 10/29/19 6:18 AM, Aleksandar Markovic wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
<br>
On Monday, October 28, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mai=
lto:philmd@redhat.com" target=3D"_blank">philmd@redhat.com</a> &lt;mailto:<=
a href=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@redhat.com</a>=
&gt;&gt; wrote:<br>
<br>
=C2=A0 =C2=A0 Hi Peter,<br>
<br>
=C2=A0 =C2=A0 This is a X86/MIPS pull, Paolo and Aleksandar are OK I send i=
t:<br>
<br>
=C2=A0 =C2=A0 <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2019=
-10/msg04959.html" target=3D"_blank">https://lists.gnu.org/archive/<wbr>htm=
l/qemu-devel/2019-10/msg049<wbr>59.html</a><br>
=C2=A0 =C2=A0 &lt;<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/=
2019-10/msg04959.html" target=3D"_blank">https://lists.gnu.org/archive<wbr>=
/html/qemu-devel/2019-10/<wbr>msg04959.html</a>&gt;<br>
<br>
=C2=A0 =C2=A0 Regards,<br>
<br>
=C2=A0 =C2=A0 Phil.<br>
<br>
<br>
Does this pull request apply on the current code base directly, or is depen=
dant on prior application of other pull requests?<br>
</blockquote>
<br>
I&#39;m not sure I understand the question, this is a pull request, so it h=
as been tested on the commit on the last master commit (yesterday),<br>
the cover says commit &#39;9bb7350232&#39;. Is there a problem?</blockquote=
><div><br></div><div>My question was crystal clear, I can&#39;t believe you=
 couldn&#39;t understand it.</div><div><br></div><div>There is no problem i=
n that case (if your request applies on the master at the moment of the sub=
mission),, but you for unknown reason mentioned in another message that you=
 plan to submit your pull request AFTER merging Paolo&#39;s pull request, c=
reating a confusion whether these pull request depend each on another.</div=
><div><br></div><div>I am happy if this pull request is finally merged.</di=
v><div><br></div><div>I supported this series from the outset, and I still =
support it, and think it is a truly=C2=A0valuable reorganization of involve=
d QEMU segment, and I salute its integration. But I did not like the proces=
s of integration that I thought would be a smooth sailing, but because of s=
urrounding self-imposed circumstances, it became at times very rocky road. =
I advise you that, in future, you try to do one thing at the time, and I th=
ink you can achieve far more that way, even if this does not look that way =
at furst glance.</div><div><br></div><div>Still, you deserve all kudos for =
the series!</div><div><br></div><div>Yours,</div><div>Aleksandar</div><div>=
<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
=C2=A0 =C2=A0 The following changes since commit<br>
=C2=A0 =C2=A0 9bb73502321d46f4d320fa17aa3820<wbr>1445783fc4:<br>
<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 Merge remote-tracking branch &#39;remotes/mst/ta=
gs/for_upstream<wbr>&#39; into<br>
=C2=A0 =C2=A0 staging (2019-10-28 13:32:40 +0000)<br>
<br>
=C2=A0 =C2=A0 are available in the Git repository at:<br>
<br>
=C2=A0 =C2=A0 <a href=3D"https://gitlab.com/philmd/qemu.git" target=3D"_bla=
nk">https://gitlab.com/philmd/qemu<wbr>.git</a><br>
=C2=A0 =C2=A0 &lt;<a href=3D"https://gitlab.com/philmd/qemu.git" target=3D"=
_blank">https://gitlab.com/philmd/qem<wbr>u.git</a>&gt;<br>
=C2=A0 =C2=A0 tags/pc_split_i440fx_piix-pull<wbr>-request<br>
<br>
=C2=A0 =C2=A0 for you to fetch changes up to d1389352cde824ce8dab7c1a2ded15=
<wbr>0df6add124:<br>
<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 hw/pci-host/i440fx: Remove the last PIIX3 traces=
 (2019-10-28<br>
=C2=A0 =C2=A0 16:12:29 +0100)<br>
<br>
=C2=A0 =C2=A0 ------------------------------<wbr>--------------------------=
----<wbr>----<br>
=C2=A0 =C2=A0 The i440FX northbridge is only used by the PC machine, while =
the<br>
=C2=A0 =C2=A0 PIIX southbridge is also used by the Malta MIPS machine.<br>
<br>
=C2=A0 =C2=A0 Split the PIIX3 southbridge from i440FX northbridge.<br>
<br>
=C2=A0 =C2=A0 ------------------------------<wbr>--------------------------=
----<wbr>----<br>
<br>
=C2=A0 =C2=A0 Herv=C3=A9 Poussineau (5):<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 piix4: Add the Reset Control Register<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 piix4: Add an i8259 Interrupt Controller as spec=
ified in datasheet<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 piix4: Rename PIIX4 object to piix4-isa<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 piix4: Add an i8257 DMA Controller as specified =
in datasheet<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 piix4: Add an i8254 PIT Controller as specified =
in datasheet<br>
<br>
=C2=A0 =C2=A0 Philippe Mathieu-Daud=C3=A9 (15):<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 MAINTAINERS: Keep PIIX4 South Bridge separate fr=
om PC Chipsets<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 Revert &quot;irq: introduce qemu_irq_proxy()&quo=
t;<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 piix4: Add a MC146818 RTC Controller as specifie=
d in datasheet<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 hw/mips/mips_malta: Create IDE hard drive array =
dynamically<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 hw/mips/mips_malta: Extract the PIIX4 creation c=
ode as piix4_create()<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 hw/isa/piix4: Move piix4_create() to hw/isa/piix=
4.c<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 hw/i386: Remove obsolete LoadStateHandler::load_=
state_o<wbr>ld handlers<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 hw/pci-host/piix: Extract piix3_create()<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 hw/pci-host/piix: Move RCR_IOPORT register defin=
ition<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 hw/pci-host/piix: Define and use the PIIX IRQ Ro=
ute Control Registers<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 hw/pci-host/piix: Move i440FX declarations to hw=
/pci-host/i440fx.h<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 hw/pci-host/piix: Fix code style issues<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 hw/pci-host/piix: Extract PIIX3 functions to hw/=
isa/piix3.c<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 hw/pci-host: Rename incorrectly named &#39;piix&=
#39; as &#39;i440fx&#39;<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 hw/pci-host/i440fx: Remove the last PIIX3 traces=
<br>
<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 14 +-<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0hw/acpi/pcihp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0hw/acpi/piix4.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 42 +--<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0hw/core/irq.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 14 -<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0hw/i386/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +-<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0hw/i386/acpi-build.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 +-<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0hw/i386/pc_piix.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 10 +-<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0hw/i386/xen/xen-hvm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A05 +-<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0hw/intc/apic_common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 49 ----<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0hw/isa/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0hw/isa/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0hw/isa/piix3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 399 +++++++++++++++++++++++++++++<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0hw/isa/piix4.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 151 ++++++++++-<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0hw/mips/gt64xxx_pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A05 +-<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0hw/mips/mips_malta.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 46 +---<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0hw/pci-host/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +-<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0hw/pci-host/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0hw/pci-host/{piix.c =3D&gt; i440fx.c} | 424 +----=
-------------------------<wbr>-<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0hw/timer/i8254_common.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 40 ---<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0include/hw/acpi/piix4.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A06 -<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0include/hw/i386/pc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 37 ---<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0include/hw/irq.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 -<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0include/hw/isa/isa.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0include/hw/pci-host/i440fx.<wbr>h=C2=A0 =C2=A0 =
=C2=A0|=C2=A0 36 +++<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0include/hw/southbridge/piix.<wbr>h=C2=A0 =C2=A0 |=
=C2=A0 74 ++++++<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0stubs/pci-host-piix.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A03 +-<br>
=C2=A0 =C2=A0 =C2=A0=C2=A026 files changed, 699 insertions(+), 683 deletion=
s(-)<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0create mode 100644 hw/isa/piix3.c<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0rename hw/pci-host/{piix.c =3D&gt; i440fx.c} (58%=
)<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0delete mode 100644 include/hw/acpi/piix4.h<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0create mode 100644 include/hw/pci-host/i440fx.h<b=
r>
=C2=A0 =C2=A0 =C2=A0=C2=A0create mode 100644 include/hw/southbridge/piix.h<=
br>
<br>
=C2=A0 =C2=A0 --=C2=A0 =C2=A0 =C2=A02.21.0<br>
<br>
<br>
</blockquote>
</blockquote>

--000000000000374a3d059613e1ff--

