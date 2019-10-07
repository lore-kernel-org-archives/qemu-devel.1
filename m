Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE40ECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 18:44:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB02920684
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 18:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=berkeley-edu.20150623.gappssmtp.com header.i=@berkeley-edu.20150623.gappssmtp.com header.b="iGcgrGOC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB02920684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=berkeley.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHXzj-0002V4-QK
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 14:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dayeol@berkeley.edu>) id 1iHXwy-0001jv-J0
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 14:41:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dayeol@berkeley.edu>) id 1iHXww-0006R3-Qg
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 14:41:40 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45311)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dayeol@berkeley.edu>) id 1iHXww-0006Qf-HN
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 14:41:38 -0400
Received: by mail-pf1-x443.google.com with SMTP id y72so9167497pfb.12
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 11:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=berkeley-edu.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KJzG2axKoZkgi+l/x9Y+YilciqreDl/CMUAdZrHp2aw=;
 b=iGcgrGOCKgHnYj0SOxs4byq0fzbx3qX+oOOzRHokaMHdEiD8mDY6Q3JygO931nMbqJ
 fzWFuzu8hPpdhWk9JEnpE9d6x6zzAzcKHAEg2Na+INFJAhv2R6MjZtcaHYVNgf4QI37D
 DJHpuk9lHL1TtvncnkAmP+sOVvxQxpuOEpdJj6gkcHoVTyTXvsbvxUILntTXb9dQ8gcf
 Z6LRr/tYlTaRBPD1Hfdz+sKjaKSnjMpdbfjjuufDgw5Vt+YvzSTKtUSVrbtfDlneELT8
 I1c74nccf5kKFy1rhccOhr50gar9wY4rJrAUbthHyDcAJkW6rmbxmppVpHe0BJjFH4+z
 21Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KJzG2axKoZkgi+l/x9Y+YilciqreDl/CMUAdZrHp2aw=;
 b=McRW9dQw7l+iMbYbr0P1vuy7PKEOdyKX6cW/j5ZyFTYBFikA/MrQI35C4daJSGE55c
 T6cWCbknxapoZQtFZVPD6Ljs1Sku1atenXzG+X4gPbve4SfjmftlbwHduUZ/bySnD9r+
 Di1lPdWnnlGttxpTI+3ns61WSOdAevCi94pOfLUwCQJCz+vjC7RfI7FZCkh1wQJ6BBCF
 I4jPOnqm3KnVkDLmcZcLMThcfaSPKyvyLXrNHltUPK6KuTg2AESVpalyGRIeAX40n7dM
 vEsklGq8n2lWjeO/2zty43Dogp7GpPpff8LDZ5Zw9AjcqAa+ELugg7Pk6nUk3g645Ktz
 PPHA==
X-Gm-Message-State: APjAAAVe3qYfVvbS/1ZXsrUy8zVITFzMjK86hkCVUkuPahHWf7fO5MCf
 bJTh+IPbsmMn30wl+mSzDPqBstKKY/X2eW1tadOMGg==
X-Google-Smtp-Source: APXvYqy56w92ZslacwtCzrc4WCV82EQC6F0vE5pppvDkBeVbKt5gFBFOxqcL+j6uZvTu+A5wjfNQqF6iLd1S+OS1L5I=
X-Received: by 2002:aa7:8816:: with SMTP id c22mr25727116pfo.197.1570473697061; 
 Mon, 07 Oct 2019 11:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20191007052813.25814-1-dayeol@berkeley.edu>
 <5583387c-5c5b-8890-999b-2ba4d75cd69d@linaro.org>
 <CACjxMEsw+Deh176JLP2aF4Pdkb_s8MiPApwMON-_K6ed61-Zyw@mail.gmail.com>
 <3747223d-23ee-1f28-e165-b2b0c5746b68@linaro.org>
In-Reply-To: <3747223d-23ee-1f28-e165-b2b0c5746b68@linaro.org>
From: Dayeol Lee <dayeol@berkeley.edu>
Date: Mon, 7 Oct 2019 11:41:26 -0700
Message-ID: <CACjxMEtPRxTQdOYFL97G7aYXC6KTBuGY2avf1bPJLYGEpURh=Q@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: PMP violation due to wrong size parameter
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000d7ce0905945666d7"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d7ce0905945666d7
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 7, 2019 at 11:25 AM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 10/7/19 10:19 AM, Dayeol Lee wrote:
> > Thank you very much for the clarification!
> >
> > I found tlb_set_page with size != TARGET_PAGE_SIZE makes the translation
> way
> > too slow; the Linux doesn't seem to boot.
>
> To clarify, PMP specifies a range.  That range has only two end points.
> Therefore, a maximum of 2 pages may be affected by a mis-aligned PMP
> boundary.
>
> It sounds like you're getting size != TARGET_PAGE_SIZE for all pages.
>
>
The cause of the problem is not a mis-aligned PMP boundary.
Let's say a PMP range is 0x1000 - 0x2000
if pmp_hart_has_privs() gets addr=0x2000 and size=0,
pmp_hart_has_privs() will ALWAYS return false because the code assumes size
> 0.
It checks if (addr) and (addr + size - 1) are within the PMP range for each
PMP entry.
(addr + size - 1) is supposed to be the last byte address of the memory
access, but it ends up with (addr - 1) if size = 0.
Thus, pmp_hart_has_privs() returns false as (addr - 1) = 0x1fff is within
the range, and addr = 0x2000 is out of the range (partial match violation).

--000000000000d7ce0905945666d7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Mon, Oct 7, 2019 at 11:25 AM Richard H=
enderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.hender=
son@linaro.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">On 10/7/19 10:19 AM, Dayeol Lee wr=
ote:<br>
&gt; Thank you very much for the clarification!<br>
&gt; <br>
&gt; I found tlb_set_page with size !=3D TARGET_PAGE_SIZE makes the transla=
tion way<br>
&gt; too slow; the Linux doesn&#39;t seem to boot.<br>
<br>
To clarify, PMP specifies a range.=C2=A0 That range has only two end points=
.<br>
Therefore, a maximum of 2 pages may be affected by a mis-aligned PMP bounda=
ry.<br>
<br>
It sounds like you&#39;re getting size !=3D TARGET_PAGE_SIZE for all pages.=
<br><br></blockquote><div><br></div><div>The cause of the problem is not a =
mis-aligned PMP boundary.</div><div>Let&#39;s say a PMP range is 0x1000 - 0=
x2000</div><div>if pmp_hart_has_privs() gets addr=3D0x2000 and size=3D0,</d=
iv><div>pmp_hart_has_privs() will ALWAYS return false because the code assu=
mes size &gt; 0.</div><div>It checks if (addr) and (addr=C2=A0+ size - 1) a=
re within the PMP range for each PMP entry.</div><div>(addr=C2=A0+ size - 1=
) is supposed to be the last byte address of the memory access, but it ends=
 up with (addr - 1) if size =3D 0.</div><div>Thus, pmp_hart_has_privs() ret=
urns false as (addr - 1) =3D 0x1fff is within the range, and addr =3D 0x200=
0 is out of the range (partial match violation).</div><div><br></div><div><=
br></div><div><br></div></div></div>

--000000000000d7ce0905945666d7--

