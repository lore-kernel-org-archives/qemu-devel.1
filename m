Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EBBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 17:33:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7B0922243
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 17:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjHxFeSs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B0922243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT77g-0004IV-2R
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 13:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kT75r-0003mj-Q5; Thu, 15 Oct 2020 13:31:13 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:38205)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kT75n-0006rM-TO; Thu, 15 Oct 2020 13:31:11 -0400
Received: by mail-lf1-x141.google.com with SMTP id c141so4531711lfg.5;
 Thu, 15 Oct 2020 10:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zyytIOO5R33ysXqjAIRHIwAoKg2+d8xF+w+BqsehKeI=;
 b=gjHxFeSsHvK9gM7+sJLBLgyuuL4OT9EiOwoxLqOVVGjL5SJueAbeOiQDazWIcQSInI
 sE25Pj49FILYQTXs5jOLlOjkE94i23r/2t3SGpCr++dbV4C7ol5BLI/ilwoP3xC42pun
 m2zEzXxyxTqlRuxBQa7WehwgiTctIP5nKGhzz/itSDDanv6PggUnRiwx0YpXI6YTqot4
 UoXEkLsvbPGQxRqxzl7/wysZKqNEqY5xJCFeYyZK6XrZaW8XSPV/T200ebltYNaWEBCE
 j6mKYLJw6IO9hP5eHNDSxx4Q7EyltU5GdJVpKL/cuvs+Lq869kgPuPK1+ndpfQywit3t
 LGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zyytIOO5R33ysXqjAIRHIwAoKg2+d8xF+w+BqsehKeI=;
 b=qtRzzwrArOsx8UqM5Ud1fzIEultLENZpQ8xkFWjpIRUy0N0MxRcfUzBWBxwDeP3G8c
 jXh/EG+Jx6EqOF76QgGYJb7Zbm3l8ROiwYe8chlT7Uwl9Orh3iPIaNTYSq3TzjHzgKCQ
 CW2A3Wo3jvMapvIakOCAwUXutdVaaP9BYwWG1y4yCrUR8z4+4OdPznvGlJrTSbjYboeX
 DLTioxME7Rm+3mkR/eiXAOHaDIRKh98lunvJGqCNpWCUKKPSVFA3gLx7frs8Yf+G4h6X
 KCXOhvIa0Ug7bDck7uAPr7gDLWw3yFAmlxWj8RgYG2ApQA3byM5UwPrcHz/i+4Di+w0r
 +DAA==
X-Gm-Message-State: AOAM533kstcEgNWWcvStwQa3igNmt8IlYuHxVPtSCVuaFmf/jXr5zE/w
 3fnS8zkPioPAYCTfhopl/JI+Nnm6Y0SyIW2cZKU=
X-Google-Smtp-Source: ABdhPJyxrVfBli3FVI+BiRCrNTSRyL6MyP+RucoA303GVXZO3fEskHGnNs2VLaoUIb6USLywn2foQFyq89DjPH5d4+g=
X-Received: by 2002:ac2:4422:: with SMTP id w2mr1357853lfl.219.1602783065424; 
 Thu, 15 Oct 2020 10:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201015152139.28903-1-space.monkey.delivers@gmail.com>
 <20201015152139.28903-4-space.monkey.delivers@gmail.com>
 <9d7e10ff-b560-4f16-9f53-516dc26156a0@linaro.org>
In-Reply-To: <9d7e10ff-b560-4f16-9f53-516dc26156a0@linaro.org>
From: Alexey Baturo <baturo.alexey@gmail.com>
Date: Thu, 15 Oct 2020 20:30:51 +0300
Message-ID: <CAFukJ-C81rO_SGcXmXb-wZfs7X__ah+cw6BEXVvEHe62UAywJA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] [RISCV_PM] Support pointer masking for RISC-V for
 i/c/f/d/a types of instructions
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000044461b05b1b9039f"
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 GAPPY_SUBJECT=0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "space.monkey.delivers@gmail.com" <space.monkey.delivers@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Dave Smith <kupokupokupopo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000044461b05b1b9039f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

