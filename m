Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E5BC2D0EC
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 20:46:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51595206A1
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 20:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLCJKH+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51595206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNjUq-0003vD-FA
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 16:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <adultjiuice@gmail.com>) id 1jNjU9-0003V5-5m
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 16:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <adultjiuice@gmail.com>) id 1jNjU7-0003cN-33
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 16:45:44 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:40564)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <adultjiuice@gmail.com>)
 id 1jNjU6-0003by-95
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 16:45:42 -0400
Received: by mail-ot1-x330.google.com with SMTP id i27so4403819ota.7
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2020 13:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=TnFsQ0ytp3EN8gHl04Jp/OvEkW7WYmZ1QKE98tnKEd8=;
 b=YLCJKH+2UiOm1D/GCOPWPr/qQOjkAvfcgy6J4zJGk6wO5bO65uDFspa8KeLdWp1L7F
 V89guoFRMR+CCiS7WJkq0nuRWzVNqUR+az2o20mcyKWuWEKrItHK+pN7p2RZvhWymwTc
 951i6/qE0j0AgPN54dox1aq+nM0vIVXYIJ6I9VBTQ31xPPt9WOMjbC29jDbKG7EQ3Qd0
 2Q4/h+2qDQlf1hiTQe23UVhkrYmiCqL4HwcqZ20sn7KnoUJCFIgc0TB5pXkHpoL8d/dO
 HzHdmRS2QvCEICIzBNQ08pBqLyEcobG3JJabPBC+ChYao4jXXpzlLSNNlKcvSRixxUgJ
 OWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=TnFsQ0ytp3EN8gHl04Jp/OvEkW7WYmZ1QKE98tnKEd8=;
 b=sY/jaWeDSgaR8xGASI53BX4MLkS/BF2AsyKzmii2Dxw++ryN1zgWnnM1Hm8SlnZc1i
 qmkNgQlx4v0LF4Gbmtqh8dTpZ1OieS4rxrMlaZ4hPJc4EFbxvVE4Wbv5JlXdLGiVRopV
 C4+MK6Ib5YmWQ1ma/Qh2T/5j2XkoCXZ/rSRuFuqj4Pl/60meFuYd6mIdd7vpkhxDI0yb
 aKFwgHYDbczQDuOu/+kEE4+qCWcP90DoCeCgUug2oydgTyA6n/qM9INtIdd6NV2uBozq
 IiGdIw8FTKkXx5TycRFMjSPu4ltruwmJX17m/TKKih29q3+cIGAJbZ2GikvDYmR5xD+R
 CpVQ==
X-Gm-Message-State: AGi0PubterzlvdWUDi8xM5J8XERJdN1R+BAlLvyq0lEkVS409zmCWPb/
 G0Kx4jYbodlf6+emOSkqFxxpPLdM+WngxDuI55dKBDbQ
X-Google-Smtp-Source: APiQypIih9FhR2EsA1pCqm0O18HMo0XdSmCwxLQ313IKUsa3b9YY8xGxyLS83cK5w0NRvoZ+VqxmYyReiRLMOAMJ2uE=
X-Received: by 2002:a9d:6e81:: with SMTP id a1mr11753718otr.360.1586724338965; 
 Sun, 12 Apr 2020 13:45:38 -0700 (PDT)
MIME-Version: 1.0
From: Oliver Christopher <adultjiuice@gmail.com>
Date: Sun, 12 Apr 2020 16:45:28 -0400
Message-ID: <CAJAyOaarDVp_Qaqn45ML+KqfidyCH=wQG36VZn=f1wh1+nBumw@mail.gmail.com>
Subject: Clarification of above code
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000094a15005a31e0c54"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::330
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000094a15005a31e0c54
Content-Type: text/plain; charset="UTF-8"

/* * We default to false if we know other options have been enabled *
which are currently incompatible with MTTCG. Otherwise when each *
guest (target) has been updated to support: *   - atomic instructions
*   - memory ordering primitives (barriers) * they can set the
appropriate CONFIG flags in ${target}-softmmu.mak * * Once a guest
architecture has been converted to the new primitives * there are two
remaining limitations to check. * * - The guest can't be oversized
(e.g. 64 bit guest on 32 bit host) * - The host must have a stronger
memory order than the guest * * It may be possible in future to
support strong guests on weak hosts * but that will require tagging
all load/stores in a guest with their * implicit memory order
requirements which would likely slow things * down a lot. */
static bool check_tcg_memory_orders_compatible(void)
{
#if defined(TCG_GUEST_DEFAULT_MO) && defined(TCG_TARGET_DEFAULT_MO)
    return (TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO) == 0;
#else
    return false;
#endif
}

That function will return false for x86_64 on ARM64.

On tcg/aarch64/tcg-target.h

#define TCG_TARGET_DEFAULT_MO (0)

On target/i386/cpu.h

