Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB70BC433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 21:07:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E1D0206A2
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 21:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E1D0206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv6gC-0005K2-Pf
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 17:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40237)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hv6fc-0004au-Mn
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 17:07:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hv6fb-0000K8-L2
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 17:07:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41648)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hv6fb-0000Jr-E2
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 17:06:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so86010481wrm.8
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 14:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rflu0PqnXmUKKjsgAyG/gcGCZwVA5Kn/iN/r++OKgQE=;
 b=P0htRpN/Q476xHFsjFyeAwcfDNUr07OpfjzgbOa350M2F47AiejN4IUlxaItemQoQi
 qlBG4DC4LYM+zJTDSVVgGnvQHora9Eqzzr19hhCqEI+uy3LWg2n8ptO9EkGJ9qYNUVRm
 M6UMcGUt9bg99E0liPWx+DRkIgqDwkaXePQc1SNX6XuSeq0RglraTd3B0SdS9tHQvOwa
 rqdUN5dLrPI1LO4qlW6gSvskzYOSL1Ru6IbtaCaO/SXZLo5GxmQ6imonf6xWWE4D5KEb
 mgsuMQAsdugtyOwouV+l9fIdDn1EwLnpJELE/oQYX1RNmNQqMuLaDy8Wq9aCif92vw6D
 1yRQ==
X-Gm-Message-State: APjAAAWFSM2CnOMDfKjVtHC785d9ljncBAzmfSUp593DFMbjvfaHkoyW
 vCOguU7CYg7x1NSIhb8EseE9bw==
X-Google-Smtp-Source: APXvYqyjPCTw6TCPod1RiWOgLhsrUZDRJvtWueVbjG5PNXUtK1osiDn61UcFpflp/M2hUhm0IQp/PA==
X-Received: by 2002:a5d:4950:: with SMTP id r16mr6333567wrs.136.1565125618445; 
 Tue, 06 Aug 2019 14:06:58 -0700 (PDT)
Received: from [10.0.0.124] ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id f192sm91850102wmg.30.2019.08.06.14.06.56
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 06 Aug 2019 14:06:57 -0700 (PDT)
To: Bin Meng <bmeng.cn@gmail.com>, Chih-Min Chao <chihmin.chao@sifive.com>
References: <1564792052-6469-1-git-send-email-bmeng.cn@gmail.com>
 <CAEiOBXWQ02uRQQOpP=Rauq8WZnYtoxNqjM--Rpi5tHX2W0bGsw@mail.gmail.com>
 <CAEUhbmU-TdVocONETkSV-+DtX_66+8J8m3yYeph3P1i_3C9LzQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <11403b54-d41a-3083-7794-2c699a223479@redhat.com>
Date: Tue, 6 Aug 2019 23:06:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAEUhbmU-TdVocONETkSV-+DtX_66+8J8m3yYeph3P1i_3C9LzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH] riscv: sifive_e: Correct
 various SoC IP block sizes
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

On 8/5/19 8:43 AM, Bin Meng wrote:
> On Mon, Aug 5, 2019 at 2:14 PM Chih-Min Chao <chihmin.chao@sifive.com> wrote:
>> On Sat, Aug 3, 2019 at 8:27 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>>>
>>> Some of the SoC IP block sizes are wrong. Correct them according
>>> to the FE310 manual.
>>>
>>> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>>> ---
>>>
>>>  hw/riscv/sifive_e.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
>>> index 2a499d8..9655847 100644
>>> --- a/hw/riscv/sifive_e.c
>>> +++ b/hw/riscv/sifive_e.c
>>> @@ -53,13 +53,13 @@ static const struct MemmapEntry {
>>>      hwaddr base;
>>>      hwaddr size;
>>>  } sifive_e_memmap[] = {
>>> -    [SIFIVE_E_DEBUG] =    {        0x0,      0x100 },
>>> +    [SIFIVE_E_DEBUG] =    {        0x0,     0x1000 },
>>>      [SIFIVE_E_MROM] =     {     0x1000,     0x2000 },
>>>      [SIFIVE_E_OTP] =      {    0x20000,     0x2000 },
>>>      [SIFIVE_E_CLINT] =    {  0x2000000,    0x10000 },
>>>      [SIFIVE_E_PLIC] =     {  0xc000000,  0x4000000 },
>>> -    [SIFIVE_E_AON] =      { 0x10000000,     0x8000 },
>>> -    [SIFIVE_E_PRCI] =     { 0x10008000,     0x8000 },
>>> +    [SIFIVE_E_AON] =      { 0x10000000,     0x1000 },
>>> +    [SIFIVE_E_PRCI] =     { 0x10008000,     0x1000 },
>>>      [SIFIVE_E_OTP_CTRL] = { 0x10010000,     0x1000 },
>>>      [SIFIVE_E_GPIO0] =    { 0x10012000,     0x1000 },
>>>      [SIFIVE_E_UART0] =    { 0x10013000,     0x1000 },
>>> --
>>> 2.7.4
>>>
>>
>> It seems the modification follows  E310-G002(Hifive1 Rev B) spec and the origin is for E310-G000(Hifive1) spec.
>> There should be some way to specify different board version with different memory map or we have policy, always support the latest spec.

I agree with Chao, it would be cleaner to have two different boards
(machines).
Since the SoCs are very similar, you could add a 'revision' property and
use it to select the correct map.

>>
> 
> Yes, I checked both specs. The older spec says these bigger sizes,
> however their register sizes fit well in the smaller range as well. So
> I think the modification works well for both.

This is OK for the PRCI, since sifive_prci_create() does not use
memmap[SIFIVE_E_PRCI].size.

However the AON case is borderline, since you shrink it from 32KiB to 4KiB.

BTW (not related to this patch) it is odd a function named
sifive_mmio_emulate() creates a RAM region with memory_region_init_ram()
and does not use the UnimplementedDevice (see make_unimp_dev() in
hw/arm/musca.c).

> 
> Regards,
> Bin
> 

