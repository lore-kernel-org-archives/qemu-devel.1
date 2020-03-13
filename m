Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A5CC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 23:40:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 018BC2074C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 23:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1N5ztFV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 018BC2074C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCtuS-0005XG-28
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 19:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jCttj-00055I-6u
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 19:39:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jCtth-0008QM-Rq
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 19:39:23 -0400
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42]:46691)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jCtth-0008Po-M3; Fri, 13 Mar 2020 19:39:21 -0400
Received: by mail-vs1-xe42.google.com with SMTP id z125so7469722vsb.13;
 Fri, 13 Mar 2020 16:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=m96dyMlNqw0+5Tu/MZ8SrGlEj2lnDxG27/rqi+LYMnk=;
 b=C1N5ztFVW0yrkSqWHFXCO52jLAoCaY9P2baUG3zeicMoUehMSlfVGsOfx7UjyzUnpy
 wfzKTewVUcKTZ8siGR7dNgRQwJ+mRTWcgWt2QbYZTdcfmxYIqe8VaAPxXj5xcFWQqu0R
 bHSTNsESRv3n0T/1pVJqatoJby4jfy35Qyx8dv0GN5zFyuUFUdFri4nvWnvqBsSALwCs
 wgyyBpDEUuLpO+Q1xXxlcGxWq9KRAzUQdGkz80GgFD4YWpsqbhLRQxpS2aKtFUVC+dGx
 iQUH4+RnhfeHuq5fOZL7sskJ+fQMjKKSRc+XQGnH9kNj9Ba5Ta6Khqp0D5yy553viilV
 L3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=m96dyMlNqw0+5Tu/MZ8SrGlEj2lnDxG27/rqi+LYMnk=;
 b=W8FcdFABSXoaEbS9ePG6wkqGhdLcMAb5En0KveJnz4mwpsCPxhHAUF7pSAO50FxIHi
 bjoqpBmifGw6iRllPoTzphX+2zuk6wpKY51Kwg00n8upo5iVCaThvAUj5MIE6E7ycSch
 wLdbapFJjm2QH1Wpr6ew1dILFKTOuVcvo/CMyr3S391Do7t58RGgC57C+FDN3gXuvtG1
 DGaulTbta+SA8UJNtKQZeSsrBNBJYKBFdN3B4I53YnJd9hzwED+BJsE2stinl6WKig9A
 GmFNB5zB3O9XabhcgsX4yfqPB++c9fOz0E0yUA37eovGsHW8euzllJqPT/PBRgUXJCOY
 Zp3w==
X-Gm-Message-State: ANhLgQ0o0QMB180g9tQyPOt0L/SYUe3eEXb8d6tCgL+B1paRy2I2i9PE
 8aGe2qQXap/ZDqHBTdhXLxe6r+681zOFthNpu3s=
X-Google-Smtp-Source: ADFU+vsN8kO94vC7pEd/emugeGAVuWnm+SPfG0+OhKUeeyWnJ8XtlICeYB4yW2Q3HvpgAhNgurT6hm+Ufom0jnksODM=
X-Received: by 2002:a67:e09a:: with SMTP id f26mr9515622vsl.70.1584142760828; 
 Fri, 13 Mar 2020 16:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-6-zhiwei_liu@c-sky.com>
 <CAKmqyKOiKUqzGSDd1+TvqhCT6pjeEXEX-QVzYhcaiRa-y4D98w@mail.gmail.com>
 <445d93e8-1d2c-9877-84a3-ed62a5920d89@c-sky.com>
 <CAKmqyKNU3En33CO-+k2JF4aTNw9BEbBzthcRQsZ6oHnW962NRQ@mail.gmail.com>
 <4afbf97a-ea6d-2ed3-7b5a-c58e59172c9d@c-sky.com>
In-Reply-To: <4afbf97a-ea6d-2ed3-7b5a-c58e59172c9d@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 13 Mar 2020 16:38:54 -0700
Message-ID: <CAKmqyKNCdFp--okyLK_bjkQwpFTQX62b_rZTnOGJhReqCvzoQA@mail.gmail.com>
Subject: Re: [PATCH v5 05/60] target/riscv: add vector stride load and store
 instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e42
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
Cc: guoren@linux.alibaba.com, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wxy194768@alibaba-inc.com, Chih-Min Chao <chihmin.chao@sifive.com>,
 wenmeng_zhang@c-sky.com, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 13, 2020 at 3:17 PM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
