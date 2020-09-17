Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5E9C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:49:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27051208DB
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TodAUhHF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27051208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIrTw-0001AJ-0j
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 06:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kIrT5-0000DF-2H
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 06:48:47 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a]:45645)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kIrT2-0008Ca-P3
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 06:48:46 -0400
Received: by mail-ej1-x62a.google.com with SMTP id i26so2551601ejb.12
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 03:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=y8R/+zN5FyprwUhVdaC38+E1m7re4VxkWi0ofwGpsIo=;
 b=TodAUhHFwYYrBNpANrFisXXcX4ARcf4+WsmKUzRMpOcCXKbUuptuaAcptOOpwfjRSK
 I2RRDKqAOw4QL86kOD/lZSqvRBrG7W07SqYPvAtZMA5l6yFb9d/LcXIZpmqvS84y3Agc
 qw7lP0b3NIgEGBUSmwKAnUJGjYJXkd87fE5cL6ThmkxXwLnHNnAaWDnDDmFfDqtv2g1U
 VekWbY7mUykaDNzXv1nAstecQJ0MRT7gJNnXs5HyhRSzw6+pjbS78k41VoQjdGrU58la
 9sKG8aK+ONJPLrRs4Hb1/VFyTOAV8gyFNm6L4Xxh8YQBmWylnCDrbi16iWdjKSQ3W414
 xBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y8R/+zN5FyprwUhVdaC38+E1m7re4VxkWi0ofwGpsIo=;
 b=PjbJTIZVKLSjjc79vQG+QBynHalkoNc2D/ilpwfw6UGEsGMCGPzcvHp6/vLbB7n6Z+
 rLMPhI3TC8flcQESSqOEzpMbGJC8CFH9mzxyHVu6GLCfUk9K3jIS5N12ZVIYYg6qUMTE
 9bEXYY/e+u3iVt6LFV2dXeXY9tGMb1ORhYkoKjrnI6cGhEMZwVADqwAbhth8v/OsHZFj
 Z3Ior9C6kd/UPA7KS9VlJzhNMNH/xa7E/3MYD5bzNuQBUj47Bm3voY/jJE4ZxH6oIxvu
 Yeo61evnoBeOh0KTrCt55qxbpx1VUchT62NlxjFVkQKCy3TMxZQAw1sIwbFdqc+1bV28
 e4Ig==
X-Gm-Message-State: AOAM532IjQpfdjZKTknkgnBLleucFaOEaW7KsLyRL77640g5cLden5VT
 5+sswNq+5CKXIAbHLJ0OPnhbgvKoYocJkvq3/nY9Lw==
X-Google-Smtp-Source: ABdhPJxY8pC1+NEtBu1X4FaeadD/ImD5s7EQAn9p6Pjh/OoZX8nxXPQmyBhtBRFiKU0y/y4Vn+qR33wGuo5AhN7i8rU=
X-Received: by 2002:a17:906:24d6:: with SMTP id
 f22mr29334810ejb.85.1600339723173; 
 Thu, 17 Sep 2020 03:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_51E8948B9AE5AD5676A1A5DE2787377A3A05@qq.com>
In-Reply-To: <tencent_51E8948B9AE5AD5676A1A5DE2787377A3A05@qq.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Sep 2020 11:48:32 +0100
Message-ID: <CAFEAcA_Oshc=ciXn-Y-RfF3=ZMfw1s08mQNtjrMeRzVjiAG9+g@mail.gmail.com>
Subject: Re: Why QEMU treats each instruction as one translation block?
To: casmac <climber.cui@qq.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

On Thu, 17 Sep 2020 at 07:11, casmac <climber.cui@qq.com> wrote:
>
>   The loader works functionally, but we then found that sometimes QEMU is down-graded - it treats each instruction as one TB. In version 4.2,  debugging shows
> that get_page_addr_code_host() from accel/tcg/cputlb.c returns -1, as shown below.
>
> accel/tcg/cputlb.c:
> tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, target_ulong addr,
>                                         void **hostp)
> {
>     uintptr_t mmu_idx = cpu_mmu_index(env, true);
>     uintptr_t index = tlb_index(env, mmu_idx, addr);
>     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
>     void *p;
>
>     //.....
>     if (unlikely(entry->addr_code & TLB_MMIO)) {
>         /* The region is not backed by RAM.  */
>         if (hostp) {
>             *hostp = NULL;
>         }
>         return -1;        /* debugging falls to this branch, after this point QEMU translate one instruction to a TB  */
>     }
>     //.......
> }
>     One intresting fact is that this somehow depends on the linker command file. The object file generated by the following linker command file(per_instr.lds)
> will "trigger" the problem. But QEMU work well with the object file linked by the other linker command file (ok.lds).
>     What cause get_page_addr_code_hostp() function to return -1?

This happens when the code has been loaded to something that
is not "normal RAM" (eg it is a device). That is, if your
guest ELF file (or COFF file in your case) has headers saying
"load this code to address X", and address X isn't actually
RAM (or ROM, or a flash memory that's in read-mode), then
you'll get the slow-path. In normal usage this almost never
happens, because only weird ELF files (or ELF files that
were intended to be run on a completely different machine model)
try to load code to something other than RAM or ROM.

Exactly when this will happen will depend on the machine model
you're using and what devices and RAM it puts where in the
memory map. You should look at what address the code gets
loaded to and what is present at that address in the board
model you're using.

thanks
-- PMM