/* The x86 has a strong memory model with some store-after-load re-ordering */
#define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)

I am asking for clarification because the above code will default x86 on
ARM64 to disable MTTCG.

--00000000000094a15005a31e0c54
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<span style=3D"color:rgb(36,41,46);font-family:-apple-system,BlinkMacSystem=
Font,&quot;Segoe UI&quot;,Helvetica,Arial,sans-serif,&quot;Apple Color Emoj=
i&quot;,&quot;Segoe UI Emoji&quot;;font-size:14px;background-color:rgb(255,=
255,255)"><div dir=3D"auto"><div class=3D"highlight highlight-source-c" sty=
le=3D"box-sizing:border-box;margin-bottom:16px;overflow:visible!important" =
dir=3D"auto"><pre style=3D"box-sizing:border-box;font-family:SFMono-Regular=
,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:11.89999961=
8530273px;margin-top:0px;margin-bottom:0px;word-wrap:normal;padding:16px;ov=
erflow:auto;line-height:1.45;background-color:rgb(246,248,250);border-top-l=
eft-radius:3px;border-top-right-radius:3px;border-bottom-right-radius:3px;b=
order-bottom-left-radius:3px;word-break:normal"><span class=3D"pl-c" style=
=3D"box-sizing:border-box;color:rgb(106,115,125)">/*</span>
<span class=3D"pl-c" style=3D"box-sizing:border-box;color:rgb(106,115,125)"=
> * We default to false if we know other options have been enabled</span>
<span class=3D"pl-c" style=3D"box-sizing:border-box;color:rgb(106,115,125)"=
> * which are currently incompatible with MTTCG. Otherwise when each</span>
<span class=3D"pl-c" style=3D"box-sizing:border-box;color:rgb(106,115,125)"=
> * guest (target) has been updated to support:</span>
<span class=3D"pl-c" style=3D"box-sizing:border-box;color:rgb(106,115,125)"=
> *   - atomic instructions</span>
<span class=3D"pl-c" style=3D"box-sizing:border-box;color:rgb(106,115,125)"=
> *   - memory ordering primitives (barriers)</span>
<span class=3D"pl-c" style=3D"box-sizing:border-box;color:rgb(106,115,125)"=
> * they can set the appropriate CONFIG flags in ${target}-softmmu.mak</spa=
n>
<span class=3D"pl-c" style=3D"box-sizing:border-box;color:rgb(106,115,125)"=
> *</span>
<span class=3D"pl-c" style=3D"box-sizing:border-box;color:rgb(106,115,125)"=
> * Once a guest architecture has been converted to the new primitives</spa=
n>
<span class=3D"pl-c" style=3D"box-sizing:border-box;color:rgb(106,115,125)"=
> * there are two remaining limitations to check.</span>
<span class=3D"pl-c" style=3D"box-sizing:border-box;color:rgb(106,115,125)"=
> *</span>
<span class=3D"pl-c" style=3D"box-sizing:border-box;color:rgb(106,115,125)"=
> * - The guest can&#39;t be oversized (e.g. 64 bit guest on 32 bit host)</=
span>
<span class=3D"pl-c" style=3D"box-sizing:border-box;color:rgb(106,115,125)"=
> * - The host must have a stronger memory order than the guest</span>
<span class=3D"pl-c" style=3D"box-sizing:border-box;color:rgb(106,115,125)"=
> *</span>
<span class=3D"pl-c" style=3D"box-sizing:border-box;color:rgb(106,115,125)"=
> * It may be possible in future to support strong guests on weak hosts</sp=
an>
<span class=3D"pl-c" style=3D"box-sizing:border-box;color:rgb(106,115,125)"=
> * but that will require tagging all load/stores in a guest with their</sp=
an>
<span class=3D"pl-c" style=3D"box-sizing:border-box;color:rgb(106,115,125)"=
> * implicit memory order requirements which would likely slow things</span=
>
<span class=3D"pl-c" style=3D"box-sizing:border-box;color:rgb(106,115,125)"=
> * down a lot.</span>
<span class=3D"pl-c" style=3D"box-sizing:border-box;color:rgb(106,115,125)"=
> <span class=3D"pl-c" style=3D"box-sizing:border-box">*/</span></span>

<span class=3D"pl-k" style=3D"box-sizing:border-box;color:rgb(215,58,73)">s=
tatic</span> <span class=3D"pl-k" style=3D"box-sizing:border-box;color:rgb(=
215,58,73)">bool</span> <span class=3D"pl-en" style=3D"box-sizing:border-bo=
x;color:rgb(111,66,193)">check_tcg_memory_orders_compatible</span>(<span cl=
ass=3D"pl-k" style=3D"box-sizing:border-box;color:rgb(215,58,73)">void</spa=
n>)
{
#<span class=3D"pl-k" style=3D"box-sizing:border-box;color:rgb(215,58,73)">=
if</span> defined(TCG_GUEST_DEFAULT_MO) &amp;&amp; defined(TCG_TARGET_DEFAU=
LT_MO)
    <span class=3D"pl-k" style=3D"box-sizing:border-box;color:rgb(215,58,73=
)">return</span> (TCG_GUEST_DEFAULT_MO &amp; ~TCG_TARGET_DEFAULT_MO) =3D=3D=
 <span class=3D"pl-c1" style=3D"box-sizing:border-box;color:rgb(0,92,197)">=
