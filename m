Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04995C35246
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:38:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB2FD2082E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMh1vOoN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2FD2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixaFR-0008QK-2D
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 12:38:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ixaEM-0007UQ-AO
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:37:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ixaEK-0000wr-QV
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:37:22 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:36076)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ixaEK-0000vk-L6
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:37:20 -0500
Received: by mail-ot1-x336.google.com with SMTP id g15so7356553otp.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 09:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=rm3excohGn/NWWgrf86HWgzIvFPZUo97MW9tcuG6V7g=;
 b=rMh1vOoNwH3YaAa1g6V1FZme5LGG8rKciq2d/BCNZV0L9Dl1nbU4pvnk90r4WQ/MtE
 /z7OonPmgHMZZ/HqMD75R17i4lg1IH1v8C/rN+e5HaWQMjXqmfhHDOCI3Y3V2+5zZEKw
 o7LQFVwYq3m7Mn0yXCXdpXnsIxQk7+ZEq60aRtazjvSgo8ITNFPQHViuaDfgpVDt3ghi
 Y7OKaF6nNPsAPeTILJDowgK+YAA9GTjTIDld/AILH97bYxhuC2HdqFB8tXRkg3kR+IXf
 YNT9Vziqf9SDIXWRy4gski3tq0+GZNOYXgFAf+9ojwbR4A7ehb/Y/nDPr4Isi4H5N3qs
 +8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=rm3excohGn/NWWgrf86HWgzIvFPZUo97MW9tcuG6V7g=;
 b=kZ4YN5hZ87TzVBznJ0bOduPJHCTqIXrAa2VtLzsCgwhbYi5b9ilzQmI5zVlJkcThKs
 dQTWYu+LeL45L8BlNV45LCMfqGwg8M6ZypIEe4yMK2uyLc1PgEx0BTlUzqsNXbU1NBPS
 gkheT/6fQzQ/0AtxG+i1iHcMaMaY/4I8y2BU75Ev1ihlmKsiIlo3dqor6CfOjAccHN7U
 PNwIA0H5lnFp3qR400mOcsx+gL261sah51/hGqQAeh81IR9sNFFCF33e/aH1V+/OpO8c
 hrHftaVlDFz5nvKrSUMiuYJ4aPFKcWce5SmP68ZV/ZWYGIVoQcpdIzguaY1I6iJFXBfo
 zf4A==
X-Gm-Message-State: APjAAAXOy0Chg1Y273PrIL+fSU1XxSwdf2BM1nmEjUqUGsXHuRUjkg1k
 1OtUk81P3r/VHpf30/lGObIgCiuqCLGRiNWlVbU1+8Gj
X-Google-Smtp-Source: APXvYqxMfXymUiMoP/TpjAJ2qYs1A9dStDskcT5lctNE2yWgDngX7W4++s2jRgjA9TXmJlO/B+HOIGVSq8a2UUDGJAU=
X-Received: by 2002:a9d:7305:: with SMTP id e5mr8144188otk.64.1580492239977;
 Fri, 31 Jan 2020 09:37:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Fri, 31 Jan 2020 09:37:19 -0800 (PST)
In-Reply-To: <158049016711.20266.13259801440809425215.launchpad@wampee.canonical.com>
References: <158038956597.5319.13308249814127344774.malonedeb@chaenomeles.canonical.com>
 <158049016711.20266.13259801440809425215.launchpad@wampee.canonical.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 31 Jan 2020 18:37:19 +0100
Message-ID: <CAL1e-=hQ=j2H3XiaJSG4XuutU_owjv1BF_Zhhg7STgLUm0bJdQ@mail.gmail.com>
Subject: Re: [Bug 1861404] [NEW] AVX instruction VMOVDQU implementation error
 for YMM registers
To: Bug 1861404 <1861404@bugs.launchpad.net>
Content-Type: multipart/alternative; boundary="00000000000088becb059d730627"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::336
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000088becb059d730627
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Friday, January 31, 2020, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:

