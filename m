Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CEEC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:02:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3319206C2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3PsecfX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3319206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHlO5-0004GA-1Y
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 05:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60493)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1iHlMG-0003Bu-BZ
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:00:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1iHlMB-0004gb-2R
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:00:40 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:41795)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1iHlMA-0004ez-UF; Tue, 08 Oct 2019 05:00:35 -0400
Received: by mail-yb1-xb42.google.com with SMTP id 206so5643309ybc.8;
 Tue, 08 Oct 2019 02:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KityKsHZrOQodKrg5hE8kA9mZCthnEQ4reQqbLW1gA0=;
 b=f3PsecfXuRJnMJNHrxlAwnHKJEMAENfSchPfCSGJN0Hj4UEqjZ0CqacTgXXnAFQgn2
 OSNQagtCA96x59mQPvm1CDJabi4Jod8QA4uUuotnTRWcWy/Z9iHFsjelJMprJZiK2zEg
 sTjGwgzm6kY+yGiyrHoEGkoGy/4hGIVzZaO5XE039b+AKY/PqDbvTl1XoyUPg/xTgeMw
 WFPE3q9tI9856y9khQcQhkPW+41cP1dOTpZR4VhN/IWmzLOXH/gAULHZ7/56cZI0bnf0
 qBRZtOeVoSmRsXTY6L73oqgwf4BzJblyvQUuFw7BseejZTYrD9SLegvgD1tdFvahmgLA
 omSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KityKsHZrOQodKrg5hE8kA9mZCthnEQ4reQqbLW1gA0=;
 b=B/Tn/MVzE9NQZGFIBqG5jLrEeMzO94aE/p7GPIBYlbND/+539PzP/e7/NeX2dI1G+w
 zT910wu/sRovKVie6F6UjjexMXmJItAuwnEQXvITuipO+j7XeQ/N0uqod2N9Vo+wOlu+
 Vv90VR7WHijGuLnkzHuFxvxJ7yS9vBnOs5ArGss3ATdv5Yvdq2+tymya8u+NQVSlTJNJ
 dTfcjpu9EeykpNvUPpsXrkDjFvyAPJK4L/FEgFLiT9QkndxtDBTYY5G3/CFkLwloMlXh
 c4elBPAwdxWeooISwRMXs9lJjc/xaPibSXQ8tsaF5/9LVm2bID7ZnrteGRaSK5Zicem1
 4x/A==
X-Gm-Message-State: APjAAAX5dsmk5zrFT6Q4wMhjDVN9yyPZGoTrK/cm6RYM5mHWEeT9lWkH
 ex2Omq7CXlDfIvQ2B1kWVkIlv6B01OgG+G2mUIk=
X-Google-Smtp-Source: APXvYqxjWjrFqPbh1q+WOZAvlXibXIeirCN15UP+5bBIoe7nh6jzUIYtKAjYeAlLAnxvOINeageA07XUX3GfHMSpezk=
X-Received: by 2002:a25:bfc4:: with SMTP id q4mr2289949ybm.29.1570525233594;
 Tue, 08 Oct 2019 02:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191004151614.81516-1-jonathan@fintelia.io>
 <5393a150-71b6-a729-7530-a50df05353bd@sifive.com>
In-Reply-To: <5393a150-71b6-a729-7530-a50df05353bd@sifive.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 8 Oct 2019 17:00:20 +0800
Message-ID: <CAEUhbmXXwZTu2rJ7Oen4mVSBjp+-7Jd7WBpmds1xm9m-tR+Q-A@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: Expose "priv" register for GDB
To: Jim Wilson <jimw@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
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
 Jonathan Behrens <jonathan@fintelia.io>, Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jim,

On Tue, Oct 8, 2019 at 5:17 AM Jim Wilson <jimw@sifive.com> wrote:
>
> On 10/4/19 8:16 AM, Jonathan Behrens wrote:
> > diff --git a/gdb-xml/riscv-32bit-cpu.xml b/gdb-xml/riscv-32bit-cpu.xml
> > index 0d07aaec85..d6d76aafd8 100644
> > --- a/gdb-xml/riscv-32bit-cpu.xml
> > +++ b/gdb-xml/riscv-32bit-cpu.xml
> > @@ -44,4 +44,5 @@
> >     <reg name="t5" bitsize="32" type="int"/>
> >     <reg name="t6" bitsize="32" type="int"/>
> >     <reg name="pc" bitsize="32" type="code_ptr"/>
> > +  <reg name="priv" bitsize="32" type="int"/>
> >   </feature>
>
> Adding this to the cpu register set means that the gdb "info registers"
> command will now list a value for the mysterious undocumented "priv"

My gdb does not list "priv" register after applying this patch.

>>> info registers
ra             0x0      0x0
sp             0x0      0x0
gp             0x0      0x0
tp             0x0      0x0
t0             0x1000   4096
t1             0x0      0
t2             0x0      0
fp             0x0      0x0
s1             0x0      0
a0             0x0      0
a1             0x1020   4128
a2             0x0      0
a3             0x0      0
a4             0x0      0
a5             0x0      0
a6             0x0      0
a7             0x0      0
s2             0x0      0
s3             0x0      0
s4             0x0      0
s5             0x0      0
s6             0x0      0
s7             0x0      0
s8             0x0      0
s9             0x0      0
s10            0x0      0
s11            0x0      0
t3             0x0      0
t4             0x0      0
t5             0x0      0
t6             0x0      0
pc             0x1008   0x1008

Anything I was missing?

> register.  That is likely to result in user confusion, and a few gdb bug
> reports.
>
> Gdb incidentally already has support for a virtual priv register.  From
> gdb/riscv-tdep.c:
>
> static const struct riscv_register_feature riscv_virtual_feature =
> {
>   "org.gnu.gdb.riscv.virtual",
>   {
>     { RISCV_PRIV_REGNUM, { "priv" }, false }
>   }
> };
>
> So the correct way to fix this is to add a
> gdb-xml/riscv-32bit-virtual.xml file, along with code to handle this new
> xml file and the registers in it.  Likewise for the 64-bit support.
>
> The main advantage of doing things this way is that only people that
> care about the priv register will see it, and this will interoperate
> with other RISC-V debuggers and targets (if any) that already have
> virtual priv register support.

Regards,
Bin

