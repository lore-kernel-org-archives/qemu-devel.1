Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E83C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:12:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8138E217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kG11sCTL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8138E217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ituGX-0007aP-T4
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 09:12:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fintelia@gmail.com>) id 1ittJh-0003BN-LY
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:11:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fintelia@gmail.com>) id 1ittJg-0003AZ-BI
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:11:37 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:36570)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <fintelia@gmail.com>)
 id 1ittJd-00038j-Ha; Tue, 21 Jan 2020 08:11:33 -0500
Received: by mail-lf1-x142.google.com with SMTP id f24so2237159lfh.3;
 Tue, 21 Jan 2020 05:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=n+O6NkyOPzJuZtsFRRj/7c77BA+yueZ6QCF2y/JENJk=;
 b=kG11sCTL3MU7NnD3BW1oqiYi+hEIMLpM18ci+2T8TaIvokMMhmRlxboCXhIck8rNG+
 KKfBgoeyL6laTnUO5Qw0+LcRfcXd8Rl0DoiFBu6eImpuKdFy2cT1Tz8JYwvxgOvwY29F
 i7WsvSW3c2MepzTvOa8d99uH+yCS6e1IkocjXzbhgRmaz57fkh93WJCz2At7Oshr+yvM
 4otBefH7N5tLxF0kIm0xMzhqg+AAoToNMA0/perPluKeBnIpZtXBRg9UBgrQzeeHTKIf
 7Ka7OWV87TayoDJuyg1ZdVdP/Z/wvcT9U0Xp44Je5Wmfug4XAQYetqOyK8QaurhOonwZ
 v0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n+O6NkyOPzJuZtsFRRj/7c77BA+yueZ6QCF2y/JENJk=;
 b=gfuGZbMLwgOT4X9MgcPpTFgfHbVUck1wS6CgjMokhdFb7EJucPbyK1inQrbO3rQRx4
 B1lgCmXf+PulgbR4N1MquyfH6thmLj1Y70FcEumX/GcETzb4zmL00b9nxRzU1sH/yekl
 zPQ/BjLcQCdyGrpaFhYwnQDBAO6wWXFW2YxklFuKctPrIIfnZWlpcxcLq+Wgx//GCIjB
 X4BBw7x1y30OJfzRZWy4Li8Sf7mSJ4HAs2KqQBmBWWRnr3mefjbCKqGWtQOEDxPPy3n+
 QnvggT9asjKYRrjI+pfg8z8Zc3xiWLEzuZps4NEGlYvgBwvZTRIqi3DYZMl6ETaQ29mW
 9//A==
X-Gm-Message-State: APjAAAUCRWAwi/Lbi26FHIFgT9lwZufH2p1yf9L5dMKOZvNKZQq3kvWq
 2tpmvSNCpwZLfPOAcxCTD5XQtUkbzP1chRmD/Hw=
X-Google-Smtp-Source: APXvYqwedYNY8e5XcfSJOmahUhBfbirEy3W7iG0UhfonbcZ/sXWmb5bnImgV1cj8Q/+UKFpDuvZBmx1GQtc7PQAUeTs=
X-Received: by 2002:a19:5503:: with SMTP id n3mr2649930lfe.136.1579612291830; 
 Tue, 21 Jan 2020 05:11:31 -0800 (PST)
MIME-Version: 1.0
References: <20200121085910.28834-1-anup.patel@wdc.com>
In-Reply-To: <20200121085910.28834-1-anup.patel@wdc.com>
From: Jonathan Behrens <fintelia@gmail.com>
Date: Tue, 21 Jan 2020 08:11:05 -0500
Message-ID: <CANnJOVHw=-yL2=j3L2XNkqYjDGnULkc-NQRzuWm2k=BWRH7EGQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] RISC-V TIME CSR for privileged mode
To: Anup Patel <Anup.Patel@wdc.com>
Content-Type: multipart/alternative; boundary="0000000000008997d5059ca625e4"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008997d5059ca625e4
Content-Type: text/plain; charset="UTF-8"

This series doesn't seem to touch mcounteren.TM which should be hardwired
to zero if no callback in provided, and writable otherwise. (I had a patch
to do the hardwiring unconditionally, but it seems to have been
accidentally dropped.) Other than that, I think the design is quite good.

Jonathan

On Tue, Jan 21, 2020 at 3:59 AM Anup Patel <Anup.Patel@wdc.com> wrote:

> This series adds emulation of TIME CSRs for privileged mode. With
> this series, we see approximately 25+% improvement in hackbench
> numbers for non-virtualized (or Host) Linux and 40+% improvement
> in hackbench numbers for Guest/VM Linux.
>
> These patches are based on mainline/alistair/riscv-hyp-ext-v0.5.1
> branch of https://github.com/kvm-riscv/qemu.git and can be found
> in riscv_time_csr_v1 branch of same repo.
>
> Anup Patel (2):
>   target/riscv: Emulate TIME CSRs for privileged mode
>   hw/riscv: Provide rdtime callback for TCG in CLINT emulation
>
>  hw/riscv/sifive_clint.c   |  1 +
>  target/riscv/cpu.h        |  5 +++
>  target/riscv/cpu_helper.c |  5 +++
>  target/riscv/csr.c        | 80 +++++++++++++++++++++++++++++++++++++--
>  4 files changed, 87 insertions(+), 4 deletions(-)
>
> --
> 2.17.1
>
>
>

--0000000000008997d5059ca625e4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>This series doesn&#39;t seem to touch mcounteren.TM w=
hich should be hardwired to zero if no callback in provided, and writable o=
therwise. (I had a patch to do the hardwiring unconditionally, but it seems=
 to have been accidentally dropped.) Other than that, I think the design is=
 quite good.</div><div><br></div><div>Jonathan<br></div></div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jan 21, 202=
0 at 3:59 AM Anup Patel &lt;<a href=3D"mailto:Anup.Patel@wdc.com">Anup.Pate=
l@wdc.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">This series adds emulation of TIME CSRs for privileged mode. Wit=
h<br>
this series, we see approximately 25+% improvement in hackbench<br>
numbers for non-virtualized (or Host) Linux and 40+% improvement<br>
in hackbench numbers for Guest/VM Linux.<br>
<br>
These patches are based on mainline/alistair/riscv-hyp-ext-v0.5.1<br>
branch of <a href=3D"https://github.com/kvm-riscv/qemu.git" rel=3D"noreferr=
er" target=3D"_blank">https://github.com/kvm-riscv/qemu.git</a> and can be =
found<br>
in riscv_time_csr_v1 branch of same repo.<br>
<br>
Anup Patel (2):<br>
=C2=A0 target/riscv: Emulate TIME CSRs for privileged mode<br>
=C2=A0 hw/riscv: Provide rdtime callback for TCG in CLINT emulation<br>
<br>
=C2=A0hw/riscv/sifive_clint.c=C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0target/riscv/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 5 +++<br>
=C2=A0target/riscv/cpu_helper.c |=C2=A0 5 +++<br>
=C2=A0target/riscv/csr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 80 ++++++++++++++++++=
+++++++++++++++++++--<br>
=C2=A04 files changed, 87 insertions(+), 4 deletions(-)<br>
<br>
-- <br>
2.17.1<br>
<br>
<br>
</blockquote></div>

--0000000000008997d5059ca625e4--

