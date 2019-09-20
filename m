Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CA8C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 22:50:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88B062080F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 22:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Ev+/6gKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B062080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBRj9-00038g-Kf
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 18:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iBRhh-0002Qz-Ox
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 18:48:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iBRhe-0002iM-2O
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 18:48:39 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35598)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iBRha-0002dW-Pc
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 18:48:35 -0400
Received: by mail-pl1-x641.google.com with SMTP id y10so2547611plp.2
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 15:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=29ILA77Vbdbb2s0ZaZxg65E8lv4+o4HRZrc86NcWXyg=;
 b=Ev+/6gKKMuY6lx0EGu/JYeijvXZ55IqtFm9EVlP9hwftgtIaFH0VsbLkgmgoI80rtN
 2uXRbCD1BIonsZi9pRrNh3inv022kvwXil96hEGIH3V8SF7iYOFfjoVkOF5xrYGSSPxK
 Orhhq4U6F0OWkRLkfvCdC7lsJe5QrYODq6Do2VYNfSs9pAiOPnrTJmIf0jRQMtQ1PGLE
 SOn1mlpMj1WiEutUho2zJGS/3Yz4bewipa8vovy0gxCrWEO1uS3OSZBB7yDTMCdW14v3
 C7Dy2GaG3Gvi4WtEYQKzCr61zmSQ2mLc2/hMFO6UcyJ8OkbFRK/slfhcHXC3DnxViy9x
 /wSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=29ILA77Vbdbb2s0ZaZxg65E8lv4+o4HRZrc86NcWXyg=;
 b=iasYt/B6XYFilxLStkX85VPURst/D6UP0gP+2fQzxWqhTUzb2ZQL1VQ7vDbw1t8YS3
 ZOc4X2+rVN61VtbBCNe8+zeWI2Toy5busLtRmoRM5NoG7wAqeKKzmxltSQM8kmdxraGR
 /XeWo3uEuKay9tXZz5geqxL6PRaxT8EBNOZNgYTQ2iMAsbThb6geAJfpwMa1epw/Cgyo
 /mTJW7TQXtmnxC9h26OROKxPhKol3tifuOs58wdUyMe/txOQwJh8OMr0FFWtYT/Sdsw5
 6O945ebwf1RtlXsIQmVCG4//MfKYTkA+BZGvznvP3ASDn/ZQWhcVc4Y4F8SuJdZ0IEGu
 pDYg==
X-Gm-Message-State: APjAAAWNTE809y0Tr6o2azKrD+EPMJvWzeZ+bAkLli5u645hxdI9s2WE
 1b/Wq+855sGOTAKTtqCr8+5jMRqALScb8w==
X-Google-Smtp-Source: APXvYqyH36eLxCUBDFVzilKGmwdsT8cX1FEShTRrE0DB5wCXn4qVHRh/Wu0V++gzjLDDX6rHe4zwHw==
X-Received: by 2002:a17:902:8a81:: with SMTP id
 p1mr18833346plo.71.1569019711791; 
 Fri, 20 Sep 2019 15:48:31 -0700 (PDT)
Received: from localhost ([2607:fb90:5de:df7b:9794:c3bf:6169:a06c])
 by smtp.gmail.com with ESMTPSA id e21sm20076pgm.7.2019.09.20.15.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 15:48:31 -0700 (PDT)
Date: Fri, 20 Sep 2019 15:48:31 -0700 (PDT)
X-Google-Original-Date: Fri, 20 Sep 2019 15:46:59 PDT (-0700)
Subject: Re: [PATCH v1 0/2]  RISC-V: Convert to do_transaction_failed hook
In-Reply-To: <cover.1568762497.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-a10f93b3-147d-42a0-8f24-6d4b1f3a214b@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Sep 2019 16:22:56 PDT (-0700), Alistair Francis wrote:
> The do_unassigned_access hook has been deprecated and RISC-V is the last
> user of it. Let's instead update the RISC-V implementation to use
> do_transaction_failed instead.
>
> After this series I used the 'git grep' regexes in
> docs/devel/loads-stores.rst and these are the memory accesses inside
> target/riscv:
>
> monitor.c:102:        cpu_physical_memory_read(pte_addr, &pte, ptesize);
>
> cpu_helper.c:262:        target_ulong pte = address_space_ldl(cs->as, pte_addr, attrs, &res);
> cpu_helper.c:264:        target_ulong pte = address_space_ldq(cs->as, pte_addr, attrs, &res);
>
> translate.c:782:    ctx->opcode = cpu_ldl_code(env, ctx->base.pc_next);
>
> gdbstub.c:328:        env->fpr[n] = ldq_p(mem_buf); /* always 64-bit */
>
> All of these look safe to me.
>
> Palmer Dabbelt (2):
>   RISC-V: Handle bus errors in the page table walker
>   RISC-V: Implement cpu_do_transaction_failed

Can you Reviewed-By these, as they've still got my Author on them?  That way I 
can pull them in :)

>
>  target/riscv/cpu.c        |  2 +-
>  target/riscv/cpu.h        |  7 +++++--
>  target/riscv/cpu_helper.c | 23 ++++++++++++++++-------
>  3 files changed, 22 insertions(+), 10 deletions(-)

