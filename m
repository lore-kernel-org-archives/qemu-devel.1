Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFDAC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 18:42:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34715216F4
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 18:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e1vk7Iyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34715216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaOk1-0006nX-QO
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 13:42:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iaNtq-00077r-I8
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 12:48:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iaNtk-0005I7-SI
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 12:48:15 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:41632)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iaNth-0005Cv-Mw
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 12:48:12 -0500
Received: by mail-lj1-x244.google.com with SMTP id m4so29284582ljj.8
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 09:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rLQ5XWPYV1spL9oJvaSjYn16zO51QaVf6UVLxT1MmP8=;
 b=e1vk7IyhwZRfM8HqFBdnzm/gdrUYH2o40ZIYVoND8Rt5lmcCgIn8tMgLYqxuiJTa4q
 +fuUVxujQTqgMk5kLTqlxrXfpTOh0Vdv0fHYxb6Cqcf8WD81smLyo14KTW07kn5L3tbS
 5CYuxXXJPTFnaW/YB03I92eHApakSkMvWcJJhJK1jIyB4hFdGRZ4acMXDq0n6Y8lOFgs
 JxZJVk3EbYulHRakEGVF4k90LqAG+p4AEuVarhP21YYdrT46sNCmd95vmramZyU0IZAU
 DPuRVVuNDPqOyGDuVqLapt6Cr0wSDZO344bq91+9WoF4D02sKUYdhEuLRYwP1fp435S1
 Hamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rLQ5XWPYV1spL9oJvaSjYn16zO51QaVf6UVLxT1MmP8=;
 b=gyfuNZakfTdu5WorOi/6j+pQa+PeST6bJwyghV1qGzSKOeU/c9IfYwCYN6UGpeff1+
 n5LChp6hDiyywsk2H0KzpTiWjsNIHWKwoSRhuuZ3uzF7CVLJ6nifXWM5apFMF/5mBnbI
 T5buOL+SxKLduqa0sS86x68b4xS0wqiViSCqHG87ZLkiYqd3x7zr9xQlSbRIjan3GACg
 xwS+22f/G4KOOFxi2R7ewFj1TkV9NoJMe/YJp3NC0hJ9Ye4UTwrXvsxbpaqDZ5ci0Ks/
 OAakupFdm5TC+cSfXicicSeYMBIYfAbks923grwSeBSvVuf8mbusNDFffr4NXBvUxpeV
 aJyQ==
X-Gm-Message-State: APjAAAXtf7tOaiz5tvt7AyFqiDcNn4pWuXH6wICpuTt5Cn1HMBdeVlI5
 NICTxOCJtZRuXeEG0WFtxy6HO+4O1CUvVtcWqrMzKA==
X-Google-Smtp-Source: APXvYqx7LdXxlr3kYD4HkFnbUx34U93dUYyQv1Wr7evmF+tLk89hd+zYXCCJv7fTNIDJseTqPSOHpWOc2goPhzXWvMk=
X-Received: by 2002:a2e:580c:: with SMTP id m12mr18958250ljb.150.1574963286587; 
 Thu, 28 Nov 2019 09:48:06 -0800 (PST)
MIME-Version: 1.0
References: <157468002661.30952.10642264809488923382.malonedeb@wampee.canonical.com>
 <157495565236.22072.12895340025547390627.malone@soybean.canonical.com>
In-Reply-To: <157495565236.22072.12895340025547390627.malone@soybean.canonical.com>
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Date: Thu, 28 Nov 2019 17:47:53 +0000
Message-ID: <CAHDbmO26ZNB4CJ0b_w+e3w8vTDFVcZQXMvchjsU32ng2JfNdQw@mail.gmail.com>
Subject: Re: [Bug 1853826] Re: ELF loader fails to load shared object on
 ThunderX2 running RHEL7
To: Bug 1853826 <1853826@bugs.launchpad.net>
Content-Type: multipart/alternative; boundary="0000000000003b529d05986bb708"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003b529d05986bb708
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Do binaries have to be page size aware? I thought it was a runtime thing.
However if the aarch64-linux-user is hardwired to 4k it might explain it's
confusion on a 64k machine.

