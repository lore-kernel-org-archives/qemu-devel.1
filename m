Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DCAC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:09:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C472217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fintelia.io header.i=@fintelia.io header.b="JeJtQ2Fc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C472217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fintelia.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ituDC-0003BE-TO
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 09:08:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1ittEN-0005XN-PI
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:06:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1ittEJ-00009L-FK
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:06:07 -0500
Received: from rs224.mailgun.us ([209.61.151.224]:10043)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1ittEJ-0008UN-9d
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:06:03 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=fintelia.io; q=dns/txt;
 s=pic; 
 t=1579611952; h=Content-Type: Cc: To: Subject: Message-ID: Date: From:
 In-Reply-To: References: MIME-Version: Sender;
 bh=AO4uiXu3ecvaYatTI1v/4EKvdGj5NK0QIjh304qeVOU=;
 b=JeJtQ2Fcv3nNIOgp1mi1nLEDkY4mwlHO53VGjYQ/Prqgvc8dtZGc+eK4fpy1uvRr+mBlqgac
 +DTmLljcMYiH13L1b+8S2aG4ID72dR9Qa5/Dhnfyw73L5t+qMooG1bNuEHh8h8uX8hsiLL1b
 Xt6f73KyFJceJyQN8dyAwrmnNmQffX7ztuTm0qNlOwxq4iPdaCCEobSIFQXQCL4NKnYueTKv
 NdLIhJtB3emOYR4NRUCRDB32gMEd0BUQqA+3r65PPJaTHIvaBooB673jWMQgYAyLsOPQOMRh
 s3+mILhhC+hksHuAHQamUfiOWBatSzKfIRXb4hj+qpD8fSEewacTOQ==
X-Mailgun-Sending-Ip: 209.61.151.224
X-Mailgun-Sid: WyJlMGM5NSIsICJxZW11LWRldmVsQG5vbmdudS5vcmciLCAiOWI0ZTc2Il0=
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com
 [209.85.208.173])
 by mxa.mailgun.org with ESMTP id 5e26f72f.7f374620ab70-smtp-out-n03;
 Tue, 21 Jan 2020 13:05:51 -0000 (UTC)
Received: by mail-lj1-f173.google.com with SMTP id r19so2703694ljg.3;
 Tue, 21 Jan 2020 05:05:50 -0800 (PST)
X-Gm-Message-State: APjAAAV1F9/9vFYGEFUaRXKIJCMvZvFdi9RfWySqpPr+HsiNZyQLbP9R
 QCoPsUouKV9ddlv0Wqgvs1lQaDEYh20zsnKl7Rg=
X-Google-Smtp-Source: APXvYqz4qQ8oNQNzEokMOUd5Vtmh0pgRqKd0htmZBnLrk721oKLb1/2yj1Oq+1SLR7r/S2AETfuwXm5RtAzeMhkL2to=
X-Received: by 2002:a2e:9118:: with SMTP id m24mr16627128ljg.105.1579611949593; 
 Tue, 21 Jan 2020 05:05:49 -0800 (PST)
MIME-Version: 1.0
References: <CANnJOVHdcb2wuTZ9U5ziJsuPVin8pae9gUZjh=VH5WJ_5Yn+rw@mail.gmail.com>
 <mhng-4545b3da-b9ba-4fa2-91e8-b0d7e66329d8@palmer-si-x1c4>
In-Reply-To: <mhng-4545b3da-b9ba-4fa2-91e8-b0d7e66329d8@palmer-si-x1c4>
From: Jonathan Behrens <jonathan@fintelia.io>
Date: Tue, 21 Jan 2020 08:05:23 -0500
X-Gmail-Original-Message-ID: <CANnJOVFZmmwvpdvLfr8r3VK1pudV_rmh3-iq_sgLZNsjkwQ_2A@mail.gmail.com>
Message-ID: <CANnJOVFZmmwvpdvLfr8r3VK1pudV_rmh3-iq_sgLZNsjkwQ_2A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2] target/riscv: Hardwire mcounter.TM and
 upper bits of [m|s]counteren
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: multipart/alternative; boundary="000000000000237b3f059ca611ad"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.61.151.224
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Alistair Francis <alistair23@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000237b3f059ca611ad
Content-Type: text/plain; charset="UTF-8"

I was just doubling checking the status of this patch because it conflicts
with the "RISC-V TIME CSR for privileged mode" PR that was just sent out,
and it seems this never got merged? In any case, perhaps these changes
should be rolled into that patch?

On Wed, Aug 21, 2019 at 1:37 PM Palmer Dabbelt <palmer@sifive.com> wrote:

