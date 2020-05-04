Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75791C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 06:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 247FC206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 06:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5NuQwpC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 247FC206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVUPp-0003qg-70
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 02:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jVUOl-0003Py-0G
 for qemu-devel@nongnu.org; Mon, 04 May 2020 02:16:16 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:46595)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jVUOi-00070x-Cy
 for qemu-devel@nongnu.org; Mon, 04 May 2020 02:16:14 -0400
Received: by mail-lj1-x243.google.com with SMTP id f18so8429126lja.13
 for <qemu-devel@nongnu.org>; Sun, 03 May 2020 23:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=D5sfMKbq/VBmjnaXCMOfTq+v6qSxLTQywJLdvcKDHfg=;
 b=k5NuQwpCUp7DXm6l8dS3KCcPcXndg32WlRo5YHTUvpnaf4Z67rOe9bb+tZCvf4akkQ
 Byjfx2wpCN6QQTXbNKYDzAdPbOSVa35ToZcHxz78MFzpA23tLE3CKIqy/55CeIWtX/Zw
 McbKQG903ZT34L3NjTJLsp5VThn6XldPTmJkt8HXT+whoVpQxDN+Ae590b8xhfTbL8Lm
 7+HVs/0AJPACGBbu3Zw6B9+Waeye8NbiKxgXB7+6sW4m0vjzv2Cf29BCe8qg7qg6Gydm
 l0BxENnSNe/ubrVcIjcA+HZEZAdjaauRMPkExj5nVd9HPpF/FCkKIt20upb3uUIQLG9S
 zfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=D5sfMKbq/VBmjnaXCMOfTq+v6qSxLTQywJLdvcKDHfg=;
 b=K0aoIC3oSMPrW57dTJYZitemQUaiYv0NsHz2WLhAC/we7v08ugbQObbY20yNWb8cy2
 E+g5gI3n/lCUeWYULP2nTQThTZlyEtrvUdSxc80XWUAAW0y3jpfWb8ShCkra2Uk51suU
 Gb2ppwwTSG7I9lSPdZOD5VTvXCSQ0qQq54Dt4dEEF6evfQSIAsUANl4SWPin+I/FDOuZ
 6J19SLNaTrYbB2KTySHAVM0akAVa7li9raOXOpaTXsKwDG5xzjTUO+QvdGs8GaC/7muF
 /ZLhgyCo7XlGHCeE/qZmpS++rPitZciPe1pe279QOLXbYPG0UeJi9ebhz9Ldwjdfl2KQ
 qUTA==
X-Gm-Message-State: AGi0PubKxa5NAqSO7p+SZWakZ9tSCcDmItM0nJ9TsZ2XmpxGppCJ0x2d
 by6fznkHQfUjCZizogTxVQhQlpnn8/Sgy7b5iqk=
X-Google-Smtp-Source: APiQypISTm9cNXzz/zErssghjSlVLynJp99c0/Cd7NrbtjqiqLR77IFdww2z3gDYhZ/Huw/T8Saqh0GublTlyC1SyjY=
X-Received: by 2002:a2e:800f:: with SMTP id j15mr9566927ljg.27.1588572968740; 
 Sun, 03 May 2020 23:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <1588501221-1205-1-git-send-email-chenhc@lemote.com>
 <CAE2XoE-6VMKY-_upyGoNeD0N6nWj2bfD6g9H0sZFFciWnOYwjw@mail.gmail.com>
 <CABDp7VrPVmhmfv7TTnXH8+kR_-9wDsmBvfTCJ+805yNSvLnCjA@mail.gmail.com>
In-Reply-To: <CABDp7VrPVmhmfv7TTnXH8+kR_-9wDsmBvfTCJ+805yNSvLnCjA@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Mon, 4 May 2020 14:15:58 +0800
Message-ID: <CAE2XoE-SGAaUhF_Yz6MLVxQtX7n=g5f5N2ZByoczZZ=rxuQw+w@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V3 0/7] mips: Add Loongson-3 machine support (with
 KVM)
To: chen huacai <zltjiangshi@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000806bd705a4cc775f"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_EXCESS_BASE64=0.979, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Reply-To: luoyonggang@gmail.com
Cc: Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 qemu-level <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000806bd705a4cc775f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yeap, I suggest convert the Chinese version to Markdown or other text
format first,
then we can got help from others to translate those documents