> ** Tags added: tcg testcase
>
> --
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1861404
>
> Title:
>   AVX instruction VMOVDQU implementation error for YMM registers
>
>
If I remember well, there is no support for AVX instructions in linux-user
mode.

If that is true, how come handling of unsupported instruction went that far=
?

Did you try other AVX instructions?

Aleksandar




> Status in QEMU:
>   New
>
> Bug description:
>   Hi,
>
>   Tested with Qemu 4.2.0, and with git version
>   bddff6f6787c916b0e9d63ef9e4d442114257739.
>
>   The x86 AVX instruction VMOVDQU doesn't work properly with YMM register=
s
> (32 bytes).
>   It works with XMM registers (16 bytes) though.
>
>   See the attached test case `ymm.c`: when copying from memory-to-ymm0
>   and then back from ymm0-to-memory using VMOVDQU, Qemu only copies the
>   first 16 of the total 32 bytes.
>
>   ```
>   user@ubuntu ~/Qemu % gcc -o ymm ymm.c -Wall -Wextra -Werror
>
>   user@ubuntu ~/Qemu % ./ymm
>   00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F 10 11 12 13 14 15 16 17
> 18 19 1A 1B 1C 1D 1E 1F
>
>   user@ubuntu ~/Qemu % ./x86_64-linux-user/qemu-x86_64 -cpu max ymm
>   00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00
>   ```
>
>   This seems to be because in `translate.c > gen_sse()`, the case
>   handling the VMOVDQU instruction calls `gen_ldo_env_A0` which always
>   performs a 16 bytes copy using two 8 bytes load and store operations
>   (with `tcg_gen_qemu_ld_i64` and `tcg_gen_st_i64`).
>
>   Instead, the `gen_ldo_env_A0` function should generate a copy with a
>   size corresponding to the used register.
>
>
>   ```
>   static void gen_sse(CPUX86State *env, DisasContext *s, int b,
>                       target_ulong pc_start, int rex_r)
>   {
>           [...]
>           case 0x26f: /* movdqu xmm, ea */
>               if (mod !=3D 3) {
>                   gen_lea_modrm(env, s, modrm);
>                   gen_ldo_env_A0(s, offsetof(CPUX86State, xmm_regs[reg]))=
;
>               } else {
>           [...]
>   ```
>
>   ```
>   static inline void gen_ldo_env_A0(DisasContext *s, int offset)
>   {
>       int mem_index =3D s->mem_index;
>       tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0, mem_index, MO_LEQ);
>       tcg_gen_st_i64(s->tmp1_i64, cpu_env, offset + offsetof(ZMMReg,
> ZMM_Q(0)));
>       tcg_gen_addi_tl(s->tmp0, s->A0, 8);
>       tcg_gen_qemu_ld_i64(s->tmp1_i64, s->tmp0, mem_index, MO_LEQ);
>       tcg_gen_st_i64(s->tmp1_i64, cpu_env, offset + offsetof(ZMMReg,
> ZMM_Q(1)));
>   }
>   ```
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1861404/+subscriptions
>
>

--00000000000088becb059d730627
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, January 31, 2020, Alex Benn=C3=A9e &lt;<a href=3D"mailto=
:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">** Tags added: tcg testcase<br>
<br>
-- <br>
You received this bug notification because you are a member of qemu-<br>
devel-ml, which is subscribed to QEMU.<br>
<a href=3D"https://bugs.launchpad.net/bugs/1861404" target=3D"_blank">https=
://bugs.launchpad.net/<wbr>bugs/1861404</a><br>
<br>
Title:<br>
=C2=A0 AVX instruction VMOVDQU implementation error for YMM registers<br>
<br></blockquote><div><br></div><div>If I remember well, there is no suppor=
t for AVX instructions in linux-user mode.</div><div><br></div><div>If that=
 is true, how come handling of unsupported instruction went that far?</div>=