> On Wed, 14 Aug 2019 20:19:39 PDT (-0700), jonathan@fintelia.io wrote:
> > Ping! What is the status of this patch?
>
> Sorry, I must have lost track of it.  I've added it to my patch queue.
>
> >
> > On Wed, Jul 3, 2019 at 2:02 PM Jonathan Behrens <jonathan@fintelia.io>
> > wrote:
> >
> >> Bin, that proposal proved to be somewhat more controversial than I was
> >> expecting, since it was different than how currently available hardware
> >> worked. This option seemed much more likely to be accepted in the short
> >> term.
> >>
> >> Jonathan
> >>
> >> On Mon, Jul 1, 2019 at 9:26 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >>
> >>> On Tue, Jul 2, 2019 at 8:20 AM Alistair Francis <alistair23@gmail.com>
> >>> wrote:
> >>> >
> >>> > On Mon, Jul 1, 2019 at 8:56 AM <jonathan@fintelia.io> wrote:
> >>> > >
> >>> > > From: Jonathan Behrens <jonathan@fintelia.io>
> >>> > >
> >>> > > QEMU currently always triggers an illegal instruction exception
> when
> >>> > > code attempts to read the time CSR. This is valid behavor, but
> only if
> >>> > > the TM bit in mcounteren is hardwired to zero. This change also
> >>> > > corrects mcounteren and scounteren CSRs to be 32-bits on both
> 32-bit
> >>> > > and 64-bit targets.
> >>> > >
> >>> > > Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>
> >>> >
> >>> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> >>> >
> >>>
> >>> I am a little bit lost here. I think we agreed to allow directly read
> >>> to time CSR when mcounteren.TM is set, no?
> >>>
> >>> Regards,
> >>> Bin
> >>>
> >>
>

--000000000000237b3f059ca611ad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I was just doubling checking the status of this patch beca=
use it conflicts with the &quot;RISC-V TIME CSR for privileged mode&quot; P=
R that was just sent out, and it seems this never got merged? In any case, =
perhaps these changes should be rolled into that patch?<br></div><br><div c=
lass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 21, =
2019 at 1:37 PM Palmer Dabbelt &lt;<a href=3D"mailto:palmer@sifive.com">pal=
mer@sifive.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On Wed, 14 Aug 2019 20:19:39 PDT (-0700), <a href=3D"mailto:j=
onathan@fintelia.io" target=3D"_blank">jonathan@fintelia.io</a> wrote:<br>
&gt; Ping! What is the status of this patch?<br>
<br>
Sorry, I must have lost track of it.=C2=A0 I&#39;ve added it to my patch qu=
eue.<br>
<br>
&gt;<br>
&gt; On Wed, Jul 3, 2019 at 2:02 PM Jonathan Behrens &lt;<a href=3D"mailto:=
jonathan@fintelia.io" target=3D"_blank">jonathan@fintelia.io</a>&gt;<br>
&gt; wrote:<br>
&gt;<br>
&gt;&gt; Bin, that proposal proved to be somewhat more controversial than I=
 was<br>
&gt;&gt; expecting, since it was different than how currently available har=
dware<br>
&gt;&gt; worked. This option seemed much more likely to be accepted in the =
short<br>
&gt;&gt; term.<br>
&gt;&gt;<br>
&gt;&gt; Jonathan<br>
&gt;&gt;<br>
&gt;&gt; On Mon, Jul 1, 2019 at 9:26 PM Bin Meng &lt;<a href=3D"mailto:bmen=
g.cn@gmail.com" target=3D"_blank">bmeng.cn@gmail.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt;&gt; On Tue, Jul 2, 2019 at 8:20 AM Alistair Francis &lt;<a href=3D=
"mailto:alistair23@gmail.com" target=3D"_blank">alistair23@gmail.com</a>&gt=
;<br>
&gt;&gt;&gt; wrote:<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; On Mon, Jul 1, 2019 at 8:56 AM &lt;<a href=3D"mailto:jona=
than@fintelia.io" target=3D"_blank">jonathan@fintelia.io</a>&gt; wrote:<br>
&gt;&gt;&gt; &gt; &gt;<br>
&gt;&gt;&gt; &gt; &gt; From: Jonathan Behrens &lt;<a href=3D"mailto:jonatha=
n@fintelia.io" target=3D"_blank">jonathan@fintelia.io</a>&gt;<br>
&gt;&gt;&gt; &gt; &gt;<br>
&gt;&gt;&gt; &gt; &gt; QEMU currently always triggers an illegal instructio=
n exception when<br>
&gt;&gt;&gt; &gt; &gt; code attempts to read the time CSR. This is valid be=
havor, but only if<br>
&gt;&gt;&gt; &gt; &gt; the TM bit in mcounteren is hardwired to zero. This =
change also<br>
&gt;&gt;&gt; &gt; &gt; corrects mcounteren and scounteren CSRs to be 32-bit=
s on both 32-bit<br>
&gt;&gt;&gt; &gt; &gt; and 64-bit targets.<br>
&gt;&gt;&gt; &gt; &gt;<br>
&gt;&gt;&gt; &gt; &gt; Signed-off-by: Jonathan Behrens &lt;<a href=3D"mailt=
o:jonathan@fintelia.io" target=3D"_blank">jonathan@fintelia.io</a>&gt;<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; Reviewed-by: Alistair Francis &lt;<a href=3D"mailto:alist=
air.francis@wdc.com" target=3D"_blank">alistair.francis@wdc.com</a>&gt;<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I am a little bit lost here. I think we agreed to allow direct=
ly read<br>
&gt;&gt;&gt; to time CSR when mcounteren.TM is set, no?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Regards,<br>
&gt;&gt;&gt; Bin<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
</blockquote></div>

--000000000000237b3f059ca611ad--