On Mon, May 4, 2020 at 2:06 PM chen huacai <zltjiangshi@gmail.com> wrote:

> Hi, Yonggang,
>
> We are planning to translate these manuals to English by human, but it
> needs a very long time to complete.
>
> Huacai
>
> On Sun, May 3, 2020 at 6:42 PM =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) =
<luoyonggang@gmail.com>
> wrote:
> >
> > The english version of the reference document is hard to head.
> > I suggest first convert the chinese version into markdown or alternativ=
e
> format and
> > place them at github.
> > And we then translate the document with google translate.
> >
> > On Sun, May 3, 2020 at 6:22 PM Huacai Chen <zltjiangshi@gmail.com>
> wrote:
> >>
> >> Loongson-3 CPU family include Loongson-3A R1/R2/R3/R4 and Loongson-3B
> >> R1/R2. Loongson-3A R1 is the oldest and its ISA is the smallest, while
> >> Loongson-3A R4 is the newest and its ISA is almost the superset of all
> >> others. To reduce complexity, in QEMU we just define two CPU types:
> >>
> >> 1, "Loongson-3A1000" CPU which is corresponding to Loongson-3A R1. It =
is
> >>    suitable for TCG because Loongson-3A R1 has fewest ASE.
> >> 2, "Loongson-3A4000" CPU which is corresponding to Loongson-3A R4. It =
is
> >>    suitable for KVM because Loongson-3A R4 has the VZ ASE.
> >>
> >> Loongson-3 lacks English documents. I've tried to translated them with
> >> translate.google.com, and the machine translated documents (together
> >> with their original Chinese versions) are available here.
> >>
> >> Loongson-3A R1 (Loongson-3A1000)
> >> User Manual Part 1:
> >> http://ftp.godson.ac.cn/lemote/3A1000_p1.pdf
> >>
> http://ftp.godson.ac.cn/lemote/Loongson3A1000_processor_user_manual_P1.pd=
f
> (Chinese Version)
> >> User Manual Part 2:
> >> http://ftp.godson.ac.cn/lemote/3A1000_p2.pdf
> >>
> http://ftp.godson.ac.cn/lemote/Loongson3A1000_processor_user_manual_P2.pd=
f
> (Chinese Version)
> >>
> >> Loongson-3A R2 (Loongson-3A2000)
> >> User Manual Part 1:
> >> http://ftp.godson.ac.cn/lemote/3A2000_p1.pdf
> >> http://ftp.godson.ac.cn/lemote/Loongson3A2000_user1.pdf (Chinese
> Version)
> >> User Manual Part 2:
> >> http://ftp.godson.ac.cn/lemote/3A2000_p2.pdf
> >> http://ftp.godson.ac.cn/lemote/Loongson3A2000_user2.pdf (Chinese
> Version)
> >>
> >> Loongson-3A R3 (Loongson-3A3000)
> >> User Manual Part 1:
> >> http://ftp.godson.ac.cn/lemote/3A3000_p1.pdf
> >> http://ftp.godson.ac.cn/lemote/Loongson3A3000_3B3000usermanual1.pdf
> (Chinese Version)
> >> User Manual Part 2:
> >> http://ftp.godson.ac.cn/lemote/3A3000_p2.pdf
> >> http://ftp.godson.ac.cn/lemote/Loongson3A3000_3B3000usermanual2.pdf
> (Chinese Version)
> >>
> >> Loongson-3A R4 (Loongson-3A4000)
> >> User Manual Part 1:
> >> http://ftp.godson.ac.cn/lemote/3A4000_p1.pdf
> >> http://ftp.godson.ac.cn/lemote/3A4000user.pdf (Chinese Version)
> >> User Manual Part 2:
> >> I'm sorry that it is unavailable now.
> >>
> >> We are preparing to add QEMU's Loongson-3 support. MIPS VZ extension i=
s
> >> fully supported in Loongson-3A R4+, so we at first add QEMU/KVM suppor=
t
> >> in this series. And the next series will add QEMU/TCG support (it will
> >> emulate Loongson-3A R1).
> >>
> >> We already have a full functional Linux kernel (based on Linux-5.4.x L=
TS
> >> but not upstream yet) here:
> >>
> >> https://github.com/chenhuacai/linux
> >>
> >> How to use QEMU/Loongson-3?
> >> 1, Download kernel source from the above URL;
> >> 2, Build a kernel with arch/mips/configs/loongson3_{def,hpc}config;
> >> 3, Boot a Loongson-3A4000 host with this kernel;
> >> 4, Build QEMU-5.0.0 with this patchset;
> >> 5, modprobe kvm;
> >> 6, Use QEMU with TCG (available in future):
> >>        qemu-system-mips64el -M loongson3,accel=3Dtcg -cpu Loongson-3A1=
000
> -kernel <path_to_kernel> -append ...
> >>    Use QEMU with KVM (available at present):
> >>        qemu-system-mips64el -M loongson3,accel=3Dkvm -cpu Loongson-3A4=
000
> -kernel <path_to_kernel> -append ...
> >>
> >>    The "-cpu" parameter can be omitted here and QEMU will use the
> correct type for TCG/KVM automatically.
> >>
> >> V1 -> V2:
> >> 1, Add a cover letter;
> >> 2, Improve CPU definitions;
> >> 3, Remove LS7A-related things (Use GPEX instead);
> >> 4, Add a description of how to run QEMU/Loongson-3.
> >>
> >> V2 -> V3:
> >> 1, Fix all possible checkpatch.pl errors and warnings.
> >>
> >> Huacai Chen(7):
> >>  configure: Add KVM target support for MIPS64
> >>  hw/mips: Implement the kvm_type() hook in MachineClass
> >>  hw/mips: Add CPU IRQ3 delivery for KVM
> >>  target/mips: Add Loongson-3 CPU definition
> >>  target/mips: Add more CP0 register for save/restor
> >>  hw/mips: Add Loongson-3 machine support (with KVM)
> >>  MAINTAINERS: Add myself as Loongson-3 maintainer
> >>
> >> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> >> ---
> >>  MAINTAINERS                          |   5 +
> >>  configure                            |   2 +-
> >>  default-configs/mips64el-softmmu.mak |   1 +
> >>  hw/core/Makefile.objs                |   2 +-
> >>  hw/core/null-machine.c               |   4 +
> >>  hw/mips/Kconfig                      |  10 +
> >>  hw/mips/Makefile.objs                |   3 +-
> >>  hw/mips/common.c                     |  31 ++
> >>  hw/mips/mips_int.c                   |   4 +-
> >>  hw/mips/mips_loongson3.c             | 901
> +++++++++++++++++++++++++++++++++++
> >>  include/hw/mips/mips.h               |   3 +
> >>  target/mips/cpu.h                    |  28 ++
> >>  target/mips/internal.h               |   2 +
> >>  target/mips/kvm.c                    | 212 +++++++++
> >>  target/mips/machine.c                |   6 +-
> >>  target/mips/mips-defs.h              |   7 +-
> >>  target/mips/translate.c              |   2 +
> >>  target/mips/translate_init.inc.c     |  86 ++++
> >>  18 files changed, 1300 insertions(+), 9 deletions(-)
> >>  create mode 100644 hw/mips/common.c
> >>  create mode 100644 hw/mips/mips_loongson3.c
> >> --
> >> 2.7.0
> >>
> >
> >
> > --
> >          =E6=AD=A4=E8=87=B4
> > =E7=A4=BC
> > =E7=BD=97=E5=8B=87=E5=88=9A
> > Yours
> >     sincerely,
> > Yonggang Luo
>
>
>
> --
> Huacai Chen
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000806bd705a4cc775f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Yeap, I suggest convert the Chinese version to Markdown or=
 other text format first,<div>then we can got help from others to translate=
 those documents</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Mon, May 4, 2020 at 2:06 PM chen huacai &lt;<a hre=