That's a great question, but unfortunately, I don't have an answer for it
now.
Let me ask it on J WG meeting that would happen next Monday along with
extension naming and CSR numbers(hopefuly).

Thanks!

=D1=87=D1=82, 15 =D0=BE=D0=BA=D1=82. 2020 =D0=B3. =D0=B2 20:00, Richard Hen=
derson <richard.henderson@linaro.org
>:

> On 10/15/20 8:21 AM, Alexey Baturo wrote:
> > Signed-off-by: Alexey Baturo <space.monkey.delivers@gmail.com>
> > ---
> >  target/riscv/insn_trans/trans_rva.c.inc |  3 +++
> >  target/riscv/insn_trans/trans_rvd.c.inc |  2 ++
> >  target/riscv/insn_trans/trans_rvf.c.inc |  2 ++
> >  target/riscv/insn_trans/trans_rvi.c.inc |  2 ++
> >  target/riscv/translate.c                | 14 ++++++++++++++
> >  5 files changed, 23 insertions(+)
>
> Looks ok.
>
> It does occur to me to wonder how this is intended to work with unaligned
> addresses, or large memory operations such as with RVV.
>
> Without changes in the generic tcg code, an unaligned memory op that
> crosses
> the mask will not wrap the second half.  E.g.
>
>   upmbase =3D 0
>   upmmask =3D 0xffff
>   address =3D 0xfffe
>   size    =3D 8
>
> will read [0x10005 : 0xfffe] and not
> [0x0005 : 0x0000] | [0xffff : 0xfffe] as a true wrapping would lead you d=
o
> believe.
>
>
> r~
>

--00000000000044461b05b1b9039f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">That&#39;s a great question, but unfortunately,=C2=A0I don=
&#39;t have an answer for it now.<div>Let me ask it on J WG meeting that wo=
uld happen next Monday along with extension naming and CSR numbers(hopefuly=
).</div><div><br></div><div>Thanks!</div></div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">=D1=87=D1=82, 15 =D0=BE=D0=BA=D1=
=82. 2020 =D0=B3. =D0=B2 20:00, Richard Henderson &lt;<a href=3D"mailto:ric=
hard.henderson@linaro.org">richard.henderson@linaro.org</a>&gt;:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">On 10/15/20 8:21 AM, Alexe=
y Baturo wrote:<br>
&gt; Signed-off-by: Alexey Baturo &lt;<a href=3D"mailto:space.monkey.delive=
rs@gmail.com" target=3D"_blank">space.monkey.delivers@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 target/riscv/insn_trans/trans_rva.c.inc |=C2=A0 3 +++<br>
&gt;=C2=A0 target/riscv/insn_trans/trans_rvd.c.inc |=C2=A0 2 ++<br>
&gt;=C2=A0 target/riscv/insn_trans/trans_rvf.c.inc |=C2=A0 2 ++<br>
&gt;=C2=A0 target/riscv/insn_trans/trans_rvi.c.inc |=C2=A0 2 ++<br>
&gt;=C2=A0 target/riscv/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 14 ++++++++++++++<br>
&gt;=C2=A0 5 files changed, 23 insertions(+)<br>
<br>
Looks ok.<br>
<br>
It does occur to me to wonder how this is intended to work with unaligned<b=
r>
addresses, or large memory operations such as with RVV.<br>
<br>
Without changes in the generic tcg code, an unaligned memory op that crosse=
s<br>
the mask will not wrap the second half.=C2=A0 E.g.<br>
<br>
=C2=A0 upmbase =3D 0<br>
=C2=A0 upmmask =3D 0xffff<br>
=C2=A0 address =3D 0xfffe<br>
=C2=A0 size=C2=A0 =C2=A0 =3D 8<br>
<br>
will read [0x10005 : 0xfffe] and not<br>
[0x0005 : 0x0000] | [0xffff : 0xfffe] as a true wrapping would lead you do =
believe.<br>
<br>
<br>
r~<br>
</blockquote></div>

--00000000000044461b05b1b9039f--

