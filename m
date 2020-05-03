Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C01AC28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 10:43:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AD2720757
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 10:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWARrsY+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD2720757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVC5m-0008Sz-8h
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 06:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jVC51-0007IT-O4
 for qemu-devel@nongnu.org; Sun, 03 May 2020 06:42:39 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:35900)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jVC4z-0004lN-PO
 for qemu-devel@nongnu.org; Sun, 03 May 2020 06:42:39 -0400
Received: by mail-lj1-x244.google.com with SMTP id u15so6813044ljd.3
 for <qemu-devel@nongnu.org>; Sun, 03 May 2020 03:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=9MlYUFji2xz28BUMq6sJRu7n4am5Z1nda+8bXYOwtW0=;
 b=OWARrsY+phEORRbOVzUmWxbYvwSOkprBvc7yDiLWZQZDfLXI770n1b8aBHHkZONJ/U
 uRQ412NXGuGrh6RAEkzJyx1ApwtjN3vtNV8HsdyihQ9FxXxvsoQODRSSfUL4Bv+VfiJs
 AZL+oukrPNrbKgdrJm6Dn/UNc3NYcOTXpHw4/WLMfP5ePtzrlgon32/4yqqzWkQAa0kX
 Zb5WSxzsDNvBnAD41QG+xiFQP4WTrRb92nPdgbuCU6xL0JwuSqnLmtQQBOYm3jMU6Kla
 nQfEXsaaM42E8qx1mQfTgyP1zA4GwsnjEFTFukKb3Ud800XwiK9A+7NncUsxtiRF5w5G
 dBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=9MlYUFji2xz28BUMq6sJRu7n4am5Z1nda+8bXYOwtW0=;
 b=fPEKqvyaHEuTvjV10gVW5Dg8pSzkt6RAXLyMuZn+UWnn69PQAhvyrSEr8nnKk1yiG8
 TtGaOTyK/FE+qezgW28r1scI+GfVV48fRaAqCbk9oJahCYJu0wuZgQfYjwK1nUbVB4WI
 91qRz/a4ZDytjO4QG8z0/9qPA92LidrcQorweXs8DN1c5e0pYW2FgpNt/SC+7pXV2ebI
 r1ZMuy7Hbv0XBcY+XBG2bXi+ZHxhXTvU+ADZBitJ+An/z8w3rXLMz+izOZU3cX8Z0RQH
 QiPhBN87oZm7CfEg/4opSBQpdiCtSG/2YmSWCAzSfiKtLpqH9fUinH2aojUsa6oVFnnu
 Fm7g==
X-Gm-Message-State: AGi0PuZp9/EJA35tWO9jerSzCjok17KyrgxJduI+wpLzbVWYchUG4UcH
 SqEIA3XaU4PejA1Ej7wQR+8hzdxIdpHhrlvorVs=
X-Google-Smtp-Source: APiQypL6ed2q5LdSOvj4zN/NhyhMqs938YFl/qcD0ipFG4LmYCEwqSZBVudzRo1BE2RMImx9TSTR7ohH08ACH1wDfUs=
X-Received: by 2002:a05:651c:3ce:: with SMTP id
 f14mr7411520ljp.98.1588502555103; 
 Sun, 03 May 2020 03:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <1588501221-1205-1-git-send-email-chenhc@lemote.com>
In-Reply-To: <1588501221-1205-1-git-send-email-chenhc@lemote.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sun, 3 May 2020 18:42:26 +0800
Message-ID: <CAE2XoE-6VMKY-_upyGoNeD0N6nWj2bfD6g9H0sZFFciWnOYwjw@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V3 0/7] mips: Add Loongson-3 machine support (with
 KVM)
To: Huacai Chen <zltjiangshi@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000085964005a4bc1292"
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x244.google.com
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
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000085964005a4bc1292
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The english version of the reference document is hard to head.
I suggest first convert the chinese version into markdown or alternative
format and
place them at github.
And we then translate the document with google translate.

On Sun, May 3, 2020 at 6:22 PM Huacai Chen <zltjiangshi@gmail.com> wrote:

