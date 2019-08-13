Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B92C32753
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 22:55:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B530E2067D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 22:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B530E2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxfhM-0006pM-2E
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 18:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56745)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hxfgn-0005tr-Bk
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 18:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hxfgm-0006Ux-52
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 18:54:49 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39740)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hxfgl-0006Um-WB
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 18:54:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so52015891pgi.6
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 15:54:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=pD5kV7hqiohLthOgANLe54vWSLciZL41msmXwMzBgK4=;
 b=OiljFS1jXtw9A3LKOlFRfJnY2OaC5UN28KQkBtJkMDyD6re8la/T5E3omEOkU8sMUD
 kAsht/yQfr6YN8g9KPe/qU83gP6zDYbbq0tw/CxFsKT6uF1l74gx+hzih3vp17sGowM3
 N/MPw/zJubS0LnWS9GxraJfeRjfzLrdc/nP4j1m64EBnez7i8rs84V+NFfY3a8KYBnP2
 WibLfDR+cqnxpQdGxLd6XiAKsEWJ+eaK5Ur9eotaLIkM+FJDeo7ZN54HiD55E9sXPbIG
 6Cv+O1G8pmakL+Mjy7x9U6V/EPXvMVffVtH9vWyyfu6SYOQwyBfdCEzTKkJ27iXw0jbK
 yycw==
X-Gm-Message-State: APjAAAVvmVMZCohS+a3+3x4Y4lfjeYBkXD9BstPQk0zeROSvdOr8CPMd
 ElQhDe4r+hrpGLOH2yF1cTYEuw==
X-Google-Smtp-Source: APXvYqx4mBueSQ5W6b0hWa/YZxUwGK9etC0eIax1zALote8GRc+iqy9JOQmHgXUL3knOiux0707hwQ==
X-Received: by 2002:a63:2744:: with SMTP id n65mr35890254pgn.277.1565736886585; 
 Tue, 13 Aug 2019 15:54:46 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id v184sm108447072pfb.82.2019.08.13.15.54.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2019 15:54:46 -0700 (PDT)
Date: Tue, 13 Aug 2019 15:54:46 -0700 (PDT)
X-Google-Original-Date: Tue, 13 Aug 2019 15:53:41 PDT (-0700)
In-Reply-To: <CAKmqyKMKBsHO2QCYC1qeGTQa0cUMEpke17dgkB=hgQC-Nd9upw@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: alistair23@gmail.com
Message-ID: <mhng-5e88dcd2-80dc-4998-8622-b346d36650f6@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.193
Subject: Re: [Qemu-devel] [PATCH for 4.1] RISC-V: Ignore the S and U
 extensions when formatting ISA strings
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Atish Patra <Atish.Patra@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 07 Aug 2019 10:54:52 PDT (-0700), alistair23@gmail.com wrote:
> On Wed, Aug 7, 2019 at 8:00 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> The ISA strings we're providing from QEMU aren't actually legal RISC-V
>> ISA strings, as both the S and U extensions cannot exist as
>> single-letter extensions and must instead be multi-letter strings.
>> We're still using the ISA strings inside QEMU to track the availiable
>
> s/availiable/available/g
>
>> extensions, so this patch just strips out the S and U extensions when
>> formatting ISA strings.
>
> Atish and I were talking about this and we concluded that S and U
> aren't extensions, but should be reported in the misa CSR.

Andrew agrees.

>
>>
>> This boots Linux on top of 4.1-rc3, which no longer has the U extension
>> in /proc/cpuinfo.
>>
>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>> ---
>> This is another late one, but I'd like to target it for 4.1 as we're
>> providing illegal ISA strings and I don't want to bake that into a bunch
>> of other code.
>> ---
>>  target/riscv/cpu.c | 17 ++++++++++++++++-
>>  1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index f8d07bd20ad7..4df14433d789 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -501,7 +501,22 @@ char *riscv_isa_string(RISCVCPU *cpu)
>>      char *p = isa_str + snprintf(isa_str, maxlen, "rv%d", TARGET_LONG_BITS);
>>      for (i = 0; i < sizeof(riscv_exts); i++) {
>>          if (cpu->env.misa & RV(riscv_exts[i])) {
>> -            *p++ = qemu_tolower(riscv_exts[i]);
>> +            char lower = qemu_tolower(riscv_exts[i]);
>> +            switch (lower) {
>> +            case 's':
>> +            case 'u':
>> +                /*
>> +                 * The 's' and 'u' extensions shouldn't be passed in the device
>> +                 * tree, but we still use them internally to track extension
>> +                 * sets.  Here we just explicitly remove them when formatting
>> +                 * an ISA string.
>
> This should be updated to note mention 's' and 'u' as extensions, but
> clarify that they are correctly include in the misa CSR.

I'll send a v2 that cleans up the wording on the comment and commit message.

>
> Alistair
>
>> +                 */
>> +                break;
>> +
>> +            default:
>> +                *p++ = qemu_tolower(riscv_exts[i]);
>> +                break;
>> +            }
>>          }
>>      }
>>      *p = '\0';
>> --
>> 2.21.0
>>
>>

