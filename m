Return-Path: <SRS0=fVwN=XJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00BFC4CEC9
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 13:01:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4CBD206A4
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 13:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4CBD206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i97gJ-0007rK-RW
	for qemu-devel@archiver.kernel.org; Sat, 14 Sep 2019 09:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i97ec-0006vf-AB
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 08:59:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i97eY-00007w-Su
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 08:59:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45836)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i97eY-00007S-N7
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 08:59:50 -0400
Received: by mail-pf1-f196.google.com with SMTP id y72so19727740pfb.12
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2019 05:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=nS/Bkx5ETvR0+ddguHIK8HfguCPB04A7fuip6hdV0zk=;
 b=haQhleyEMuSHPbhS2P2iwx0Ea+MIVNAq318IcU58bHvHhq96ugE2nXnvmkTyy2ZGfs
 EriVMl/YPTPMg/Os2nk3m/jJ8T8lgvD+2prVLCmBezb3tBsz2MwG7jlkjwK8z7hHTvmn
 DjMwys4WqI6CLwOXFff2hUFN7fetZ7++uQr+dCC0l8xuXVrVd+O9XDE2iRX5jLD0+P8o
 qHFvF0MfbRwwjr4/sZyAYO7EE+73cl1/dVkj3C++zu7gdMpv4Iblh06itn3BeCcEVqAi
 9pFAQypmYIFxyn+N326QS97Cs573RYffTrVBs4Ua8OBkPPvpolRBkKEJ5eMPu5Ssp6m5
 pPJQ==
X-Gm-Message-State: APjAAAXA3/xJU8IOkp8jafTqNgUeFBoo9GCTVmqPSEPQOyEGrFWKkoq8
 ltkgijo7D4BwBLOnRol27Rd+Pg==
X-Google-Smtp-Source: APXvYqxzgTIlllV62yaI0pOs+DbLKXnTRJAMQ541M7FE42Ev7vPzdS/y7YPeA0p7PXwA6oeUFNboZw==
X-Received: by 2002:a17:90a:aa82:: with SMTP id
 l2mr11072854pjq.73.1568465989011; 
 Sat, 14 Sep 2019 05:59:49 -0700 (PDT)
Received: from localhost (amx-tls3.starhub.net.sg. [203.116.164.13])
 by smtp.gmail.com with ESMTPSA id z12sm50416072pfj.41.2019.09.14.05.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Sep 2019 05:59:48 -0700 (PDT)
Date: Sat, 14 Sep 2019 05:59:48 -0700 (PDT)
X-Google-Original-Date: Sat, 14 Sep 2019 05:23:48 PDT (-0700)
In-Reply-To: <CAL1e-=iyBP+k6MH+uCd7EAUAqp=hSG7SQOMemuJwdhJVGusYcg@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: aleksandar.m.mail@gmail.com
Message-ID: <mhng-307e8199-1ecf-4627-9d24-83656d2423f7@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.196
Subject: Re: [Qemu-devel] [PATCH v2 00/17] RISC-V: support vector extension
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
Cc: qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, riku.voipio@iki.fi,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com, laurent@vivier.eu,
 wenmeng_zhang@c-sky.com, Alistair Francis <Alistair.Francis@wdc.com>,
 zhiwei_liu@c-sky.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Sep 2019 00:00:56 PDT (-0700), aleksandar.m.mail@gmail.com wrote:
> 11.09.2019. 08.35, "liuzhiwei" <zhiwei_liu@c-sky.com> је написао/ла:
>>
>> Features:
>>   * support specification riscv-v-spec-0.7.1(
> https://content.riscv.org/wp-content/uploads/2019/06/17.40-Vector_RISCV-20190611-Vectors.pdf
> ).
>
> Hi, Zhivei.
>
> The linked document is a presentation, outlining general concepts of the
> instruction set in question, which is certainly useful and nice to have,
> but, for review process, we need *specifications* (especially given that
> they are in draft phase, and therefore "moving target"). Please provide
> such link.

Here's the V spec repository

    https://github.com/riscv/riscv-v-spec

and the exact 0.7.1 specification PDF

    https://github.com/riscv/riscv-v-spec/releases/download/0.7.1/riscv-v-spec-0.7.1.pdf

In RISC-V land this constitutes an official draft -- there's a whole process 
for getting a specification ratified, but that isn't done for these draft 
specifications.  The RISC-V QEMU maintainers agree that we'll take 
implementations of drafts as long as there's a concrete definition we can point 
at, like this one.

> I also noticed lack of commit messages, and was really disappointed by
> that. It looks to me you did not honor in entirety our guidlines for
> submitting patches.
>
> Yours,
> Aleksandar
>
>>   * support basic vector extension.
>
>>   * support Zvlsseg.
>
>>   * support Zvamo.
>
>>   * not support Zvediv as it is changing.
>>   * fixed VLEN 128bit.
>>   * fixed SLEN 128bit.
>>   * ELEN support 8bit, 16bit, 32bit, 64bit.
>>
>> Todo:
>>   * support VLEN configure from qemu command line.
>>   * move check code from execution-time to translation-time
>>
>> Changelog:
>> V2
>>   * use float16_compare{_quiet}
>>   * only use GETPC() in outer most helper
>>   * add ctx.ext_v Property
>>
>>
>> LIU Zhiwei (17):
>>   RISC-V: add vfp field in CPURISCVState
>>   RISC-V: turn on vector extension from command line by cfg.ext_v
>>     Property
>>   RISC-V: support vector extension csr
>>   RISC-V: add vector extension configure instruction
>>   RISC-V: add vector extension load and store instructions
>>   RISC-V: add vector extension fault-only-first implementation
>>   RISC-V: add vector extension atomic instructions
>>   RISC-V: add vector extension integer instructions part1,
>>     add/sub/adc/sbc
>>   RISC-V: add vector extension integer instructions part2, bit/shift
>>   RISC-V: add vector extension integer instructions part3, cmp/min/max
>>   RISC-V: add vector extension integer instructions part4, mul/div/merge
>>   RISC-V: add vector extension fixed point instructions
>>   RISC-V: add vector extension float instruction part1, add/sub/mul/div
>>   RISC-V: add vector extension float instructions part2,
>>     sqrt/cmp/cvt/others
>>   RISC-V: add vector extension reduction instructions
>>   RISC-V: add vector extension mask instructions
>>   RISC-V: add vector extension premutation instructions
>>
>>  linux-user/riscv/cpu_loop.c             |     7 +
>>  target/riscv/Makefile.objs              |     2 +-
>>  target/riscv/cpu.c                      |     6 +-
>>  target/riscv/cpu.h                      |    30 +
>>  target/riscv/cpu_bits.h                 |    15 +
>>  target/riscv/cpu_helper.c               |     7 +
>>  target/riscv/csr.c                      |    65 +-
>>  target/riscv/helper.h                   |   358 +
>>  target/riscv/insn32.decode              |   373 +
>>  target/riscv/insn_trans/trans_rvv.inc.c |   490 +
>>  target/riscv/translate.c                |     1 +
>>  target/riscv/vector_helper.c            | 25701
> ++++++++++++++++++++++++++++++
>>  12 files changed, 27049 insertions(+), 6 deletions(-)
>>  create mode 100644 target/riscv/insn_trans/trans_rvv.inc.c
>>  create mode 100644 target/riscv/vector_helper.c
>>
>> --
>> 2.7.4
>>
>>

