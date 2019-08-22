Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52DBC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 18:17:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B40AC21848
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 18:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRl+iw7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B40AC21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0reI-0006cM-Oc
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 14:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i0rdQ-0006Bh-F3
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 14:16:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i0rdO-0004v2-BY
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 14:16:32 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44813)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i0rdO-0004uT-5B
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 14:16:30 -0400
Received: by mail-ot1-x342.google.com with SMTP id w4so6307823ote.11
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 11:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=R6FS+UPu9axSQ9mgY/lVjeDTBCsQST2wXuuGJSwTewc=;
 b=IRl+iw7bVW4EiNoZIO5OrW5VwGF2QFYi+1b1m14eHvbp7a4O3JQ+nLbjbIhPp+5Ezv
 AsBDcc1+dDJWfJlAFKqXAmcDBZyR0TIl2TJRFP16/uKntS8KC7o9vFPzLfoOEs8uscvM
 ZgFxCVgIchq9Imjf+rQka8BrE7cNF67bGeFG4GY5oQiJz0XlpLpuOj1XRKxEL5ks7XB4
 FBMJ6eZgFJetcRoSz4BuwgJjQ/qP0KMF7D4S2ZC5+coK6LJmbg99bBqAFes3ZHl0rG2V
 X8cguZuxN54LRG7whkTdn/jGYXlolxfzKoWmPfUP9AyVlwIHcC1YFY059/2YIALxzqx2
 lXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=R6FS+UPu9axSQ9mgY/lVjeDTBCsQST2wXuuGJSwTewc=;
 b=fYw+1I/a/RKxjpQVkGJ33fxQC0TKJY3gOK/4/4EhEy3Qq00UWY/WwAg6CGr5o7HYmD
 CHJKqd4AFYm94Vq4l0cnxiN4cpCIfmnWYSNcDgpAnq47s2XjMEmBfLEmqBD4FCB54hNI
 KoJLlWTfVnmOY0GzRpizuf2+ji4he3jUbVH3+qG5tmqi9tV231SLmIDlV5hCQftAGGAb
 vyDXQNhVXV/PPzkX6z6ggamaCn3BTUaGkYYqdKEgeaiMEbMMNo69XzIM3rIwJ1RwPg8N
 aF41r3gYkVbbEDgxDaApI2Isf3pm0csyxEh2rjytsd6ye5anbplNb5iqVrb8kMnnK57d
 ATlQ==
X-Gm-Message-State: APjAAAUEF4/u4OKp9O4cLTS8ay9qP8eD3nYFisd5ZDZDONYHsCVAi5wx
 1TVO/wizmf1iPHUcGax32x0+uRXZ7X/tRs37+bwxIw==
X-Google-Smtp-Source: APXvYqwOsTnaxXYqGigfZ7pa6U746UfvN72Qmj64AJsShqdCynN761gt/uvGoesB0y5J1Z3kfyp4mcU+KAY6QzoELZ0=
X-Received: by 2002:a05:6830:15cc:: with SMTP id
 j12mr788835otr.64.1566497789234; 
 Thu, 22 Aug 2019 11:16:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Thu, 22 Aug 2019 11:16:28
 -0700 (PDT)
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Thu, 22 Aug 2019 11:16:28
 -0700 (PDT)
In-Reply-To: <20190802160458.25681-1-peter.maydell@linaro.org>
References: <20190802160458.25681-1-peter.maydell@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 22 Aug 2019 20:16:28 +0200
Message-ID: <CAL1e-=icX+uKfHtMc69-GVQAkTfR-poreB2_Zzm-=tyK=fp+KA@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 0/3] target/mips: Convert to
 do_transaction_failed hook
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

02.08.2019. 18.05, "Peter Maydell" <peter.maydell@linaro.org> =D1=98=D0=B5 =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> This patchset converts the MIPS target away from the
> old broken do_unassigned_access hook to the new (added in
> 2017...) do_transaction_failed hook.
>

Herve, bonjour.

As far as I can see these changes are fine. May I ask you for your opinion?
Can you run your Jazz tests without regressions with this change?

Mille mercis,
Aleksandar

