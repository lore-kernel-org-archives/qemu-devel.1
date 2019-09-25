Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E643C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:57:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 096C021D7A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZuaLyr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096C021D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD9fy-0006rh-4R
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 11:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36387)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoren@kernel.org>) id 1iD9V5-0003mh-FU
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:46:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoren@kernel.org>) id 1iD9V3-0008Q7-7J
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:46:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56088)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoren@kernel.org>)
 id 1iD9V3-0008Pq-16; Wed, 25 Sep 2019 11:46:41 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7309321D7B;
 Wed, 25 Sep 2019 15:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569426399;
 bh=kS7iHUZBpobHHkcL44QM2SKtkOCrqXA0YtmVeoaDbz8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=YZuaLyr0gKuVE+nchojFLfvvZdxpN/BuNsCashVgn+4u1V7JP5Qa49Hxnmkn3AeI+
 t1CSWuOi7qF/XZNzicpenUYnUN6/B9sY9svroIz8cDJjs1bEn1gec7vEUajXjk6i+z
 ARNmK+9lDiPaQSfAa+qfJh6NSxjoDRX7mfWYu1Kw=
Received: by mail-wm1-f45.google.com with SMTP id v17so5514794wml.4;
 Wed, 25 Sep 2019 08:46:39 -0700 (PDT)
X-Gm-Message-State: APjAAAU7iPNRh4bdQeoG9OaFLl1Oz4vVXul3l20GCHZM/s6FdXexLplS
 uiGb855iJFDJ8dioOAYp6KTa/avyxqHWr0DlFn8=
X-Google-Smtp-Source: APXvYqzQD79Gyu/CB5/9e35reTlojOx2xToFpO0LXgIdXHeIuvTepv5I9M0NzXlcv9175EnCT3+lutzLejICofJEBXo=
X-Received: by 2002:a05:600c:1103:: with SMTP id
 b3mr8724713wma.3.1569426397979; 
 Wed, 25 Sep 2019 08:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <1569386895-8726-1-git-send-email-guoren@kernel.org>
 <CAKmqyKMraotFmqMg7MrJC5C4SogGqSaVtHkVYTEgGWK9UnWb5g@mail.gmail.com>
 <CAJF2gTR0o0s_p0H669BRZ86phLtpATwWczczWV8HWw1nc+doFA@mail.gmail.com>
 <CANnJOVFkviip0g1tBHdL6n2B8pMAQxVBC83RTaF4PAE1t+aPew@mail.gmail.com>
In-Reply-To: <CANnJOVFkviip0g1tBHdL6n2B8pMAQxVBC83RTaF4PAE1t+aPew@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 25 Sep 2019 23:46:26 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS=1uaQi7=CXg7f0eh2xb-HcG_sriMtU208VHXnJ4GTvA@mail.gmail.com>
Message-ID: <CAJF2gTS=1uaQi7=CXg7f0eh2xb-HcG_sriMtU208VHXnJ4GTvA@mail.gmail.com>
Subject: Re: [PATCH V3] target/riscv: Bugfix reserved bits in PTE for RV64
To: Jonathan Behrens <fintelia@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 198.145.29.99
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
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>, Guo Ren <ren_guo@c-sky.com>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I think your thoughts are wrong.
The specification is very clear: these bits are not part of ppn, not
part of the translation target address. The current code is against
the riscv-privilege specification.

On Wed, Sep 25, 2019 at 11:20 PM Jonathan Behrens <fintelia@gmail.com> wrot=
e:
>
> Any code whose behavior is changed by this patch is wrong, so it doesn't =
seem like it matters much whether this is merged or not. Personally I'd lea=
n towards making sure that attempts to use PTEs with the reserved bit set w=
ould always fault, rather than wrapping around to low memory and perhaps si=
lently succeeding.
>
> Jonathan
>
> On Wed, Sep 25, 2019 at 8:29 AM Guo Ren <guoren@kernel.org> wrote:
>>
>> On Wed, Sep 25, 2019 at 1:19 PM Alistair Francis <alistair23@gmail.com> =
wrote:
>> >
>> > On Tue, Sep 24, 2019 at 9:48 PM <guoren@kernel.org> wrote:
>> > >
>> > > From: Guo Ren <ren_guo@c-sky.com>
>> > >
>> > > Highest 10 bits of PTE are reserved in riscv-privileged, ref: [1], s=
o we
>> > > need to ignore them. They can not be a part of ppn.
>> > >
>> > > 1: The RISC-V Instruction Set Manual, Volume II: Privileged Architec=
ture
>> > >    4.4 Sv39: Page-Based 39-bit Virtual-Memory System
>> > >    4.5 Sv48: Page-Based 48-bit Virtual-Memory System
>> >
>> > Hey,
>> >
>> > As I mentioned on patch 2 I don't think this is right. It isn't up to
>> > HW to clear these bits, software should keep them clear.
>>
>> These bits are not part of ppn in spec, so we still need to ignore them =
for ppn.
>>
>> The patch is reasonable.
>>
>> --
>> Best Regards
>>  Guo Ren
>>
>> ML: https://lore.kernel.org/linux-csky/
>>


--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

