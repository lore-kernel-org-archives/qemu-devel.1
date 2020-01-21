Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F084BC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 10:52:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BADEE20882
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 10:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlqxDicq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADEE20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itr9N-0001gw-RA
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 05:52:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1itr76-0007Qd-92
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:50:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1itr75-0001kt-3x
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:50:28 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231]:40895)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1itr74-0001kK-TK
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:50:27 -0500
Received: by mail-lj1-x231.google.com with SMTP id u1so2225948ljk.7
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 02:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tprEsKQLieo3RaBiu3dgPzJziasGYJ7Wzw39ezlYlao=;
 b=nlqxDicq7tw59qnP1jWhu36B0+WxtuKGOskijEckK/sWX9TnhV2Z11TZnetoaA29O1
 aiaAYaoeorAdFK+GKo7G47vX+LFuOrk2u+Hcc02np9rBtJmXXHcTmj/oiUM5TjrFZrG1
 XUJKC9tuAuBFsPnAEsxO6YPV77YB0dzWX/H69XTwSvoz6OXQyWs2ym+WAZD6PHeQmL4d
 YiQabqAdCGlBQS2XwTcF4zNZMGdIOMQsdOjXXOQ8/1GxGKZhfz3KbFPb9SQqP3HapLP3
 I+H0tBN/7+KKYNz8TKy00YwT125wt4M3YYcYp1OwZwuM1Yy3mdwp6I5q7ugiiNVtfOfx
 xgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tprEsKQLieo3RaBiu3dgPzJziasGYJ7Wzw39ezlYlao=;
 b=iqh4KMi855eiYj7KA5h0rTLVNGue/toTXk+sHSv+JSLhqUXJMeFc+BoWvY5v5ydPkf
 d7Xz3nRBxs5YptAGF886gtGceLEreQF1WuHihXT1eLgbzaBRgG6KG8ia9U7YTPrsbPc8
 Lv8OQdZL0oYtV0mo5rRwYbcYIoOLYJZjHSLU7P7RfTRVsCgcmUNSfjAHgX8IanXdiBR2
 ynUIh2g/UudQsuk2RC/RfH/LK5d039OsNqDKeCCCMp9a8HkvwRZCE9wmhxWYGZ5ot6bv
 0cAZxy6x5IGk7QioI07o7M3nJ8sRCQEP96jgElMr4LSfzpw5m+3A41RRj8d4BFR52u8f
 S0ZA==
X-Gm-Message-State: APjAAAVDXnqkoSY9na2HoZUfmsvrlFzyOeLRPHi4pAQlP7ORfo4Ci6r+
 6WMD/sxNAHZFR/0VL4mv9SzE9cCYSsOVij6RmhM=
X-Google-Smtp-Source: APXvYqzLCMVyTk3Rj/8lafc5QyDV4oRiUf2rvv2saKiATOgGdbO7kO5g0x0sZIyD1yoZXqmhY7+SDs4xYv3sjZ7Duko=
X-Received: by 2002:a2e:461a:: with SMTP id t26mr15781336lja.204.1579603825336; 
 Tue, 21 Jan 2020 02:50:25 -0800 (PST)
MIME-Version: 1.0
References: <CAMAD20n_9Xj6HqgYzB-_Ra71f=_YyS4WkAFJK6VExOA50Bfcjw@mail.gmail.com>
In-Reply-To: <CAMAD20n_9Xj6HqgYzB-_Ra71f=_YyS4WkAFJK6VExOA50Bfcjw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 21 Jan 2020 20:49:58 +1000
Message-ID: <CAKmqyKNzFeWcNP7Stz5TnjzEysGt3pSe8qNvq4rTtM4guaLDTg@mail.gmail.com>
Subject: Re: riscv: How to check floating point support is currently enabled?
To: Ian Jiang <ianjiang.ict@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::231
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 21, 2020 at 11:12 AM Ian Jiang <ianjiang.ict@gmail.com> wrote:
>
> The function riscv_cpu_fp_enabled() is used for checking whether floating point support is currently enabled. In fact it checks the FS field in the mstatus MSR.
>
> target/riscv/cpu_helper.c
>  76 bool riscv_cpu_fp_enabled(CPURISCVState *env)
>  77 {
>  78     if (env->mstatus & MSTATUS_FS) {
>  79         return true;
>  80     }
>  81
>  82     return false;
>  83 }
>
> This will cause a problem that the SD bit in mstatus is not set to 1 when  FS in mstatus is modified from '00'b to '11'b with write_mstatus().

Thanks for looking into this.

There are patches on list fixing floating point errors. Can you check
if this branch fixes any issues you have:
https://github.com/palmer-dabbelt/qemu/commits/for-master

>
> file target/riscv/csr.c, func write_mstatus():
> 350     dirty = (riscv_cpu_fp_enabled(env) &&
> 351              ((mstatus & MSTATUS_FS) == MSTATUS_FS)) |
> 352             ((mstatus & MSTATUS_XS) == MSTATUS_XS);
> 353     mstatus = set_field(mstatus, MSTATUS_SD, dirty);
> 354     env->mstatus = mstatus;
>
> So checking fields D and F in the misa MSR (bit 3 and bit 5) may be an better way. That is
> bool riscv_cpu_fp_enabled(CPURISCVState *env)
>     if (env->misa & (MISA_F | MISA_F) {
>         return true;
>     }
>     return false;
> }

This doesn't seem right, just because the HW supports it doesn't mean
it's enabled.

Alistair

>
>
> --
> Ian Jiang