> Loongson-3 CPU family include Loongson-3A R1/R2/R3/R4 and Loongson-3B
> R1/R2. Loongson-3A R1 is the oldest and its ISA is the smallest, while
> Loongson-3A R4 is the newest and its ISA is almost the superset of all
> others. To reduce complexity, in QEMU we just define two CPU types:
>
> 1, "Loongson-3A1000" CPU which is corresponding to Loongson-3A R1. It is
>    suitable for TCG because Loongson-3A R1 has fewest ASE.
> 2, "Loongson-3A4000" CPU which is corresponding to Loongson-3A R4. It is
>    suitable for KVM because Loongson-3A R4 has the VZ ASE.
>
> Loongson-3 lacks English documents. I've tried to translated them with
> translate.google.com, and the machine translated documents (together
> with their original Chinese versions) are available here.
>
> Loongson-3A R1 (Loongson-3A1000)
> User Manual Part 1:
> http://ftp.godson.ac.cn/lemote/3A1000_p1.pdf
> http://ftp.godson.ac.cn/lemote/Loongson3A1000_processor_user_manual_P1.pd=
f
> (Chinese Version)
> User Manual Part 2:
> http://ftp.godson.ac.cn/lemote/3A1000_p2.pdf
> http://ftp.godson.ac.cn/lemote/Loongson3A1000_processor_user_manual_P2.pd=
f
> (Chinese Version)
>
> Loongson-3A R2 (Loongson-3A2000)
> User Manual Part 1:
> http://ftp.godson.ac.cn/lemote/3A2000_p1.pdf
> http://ftp.godson.ac.cn/lemote/Loongson3A2000_user1.pdf (Chinese Version)
> User Manual Part 2:
> http://ftp.godson.ac.cn/lemote/3A2000_p2.pdf
> http://ftp.godson.ac.cn/lemote/Loongson3A2000_user2.pdf (Chinese Version)
>
> Loongson-3A R3 (Loongson-3A3000)
> User Manual Part 1:
> http://ftp.godson.ac.cn/lemote/3A3000_p1.pdf
> http://ftp.godson.ac.cn/lemote/Loongson3A3000_3B3000usermanual1.pdf
> (Chinese Version)
> User Manual Part 2:
> http://ftp.godson.ac.cn/lemote/3A3000_p2.pdf
> http://ftp.godson.ac.cn/lemote/Loongson3A3000_3B3000usermanual2.pdf
> (Chinese Version)
>
> Loongson-3A R4 (Loongson-3A4000)
> User Manual Part 1:
> http://ftp.godson.ac.cn/lemote/3A4000_p1.pdf
> http://ftp.godson.ac.cn/lemote/3A4000user.pdf (Chinese Version)
> User Manual Part 2:
> I'm sorry that it is unavailable now.
>
> We are preparing to add QEMU's Loongson-3 support. MIPS VZ extension is
> fully supported in Loongson-3A R4+, so we at first add QEMU/KVM support
> in this series. And the next series will add QEMU/TCG support (it will
> emulate Loongson-3A R1).
>
> We already have a full functional Linux kernel (based on Linux-5.4.x LTS
> but not upstream yet) here:
>
> https://github.com/chenhuacai/linux
>
> How to use QEMU/Loongson-3?
> 1, Download kernel source from the above URL;
> 2, Build a kernel with arch/mips/configs/loongson3_{def,hpc}config;
> 3, Boot a Loongson-3A4000 host with this kernel;
> 4, Build QEMU-5.0.0 with this patchset;
> 5, modprobe kvm;
> 6, Use QEMU with TCG (available in future):
>        qemu-system-mips64el -M loongson3,accel=3Dtcg -cpu Loongson-3A1000
> -kernel <path_to_kernel> -append ...
>    Use QEMU with KVM (available at present):
>        qemu-system-mips64el -M loongson3,accel=3Dkvm -cpu Loongson-3A4000
> -kernel <path_to_kernel> -append ...
>
>    The "-cpu" parameter can be omitted here and QEMU will use the correct
> type for TCG/KVM automatically.
>
> V1 -> V2:
> 1, Add a cover letter;
> 2, Improve CPU definitions;
> 3, Remove LS7A-related things (Use GPEX instead);
> 4, Add a description of how to run QEMU/Loongson-3.
>
> V2 -> V3:
> 1, Fix all possible checkpatch.pl errors and warnings.
>
> Huacai Chen(7):
>  configure: Add KVM target support for MIPS64
>  hw/mips: Implement the kvm_type() hook in MachineClass
>  hw/mips: Add CPU IRQ3 delivery for KVM
>  target/mips: Add Loongson-3 CPU definition
>  target/mips: Add more CP0 register for save/restor
>  hw/mips: Add Loongson-3 machine support (with KVM)
>  MAINTAINERS: Add myself as Loongson-3 maintainer
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  MAINTAINERS                          |   5 +
>  configure                            |   2 +-
>  default-configs/mips64el-softmmu.mak |   1 +
>  hw/core/Makefile.objs                |   2 +-
>  hw/core/null-machine.c               |   4 +
>  hw/mips/Kconfig                      |  10 +
>  hw/mips/Makefile.objs                |   3 +-
>  hw/mips/common.c                     |  31 ++
>  hw/mips/mips_int.c                   |   4 +-
>  hw/mips/mips_loongson3.c             | 901
> +++++++++++++++++++++++++++++++++++
>  include/hw/mips/mips.h               |   3 +
>  target/mips/cpu.h                    |  28 ++
>  target/mips/internal.h               |   2 +
>  target/mips/kvm.c                    | 212 +++++++++
>  target/mips/machine.c                |   6 +-
>  target/mips/mips-defs.h              |   7 +-
>  target/mips/translate.c              |   2 +
>  target/mips/translate_init.inc.c     |  86 ++++
>  18 files changed, 1300 insertions(+), 9 deletions(-)
>  create mode 100644 hw/mips/common.c
>  create mode 100644 hw/mips/mips_loongson3.c
> --
> 2.7.0
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000085964005a4bc1292
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The english version of the reference document is hard to h=
ead.<div>I suggest first convert the chinese version into markdown or alter=
native format and</div><div>place them at github.</div><div>And we then tra=
nslate the document with google translate.=C2=A0=C2=A0</div></div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, May 3, =
2020 at 6:22 PM Huacai Chen &lt;<a href=3D"mailto:zltjiangshi@gmail.com">zl=
tjiangshi@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Loongson-3 CPU family include Loongson-3A R1/R2/R3/R4 an=
d Loongson-3B<br>
R1/R2. Loongson-3A R1 is the oldest and its ISA is the smallest, while<br>
Loongson-3A R4 is the newest and its ISA is almost the superset of all<br>
others. To reduce complexity, in QEMU we just define two CPU types:<br>
<br>
1, &quot;Loongson-3A1000&quot; CPU which is corresponding to Loongson-3A R1=
. It is<br>
=C2=A0 =C2=A0suitable for TCG because Loongson-3A R1 has fewest ASE.<br>
2, &quot;Loongson-3A4000&quot; CPU which is corresponding to Loongson-3A R4=
. It is<br>
=C2=A0 =C2=A0suitable for KVM because Loongson-3A R4 has the VZ ASE.<br>
<br>
Loongson-3 lacks English documents. I&#39;ve tried to translated them with<=
br>
<a href=3D"http://translate.google.com" rel=3D"noreferrer" target=3D"_blank=
">translate.google.com</a>, and the machine translated documents (together<=
br>
with their original Chinese versions) are available here.<br>
<br>
Loongson-3A R1 (Loongson-3A1000)<br>
User Manual Part 1:<br>
<a href=3D"http://ftp.godson.ac.cn/lemote/3A1000_p1.pdf" rel=3D"noreferrer"=
 target=3D"_blank">http://ftp.godson.ac.cn/lemote/3A1000_p1.pdf</a><br>
