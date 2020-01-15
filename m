Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AD0C33CB3
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 14:28:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E4FE2073A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 14:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VJCO24Va"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4FE2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irjep-0003hr-SZ
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 09:28:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shihpo.hung@sifive.com>) id 1irjeE-0003Eu-QB
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 09:27:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shihpo.hung@sifive.com>) id 1irjeD-0007Ru-7v
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 09:27:54 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37037)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shihpo.hung@sifive.com>)
 id 1irjeC-0007QA-W4
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 09:27:53 -0500
Received: by mail-wr1-x442.google.com with SMTP id w15so15972851wru.4
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 06:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TTblYoglIXYAwtNqvTtUQH62e0FOZG9e0GefOBYk3fo=;
 b=VJCO24VaKi3Sza1b+i4wcrl51olDPxWJytBtrTqq2U7olM4++miyjpVQItzgRz6RrA
 QovBeF+N+v9+PX0EY89AoImKsXbCIzyX/Ist8ygjZeDBZ4ZgYIESGPEVq5EZKNWGp4nP
 D8/99MDOFd5xH1bp0V76RMnBn/k6GfaBOskuL0jIUsXdbDLeVQ+VB1UN/WXK2wRArCdH
 MD07Px3gzmNSNavHPn6Z6JRoHfKktcLm9An+ioRjiLV80do9DluGQRPBvR9vSElX7yix
 ahuIV7uTa4IVnSE4RLm6wBbzG/c0a2w1H4nY4ScEbz4/lUH5WPUK8CFxoCdjfJ2Tr9K5
 pt+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TTblYoglIXYAwtNqvTtUQH62e0FOZG9e0GefOBYk3fo=;
 b=pPZazcz/JTY3W4JB+CgzJr50QfH7f2R3VIkjXKrg8Z6/AxKtAVS4HHzjvy2AheuMB+
 pMGdQbsYLRqdBLnDkkR+/a0/pdjLEzarm1bL9Hy2fERwuWWQRZkZim6+mTdm8eBab39x
 RzTKkmPsP47AbfoMWwuV/JeqErUBgdKjEgyhnidwym1UkJXjIsLXtAn9ThoPPujspf2p
 GrrjRBF+BYMP6GVMJ78tbXlivkn2wAdm3VHxZpDHhOL2PKrknyr9chAosuQrBpBZc1hG
 vSI86IkrO59voPTDmryszsls9B0QN4Q5+6NsCfDzhoOr0qpu7/gfEjWDiq+bCup4v2yD
 /gVw==
X-Gm-Message-State: APjAAAWEUaG8vGs0onNTTnKX39W/003hvFPDKKWC6alSzDwl/zKWUQSu
 mCm7tC2fXtRndqUfh+DYkPCLRYg7M3rEFuVuPDwf1w==
X-Google-Smtp-Source: APXvYqz+YWkXkQ0FUbjuO6JaISI1Fx7eSgRHAxIySzvSeqLksyKZr70r/qT7v0pMnZIThR/m+QJhCoUAQ5c3f0LpQIY=
X-Received: by 2002:a05:6000:12:: with SMTP id
 h18mr30011608wrx.87.1579098471220; 
 Wed, 15 Jan 2020 06:27:51 -0800 (PST)
MIME-Version: 1.0
References: <1579069053-22190-1-git-send-email-shihpo.hung@sifive.com>
 <CAKmqyKNeAFRP7eCLtw1b0P53ub3k--+dROpPRynzCwM8DF15ng@mail.gmail.com>
In-Reply-To: <CAKmqyKNeAFRP7eCLtw1b0P53ub3k--+dROpPRynzCwM8DF15ng@mail.gmail.com>
From: ShihPo Hung <shihpo.hung@sifive.com>
Date: Wed, 15 Jan 2020 22:27:39 +0800
Message-ID: <CALoQrwf6FEqKaSC1z3Kf1Mz0E0820dttHUFONE_-pP0U=T77_w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] target/riscv: Fix tb->flags FS status
To: Alistair Francis <alistair23@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000007162f6059c2e83ed"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007162f6059c2e83ed
Content-Type: text/plain; charset="UTF-8"

On Wed, Jan 15, 2020 at 2:29 PM Alistair Francis <alistair23@gmail.com>
wrote:

> > -    *flags = cpu_mmu_index(env, 0);
> > -    if (riscv_cpu_fp_enabled(env)) {
> > -        *flags |= TB_FLAGS_MSTATUS_FS;
> > -    }
> > +    *flags = cpu_mmu_index(env, 0) | (env->mstatus & MSTATUS_FS);
>
> I don't think this is right, you should use the riscv_cpu_fp_enabled()
> function.
>
> Right now it's the same as env->mstatus & MSTATUS_FS but when the
> Hypervisor extension goes in riscv_cpu_fp_enabled() will be more
> complex.
>
> Alistair
>
> I agree using riscv_cpu_fp_enabled() to hide the complexity when checking
FP,
but here I only duplicate the FP status (disabled/initial/clean/dirty) to
tb->flags
no matter FP is enabled or not.

Is it still necessary to check this before duplicating it?

I think it is not as long as TB_FLAGS_MSTATUS_FS is equivalent to
MSTATUS_FS.
But I don't know what changes hypervisor extension brings, please correct
me if I am wrong.

ShihPo

--0000000000007162f6059c2e83ed
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 15, 2020 at 2:29 PM Alist=
air Francis &lt;<a href=3D"mailto:alistair23@gmail.com">alistair23@gmail.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>&gt; -=C2=A0 =C2=A0 *flags =3D cpu_mmu_index(env, 0);<br>
&gt; -=C2=A0 =C2=A0 if (riscv_cpu_fp_enabled(env)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 *flags |=3D TB_FLAGS_MSTATUS_FS;<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 *flags =3D cpu_mmu_index(env, 0) | (env-&gt;mstatus &am=
p; MSTATUS_FS);<br>
<br>
I don&#39;t think this is right, you should use the riscv_cpu_fp_enabled() =
function.<br>
<br>
Right now it&#39;s the same as env-&gt;mstatus &amp; MSTATUS_FS but when th=
e<br>
Hypervisor extension goes in riscv_cpu_fp_enabled() will be more<br>
complex.<br>
<br>
Alistair<br><br></blockquote><div>I agree using riscv_cpu_fp_enabled() to h=
ide the complexity when checking FP,</div><div>but here I only duplicate th=
e FP status (disabled/initial/clean/dirty) to tb-&gt;flags</div><div>no mat=
ter FP is enabled or not.</div><div><br></div><div>Is it still necessary to=
 check this before duplicating it?</div><div><br></div><div>I think it is n=
ot as long as=C2=A0TB_FLAGS_MSTATUS_FS is equivalent=C2=A0to MSTATUS_FS.</d=
iv><div>But I don&#39;t know what changes hypervisor extension brings, plea=
se correct me if I am wrong.</div><div><br></div><div>ShihPo</div><div><br>=
</div></div></div>

--0000000000007162f6059c2e83ed--

