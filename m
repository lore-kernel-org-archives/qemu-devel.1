Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922C7C47404
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 00:21:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B9B320867
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 00:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fintelia.io header.i=@fintelia.io header.b="kxEIBLo4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9B320867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fintelia.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHdFu-0000hN-EJ
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 20:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1iHdEe-0007Z7-Vb
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 20:20:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1iHdEd-0000jS-Lg
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 20:20:16 -0400
Received: from rs224.mailgun.us ([209.61.151.224]:15646)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1iHdEc-0000ak-8N
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 20:20:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=fintelia.io; q=dns/txt;
 s=pic; 
 t=1570494015; h=Content-Type: Cc: To: Subject: Message-ID: Date: From:
 In-Reply-To: References: MIME-Version: Sender;
 bh=drH/zB/QxuxLYhjag3TUJ8W6IlSD6+zPujsecelTy4g=;
 b=kxEIBLo44+3cWExSZlb+EBSk9ge3I/PgE6ox7vIQQgS4nHSU+DdDlxuQ0CjPN4iKU94j6Ji2
 EFYQreCE5odlEBRtgNXmG3LZIO5K4ijPYTBBTmsqesTPOIqVSuQga16VRS0tYJpbjMNR+i2I
 Qv/WCKEIBueFBA4w7N+FP9tLVQnFhgWe3amR85tlhVA1dgBUxOAFLEZ0J4qM2yv9HpG05iwb
 WqP71g5yxuAbcyUREhyIrg2zcsblCujFgWiUbYgcvKsF+8F8pNhZB8jm4pJ4n0Rhvp21iGIO
 T8V6t5zud7w6bBCvYdt1VEV9hvCrfFCJswBMJWVpFkAnUgM72/+/Ug==
X-Mailgun-Sending-Ip: 209.61.151.224
X-Mailgun-Sid: WyJlMGM5NSIsICJxZW11LWRldmVsQG5vbmdudS5vcmciLCAiOWI0ZTc2Il0=
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com
 [209.85.167.44])
 by mxa.mailgun.org with ESMTP id 5d9bd63b.7fc9290a6c30-smtp-out-n03;
 Tue, 08 Oct 2019 00:20:11 -0000 (UTC)
Received: by mail-lf1-f44.google.com with SMTP id w6so10556672lfl.2;
 Mon, 07 Oct 2019 17:20:10 -0700 (PDT)
X-Gm-Message-State: APjAAAUhAofdP49XOq537aOpyGukssYvSCTAbuj89AadGu+ynUge2+sI
 i8wTMVRZApVW6ppzV3v2kYjqagV0TyntxQTNTKY=
X-Google-Smtp-Source: APXvYqyBfTgEh0BR1rr35eQMwULpqoo7uR+NnF1tcafVlI6yVUFS16ok2BQc1xbL8vO1hsiesmig1EB7eHfcgekh8SA=
X-Received: by 2002:ac2:5e9e:: with SMTP id b30mr18321025lfq.5.1570494009704; 
 Mon, 07 Oct 2019 17:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20191004151614.81516-1-jonathan@fintelia.io>
 <5393a150-71b6-a729-7530-a50df05353bd@sifive.com>
In-Reply-To: <5393a150-71b6-a729-7530-a50df05353bd@sifive.com>
From: Jonathan Behrens <jonathan@fintelia.io>
Date: Mon, 7 Oct 2019 20:19:05 -0400
X-Gmail-Original-Message-ID: <CANnJOVG3=O8B0m12dJp7raGAgPPMt8eAvsJ58193A_yeEqPKrw@mail.gmail.com>
Message-ID: <CANnJOVG3=O8B0m12dJp7raGAgPPMt8eAvsJ58193A_yeEqPKrw@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: Expose "priv" register for GDB
To: Jim Wilson <jimw@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.61.151.224
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
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 7, 2019 at 5:17 PM Jim Wilson <jimw@sifive.com> wrote:
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
>
> Jim

Thanks for this suggestion, I've incorporated it into the next version.

Jonathan