<a href=3D"http://ftp.godson.ac.cn/lemote/Loongson3A1000_processor_user_man=
ual_P1.pdf" rel=3D"noreferrer" target=3D"_blank">http://ftp.godson.ac.cn/le=
mote/Loongson3A1000_processor_user_manual_P1.pdf</a> (Chinese Version)<br>
User Manual Part 2:<br>
<a href=3D"http://ftp.godson.ac.cn/lemote/3A1000_p2.pdf" rel=3D"noreferrer"=
 target=3D"_blank">http://ftp.godson.ac.cn/lemote/3A1000_p2.pdf</a><br>
<a href=3D"http://ftp.godson.ac.cn/lemote/Loongson3A1000_processor_user_man=
ual_P2.pdf" rel=3D"noreferrer" target=3D"_blank">http://ftp.godson.ac.cn/le=
mote/Loongson3A1000_processor_user_manual_P2.pdf</a> (Chinese Version)<br>
<br>
Loongson-3A R2 (Loongson-3A2000)<br>
User Manual Part 1:<br>
<a href=3D"http://ftp.godson.ac.cn/lemote/3A2000_p1.pdf" rel=3D"noreferrer"=
 target=3D"_blank">http://ftp.godson.ac.cn/lemote/3A2000_p1.pdf</a><br>
