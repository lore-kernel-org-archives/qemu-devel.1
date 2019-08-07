Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21F3C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8E0A222FC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7LDUm3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E0A222FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvIPB-0005Mf-14
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 05:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59025)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvIOo-0004vv-2K
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:38:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvIOn-0004F4-4F
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:38:26 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:34394)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hvIOm-0004Eg-Se; Wed, 07 Aug 2019 05:38:25 -0400
Received: by mail-ed1-x542.google.com with SMTP id s49so50782367edb.1;
 Wed, 07 Aug 2019 02:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=E7OPrDfKUCQOtGnRnv49nywDmsT5mWNpTufr6o0c+Uc=;
 b=F7LDUm3jrZ1u24V4zfdOYm31iT1E3CnHAcCGDnChza97x8lf+2gHZl40aS8bdDKePs
 67YJtPpyhArgmjQ/ltz95O6q3Zdid1T60bDTqtQT0jx+FJmI+WWPB3DkfowqUM9WXALk
 1JzTc5TWOuFTnct1lCEahBT3tXuUnICLt1PoW34SG7YJ5OsYrVLaRBXFd77HeWjlJJW0
 TeRy64s862Ttss/CZmvqBjrBVonTfbMbIBu5FzG724eTC+Njeb/Etj+4yk1NjzpC1pI7
 X+JFryIewNPRAWf9vtSC0vxt+dzB6cMXyFU559iT5SsWNh+oBdfHyB/HIPT57ekoGeQq
 Eh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E7OPrDfKUCQOtGnRnv49nywDmsT5mWNpTufr6o0c+Uc=;
 b=M5vw0AOU5hIIP49k9pPV15naQ99VD0mMU/bfx9N2piE9bPM3c4h2BQ/BLlBcUsHahM
 ufqaN69zQn8aT6jwv9zhCaiEn6NlCFimknP68Tbbs79Y9yVyF97lmXT6KqpLpKJuaKJV
 6Rb+ViAAZ31eWSAhti6Zk0kpFScKMpxxO8H3pZMU0g14iR2jyvu0LusQgjgCwV2faGEs
 jupVmpw/vQ7BySF+m5IVn6STRqmFT4Mm36NRhYJrnwpUdXwyWBXluhLxCL6IV7nD6uWq
 EMWEoOrTZnXp86JF6ajocJ1qkuSDbRiypHnD07YwwoCVRBVLacZ4iLpSW2O8aW1gZeb5
 N7OA==
X-Gm-Message-State: APjAAAWH/b1QUluu36H2DaVXmZ9ftN0EN0kFRDt8z8FTs5Ov+GDjNlX1
 gc0faFxTGY4DnQV9xiYCom4aapLMG7JosWDX334=
X-Google-Smtp-Source: APXvYqzPQphNRPiyKdT0hmeXg+4QNhMLuSTapfpCIUBgHUyCkzabAbOp8gKahJOjPjLU463YazPl1u6wdGP58fmgKD4=
X-Received: by 2002:a50:886a:: with SMTP id c39mr8591811edc.214.1565170703816; 
 Wed, 07 Aug 2019 02:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
 <1565163924-18621-10-git-send-email-bmeng.cn@gmail.com>
 <CAEiOBXV1S_hOesF65YTi6EqKeYHjW+rByPgfcEg1yeET696KRw@mail.gmail.com>
In-Reply-To: <CAEiOBXV1S_hOesF65YTi6EqKeYHjW+rByPgfcEg1yeET696KRw@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 7 Aug 2019 17:38:12 +0800
Message-ID: <CAEUhbmWrcbmpvD_7Y=To-R4NU58ri6fyPP9aUWSTGx_7byxeYg@mail.gmail.com>
To: Chih-Min Chao <chihmin.chao@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v2 09/28] riscv: sifive_u: Update UART base
 addresses
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 7, 2019 at 5:25 PM Chih-Min Chao <chihmin.chao@sifive.com> wrote:
>
>
>
> On Wed, Aug 7, 2019 at 3:48 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>>
>> This updates the UART base address to match the hardware.
>>
>> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>> Reviewed-by: Jonathan Behrens <fintelia@gmail.com>
>> Acked-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>
>> Changes in v2: None
>>
>>  hw/riscv/sifive_u.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
>> index fe8dd3e..ea45e77 100644
>> --- a/hw/riscv/sifive_u.c
>> +++ b/hw/riscv/sifive_u.c
>> @@ -61,8 +61,8 @@ static const struct MemmapEntry {
>>      [SIFIVE_U_MROM] =     {     0x1000,    0x11000 },
>>      [SIFIVE_U_CLINT] =    {  0x2000000,    0x10000 },
>>      [SIFIVE_U_PLIC] =     {  0xc000000,  0x4000000 },
>> -    [SIFIVE_U_UART0] =    { 0x10013000,     0x1000 },
>> -    [SIFIVE_U_UART1] =    { 0x10023000,     0x1000 },
>> +    [SIFIVE_U_UART0] =    { 0x10010000,     0x1000 },
>> +    [SIFIVE_U_UART1] =    { 0x10011000,     0x1000 },
>>      [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
>>      [SIFIVE_U_GEM] =      { 0x100900FC,     0x2000 },
>>  };
>> --
>> 2.7.4
>>
>>
>
> By the way,  OpenSBI also needs a patch to fix the same problem.
>

No, with this series, sifive_u is not a special target any more and
sifive/fu540 should be set to PLATFORM in the OpenSBI build for the
'sifive_u' machine.

I will send a patch to OpenSBI to drop the 'sifive_u' support.

> Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>

Regards,
Bin