On Thu, 28 Nov 2019, 16:33 Peter Maydell, <peter.maydell@linaro.org> wrote:

> If you objdump the binary and the offending library what do they seem to
> have been built for ?
>
> Certainly this:
>
> 0000004000000000-0000004000001000 0000000000001000 ---
>
> looks like a 4K page when we're trying to load things, so either we got
> the loading wrong or the binary is 4K.
>
> --
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1853826
>
> Title:
>   ELF loader fails to load shared object on ThunderX2 running RHEL7
>
> Status in QEMU:
>   Incomplete
>
> Bug description:
>   Simple test:
>   hello.c
>
>   include <stdio.h>
>
>   int main(int argc, char* argv[])
>   {
>     {
>       printf("Hello World... \n");
>     }
>     return 0;
>   }
>
>   when compiled with :
>   *Compiler
>
> https://developer.arm.com/tools-and-software/server-and-hpc/arm-architect=
ure-tools/arm-allinea-studio/download
>   Arm-Compiler-for-HPC_19.3_RHEL_7_aarch64.tar
>
>   *Running:
>   1) with -armpl
>        armclang -armpl hello.c
>        ./qemu/build/aarch64-linux-user/qemu-aarch64 a.out
>   2) without flag
>       armclang hello.c
>        ./qemu/build/aarch64-linux-user/qemu-aarch64 a.out
>
>   =E2=80=A2With Docker image:
>          CentOS Linux release 7.7.1908 (AltArch)
>
>   *Two different machines:
>          AArch64, Taishan. tsv110, Kunpeng 920, ARMv8.2-A
>          AArch64, Taishan 2280, Cortex-A72, ARMv8-A
>
>   *QEMU 4.0
>        qemu-aarch64 version 4.1.91 (v4.2.0-rc1)
>
>
>   Results:
>
>
>    ****Taishan 2280 Cortex-A72
>         Running
>   1)with -armpl flag with and without the docker
>             WORKS-> Hello World...
>                  -> ldd a.out
>   ldd a.out
>   linux-vdso.so.1 =3D>  (0x0000ffffbc6a2000)
>   libamath_generic.so =3D>
> /scratch/arm-linux-compiler-19.3_Generic-AArch64_RHEL-8_aarch64-linux/lib=
/clang/9.0.1/armpl_links/lib/libamath_generic.so
> (0x0000ffffbc544000)
>   libm.so.6 =3D> /lib64/libm.so.6 (0x0000ffffbc493000)
>   libastring_generic.so =3D>
> /scratch/arm-linux-compiler-19.3_Generic-AArch64_RHEL-8_aarch64-linux/lib=
/clang/9.0.1/armpl_links/lib/libastring_generic.so
> (0x0000ffffbc472000) libarmflang.so =3D>
> /scratch/arm-linux-compiler-19.3_Generic-AArch64_RHEL-8_aarch64-linux/lib=
/libarmflang.so
> (0x0000ffffbbfd3000)
>   libomp.so =3D>
> /scratch/arm-linux-compiler-19.3_Generic-AArch64_RHEL-8_aarch64-linux/lib=
/libomp.so
> (0x0000ffffbbef5000)
>   librt.so.1 =3D> /lib64/librt.so.1 (0x0000ffffbbed4000)
>   libpthread.so.0 =3D> /lib64/libpthread.so.0 (0x0000ffffbbe9f000)
>   libarmpl_lp64_generic.so =3D>
> /scratch/arm-linux-compiler-19.3_Generic-AArch64_RHEL-8_aarch64-linux/lib=
/clang/9.0.1/armpl_links/lib/libarmpl_lp64_generic.so
> (0x0000ffffb3306000)
>   libc.so.6 =3D> /lib64/libc.so.6 (0x0000ffffb3180000)
>   libstdc++.so.6 =3D>
> /scratch/gcc-9.2.0_Generic-AArch64_RHEL-8_aarch64-linux/lib64/libstdc++.s=
o.6
> (0x0000ffffb2f30000)
>   libgcc_s.so.1 =3D>
> /scratch/gcc-9.2.0_Generic-AArch64_RHEL-8_aarch64-linux/lib64/libgcc_s.so=
.1
> (0x0000ffffb2eff000)
>   libdl.so.2 =3D> /lib64/libdl.so.2 (0x0000ffffb2ede000)
>   /lib/ld-linux-aarch64.so.1 (0x0000ffffbc674000)
>
>
>   Running
>   2) without -armpl flag with and without the docker
>              WORKS -> Hello World...
>                    -> ldd a.out
>   ldd a.out
>    linux-vdso.so.1 =3D>  (0x0000ffffa6895000)
>   libastring_generic.so =3D>
> /scratch/arm-linux-compiler-19.3_Generic-AArch64_RHEL-8_aarch64-linux/lib=
/clang/9.0.1/armpl_links/lib/libastring_generic.so
> (0x0000ffffa6846000)
>   libc.so.6 =3D> /lib64/libc.so.6 (0x0000ffffa66c0000)
>   /lib/ld-linux-aarch64.so.1 (0x0000ffffa6867000)
>
>
>   ****Taishan - tsv110  Kunpeng 920
>          For Running
>
>   1)with -armpl flag with and without the docker
>              DOES NOT WORK -> with and without Docker
>                            -> It shows : qemu:handle_cpu_signal received
> signal outside vCPU
>    context @ pc=3D0xffffaaa8844a
>                            -> ldd a.out
>   ldd a.out
>   linux-vdso.so.1 =3D>  (0x0000ffffad4b0000)
>   libamath_generic.so =3D>
> /scratch/arm-linux-compiler-19.3_Generic-AArch64_RHEL-8_aarch64-linux/lib=
/clang/9.0.1/armpl_links/lib/libamath_generic.so
> (0x0000ffffad370000)
>   libm.so.6 =3D> /lib64/libm.so.6 (0x0000ffffad2a0000)
>   libastring_generic.so =3D>
> /scratch/arm-linux-compiler-19.3_Generic-AArch64_RHEL-8_aarch64-linux/lib=
/clang/9.0.1/armpl_links/lib/libastring_generic.so
> (0x0000ffffad270000) libarmflang.so =3D>
> /scratch/arm-linux-compiler-19.3_Generic-AArch64_RHEL-8_aarch64-linux/lib=
/libarmflang.so
> (0x0000ffffacdd0000)
>   libomp.so =3D>
> /scratch/arm-linux-compiler-19.3_Generic-AArch64_RHEL-8_aarch64-linux/lib=
/libomp.so
> (0x0000ffffaccf0000)
>   librt.so.1 =3D> /lib64/librt.so.1 (0x0000ffffaccc0000)
>   libpthread.so.0 =3D> /lib64/libpthread.so.0 (0x0000ffffacc80000)
>   libarmpl_lp64_generic.so =3D>
> /scratch/arm-linux-compiler-19.3_Generic-AArch64_RHEL-8_aarch64-linux/lib=
/clang/9.0.1/armpl_links/lib/libarmpl_lp64_generic.so
> (0x0000ffffa40e0000)
>   libc.so.6 =3D> /lib64/libc.so.6 (0x0000ffffa3f50000)
>   libstdc++.so.6 =3D>
> /scratch/gcc-9.2.0_Generic-AArch64_RHEL-8_aarch64-linux/lib64/libstdc++.s=
o.6
> (0x0000ffffa3d00000)
>   libgcc_s.so.1 =3D>
> /scratch/gcc-9.2.0_Generic-AArch64_RHEL-8_aarch64-linux/lib64/libgcc_s.so=
.1
> (0x0000ffffa3cc0000)
>   libdl.so.2 =3D> /lib64/libdl.so.2 (0x0000ffffa3c90000)
>   /lib/ld-linux-aarch64.so.1 (0x0000ffffad4c0000)
>
>
>   Running
>   2) without -armpl flag with and without the docker
>                  WORKS -> Hello World..
>                        -> ldd a.out
>   ldd a.out
>   linux-vdso.so.1 =3D>  (0x0000ffff880c0000)
>   libastring_generic.so =3D>
> /scratch/arm-linux-compiler-19.3_Generic-AArch64_RHEL-8_aarch64-linux/lib=
/clang/9.0.1/armpl_links/lib/libastring_generic.so
> (0x0000ffff88080000)
>   libc.so.6 =3D> /lib64/libc.so.6 (0x0000ffff87ee0000)
>   /lib/ld-linux-aarch64.so.1 (0x0000ffff880d0000)
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1853826/+subscriptions
>
>

