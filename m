Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A848DC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 22:07:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A67B21880
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 22:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0nt8Ejl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A67B21880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr8NG-0006qP-0E
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 18:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60399)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <fintelia@gmail.com>) id 1hr8N1-0006HG-8C
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 18:07:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fintelia@gmail.com>) id 1hr8Mv-0003aH-3Y
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 18:07:18 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:36036)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <fintelia@gmail.com>)
 id 1hr8Mu-0003EF-I6; Fri, 26 Jul 2019 18:07:16 -0400
Received: by mail-lf1-x141.google.com with SMTP id q26so38102385lfc.3;
 Fri, 26 Jul 2019 15:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fCK+X2tcIS92/EKkLAEH9dGaJcfqMKXYLhoNNJJVB0E=;
 b=O0nt8Ejl+oPRGkmrZfNBwxsKHxdZzv+QdxkPU/NX4H7WbN7vdAPmmgJjM8yOre3ByD
 gwQCHluVRVan4jubv+QqI9K96vd70T20iz27uVqNhsLFopYiiP1+/x4s0xOnyZ6Mu79v
 CjFyGmaCZ9vS0BXAy0h+r8dQiEkuDGyddJH0GvBDpzzuj4TzeC2duH+YTkhsOZeofz6j
 1rQpkmG1BCyMpLa4U9+XS84sXVEKS5VrNkL8lu9Sq+zHozOOWlzZkot5A3W52SWOgXQ7
 l0g3pLtcffrABCIiCSkrunb38lQ5W8S9ruI3l4zO2xzQVsV99O812FD/XBgzuQxJ1ub2
 X8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fCK+X2tcIS92/EKkLAEH9dGaJcfqMKXYLhoNNJJVB0E=;
 b=jC2zPCkPxrufgIrLFzMV1WnR4yzs0jGjkx0ruL22I/eEfj0DyUtY3eqLNpBiLtdU/O
 P2jyHEOtTsuY/89G+LlwQxKbtymvpUZbdBt4NVphN3HXjnnSr4v+aZg5GD5RvflOSQsj
 rSETbOZekCxXk9DWw1GFgJ3iqBkr293suHyQSjrrrXsDL/9s2+LM8bZUlJUxf7F7NxCe
 A1TVTtptr6LPanT+lZaIkRxNG+RjTm2KSM4QN2JMYtTNlmURVyJC8AsUDPbVXvV2zp5X
 Vb/b8VlpY1JSzw+j4WGt8WyBgLHVTQ0pAFmSizCBVF/X9MU7/0FxUGZJLhlMJ0gvU81r
 2GJg==
X-Gm-Message-State: APjAAAW19ttx/bOP8sqsACOgyiZH3CYnblDs8MmEq2IcHazcilXGlgep
 qcteDlcg6XfIuoSNhB6oGHd7psTwPhWmV/qgi0Qm8KDg
X-Google-Smtp-Source: APXvYqwISxTqTXIUht4oVDWEipcjsRU9WorxiK6vadDCUb2C91FzAvg3Vc6HWd849PSWt9PH1e6BQykS+IdePdqbdb4=
X-Received: by 2002:a19:7006:: with SMTP id h6mr44830456lfc.5.1564174850508;
 Fri, 26 Jul 2019 14:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1564080680.git.alistair.francis@wdc.com>
 <b415f5b51e09418760b95e5c73fad5e68b97f173.1564080680.git.alistair.francis@wdc.com>
 <CANnJOVEyy7wb74eEucj5t=xonOvUFTPWuty9R+-KP0DLc+L7zQ@mail.gmail.com>
 <CAKmqyKOh-7LE5ry_RG56-TM0bqj_kckcK74W8kFLiPHrjjx7hw@mail.gmail.com>
In-Reply-To: <CAKmqyKOh-7LE5ry_RG56-TM0bqj_kckcK74W8kFLiPHrjjx7hw@mail.gmail.com>
From: Jonathan Behrens <fintelia@gmail.com>
Date: Fri, 26 Jul 2019 17:00:07 -0400
Message-ID: <CANnJOVHWmA_KcdOC4o_4Uq9vZmNR_Sdy0L0foqqr_FwJY7ULqQ@mail.gmail.com>
To: Alistair Francis <alistair23@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH-4.2 v1 2/6] target/riscv:
 Remove strict perm checking for CSR R/W
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
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The remaining checks are not sufficient. If you look at the bottom of
csr.c, you'll see that for most of the M-mode CSRs the predicate is set to
"any" which unconditionally allows access regardless of privilege mode. The
S-mode CSR predicates similarly only check that supervisor mode exists, but
not that the processor is current running in that mode. I do agree with you
that using the register address to determine the required privilege mode is
a little strange, but RISC-V is designed so that bits 8 and 9 of the CSR
address encode that information: 0=U-mode, 1=S-mode, 2=HS-mode, 3=M-mode.

I also tested by booting RVirt <https://github.com/mit-pdos/RVirt> with a
Linux guest and found that this patch caused it to instantly crash because
guest CSR accesses weren't intercepted.

Jonathan

On Fri, Jul 26, 2019 at 4:28 PM Alistair Francis <alistair23@gmail.com>
wrote:

> On Thu, Jul 25, 2019 at 2:48 PM Jonathan Behrens <fintelia@gmail.com>
> wrote:
> >
> > Unless I'm missing something, this is the only place that QEMU checks
> the privilege level for read and writes to CSRs. The exact computation used
> here won't work with the hypervisor extension, but we also can't just get
> rid of privilege checking entirely...
>
> The csr_ops struct contains a checker function, so there are still
> some checks occurring. I haven't done negative testing on this patch,
> but the current check doesn't seem to make any sense so it should be
> removed. We can separately discuss adding more checks but this current
> way base don CSR address just seems strange.
>
> Alistair
>
> >
> > Jonathan
> >
> > On Thu, Jul 25, 2019 at 2:56 PM Alistair Francis <
> alistair.francis@wdc.com> wrote:
> >>
> >> The privledge check based on the CSR address mask 0x300 doesn't work
> >> when using Hypervisor extensions so remove the check
> >>
> >> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> >> ---
> >>  target/riscv/csr.c | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> >> index e0d4586760..af3b762c8b 100644
> >> --- a/target/riscv/csr.c
> >> +++ b/target/riscv/csr.c
> >> @@ -797,9 +797,8 @@ int riscv_csrrw(CPURISCVState *env, int csrno,
> target_ulong *ret_value,
> >>
> >>      /* check privileges and return -1 if check fails */
> >>  #if !defined(CONFIG_USER_ONLY)
> >> -    int csr_priv = get_field(csrno, 0x300);
> >>      int read_only = get_field(csrno, 0xC00) == 3;
> >> -    if ((write_mask && read_only) || (env->priv < csr_priv)) {
> >> +    if (write_mask && read_only) {
> >>          return -1;
> >>      }
> >>  #endif
> >> --
> >> 2.22.0
> >>
> >>
>