f=3D"mailto:zltjiangshi@gmail.com">zltjiangshi@gmail.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">Hi, Yonggang,<br>
<br>
We are planning to translate these manuals to English by human, but it<br>
needs a very long time to complete.<br>
<br>
Huacai<br>
<br>
On Sun, May 3, 2020 at 6:42 PM =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) &l=
t;<a href=3D"mailto:luoyonggang@gmail.com" target=3D"_blank">luoyonggang@gm=
ail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; The english version of the reference document is hard to head.<br>
&gt; I suggest first convert the chinese version into markdown or alternati=
ve format and<br>
&gt; place them at github.<br>
&gt; And we then translate the document with google translate.<br>
&gt;<br>
&gt; On Sun, May 3, 2020 at 6:22 PM Huacai Chen &lt;<a href=3D"mailto:zltji=
angshi@gmail.com" target=3D"_blank">zltjiangshi@gmail.com</a>&gt; wrote:<br=
>
&gt;&gt;<br>
&gt;&gt; Loongson-3 CPU family include Loongson-3A R1/R2/R3/R4 and Loongson=
-3B<br>
&gt;&gt; R1/R2. Loongson-3A R1 is the oldest and its ISA is the smallest, w=
hile<br>
&gt;&gt; Loongson-3A R4 is the newest and its ISA is almost the superset of=
 all<br>
