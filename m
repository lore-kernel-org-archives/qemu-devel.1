Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AADC32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 16:24:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 652F42075D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 16:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ARP5yo+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 652F42075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEyTe-0000d6-Hg
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 12:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iEySt-00009s-EV
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 12:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iEySr-0007Sq-IL
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 12:23:58 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:41087)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iEySr-0007SX-AF
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 12:23:57 -0400
Received: by mail-oi1-x22b.google.com with SMTP id w17so11638475oiw.8
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 09:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5rzC31yhwDTFkWb30k4boCpIB/HLHfFLBF5NA1ioMbY=;
 b=ARP5yo+objylAj0TIuOwiRzpfHCz2yRusDQ2401RO/Ejw3eBKAC63bSlOUT1sbatIa
 b+gdwC+yEIhsLhqNozHAk9w46vOMy182CQG9qktfW2Z9YGtEiqgKD1ru0HyNYt9HuuHT
 utJ6STTCOdxQA0ol9cuvD3Sk31/ixA3oRtRgyOP2xJuyMIww45GQhWro3Afi5sQxHoYR
 8xrrF/mB0O9XwgvquQxH2o+WL8Vpc+YMd9QfVW2Ubl3AZHDtycZmyCQdQVqP3N+h7MkG
 vbr7N/M16aFbGBaq3aOjgCdTmcMuQgCO5seY3DhqeUhAtabqu1KRvQkiAb5Lq6AY2Bmi
 UjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5rzC31yhwDTFkWb30k4boCpIB/HLHfFLBF5NA1ioMbY=;
 b=Er54i5Bt/O724c2UFsgFo1z9W7ZHVXkdRpkXDZBUavnBL9u/1niP1czZ2Ew+zvqB8H
 SgJWWhMn14pSDLh6IscFIzN7g3H9RmrPvErt6Pfezttzkk/DFfaoFM1BQnle9zuRBPnE
 tNmTq+qqp57VUmhLM4kxUe2uBy4KM9ONZ7OxFqgNJld66GkNq9yq+g4OCOM+mnIQtT28
 A/enj27Z3WdKD+nmHEiR0HCR2dZXCY48tcJO8dB5dhwpToI/suZWhVj4mjGoXFqgSwPf
 8F9px1R54ElpWcsff9RvqwB5FeW7ZYDgqAV5ov/Ws1fcJpO9cG1QpZtU2bVEIz/LAiH7
 UZyw==
X-Gm-Message-State: APjAAAVX6HSGPJoS3nDT89jtpMMFwm2dUMFIs6D9VSRWbNc+bxBxFFVM
 UAhkbZv8yVcpqBPy93ew8C5sujDTbzTSwyenxHrgag==
X-Google-Smtp-Source: APXvYqwqxTSOhs/NqFpQNQJQYswao3q0CqTtNiyhMUAcJlbqBol9SR4V148cm/cruKMoe2Rk9klVGGtKwVUvtBpoJYY=
X-Received: by 2002:aca:b646:: with SMTP id g67mr5353oif.163.1569860636390;
 Mon, 30 Sep 2019 09:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_363C13D92BFF319155906E6B@qq.com>
In-Reply-To: <tencent_363C13D92BFF319155906E6B@qq.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Sep 2019 17:23:45 +0100
Message-ID: <CAFEAcA9uneV_FY-1XV5_Wa-Lb28_ojSBP9GhWy1xyAmGcZqamg@mail.gmail.com>
Subject: Re: gdbstub and gbd segfaults on different instructions in user space
 emulation
To: Libo Zhou <zhlb29@foxmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22b
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 30 Sep 2019 at 16:57, Libo Zhou <zhlb29@foxmail.com> wrote:
> I am encountering segmentation fault while porting my custom ISA to QEMU.=
 My custom ISA is VERY VERY simple, it only changes the [31:26] opcode fiel=
d of LW and SW instructions. The link has my very simple implementation: ht=
tps://lists.gnu.org/archive/html/qemu-devel/2019-09/msg06976.html

> I have tried 2 ways of debugging it.
> Firstly, I connected gdb-multiarch to gdbstub, and I single-stepped the i=
nstructions in my ELF. Immediately after the LW instruction, the segfault w=
as thrown. I observed the memory location using 'x' command and found that =
at least my SW instruction was implemented correctly.
> Secondly, I used gdb to directly debug QEMU. I set the breakpoint at func=
tion in translate.c:decode_opc. Pressing 'c' should have the same effect as=
 single-stepping instruction in gdbstub. However, the segmentation fault wa=
sn't thrown after LW. It was instead thrown after the 'nop' after 'jr r31' =
in the objdump.

(1) If you're debugging the QEMU JIT itself, then you're probably
better off using QEMU's logging facilities (under the -d option)
rather than the gdbstub. The gdbstub is good if you're sure that
QEMU is basically functional and want to debug your guest, but
if you suspect bugs in QEMU itself then it can confuse you.
The -d debug logging is at a much lower level, which makes it
a better guide to what QEMU is really doing, though it is also
trickier to interpret.

(2) No, breakpointing on decode_opc is not the same as singlestepping
an instruction in gdb. This is a really important concept in QEMU
(and JITs in general) and if you don't understand it you're going
to be very confused. A JIT has two phases:
 (a) "translate time", when we take a block of guest instructions
and generate host machine code for them
 (b) "execution time", when we execute one or more of the blocks
of host machine code that we wrote at translate time
QEMU calls the blocks it works with "translation blocks", and
usually it will put multiple guest instructions into each TB;
a TB usually stops after a guest branch instructions. (You can
ask QEMU to put just one guest instruction into a TB using
the -singlestep command line option -- this is sometimes useful
when debugging.)

So if you put a breakpoint on decode_opc you'll see it is hit
for every instruction in the TB, which for the TB starting at
"00400090 <main>" will be every instruction up to and including
the 'nop' in the delay slot of the 'jr'. Once the whole TB is
translated, *then* we will execute it. It's only at execute time
that we perform the actual operations on the guest CPU that
the instructions require. If the segfault is because we think
the guest has made a bad memory access, we'll generate it here.
If the segfault is an actual crash in QEMU itself, it will
happen here if the bug is one that happens at execution time.

Note that the -d logging will distinguish between things that
happen at translate time (which is when the in_asm, op, out_asm etc
logging is printed) and things that happen at execution time
(which is when cpu, exec, int, etc logs are printed).

thanks
-- PMM