>
>
> On 2020/3/14 6:05, Alistair Francis wrote:
> > On Fri, Mar 13, 2020 at 2:32 PM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
> >>
> >>
> >> On 2020/3/14 4:38, Alistair Francis wrote:
> >>> On Thu, Mar 12, 2020 at 8:09 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
> >>>> Vector strided operations access the first memory element at the base address,
> >>>> and then access subsequent elements at address increments given by the byte
> >>>> offset contained in the x register specified by rs2.
> >>>>
> >>>> Vector unit-stride operations access elements stored contiguously in memory
> >>>> starting from the base effective address. It can been seen as a special
> >>>> case of strided operations.
> >>>>
> >>>> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> >>>> ---
> >>>>    target/riscv/cpu.h                      |   6 +
> >>>>    target/riscv/helper.h                   | 105 ++++++
> >>>>    target/riscv/insn32.decode              |  32 ++
> >>>>    target/riscv/insn_trans/trans_rvv.inc.c | 340 ++++++++++++++++++++
> >>>>    target/riscv/translate.c                |   7 +
> >>>>    target/riscv/vector_helper.c            | 406 ++++++++++++++++++++++++
> >>>>    6 files changed, 896 insertions(+)
> >>>>
> >>>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> >>>> index 505d1a8515..b6ebb9b0eb 100644
> >>>> --- a/target/riscv/cpu.h
> >>>> +++ b/target/riscv/cpu.h
> >>>> @@ -369,6 +369,12 @@ typedef CPURISCVState CPUArchState;
> >>>>    typedef RISCVCPU ArchCPU;
> >>>>    #include "exec/cpu-all.h"
> >>>>
> >>>> +/* share data between vector helpers and decode code */
> >>>> +FIELD(VDATA, MLEN, 0, 8)
> >>>> +FIELD(VDATA, VM, 8, 1)
> >>>> +FIELD(VDATA, LMUL, 9, 2)
> >>>> +FIELD(VDATA, NF, 11, 4)
> >>>> +
> >>>>    FIELD(TB_FLAGS, VL_EQ_VLMAX, 2, 1)
> >>>>    FIELD(TB_FLAGS, LMUL, 3, 2)
> >>>>    FIELD(TB_FLAGS, SEW, 5, 3)
> >>>> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> >>>> index 3c28c7e407..87dfa90609 100644
> >>>> --- a/target/riscv/helper.h
> >>>> +++ b/target/riscv/helper.h
> >>>> @@ -78,3 +78,108 @@ DEF_HELPER_1(tlb_flush, void, env)
> >>>>    #endif
> >>>>    /* Vector functions */
> >>>>    DEF_HELPER_3(vsetvl, tl, env, tl, tl)
> >>>> +DEF_HELPER_5(vlb_v_b, void, ptr, ptr, tl, env, i32)
> >>>> +DEF_HELPER_5(vlb_v_b_mask, void, ptr, ptr, tl, env, i32)
> >>> Do you mind explaining why we have *_mask versions? I'm struggling to
> >>> understand this.
> >> When an instruction with a mask, it will only operate the active
> >> elements in vector.
> >> Whether an element is active or inactive is predicated by a mask
> >> register v0.
> >>
> >> Without mask, it will operate every element in vector in the body.
> > Doesn't the mask always apply though? Why do we need an extra helper?
> Yes, mask is always applied.
>
> As you can see,  an extra helper is  very special for unit stride mode.
> Other
> instructions do not have the extra helpers.
>
> That's because a more efficient implementation is possible for unit stride
> load/store with vm==1(always unmasked).
>
> It will operate a contiguous memory block, so I can probe the memory access
> and clean the tail elements more efficient.

Ah ok. I think I get what you are saying. I think this is all ok then.
I'll review the next version (after you have split it).

Alistair

>
> Zhiwei