&gt;&gt; others. To reduce complexity, in QEMU we just define two CPU types=
:<br>
&gt;&gt;<br>
&gt;&gt; 1, &quot;Loongson-3A1000&quot; CPU which is corresponding to Loong=
son-3A R1. It is<br>
&gt;&gt;=C2=A0 =C2=A0 suitable for TCG because Loongson-3A R1 has fewest AS=
E.<br>
&gt;&gt; 2, &quot;Loongson-3A4000&quot; CPU which is corresponding to Loong=
son-3A R4. It is<br>
&gt;&gt;=C2=A0 =C2=A0 suitable for KVM because Loongson-3A R4 has the VZ AS=
E.<br>
&gt;&gt;<br>
&gt;&gt; Loongson-3 lacks English documents. I&#39;ve tried to translated t=
hem with<br>
&gt;&gt; <a href=3D"http://translate.google.com" rel=3D"noreferrer" target=
=3D"_blank">translate.google.com</a>, and the machine translated documents =
(together<br>
&gt;&gt; with their original Chinese versions) are available here.<br>
&gt;&gt;<br>
&gt;&gt; Loongson-3A R1 (Loongson-3A1000)<br>
&gt;&gt; User Manual Part 1:<br>
&gt;&gt; <a href=3D"http://ftp.godson.ac.cn/lemote/3A1000_p1.pdf" rel=3D"no=
referrer" target=3D"_blank">http://ftp.godson.ac.cn/lemote/3A1000_p1.pdf</a=
><br>
&gt;&gt; <a href=3D"http://ftp.godson.ac.cn/lemote/Loongson3A1000_processor=
_user_manual_P1.pdf" rel=3D"noreferrer" target=3D"_blank">http://ftp.godson=
.ac.cn/lemote/Loongson3A1000_processor_user_manual_P1.pdf</a> (Chinese Vers=
ion)<br>
&gt;&gt; User Manual Part 2:<br>
&gt;&gt; <a href=3D"http://ftp.godson.ac.cn/lemote/3A1000_p2.pdf" rel=3D"no=
referrer" target=3D"_blank">http://ftp.godson.ac.cn/lemote/3A1000_p2.pdf</a=
><br>
&gt;&gt; <a href=3D"http://ftp.godson.ac.cn/lemote/Loongson3A1000_processor=
_user_manual_P2.pdf" rel=3D"noreferrer" target=3D"_blank">http://ftp.godson=
.ac.cn/lemote/Loongson3A1000_processor_user_manual_P2.pdf</a> (Chinese Vers=
ion)<br>
&gt;&gt;<br>
&gt;&gt; Loongson-3A R2 (Loongson-3A2000)<br>
&gt;&gt; User Manual Part 1:<br>
&gt;&gt; <a href=3D"http://ftp.godson.ac.cn/lemote/3A2000_p1.pdf" rel=3D"no=
referrer" target=3D"_blank">http://ftp.godson.ac.cn/lemote/3A2000_p1.pdf</a=
><br>
&gt;&gt; <a href=3D"http://ftp.godson.ac.cn/lemote/Loongson3A2000_user1.pdf=
" rel=3D"noreferrer" target=3D"_blank">http://ftp.godson.ac.cn/lemote/Loong=
son3A2000_user1.pdf</a> (Chinese Version)<br>
&gt;&gt; User Manual Part 2:<br>
&gt;&gt; <a href=3D"http://ftp.godson.ac.cn/lemote/3A2000_p2.pdf" rel=3D"no=
referrer" target=3D"_blank">http://ftp.godson.ac.cn/lemote/3A2000_p2.pdf</a=
><br>
&gt;&gt; <a href=3D"http://ftp.godson.ac.cn/lemote/Loongson3A2000_user2.pdf=
" rel=3D"noreferrer" target=3D"_blank">http://ftp.godson.ac.cn/lemote/Loong=
son3A2000_user2.pdf</a> (Chinese Version)<br>
&gt;&gt;<br>
&gt;&gt; Loongson-3A R3 (Loongson-3A3000)<br>
&gt;&gt; User Manual Part 1:<br>
&gt;&gt; <a href=3D"http://ftp.godson.ac.cn/lemote/3A3000_p1.pdf" rel=3D"no=
referrer" target=3D"_blank">http://ftp.godson.ac.cn/lemote/3A3000_p1.pdf</a=
><br>
&gt;&gt; <a href=3D"http://ftp.godson.ac.cn/lemote/Loongson3A3000_3B3000use=
rmanual1.pdf" rel=3D"noreferrer" target=3D"_blank">http://ftp.godson.ac.cn/=
lemote/Loongson3A3000_3B3000usermanual1.pdf</a> (Chinese Version)<br>
&gt;&gt; User Manual Part 2:<br>
&gt;&gt; <a href=3D"http://ftp.godson.ac.cn/lemote/3A3000_p2.pdf" rel=3D"no=
referrer" target=3D"_blank">http://ftp.godson.ac.cn/lemote/3A3000_p2.pdf</a=
><br>
&gt;&gt; <a href=3D"http://ftp.godson.ac.cn/lemote/Loongson3A3000_3B3000use=
rmanual2.pdf" rel=3D"noreferrer" target=3D"_blank">http://ftp.godson.ac.cn/=
lemote/Loongson3A3000_3B3000usermanual2.pdf</a> (Chinese Version)<br>
&gt;&gt;<br>
&gt;&gt; Loongson-3A R4 (Loongson-3A4000)<br>
&gt;&gt; User Manual Part 1:<br>
&gt;&gt; <a href=3D"http://ftp.godson.ac.cn/lemote/3A4000_p1.pdf" rel=3D"no=
referrer" target=3D"_blank">http://ftp.godson.ac.cn/lemote/3A4000_p1.pdf</a=
><br>
&gt;&gt; <a href=3D"http://ftp.godson.ac.cn/lemote/3A4000user.pdf" rel=3D"n=
oreferrer" target=3D"_blank">http://ftp.godson.ac.cn/lemote/3A4000user.pdf<=
/a> (Chinese Version)<br>
&gt;&gt; User Manual Part 2:<br>
&gt;&gt; I&#39;m sorry that it is unavailable now.<br>
&gt;&gt;<br>
&gt;&gt; We are preparing to add QEMU&#39;s Loongson-3 support. MIPS VZ ext=
ension is<br>
&gt;&gt; fully supported in Loongson-3A R4+, so we at first add QEMU/KVM su=
pport<br>
&gt;&gt; in this series. And the next series will add QEMU/TCG support (it =
will<br>
&gt;&gt; emulate Loongson-3A R1).<br>
&gt;&gt;<br>
&gt;&gt; We already have a full functional Linux kernel (based on Linux-5.4=
.x LTS<br>
&gt;&gt; but not upstream yet) here:<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"https://github.com/chenhuacai/linux" rel=3D"noreferrer"=
 target=3D"_blank">https://github.com/chenhuacai/linux</a><br>
