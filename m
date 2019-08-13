Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA89C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 23:31:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAE9C20644
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 23:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE9C20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxgFt-0004CD-Qm
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 19:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60372)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hxgFV-0003kY-1z
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 19:30:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hxgFT-0001g3-VJ
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 19:30:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46412)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hxgFT-0001fK-Q8
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 19:30:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id w3so14856100pgt.13
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 16:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=arm4K0dKxYKw4Fxge2NFXBM/nUogYItcCwIYo5sd70w=;
 b=ICYjhQ9jiQm+xoKwDMWQyi8eKlFE7+sU3xbYDodPzGYcOw2olfbvBvDcoyCtO7EAyj
 +pH8W1kWnUThhvboakFyGI9AOC/wcilLs718DnIX95vdfp6Ysh37Gm+RtPTsPmkAg3M/
 S0uMw4f/4GwU+ylb6zgwhcoSiVjJ4n156OB0oVc2/m3aqSYGLfl0S2sIqLMExj6l0A30
 TKm5zjU7/fA4X1Ab+hoqy9RzsQsTDv/iQljgn7XR9X1F6H9dCYnBJ1ULzRFx63EfsEhg
 /x9m98zcHiqTWGw6YCEnmH3frWDi3uJoAwVfeMjPAXErKdIRcgiVaCjuktW7YHteJUiz
 h8vQ==
X-Gm-Message-State: APjAAAX8KAJduAIDJ4iCJRPi29dbGFl7kichEj+4sYFuV0OSmk/2Ej0k
 tpAMvRVr7DwGmG+rj4IDmad2BQ==
X-Google-Smtp-Source: APXvYqxLszqPSThKRjLAYe9DqoOaL3X5RvYYYX/b9g1U7WAMDOOLi+2VTUEQ26MR46Z4n718l2u85A==
X-Received: by 2002:a17:90a:71ca:: with SMTP id
 m10mr4541490pjs.27.1565739038179; 
 Tue, 13 Aug 2019 16:30:38 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id s24sm75455293pgm.3.2019.08.13.16.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2019 16:30:37 -0700 (PDT)
Date: Tue, 13 Aug 2019 16:30:37 -0700 (PDT)
X-Google-Original-Date: Tue, 13 Aug 2019 16:27:49 PDT (-0700)
In-Reply-To: <CAKmqyKNPW=Jtp3PUdwuSzjNE7g58WdureNxAWUnK_KZ-Z17HnQ@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: alistair23@gmail.com
Message-ID: <mhng-5f5b5d32-dff8-45cd-9644-dd40e502fca1@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.194
Subject: Re: [Qemu-devel] [PATCH v2 6/7] target/riscv: rationalise softfloat
 includes
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
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, armbru@redhat.com,
 Alistair Francis <Alistair.Francis@wdc.com>, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 09 Aug 2019 18:55:42 PDT (-0700), alistair23@gmail.com wrote:
> On Fri, Aug 9, 2019 at 2:22 AM Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> We should avoid including the whole of softfloat headers in cpu.h and
>> explicitly include it only where we will be calling softfloat
>> functions. We can use the -types.h and -helpers.h in cpu.h for the few
>> bits that are global.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> I just reviewed v1, but this also applies to v2:
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Acked-by: Palmer Dabbelt <palmer@sifive.com>

I'm assuming this are going in through another tree, along with the rest of the 
patch set.

>
> Alistair
>
>> ---
>>  target/riscv/cpu.c        | 1 +
>>  target/riscv/cpu.h        | 2 +-
>>  target/riscv/fpu_helper.c | 1 +
>>  3 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index f8d07bd20ad..6d52f97d7c3 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -27,6 +27,7 @@
>>  #include "qemu/error-report.h"
>>  #include "hw/qdev-properties.h"
>>  #include "migration/vmstate.h"
>> +#include "fpu/softfloat-helpers.h"
>>
>>  /* RISC-V CPU definitions */
>>
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index 0adb307f329..240b31e2ebb 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -22,7 +22,7 @@
>>
>>  #include "qom/cpu.h"
>>  #include "exec/cpu-defs.h"
>> -#include "fpu/softfloat.h"
>> +#include "fpu/softfloat-types.h"
>>
>>  #define TCG_GUEST_DEFAULT_MO 0
>>
>> diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
>> index b4f818a6465..0b79562a690 100644
>> --- a/target/riscv/fpu_helper.c
>> +++ b/target/riscv/fpu_helper.c
>> @@ -21,6 +21,7 @@
>>  #include "qemu/host-utils.h"
>>  #include "exec/exec-all.h"
>>  #include "exec/helper-proto.h"
>> +#include "fpu/softfloat.h"
>>
>>  target_ulong riscv_cpu_get_fflags(CPURISCVState *env)
>>  {
>> --
>> 2.20.1