0</span>;
#<span class=3D"pl-k" style=3D"box-sizing:border-box;color:rgb(215,58,73)">=
else</span>
    <span class=3D"pl-k" style=3D"box-sizing:border-box;color:rgb(215,58,73=
)">return</span> <span class=3D"pl-c1" style=3D"box-sizing:border-box;color=
:rgb(0,92,197)">false</span>;
#<span class=3D"pl-k" style=3D"box-sizing:border-box;color:rgb(215,58,73)">=
endif</span>
}</pre></div><p style=3D"box-sizing:border-box;margin-top:0px;margin-bottom=
:16px">That function will return false for x86_64 on ARM64.</p><p style=3D"=
box-sizing:border-box;margin-top:0px;margin-bottom:16px">On=C2=A0<code styl=
e=3D"box-sizing:border-box;font-family:SFMono-Regular,Consolas,&quot;Libera=
tion Mono&quot;,Menlo,monospace;font-size:11.899999618530273px;padding:0.2e=
m 0.4em;margin:0px;background-color:rgba(27,31,35,0.05);border-top-left-rad=
ius:3px;border-top-right-radius:3px;border-bottom-right-radius:3px;border-b=
ottom-left-radius:3px">tcg/aarch64/tcg-target.h</code></p><div class=3D"hig=
hlight highlight-source-c" style=3D"box-sizing:border-box;margin-bottom:16p=
x;overflow:visible!important" dir=3D"auto"><pre style=3D"box-sizing:border-=
box;font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,m=
onospace;font-size:11.899999618530273px;margin-top:0px;margin-bottom:0px;wo=
rd-wrap:normal;padding:16px;overflow:auto;line-height:1.45;background-color=
:rgb(246,248,250);border-top-left-radius:3px;border-top-right-radius:3px;bo=
rder-bottom-right-radius:3px;border-bottom-left-radius:3px;word-break:norma=
l">#<span class=3D"pl-k" style=3D"box-sizing:border-box;color:rgb(215,58,73=
)">define</span> <span class=3D"pl-en" style=3D"box-sizing:border-box;color=
:rgb(111,66,193)">TCG_TARGET_DEFAULT_MO</span> (<span class=3D"pl-c1" style=
=3D"box-sizing:border-box;color:rgb(0,92,197)">0</span>)</pre></div><p styl=
e=3D"box-sizing:border-box;margin-top:0px;margin-bottom:16px">On=C2=A0<code=
 style=3D"box-sizing:border-box;font-family:SFMono-Regular,Consolas,&quot;L=
iberation Mono&quot;,Menlo,monospace;font-size:11.899999618530273px;padding=
:0.2em 0.4em;margin:0px;background-color:rgba(27,31,35,0.05);border-top-lef=
t-radius:3px;border-top-right-radius:3px;border-bottom-right-radius:3px;bor=
der-bottom-left-radius:3px">target/i386/cpu.h</code></p><div class=3D"highl=
ight highlight-source-c" style=3D"box-sizing:border-box;margin-bottom:16px;=
overflow:visible!important" dir=3D"auto"><pre style=3D"box-sizing:border-bo=
x;font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,mon=
ospace;font-size:11.899999618530273px;margin-top:0px;margin-bottom:0px;word=
-wrap:normal;padding:16px;overflow:auto;line-height:1.45;background-color:r=
gb(246,248,250);border-top-left-radius:3px;border-top-right-radius:3px;bord=
er-bottom-right-radius:3px;border-bottom-left-radius:3px;word-break:normal"=
><span class=3D"pl-c" style=3D"box-sizing:border-box;color:rgb(106,115,125)=
"><span class=3D"pl-c" style=3D"box-sizing:border-box">/*</span> The x86 ha=
s a strong memory model with some store-after-load re-ordering <span class=
=3D"pl-c" style=3D"box-sizing:border-box">*/</span></span>
#<span class=3D"pl-k" style=3D"box-sizing:border-box;color:rgb(215,58,73)">=
define</span> <span class=3D"pl-en" style=3D"box-sizing:border-box;color:rg=
b(111,66,193)">TCG_GUEST_DEFAULT_MO</span>      (TCG_MO_ALL &amp; ~TCG_MO_S=
T_LD)</pre></div></div><div dir=3D"auto">I am asking for clarification beca=
use the above code will default x86 on ARM64 to disable MTTCG.</div></span>

--00000000000094a15005a31e0c54--