<a href=3D"http://ftp.godson.ac.cn/lemote/Loongson3A2000_user1.pdf" rel=3D"=
noreferrer" target=3D"_blank">http://ftp.godson.ac.cn/lemote/Loongson3A2000=
_user1.pdf</a> (Chinese Version)<br>
User Manual Part 2:<br>
<a href=3D"http://ftp.godson.ac.cn/lemote/3A2000_p2.pdf" rel=3D"noreferrer"=
 target=3D"_blank">http://ftp.godson.ac.cn/lemote/3A2000_p2.pdf</a><br>
<a href=3D"http://ftp.godson.ac.cn/lemote/Loongson3A2000_user2.pdf" rel=3D"=
noreferrer" target=3D"_blank">http://ftp.godson.ac.cn/lemote/Loongson3A2000=
_user2.pdf</a> (Chinese Version)<br>
<br>
Loongson-3A R3 (Loongson-3A3000)<br>
User Manual Part 1:<br>
<a href=3D"http://ftp.godson.ac.cn/lemote/3A3000_p1.pdf" rel=3D"noreferrer"=
 target=3D"_blank">http://ftp.godson.ac.cn/lemote/3A3000_p1.pdf</a><br>
<a href=3D"http://ftp.godson.ac.cn/lemote/Loongson3A3000_3B3000usermanual1.=
pdf" rel=3D"noreferrer" target=3D"_blank">http://ftp.godson.ac.cn/lemote/Lo=
ongson3A3000_3B3000usermanual1.pdf</a> (Chinese Version)<br>
User Manual Part 2:<br>
<a href=3D"http://ftp.godson.ac.cn/lemote/3A3000_p2.pdf" rel=3D"noreferrer"=
 target=3D"_blank">http://ftp.godson.ac.cn/lemote/3A3000_p2.pdf</a><br>
<a href=3D"http://ftp.godson.ac.cn/lemote/Loongson3A3000_3B3000usermanual2.=
pdf" rel=3D"noreferrer" target=3D"_blank">http://ftp.godson.ac.cn/lemote/Lo=
ongson3A3000_3B3000usermanual2.pdf</a> (Chinese Version)<br>
<br>
Loongson-3A R4 (Loongson-3A4000)<br>
User Manual Part 1:<br>
<a href=3D"http://ftp.godson.ac.cn/lemote/3A4000_p1.pdf" rel=3D"noreferrer"=
 target=3D"_blank">http://ftp.godson.ac.cn/lemote/3A4000_p1.pdf</a><br>