--0000000000003b529d05986bb708
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Do binaries have to be page size aware? I thought it was =
a runtime thing. However if the aarch64-linux-user is hardwired to 4k it mi=
ght explain it&#39;s confusion on a 64k machine.</div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, 28 Nov 2019, 16:33 =
Peter Maydell, &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydel=
l@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">If you =
objdump the binary and the offending library what do they seem to<br>
have been built for ?<br>
<br>
Certainly this:<br>
<br>
0000004000000000-0000004000001000 0000000000001000 ---<br>
<br>
looks like a 4K page when we&#39;re trying to load things, so either we got=
<br>
the loading wrong or the binary is 4K.<br>
<br>
-- <br>
You received this bug notification because you are a member of qemu-<br>
devel-ml, which is subscribed to QEMU.<br>
<a href=3D"https://bugs.launchpad.net/bugs/1853826" rel=3D"noreferrer noref=
errer" target=3D"_blank">https://bugs.launchpad.net/bugs/1853826</a><br>
<br>
Title:<br>
=C2=A0 ELF loader fails to load shared object on ThunderX2 running RHEL7<br=
>
<br>
Status in QEMU:<br>
=C2=A0 Incomplete<br>
<br>
Bug description:<br>
=C2=A0 Simple test:<br>
=C2=A0 hello.c<br>
<br>
=C2=A0 include &lt;stdio.h&gt;<br>
<br>
=C2=A0 int main(int argc, char* argv[])<br>
=C2=A0 {<br>
=C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 printf(&quot;Hello World... \n&quot;);<br>
=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 return 0;<br>
=C2=A0 }<br>
<br>
=C2=A0 when compiled with :<br>
=C2=A0 *Compiler <br>
=C2=A0 <a href=3D"https://developer.arm.com/tools-and-software/server-and-h=
pc/arm-architecture-tools/arm-allinea-studio/download" rel=3D"noreferrer no=
referrer" target=3D"_blank">https://developer.arm.com/tools-and-software/se=
rver-and-hpc/arm-architecture-tools/arm-allinea-studio/download</a><br>
=C2=A0 Arm-Compiler-for-HPC_19.3_RHEL_7_aarch64.tar=C2=A0 =C2=A0<br>
<br>
=C2=A0 *Running:<br>
=C2=A0 1) with -armpl<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0armclang -armpl hello.c<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0./qemu/build/aarch64-linux-user/qemu-aarch64 a.o=
ut<br>
=C2=A0 2) without flag<br>
=C2=A0 =C2=A0 =C2=A0 armclang hello.c<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0./qemu/build/aarch64-linux-user/qemu-aarch64 a.o=
ut<br>
<br>
=C2=A0 =E2=80=A2With Docker image:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CentOS Linux release 7.7.1908 (AltArch)<b=
r>
<br>
=C2=A0 *Two different machines:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AArch64, Taishan. tsv110, Kunpeng 920, AR=
Mv8.2-A<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AArch64, Taishan 2280, Cortex-A72, ARMv8-=
A<br>
<br>
=C2=A0 *QEMU 4.0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu-aarch64 version 4.1.91 (v4.2.0-rc1)<br>
<br>
<br>
=C2=A0 Results:<br>
<br>
<br>
=C2=A0 =C2=A0****Taishan 2280 Cortex-A72 <br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Running <br>
=C2=A0 1)with -armpl flag with and without the docker<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 WORKS-&gt; Hello World...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-&gt; ldd a.o=
ut<br>
=C2=A0 ldd a.out <br>
=C2=A0 linux-vdso.so.1 =3D&gt;=C2=A0 (0x0000ffffbc6a2000) <br>
=C2=A0 libamath_generic.so =3D&gt; /scratch/arm-linux-compiler-19.3_Generic=
-AArch64_RHEL-8_aarch64-linux/lib/clang/9.0.1/armpl_links/lib/libamath_gene=
ric.so (0x0000ffffbc544000) <br>
=C2=A0 libm.so.6 =3D&gt; /lib64/libm.so.6 (0x0000ffffbc493000) <br>
=C2=A0 libastring_generic.so =3D&gt; /scratch/arm-linux-compiler-19.3_Gener=
ic-AArch64_RHEL-8_aarch64-linux/lib/clang/9.0.1/armpl_links/lib/libastring_=
generic.so (0x0000ffffbc472000) libarmflang.so =3D&gt; /scratch/arm-linux-c=
ompiler-19.3_Generic-AArch64_RHEL-8_aarch64-linux/lib/libarmflang.so (0x000=
0ffffbbfd3000) <br>
=C2=A0 libomp.so =3D&gt; /scratch/arm-linux-compiler-19.3_Generic-AArch64_R=
HEL-8_aarch64-linux/lib/libomp.so (0x0000ffffbbef5000) <br>
=C2=A0 librt.so.1 =3D&gt; /lib64/librt.so.1 (0x0000ffffbbed4000) <br>
=C2=A0 libpthread.so.0 =3D&gt; /lib64/libpthread.so.0 (0x0000ffffbbe9f000) =
<br>
=C2=A0 libarmpl_lp64_generic.so =3D&gt; /scratch/arm-linux-compiler-19.3_Ge=
neric-AArch64_RHEL-8_aarch64-linux/lib/clang/9.0.1/armpl_links/lib/libarmpl=
_lp64_generic.so (0x0000ffffb3306000) <br>
=C2=A0 libc.so.6 =3D&gt; /lib64/libc.so.6 (0x0000ffffb3180000) <br>
=C2=A0 libstdc++.so.6 =3D&gt; /scratch/gcc-9.2.0_Generic-AArch64_RHEL-8_aar=
ch64-linux/lib64/libstdc++.so.6 (0x0000ffffb2f30000) <br>
=C2=A0 libgcc_s.so.1 =3D&gt; /scratch/gcc-9.2.0_Generic-AArch64_RHEL-8_aarc=
h64-linux/lib64/libgcc_s.so.1 (0x0000ffffb2eff000) <br>
=C2=A0 libdl.so.2 =3D&gt; /lib64/libdl.so.2 (0x0000ffffb2ede000) <br>
=C2=A0 /lib/ld-linux-aarch64.so.1 (0x0000ffffbc674000)<br>
<br>
<br>
=C2=A0 Running <br>
=C2=A0 2) without -armpl flag with and without the docker<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WORKS -&gt; Hello World...=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-&gt; =
ldd a.out<br>
=C2=A0 ldd a.out<br>
=C2=A0 =C2=A0linux-vdso.so.1 =3D&gt;=C2=A0 (0x0000ffffa6895000) <br>
=C2=A0 libastring_generic.so =3D&gt; /scratch/arm-linux-compiler-19.3_Gener=
ic-AArch64_RHEL-8_aarch64-linux/lib/clang/9.0.1/armpl_links/lib/libastring_=
generic.so (0x0000ffffa6846000) <br>
=C2=A0 libc.so.6 =3D&gt; /lib64/libc.so.6 (0x0000ffffa66c0000) <br>
=C2=A0 /lib/ld-linux-aarch64.so.1 (0x0000ffffa6867000)<br>
<br>
<br>
=C2=A0 ****Taishan - tsv110=C2=A0 Kunpeng 920<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0For Running <br>
<br>
=C2=A0 1)with -armpl flag with and without the docker<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DOES NOT WORK -&gt; with an=
d without Docker<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0-&gt; It shows : qemu:handle_cpu_signal received si=
gnal outside vCPU<br>
=C2=A0 =C2=A0context @ pc=3D0xffffaaa8844a<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0-&gt; ldd a.out <br>
=C2=A0 ldd a.out <br>
=C2=A0 linux-vdso.so.1 =3D&gt;=C2=A0 (0x0000ffffad4b0000)<br>
=C2=A0 libamath_generic.so =3D&gt; /scratch/arm-linux-compiler-19.3_Generic=
-AArch64_RHEL-8_aarch64-linux/lib/clang/9.0.1/armpl_links/lib/libamath_gene=
ric.so (0x0000ffffad370000) <br>
=C2=A0 libm.so.6 =3D&gt; /lib64/libm.so.6 (0x0000ffffad2a0000) <br>
=C2=A0 libastring_generic.so =3D&gt; /scratch/arm-linux-compiler-19.3_Gener=
ic-AArch64_RHEL-8_aarch64-linux/lib/clang/9.0.1/armpl_links/lib/libastring_=
generic.so (0x0000ffffad270000) libarmflang.so =3D&gt; /scratch/arm-linux-c=
ompiler-19.3_Generic-AArch64_RHEL-8_aarch64-linux/lib/libarmflang.so (0x000=
0ffffacdd0000) <br>
=C2=A0 libomp.so =3D&gt; /scratch/arm-linux-compiler-19.3_Generic-AArch64_R=
HEL-8_aarch64-linux/lib/libomp.so (0x0000ffffaccf0000) <br>
=C2=A0 librt.so.1 =3D&gt; /lib64/librt.so.1 (0x0000ffffaccc0000) <br>
=C2=A0 libpthread.so.0 =3D&gt; /lib64/libpthread.so.0 (0x0000ffffacc80000) =
<br>
=C2=A0 libarmpl_lp64_generic.so =3D&gt; /scratch/arm-linux-compiler-19.3_Ge=
neric-AArch64_RHEL-8_aarch64-linux/lib/clang/9.0.1/armpl_links/lib/libarmpl=
_lp64_generic.so (0x0000ffffa40e0000) <br>
=C2=A0 libc.so.6 =3D&gt; /lib64/libc.so.6 (0x0000ffffa3f50000) <br>
=C2=A0 libstdc++.so.6 =3D&gt; /scratch/gcc-9.2.0_Generic-AArch64_RHEL-8_aar=
ch64-linux/lib64/libstdc++.so.6 (0x0000ffffa3d00000) <br>
=C2=A0 libgcc_s.so.1 =3D&gt; /scratch/gcc-9.2.0_Generic-AArch64_RHEL-8_aarc=
h64-linux/lib64/libgcc_s.so.1 (0x0000ffffa3cc0000)<br>
=C2=A0 libdl.so.2 =3D&gt; /lib64/libdl.so.2 (0x0000ffffa3c90000) <br>
=C2=A0 /lib/ld-linux-aarch64.so.1 (0x0000ffffad4c0000)<br>
<br>
<br>
=C2=A0 Running <br>
=C2=A0 2) without -armpl flag with and without the docker<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WORKS -&gt; H=
ello World..<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0-&gt; ldd a.out<br>
=C2=A0 ldd a.out=C2=A0 <br>
=C2=A0 linux-vdso.so.1 =3D&gt;=C2=A0 (0x0000ffff880c0000) <br>
=C2=A0 libastring_generic.so =3D&gt; /scratch/arm-linux-compiler-19.3_Gener=
ic-AArch64_RHEL-8_aarch64-linux/lib/clang/9.0.1/armpl_links/lib/libastring_=
generic.so (0x0000ffff88080000) <br>
=C2=A0 libc.so.6 =3D&gt; /lib64/libc.so.6 (0x0000ffff87ee0000)<br>
=C2=A0 /lib/ld-linux-aarch64.so.1 (0x0000ffff880d0000)<br>
<br>
To manage notifications about this bug go to:<br>
<a href=3D"https://bugs.launchpad.net/qemu/+bug/1853826/+subscriptions" rel=
=3D"noreferrer noreferrer" target=3D"_blank">https://bugs.launchpad.net/qem=
u/+bug/1853826/+subscriptions</a><br>
<br>
</blockquote></div>

--0000000000003b529d05986bb708--

