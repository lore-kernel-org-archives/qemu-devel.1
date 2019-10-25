Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32408CA9EBD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:02:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 014B720679
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GZvnZsM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 014B720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO0AZ-0001Q9-I8
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 10:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iO05E-00007k-Pn
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:56:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iO05D-0004oa-Ez
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:56:52 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:44827)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iO05D-0004oA-9E
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:56:51 -0400
Received: by mail-oi1-x242.google.com with SMTP id s71so1661772oih.11
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 06:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/bRTAch7TN8AElK6YT0WBBYEsDIeLtG7aQXPhu3kJI4=;
 b=GZvnZsM6Pnd8X7VO0LEZDIWWduU95y52I8n/w/6aeSFytaTQg2F9WhPJvs//5jmQmS
 dWOEvJBxGy9YY4IkNDbmBOwJbIadog/IV9IzwwXp6h2B+gM2E8ISVmSe7/jSOyXxWuAY
 gV43z6MpSmukpfazkuKfHWa4jaTkdDpPIon5aCJ15lbXZP1jyvhkx/7zUmSC/WnU/U2w
 3yP/MQgWg8aZGWBy9+0KVIBfzxW+gksm4RDF1IchroOIwOm6aY3g+mDewCPXBGvPRqif
 S0gWxDXoxXQLAbtJmM+qZ6ssPFcTtdttwUZLwJM838BPMCGRad54HdOAQgEqMT9YC5Zr
 O/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/bRTAch7TN8AElK6YT0WBBYEsDIeLtG7aQXPhu3kJI4=;
 b=C84/bEp6u3RHn67IB4KOWG0W1Wks5dDsJ0JRDOvJOfk9AywW8y6hH0T6oT9iAPbUSh
 +qmW5tTkhydfurBD3NBbrXWLH6P9UHrSlFTG+wXQhQWHDBSmzOmomwcICO8SF9go+O40
 Mg3lkLc+VHxy3QCgWhQDbqtci9jSa2Fpkrq5JpszgV+potmGGmbvMUar8SBTkkKeVmYv
 Qx4DaBu8W5M2VZ9KfLcC4j/XFMIzxHhatX+dkcP9js7kkzDE6I+L4JNLM1S0kQzGhQ26
 1nP1a0vSPNQEJ9JdL+5NtCiBd0noKI5wTZa2WyCl8HQa72SWjRNwJB52NFA2uhPnF2KF
 rMuA==
X-Gm-Message-State: APjAAAUcKNoweM00mA3uFLbduHSiKN5WHJb1DFl8gmh12YFY7/PC5YTr
 7HcoljvQGLHcqjSoLh1JR1k2MRz2piZCwg5PiRx2IQ==
X-Google-Smtp-Source: APXvYqx/2nIGI7laJjOizTEHsn9rqO7zwfRYbL0MYOlTcID/njBFEBvp7jh79RhvREn54ssV/9iSoM+0co+8LJHn/6M=
X-Received: by 2002:aca:2312:: with SMTP id e18mr2135924oie.98.1572011810153; 
 Fri, 25 Oct 2019 06:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1570567870.git.alistair.francis@wdc.com>
 <mhng-0b0d87ea-8019-4226-b65c-76bdfc0c4189@palmer-si-x1e>
In-Reply-To: <mhng-0b0d87ea-8019-4226-b65c-76bdfc0c4189@palmer-si-x1e>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Oct 2019 14:56:39 +0100
Message-ID: <CAFEAcA-J-xGSx=0zjibvs5C1YD7_=YZy+NmghzUSFu6wh3e8Dg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] RISC-V: Convert to do_transaction_failed hook
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
 Alistair Francis <Alistair.Francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 8 Oct 2019 at 22:31, Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Tue, 08 Oct 2019 13:51:46 PDT (-0700), Alistair Francis wrote:
> >
> > The do_unassigned_access hook has been deprecated and RISC-V is the last
> > user of it. Let's instead update the RISC-V implementation to use
> > do_transaction_failed instead.
> >
> > After this series I used the 'git grep' regexes in
> > docs/devel/loads-stores.rst and these are the memory accesses inside
> > target/riscv:
> >
> > monitor.c:102:        cpu_physical_memory_read(pte_addr, &pte, ptesize);
> >
> > cpu_helper.c:262:        target_ulong pte = address_space_ldl(cs->as, pte_addr, attrs, &res);
> > cpu_helper.c:264:        target_ulong pte = address_space_ldq(cs->as, pte_addr, attrs, &res);
> >
> > translate.c:782:    ctx->opcode = cpu_ldl_code(env, ctx->base.pc_next);
> >
> > gdbstub.c:328:        env->fpr[n] = ldq_p(mem_buf); /* always 64-bit */
> >
> > All of these look safe to me.
> >
> > v2:
> >  - Rebase on master
> >
> >
> > Palmer Dabbelt (2):
> >   RISC-V: Handle bus errors in the page table walker
> >   RISC-V: Implement cpu_do_transaction_failed
> >
> >  target/riscv/cpu.c        |  2 +-
> >  target/riscv/cpu.h        |  7 +++++--
> >  target/riscv/cpu_helper.c | 23 ++++++++++++++++-------
> >  3 files changed, 22 insertions(+), 10 deletions(-)
>
> Thanks, these are in the queue.

Ping! These still don't seem to be in master, and softfreeze
is rapidly approaching (it's on the 29th).

(As a general observation, flow of riscv patches into
master seems to be quite slow. My recommendation would tend
to be doing smaller pullrequests more frequently; I try to
push through accumulated target-arm patches at least once
a fortnight, though it depends on how many patches are
arriving.)

thanks
-- PMM