<a href=3D"http://ftp.godson.ac.cn/lemote/3A4000user.pdf" rel=3D"noreferrer=
" target=3D"_blank">http://ftp.godson.ac.cn/lemote/3A4000user.pdf</a> (Chin=
ese Version)<br>
User Manual Part 2:<br>
I&#39;m sorry that it is unavailable now.<br>
<br>
We are preparing to add QEMU&#39;s Loongson-3 support. MIPS VZ extension is=
<br>
fully supported in Loongson-3A R4+, so we at first add QEMU/KVM support<br>
in this series. And the next series will add QEMU/TCG support (it will<br>
emulate Loongson-3A R1).<br>
<br>
We already have a full functional Linux kernel (based on Linux-5.4.x LTS<br=
>
but not upstream yet) here:<br>
<br>
<a href=3D"https://github.com/chenhuacai/linux" rel=3D"noreferrer" target=
=3D"_blank">https://github.com/chenhuacai/linux</a><br>
<br>
How to use QEMU/Loongson-3?<br>
1, Download kernel source from the above URL;<br>
2, Build a kernel with arch/mips/configs/loongson3_{def,hpc}config;<br>
3, Boot a Loongson-3A4000 host with this kernel;<br>
4, Build QEMU-5.0.0 with this patchset;<br>
5, modprobe kvm;<br>
6, Use QEMU with TCG (available in future):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu-system-mips64el -M loongson3,accel=3Dtcg -c=
pu Loongson-3A1000 -kernel &lt;path_to_kernel&gt; -append ... <br>
=C2=A0 =C2=A0Use QEMU with KVM (available at present): <br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu-system-mips64el -M loongson3,accel=3Dkvm -c=
pu Loongson-3A4000 -kernel &lt;path_to_kernel&gt; -append ... <br>
<br>
=C2=A0 =C2=A0The &quot;-cpu&quot; parameter can be omitted here and QEMU wi=
ll use the correct type for TCG/KVM automatically.<br>
<br>
V1 -&gt; V2:<br>
1, Add a cover letter;<br>
2, Improve CPU definitions;<br>
3, Remove LS7A-related things (Use GPEX instead);<br>
4, Add a description of how to run QEMU/Loongson-3.<br>
<br>
V2 -&gt; V3:<br>
1, Fix all possible <a href=3D"http://checkpatch.pl" rel=3D"noreferrer" tar=
get=3D"_blank">checkpatch.pl</a> errors and warnings.<br>
<br>
Huacai Chen(7):<br>
=C2=A0configure: Add KVM target support for MIPS64<br>
=C2=A0hw/mips: Implement the kvm_type() hook in MachineClass<br>
=C2=A0hw/mips: Add CPU IRQ3 delivery for KVM<br>
=C2=A0target/mips: Add Loongson-3 CPU definition<br>
=C2=A0target/mips: Add more CP0 register for save/restor<br>
=C2=A0hw/mips: Add Loongson-3 machine support (with KVM)<br>
=C2=A0MAINTAINERS: Add myself as Loongson-3 maintainer<br>
<br>
Signed-off-by: Huacai Chen &lt;<a href=3D"mailto:chenhc@lemote.com" target=
=3D"_blank">chenhc@lemote.com</a>&gt;<br>
---<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A05 +<br>
=C2=A0configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0default-configs/mips64el-softmmu.mak |=C2=A0 =C2=A01 +<br>
=C2=A0hw/core/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0hw/core/null-machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A04 +<br>
=C2=A0hw/mips/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 10 +<br>
=C2=A0hw/mips/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 =C2=A03 +-<br>
=C2=A0hw/mips/common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 31 ++<br>
=C2=A0hw/mips/mips_int.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
=C2=A0hw/mips/mips_loongson3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 901 +++++++++++++++++++++++++++++++++++<br>
=C2=A0include/hw/mips/mips.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A03 +<br>
=C2=A0target/mips/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 28 ++<br>
=C2=A0target/mips/internal.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
=C2=A0target/mips/kvm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 212 +++++++++<br>
=C2=A0target/mips/machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 =C2=A06 +-<br>
=C2=A0target/mips/mips-defs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A07 +-<br>
=C2=A0target/mips/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A02 +<br>
=C2=A0target/mips/translate_init.inc.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 86 ++++<b=
r>
=C2=A018 files changed, 1300 insertions(+), 9 deletions(-)<br>
=C2=A0create mode 100644 hw/mips/common.c<br>
=C2=A0create mode 100644 hw/mips/mips_loongson3.c<br>
--<br>
2.7.0<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div>

--00000000000085964005a4bc1292--