<div><br></div><div>Did you try other AVX instructions?</div><div><br></div=
><div>Aleksandar</div><div><br></div><div><br></div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">
Status in QEMU:<br>
=C2=A0 New<br>
<br>
Bug description:<br>
=C2=A0 Hi,<br>
<br>
=C2=A0 Tested with Qemu 4.2.0, and with git version<br>
=C2=A0 bddff6f6787c916b0e9d63ef9e4d44<wbr>2114257739.<br>
<br>
=C2=A0 The x86 AVX instruction VMOVDQU doesn&#39;t work properly with YMM r=
egisters (32 bytes).<br>
=C2=A0 It works with XMM registers (16 bytes) though.<br>
<br>
=C2=A0 See the attached test case `ymm.c`: when copying from memory-to-ymm0=
<br>
=C2=A0 and then back from ymm0-to-memory using VMOVDQU, Qemu only copies th=
e<br>
=C2=A0 first 16 of the total 32 bytes.<br>
<br>
=C2=A0 ```<br>
=C2=A0 user@ubuntu ~/Qemu % gcc -o ymm ymm.c -Wall -Wextra -Werror<br>
<br>
=C2=A0 user@ubuntu ~/Qemu % ./ymm<br>
=C2=A0 00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F 10 11 12 13 14 15 16=
 17 18 19 1A 1B 1C 1D 1E 1F<br>
<br>
=C2=A0 user@ubuntu ~/Qemu % ./x86_64-linux-user/qemu-x86_<wbr>64 -cpu max y=
mm<br>
=C2=A0 00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 00<br>
=C2=A0 ```<br>
<br>
=C2=A0 This seems to be because in `translate.c &gt; gen_sse()`, the case<b=
r>
=C2=A0 handling the VMOVDQU instruction calls `gen_ldo_env_A0` which always=
<br>
=C2=A0 performs a 16 bytes copy using two 8 bytes load and store operations=
<br>
=C2=A0 (with `tcg_gen_qemu_ld_i64` and `tcg_gen_st_i64`).<br>
<br>
=C2=A0 Instead, the `gen_ldo_env_A0` function should generate a copy with a=
<br>
=C2=A0 size corresponding to the used register.<br>
<br>
<br>
=C2=A0 ```<br>
=C2=A0 static void gen_sse(CPUX86State *env, DisasContext *s, int b,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 target_ulong pc_start, int rex_r)<br>
=C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [...]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x26f: /* movdqu xmm, ea */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mod !=3D 3) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_lea_modr=
m(env, s, modrm);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_ldo_env_=
A0(s, offsetof(CPUX86State, xmm_regs[reg]));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else { <br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [...]<br>
=C2=A0 ```<br>
<br>
=C2=A0 ```<br>
=C2=A0 static inline void gen_ldo_env_A0(DisasContext *s, int offset)<br>
=C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 int mem_index =3D s-&gt;mem_index;<br>
=C2=A0 =C2=A0 =C2=A0 tcg_gen_qemu_ld_i64(s-&gt;tmp1_<wbr>i64, s-&gt;A0, mem=
_index, MO_LEQ);<br>
=C2=A0 =C2=A0 =C2=A0 tcg_gen_st_i64(s-&gt;tmp1_i64, cpu_env, offset + offse=
tof(ZMMReg, ZMM_Q(0)));<br>
=C2=A0 =C2=A0 =C2=A0 tcg_gen_addi_tl(s-&gt;tmp0, s-&gt;A0, 8);<br>
=C2=A0 =C2=A0 =C2=A0 tcg_gen_qemu_ld_i64(s-&gt;tmp1_<wbr>i64, s-&gt;tmp0, m=
em_index, MO_LEQ);<br>
=C2=A0 =C2=A0 =C2=A0 tcg_gen_st_i64(s-&gt;tmp1_i64, cpu_env, offset + offse=
tof(ZMMReg, ZMM_Q(1)));<br>
=C2=A0 }<br>
=C2=A0 ```<br>
<br>
To manage notifications about this bug go to:<br>
<a href=3D"https://bugs.launchpad.net/qemu/+bug/1861404/+subscriptions" tar=
get=3D"_blank">https://bugs.launchpad.net/<wbr>qemu/+bug/1861404/+<wbr>subs=
criptions</a><br>
<br>
</blockquote>

--00000000000088becb059d730627--

