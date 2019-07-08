Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52680C606AC
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 12:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D88D20665
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 12:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D88D20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkT4g-0000bb-CG
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 08:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40938)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hkT2r-0008Vo-CU
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 08:47:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hkT2k-00046o-US
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 08:46:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44801)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hkT2e-00043Z-O6
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 08:46:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id k18so15750937ljc.11
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 05:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=Y/jtFao6VAyZjhlyG7vlyADHIkDbBiTq0IGy4aFAAnw=;
 b=ESZZhMpVabuyAGsdopLUgtKKnkSl0pWeXantMCEMMxxieUmx6g7LyNQF0zwFdEujO3
 mZ5hgu7a1Z8//FV4LK1FraHriKVOUqD/hxWkFdo149SgbiSwbvTZrndt6Wujwhvl2P48
 BAX8svWgTUCvB6+0YcO47QF5bJkiXBk0OvnUrKWmQK7ueyN3hKlaXDddERtGV921jQuH
 xje3sIgHAdYb6fM6juZqTnllf66cv9Sfqx4GtH534Jn/hZHBMeFKNytZbRd3QGmm5RcZ
 gZ44apxpNJg5saBA+sL/6RXXzbgvii45BrDkjDr8yTCQtR/gmlPuDzAG8wzP53XlEAdf
 Qelw==
X-Gm-Message-State: APjAAAVhsaTe1weR0Rg7ImEmf+22J69TQ5+bQfOXc1kZ8DCP0biUqY57
 MuT8oqzHxeDqeTKhnu+yiruBIA==
X-Google-Smtp-Source: APXvYqwq+eYH/ADKYDrC7K+UEUfe0PIs8dTk0JwZTzGIIJfQV3Ef6rlyPF1npketr68+2BunTQkE4g==
X-Received: by 2002:a2e:9209:: with SMTP id k9mr10168716ljg.96.1562590002984; 
 Mon, 08 Jul 2019 05:46:42 -0700 (PDT)
Received: from localhost ([134.17.27.127])
 by smtp.gmail.com with ESMTPSA id p9sm3664382lji.107.2019.07.08.05.46.41
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 08 Jul 2019 05:46:42 -0700 (PDT)
Date: Mon, 08 Jul 2019 05:46:42 -0700 (PDT)
X-Google-Original-Date: Mon, 08 Jul 2019 05:46:40 PDT (-0700)
In-Reply-To: <c64fa0e8-fd9c-8e86-418c-0553f56a0f34@linaro.org>
From: Palmer Dabbelt <palmer@sifive.com>
To: richard.henderson@linaro.org
Message-ID: <mhng-3d187b03-c0e9-4b44-aec3-1b09fcf01fa5@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.194
Subject: Re: [Qemu-devel] [Qemu-riscv] [PULL 10/34] RISC-V: Fix a PMP check
 with the correct access size
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, fintelia@gmail.com,
 Alistair Francis <Alistair.Francis@wdc.com>, Hesham.Almatary@cl.cam.ac.uk
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Jun 2019 11:23:20 PDT (-0700), richard.henderson@linaro.org wrote:
> On 6/27/19 7:44 PM, Jonathan Behrens wrote:
>> I think this patch is slightly incorrect. If the PMP region is valid for
>> the size of the access, but not the rest of the page then a few lines down
>> in this function the entire page should not be placed into the TLB. Instead
>> only the portion of the page that passed the access check should be
>> included. To give an example of where this goes wrong, in the code below
>> access to address 0x90000008 should always fail due to PMP rules, but if
>> the TLB has already been primed by loading the (allowed) address 0x90000000
>> then no fault will be triggered. Notably, this code also executes
>> improperly without the patch because the first `ld` instruction traps when
>> it shouldn't.
>>
>>   li t0, 0x0000000024000000 // region[0]: 0x90000000..0x90000007
>>   csrw pmpaddr0, t0
>>
>>   li t0, 0x00000000240001FF // region[1]: 0x90000000..0x90000fff
>>   csrw pmpaddr1, t0
>>
>>   li t0, 0x1F0000000000989F // cfg[0] = LXRW, cfg[1] = L
>>   csrw pmpcfg0, t0
>>
>>   sfence.vma
>>
>>   li t0, 0x90000000
>>   ld s0, 0(t0)
>>   ld s1, 8(t0) // NO TRAP: address is incorrectly in TLB!
>
> Nice test case.
>
>> I think that the proper fix would be to first do a PMP check for the full
>> PAGE_SIZE and execute normally if it passes. Then in the event the full
>> page fails, there could be a more granular PMP check with only the accessed
>> region inserted as an entry in the TLB.
>
> This feature looks to be almost identical to the ARM m-profile MPU.
>
> The fix is:
>
> If the PMP check is valid for the entire page, then continue to call
> tlb_set_page with size=TARGET_PAGE_SIZE.
>
> If the PMP check is valid for the current access, but not for the entire page,
> then call tlb_set_page with any size < TARGET_PAGE_SIZE.  This change alone is
> sufficient, even though the full argument tuple (paddr, vaddr, size) no longer
> quite make perfect sense.  (For the arm mpu, we compute some 1 << rsize, but
> the actual value is never used; setting size=1 would be sufficient.)
>
> Any size < TARGET_PAGE_SIZE will cause TLB_RECHECK to be set for the page,
> which will force all accesses to the page to go back through riscv_cpu_tlb_fill
> for re-validation.

RISC-V allows another option: support for fine-grained PMPs is optional, which
allows implementations ignore this issue to save on hardware costs.  It looks
like Rocket leaves this as a parameter

   https://github.com/chipsalliance/rocket-chip/blob/master/src/main/scala/rocket/TLB.scala#L159

but our implementations always have page-granularity PMPs if virtual memory is
supported.

Unless anyone objects, I'll restrict the PMP granularity to 4K on all systems
that support virtual memory as a bug fix.  We can add the configuration option
in as a feature.

>> Unrelated question: should I be sending "Reviewed By" lines if I read
>> through patches that seem reasonable? Or there some formal process I'd have
>> to go through first to be approved?
>
> No formal process.  More eyes are always welcome.
>
>
> r~

