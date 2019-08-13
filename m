Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FE4C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 22:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA1B620644
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 22:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1B620644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxfX6-0000b1-5S
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 18:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55386)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hxfWi-0000AC-LV
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 18:44:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hxfWh-0003Ee-EE
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 18:44:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33849)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hxfWh-0003EJ-9W
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 18:44:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so45788102pgc.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 15:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=sJIocxls5v7/F9lnrVCDJBoHU+q1YnklqThtqdk9Kz4=;
 b=eigVnqTJfCSMbr4YLbf4TpVxPCx4tVtldU07yNbMPENKtlRei9W6Wi5QBMGCwId6U7
 QA00gp6SsYRbjbw832H/8xkUQKgAs+9pDC+EKx5uucjR3OpzlrhGD/EXhB1OvWYjeZQa
 wDR8ElcI3B8zBBZ3rL11hMDtLmBVg+K3a2cZS0iYfy5CsrunQ3HYiqytioI/tZy/VWnv
 ENkBtA9Zz5NT1riCiw2cdOyrM66g4vW9Jj8Qxg5Krl8vuqbKJhVDbxXB7MzhuUYm9OEn
 fTr2/+nrZiSIDx1qhWyO1PKw46OZsC3VJ2g3QhLlQv7kWCerl6ujNApN+ZwGqkIRqFXI
 oZ9w==
X-Gm-Message-State: APjAAAXuy5e00hZEros8PZGZMYPTCv7eJgXDyIqkO/y9HWUROtY2VV1h
 TSM18JvunglpPRtX0D3RNbUIuMHaopE=
X-Google-Smtp-Source: APXvYqwbvxlulGm8svsBkzFA7P0HPvrJDdmkuIdJTPi+TOwWwrnvSUdLJhVlQcAG/3cWMcLVHnspdQ==
X-Received: by 2002:a63:2b8e:: with SMTP id r136mr6818998pgr.216.1565736261420; 
 Tue, 13 Aug 2019 15:44:21 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id u7sm99025672pgr.94.2019.08.13.15.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2019 15:44:20 -0700 (PDT)
Date: Tue, 13 Aug 2019 15:44:20 -0700 (PDT)
X-Google-Original-Date: Tue, 13 Aug 2019 15:43:48 PDT (-0700)
In-Reply-To: <CAFEAcA-A5P+2XE49dg582CRtDPH0CXevyYfkGkaDH3HN=NFYcg@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <mhng-19b0dd58-7f8d-45a6-ac6b-049be291d2a7@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.193
Subject: Re: [Qemu-devel] [PULL 04/32] target/riscv: Implement
 riscv_cpu_unassigned_access
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 01 Aug 2019 08:39:17 PDT (-0700), Peter Maydell wrote:
> On Wed, 3 Jul 2019 at 09:41, Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> From: Michael Clark <mjc@sifive.com>
>>
>> This patch adds support for the riscv_cpu_unassigned_access call
>> and will raise a load or store access fault.
>>
>> Signed-off-by: Michael Clark <mjc@sifive.com>
>> [Changes by AF:
>>  - Squash two patches and rewrite commit message
>>  - Set baddr to the access address
>> ]
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>
> Oops, I missed seeing this go by. The do_unassigned_access
> hook is deprecated and you should drop this and use
> the do_transaction_failed hook instead.
>
> The distinction between the two is that do_unassigned_access
> will end up being called for any failing access, including
> not just "normal" guest accesses but also for bad accesses
> that happen during page table walks (which often want to
> be reported to the guest differently) and also accesses
> by random devices like DMA controllers (where throwing a
> cpu exception is always a bug).
>
> Changing the hook implementation itself should be straightforward;
> commit 6ad4d7eed05a1e23537f is an example of doing that on Alpha.
> You also want to check all the places in your target code that
> do physical memory accesses, determine what the right behaviour
> if they get a bus fault is, and implement that (or at least put
> in TODO comments).

Sorry, updating that has been on my TODO list for a while now.  I figured it 
was better to have the deprecated version in there than nothing at all.  I've 
written some patches to fix this, but I want to give them another look before 
sending them out.