> The motivation here is:
>  * do_unassigned_access is broken because:
>     + it will be called for any kind of access to physical addresses
>       where there is no assigned device, whether that access is by the
>       CPU or by something else (like a DMA controller!), so it can
>       result in spurious guest CPU exceptions.
>     + It will also get called even when using KVM, when there's nothing
>       useful it can do.
>     + It isn't passed in the return-address within the TCG generated
>       code, so it isn't able to correctly restore the CPU state
>       before generating the exception, and so the exception will
>       often be generated with the wrong faulting guest PC value
>  * there are now only a few targets still using the old hook,
>    so if we can convert them we can delete all the old code
>    and complete this API transation. (Patches for SPARC are on
>    the list; the other user is RISCV, which accidentally
>    implemented the old hook rather than the new one recently.)
>
> The general approach to the conversion is to check the target for
> load/store-by-physical-address operations which were previously
> implicitly causing exceptions, to see if they now need to explicitly
> check for and handle memory access failures. (The 'git grep' regexes
> in docs/devel/loads-stores.rst are useful here: the API families to
> look for are ld*_phys/st*_phys, address_space_ld/st*, and
> cpu_physical_memory*.)
>
> For MIPS, there are none of these (the usual place where targets do
> this is hardware page table walks where the page table entries are
> loaded by physical address, and MIPS doesn't seem to have those).
>
> Code audit out of the way, the actual hook changeover is pretty
> simple.
>
> The complication here is the MIPS Jazz board, which has some rather
> dubious code that intercepts the do_unassigned_access hook to suppress
> generation of exceptions for invalid accesses due to data accesses,
> while leaving exceptions for invalid instruction fetches in place. I'm
> a bit dubious about whether the behaviour we have implemented here is
> really what the hardware does -- it seems pretty odd to me to not
> generate exceptions for d-side accesses but to generate them for
> i-side accesses, and looking back through git and mailing list history
> this code is here mainly as "put back the behaviour we had before a
> previous commit broke it", and that older behaviour in turn I think is
> more historical-accident than because anybody deliberately checked the
> hardware behaviour and made QEMU work that way. However, I don't have
> any real hardware to do comparative tests on, so this series retains
> the same behaviour we had before on this board, by making it intercept
> the new hook in the same way it did the old one. I've beefed up the
> comment somewhat to indicate what we're doing, why, and why it might
> not be right.
>
> The patch series is structured in three parts:
>  * make the Jazz board code support CPUs regardless of which
>    of the two hooks they implement
>  * switch the MIPS CPUs over to implementing the new hook
>  * remove the no-longer-needed Jazz board code for the old
>    hook
> (This seemed cleaner to me than squashing the whole thing into
> a single patch that touched core mips code and the jazz board
> at the same time.)
>
> I have tested this with:
>  * the ARC Multiboot BIOS linked to from the bug
>    https://bugs.launchpad.net/qemu/+bug/1245924 (and which
>    was the test case for needing the hook intercept)
>  * a Linux kernel for the 'mips' mips r4k machine
>  * 'make check'
> Obviously more extensive testing would be useful, but I
> don't have any other test images. I also don't have
> a KVM MIPS host, which would be worth testing to confirm
> that it also still works.
>
> If anybody happens by some chance to still have a working
> real-hardware Magnum or PICA61 board, we could perhaps test
> how it handles accesses to invalid memory, but I suspect that
> nobody does any more :-)
>
> thanks
> -- PMM
>
>
> Peter Maydell (3):
>   hw/mips/mips_jazz: Override do_transaction_failed hook
>   target/mips: Switch to do_transaction_failed() hook
>   hw/mips/mips_jazz: Remove no-longer-necessary override of
>     do_unassigned_access
>
>  target/mips/internal.h  |  8 ++++---
>  hw/mips/mips_jazz.c     | 47 +++++++++++++++++++++++++++++------------
>  target/mips/cpu.c       |  2 +-
>  target/mips/op_helper.c | 24 +++++++--------------
>  4 files changed, 47 insertions(+), 34 deletions(-)
>
> --
> 2.20.1
>
>
