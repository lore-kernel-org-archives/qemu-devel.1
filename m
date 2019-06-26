Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629DBC4646B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 06:55:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 255B72086D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 06:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ic0fSPlB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255B72086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg1q0-0003fy-7L
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 02:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52422)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hg1oy-0003AO-Be
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 02:54:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hg1ox-0000i6-6J
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 02:54:20 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:40350)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hg1ow-0000h4-Vj; Wed, 26 Jun 2019 02:54:19 -0400
Received: by mail-ed1-x543.google.com with SMTP id k8so1661587eds.7;
 Tue, 25 Jun 2019 23:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=owasJxfbUT+2CzytPdtooyLG5oBkm0msrSQauMivNBE=;
 b=ic0fSPlB5/Q8YW2Y/MLUvkotN5yDP20qMdfb12qSL+lkbegGLbK/cZgOLZc5pkJupW
 S8my3bhPlAEuDUmALsz88zAy1fBzpY5DGQv2I0i5Nvf6ic+5xceySXBjFADZ14G0NW+I
 nhUchMISQngCP4BwNoW9X+YFigu8CGgLV9BxpbpjMquZ/zMHfpFtffsgKUA87XIwPrU4
 jYAneRRskwRGOwMf+LpRrcXcxdnnFvBt3i49WhooxT2l1Xuy11BKkB/AbKb5AIMFqZ+d
 oTrR4hnXUGZJB448QoazwB0xYZ5P1EwXfn0aH6e0CL4YihJM9O58cBpxLfZZUkI58HXC
 ewnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=owasJxfbUT+2CzytPdtooyLG5oBkm0msrSQauMivNBE=;
 b=pcBDejEYHBqaEs7cEXlsAPadIarL/Vdm4oAKUFXtjOgrx9xxC0KUYC2LTN6oYBYkhx
 8G6E1KeQ94kz9F7AQWc9xLJyoClgXuFGpmm3wdV9XBUHe+s4/0W7nJ/eYXn4+xdcuJDS
 Pna+8Q6URXVO7qfKlEkqEzzkUzsx2bOI5RLgqNa8ujw9aMe6U6TootTGB4wM3MbCIHrd
 jRI2yxR2GhrRxgy5n9ft/fJ7ezEjnCRXPhmhXzFmw7aR2F2f9Fcser8g1J/PDdNc5Jo0
 uHv5mT9YAC/+untEm6Xd8Ik5Wm+nJyryAvsN8pUXD2XCfePG5oEYdkjaLhbBgtdoLxOK
 0gBQ==
X-Gm-Message-State: APjAAAU5MhJUR3aGY0aoEzpCnZTLVgf69j1YMT4xoMsmwOYBj7Ihauyy
 Khs/vQkA1hnuc0MRlEw5McYvlmsYHTruqFFY5eQ=
X-Google-Smtp-Source: APXvYqyGcURxrBx0ID51WN90qaL4MqwQ942DmZ5nxjuS4aGkvSQGnplPPcfBoRbbnYQI7ysuHgg2lhCR2naylnjVtX0=
X-Received: by 2002:a17:906:fcb8:: with SMTP id
 qw24mr2455887ejb.239.1561532057281; 
 Tue, 25 Jun 2019 23:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <CANnJOVF7DUabc6ut92dQQUjxWud7zfdgBEkj=GPn1P+2tKw-ag@mail.gmail.com>
 <mhng-94c196fb-ebb6-4075-afa9-96989bbc037c@palmer-si-x1e>
In-Reply-To: <mhng-94c196fb-ebb6-4075-afa9-96989bbc037c@palmer-si-x1e>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 26 Jun 2019 14:54:06 +0800
Message-ID: <CAEUhbmVdVXaFhM2b1U2d5G0My5Gq3cMM1zhQKU3n051KuXu4HQ@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::543
Subject: Re: [Qemu-devel] [PATCH for 4.1 v3] target/riscv: Expose time CSRs
 when allowed by [m|s]counteren
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
 Jonathan Behrens <fintelia@gmail.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Palmer,

On Tue, Jun 25, 2019 at 5:57 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Mon, 24 Jun 2019 16:03:20 PDT (-0700), fintelia@gmail.com wrote:
> > Apparently my previous message didn't make it out onto the list (sorry
> > about all these email glitches!). I've included the message again below.
> > Hopefully either a patch like this one or something simpler that just hard
> > codes mcounteren.TM to zero (so QEMU is at least conformant) can be merged
> > in time for 4.1.
> >
> > On Fri, Jun 14, 2019 at 8:55 AM Jonathan Behrens <jonathan@fintelia.io>
> > wrote:
> >
> >> I'm not sure that is accurate. Based on the discussion here
> >> <https://forums.sifive.com/t/possible-bug-in-counteren-csrs/2123> the
> >> HiFive Unleashed actually does support reading the timer CSR from
> >> unprivileged modes (from that discussion it does so a little too well...
> >> but it should presumably be fixed in later iterations of the processor).
> >> And even if no real hardware supported this capability, it still might make
> >> sense to provide it in QEMU as an optimization.
>
> time and cycle are different registers: rdtime should trap, but rdcycle should
> work.  The hardware traps rdtime into machine mode and emulates it via a memory
> mapped register.  The bug in the FU540-C000 appears to be related to the
> counter enables, not the presence of the counters.

I don't think rdtime is required to mandatorily trap.

Per privileged spec v1.10, chapter 3.1.17 Counter-Enable Registers
([m|h|s]counteren), it says:

"When the CY, TM, IR, or HPMn bit in the mcounteren register is clear,
attempts to read the cycle, time, instret, or hpmcountern register
while executing in S-mode or U-mode will cause an illegal instruction
exception."

In the same chapter, it also says:

"Implementations can convert reads of the time CSR into loads to the
memory-mapped mtime register, or hard-wire the TM bits in mxcounteren
to 0 and emulate this functionality in M-mode software."

So per my understanding when mcounteren.TM is set, rdtime should NOT trap.

Regards,
Bin