&gt;&gt;<br>
&gt;&gt; How to use QEMU/Loongson-3?<br>
&gt;&gt; 1, Download kernel source from the above URL;<br>
&gt;&gt; 2, Build a kernel with arch/mips/configs/loongson3_{def,hpc}config=
;<br>
&gt;&gt; 3, Boot a Loongson-3A4000 host with this kernel;<br>
&gt;&gt; 4, Build QEMU-5.0.0 with this patchset;<br>
&gt;&gt; 5, modprobe kvm;<br>
&gt;&gt; 6, Use QEMU with TCG (available in future):<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu-system-mips64el -M loongson3,accel=
=3Dtcg -cpu Loongson-3A1000 -kernel &lt;path_to_kernel&gt; -append ...<br>
&gt;&gt;=C2=A0 =C2=A0 Use QEMU with KVM (available at present):<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu-system-mips64el -M loongson3,accel=
=3Dkvm -cpu Loongson-3A4000 -kernel &lt;path_to_kernel&gt; -append ...<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 The &quot;-cpu&quot; parameter can be omitted here an=
d QEMU will use the correct type for TCG/KVM automatically.<br>
&gt;&gt;<br>
&gt;&gt; V1 -&gt; V2:<br>
&gt;&gt; 1, Add a cover letter;<br>
&gt;&gt; 2, Improve CPU definitions;<br>
&gt;&gt; 3, Remove LS7A-related things (Use GPEX instead);<br>
&gt;&gt; 4, Add a description of how to run QEMU/Loongson-3.<br>
&gt;&gt;<br>
&gt;&gt; V2 -&gt; V3:<br>
&gt;&gt; 1, Fix all possible <a href=3D"http://checkpatch.pl" rel=3D"norefe=
rrer" target=3D"_blank">checkpatch.pl</a> errors and warnings.<br>
&gt;&gt;<br>
&gt;&gt; Huacai Chen(7):<br>
&gt;&gt;=C2=A0 configure: Add KVM target support for MIPS64<br>
&gt;&gt;=C2=A0 hw/mips: Implement the kvm_type() hook in MachineClass<br>
&gt;&gt;=C2=A0 hw/mips: Add CPU IRQ3 delivery for KVM<br>
&gt;&gt;=C2=A0 target/mips: Add Loongson-3 CPU definition<br>
&gt;&gt;=C2=A0 target/mips: Add more CP0 register for save/restor<br>
&gt;&gt;=C2=A0 hw/mips: Add Loongson-3 machine support (with KVM)<br>
&gt;&gt;=C2=A0 MAINTAINERS: Add myself as Loongson-3 maintainer<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Huacai Chen &lt;<a href=3D"mailto:chenhc@lemote.com=
" target=3D"_blank">chenhc@lemote.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A05 +<br>
&gt;&gt;=C2=A0 configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;&gt;=C2=A0 default-configs/mips64el-softmmu.mak |=C2=A0 =C2=A01 +<br>
&gt;&gt;=C2=A0 hw/core/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;&gt;=C2=A0 hw/core/null-machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +<br>
&gt;&gt;=C2=A0 hw/mips/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 10 +<br>
&gt;&gt;=C2=A0 hw/mips/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +-<br>
&gt;&gt;=C2=A0 hw/mips/common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 31 ++<br>
&gt;&gt;=C2=A0 hw/mips/mips_int.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
&gt;&gt;=C2=A0 hw/mips/mips_loongson3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 901 +++++++++++++++++++++++++++++++++++<br>
&gt;&gt;=C2=A0 include/hw/mips/mips.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 +<br>
&gt;&gt;=C2=A0 target/mips/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 28 ++<br>
&gt;&gt;=C2=A0 target/mips/internal.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
&gt;&gt;=C2=A0 target/mips/kvm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 212 +++++++++<br>
&gt;&gt;=C2=A0 target/mips/machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +-<br>
&gt;&gt;=C2=A0 target/mips/mips-defs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A07 +-<br>
&gt;&gt;=C2=A0 target/mips/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A02 +<br>
&gt;&gt;=C2=A0 target/mips/translate_init.inc.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
86 ++++<br>
&gt;&gt;=C2=A0 18 files changed, 1300 insertions(+), 9 deletions(-)<br>
&gt;&gt;=C2=A0 create mode 100644 hw/mips/common.c<br>
&gt;&gt;=C2=A0 create mode 100644 hw/mips/mips_loongson3.c<br>
&gt;&gt; --<br>
&gt;&gt; 2.7.0<br>
&gt;&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =E6=AD=A4=E8=87=B4<br>
&gt; =E7=A4=BC<br>
&gt; =E7=BD=97=E5=8B=87=E5=88=9A<br>
&gt; Yours<br>
&gt;=C2=A0 =C2=A0 =C2=A0sincerely,<br>
&gt; Yonggang Luo<br>
<br>
<br>
<br>
-- <br>
Huacai Chen<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div>

--000000000000806bd705a4cc775f--

