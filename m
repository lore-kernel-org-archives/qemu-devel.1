Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734D1C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 18:05:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 452CA20659
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 18:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fintelia.io header.i=@fintelia.io header.b="7PV+YFqS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 452CA20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fintelia.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hijdd-00028f-Ay
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 14:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55447)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1hijbW-0001Fo-PS
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 14:03:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1hijbV-0005pb-8H
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 14:03:38 -0400
Received: from rs224.mailgun.us ([209.61.151.224]:61941)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1hijbT-0005lz-Cs
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 14:03:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=fintelia.io; q=dns/txt;
 s=pic; 
 t=1562177012; h=Content-Type: Cc: To: Subject: Message-ID: Date: From:
 In-Reply-To: References: MIME-Version: Sender;
 bh=cFsveXpt62Kbr2tJ04ztChy5Zigq6AHRo8hGSNeg8p4=;
 b=7PV+YFqSdg0FnA5FdHFZyGlU8IApcFNK+DFFQyvgPY3SfQtvqjN+KQmVij+bHpRtZyspb8DD
 +ujE8G1HO9BVAW62/5Z7iWpZlFFgc3UbGEud8jd5lakgDLECUxJANIqHzFEC/bkc73TvSCHO
 0xQBh0gaLS48mARhM6/oH7azSAlV94lYJWbsXe6qjRXCEHbcxdCHZCqBoEOzs2hR2YTAi2Kn
 kwjhRoz2cP8Q7/SFIeTOgjBwXvFpdqfNYe6IHEXHEytZU1TzTKlIsULLiA8poZ5Tv4ZYWETM
 R+Y3QAZSbaJndSTB4nKWrpWHZr2L/tc6hZSb19gCFhZLr+vddwvwfA==
X-Mailgun-Sending-Ip: 209.61.151.224
X-Mailgun-Sid: WyJlMGM5NSIsICJxZW11LWRldmVsQG5vbmdudS5vcmciLCAiOWI0ZTc2Il0=
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com
 [209.85.167.50])
 by mxa.mailgun.org with ESMTP id 5d1cedf3.7fc2f111b030-smtp-out-n02;
 Wed, 03 Jul 2019 18:03:31 -0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id z15so2392517lfh.13;
 Wed, 03 Jul 2019 11:03:31 -0700 (PDT)
X-Gm-Message-State: APjAAAUNo8WnduhiZa61H6vJ65JHFWDaNauAJurHs0s/9EJajyQkmGt7
 4r1rqJQGun0DKs4xQaaf5nmgFODwzqXShxBbC0A=
X-Google-Smtp-Source: APXvYqyfkgQCPmcR1HsXdOf3vkEZa5etH7twRV+o969RC9jqcMtEoMisHD18e7OZIoxF79/wPFUY0d7yrmPLsnxsQcM=
X-Received: by 2002:ac2:518d:: with SMTP id u13mr18744065lfi.40.1562177010158; 
 Wed, 03 Jul 2019 11:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190701154617.22908-1-jonathan@fintelia.io>
 <CAKmqyKOsMO7SvvDfiqhywxb=oaqo=NDjw==reVpU9sLh+3dGuw@mail.gmail.com>
 <CAEUhbmXBnu_Fet99AjQj6XZ10m045N8kY7d8VNy28ktmFBsrQQ@mail.gmail.com>
In-Reply-To: <CAEUhbmXBnu_Fet99AjQj6XZ10m045N8kY7d8VNy28ktmFBsrQQ@mail.gmail.com>
From: Jonathan Behrens <jonathan@fintelia.io>
Date: Wed, 3 Jul 2019 14:02:56 -0400
X-Gmail-Original-Message-ID: <CANnJOVGXcTkH2_2cRqAv0CnZx4xHQ_npEjW-au-FPxe_cU0=5Q@mail.gmail.com>
Message-ID: <CANnJOVGXcTkH2_2cRqAv0CnZx4xHQ_npEjW-au-FPxe_cU0=5Q@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.61.151.224
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2] target/riscv: Hardwire mcounter.TM and
 upper bits of [m|s]counteren
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
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Bin, that proposal proved to be somewhat more controversial than I was
expecting, since it was different than how currently available hardware
worked. This option seemed much more likely to be accepted in the short
term.

Jonathan

On Mon, Jul 1, 2019 at 9:26 PM Bin Meng <bmeng.cn@gmail.com> wrote:

> On Tue, Jul 2, 2019 at 8:20 AM Alistair Francis <alistair23@gmail.com>
> wrote:
> >
> > On Mon, Jul 1, 2019 at 8:56 AM <jonathan@fintelia.io> wrote:
> > >
> > > From: Jonathan Behrens <jonathan@fintelia.io>
> > >
> > > QEMU currently always triggers an illegal instruction exception when
> > > code attempts to read the time CSR. This is valid behavor, but only if
> > > the TM bit in mcounteren is hardwired to zero. This change also
> > > corrects mcounteren and scounteren CSRs to be 32-bits on both 32-bit
> > > and 64-bit targets.
> > >
> > > Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>
> >
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> >
>
> I am a little bit lost here. I think we agreed to allow directly read
> to time CSR when mcounteren.TM is set, no?
>
> Regards,
> Bin
>
