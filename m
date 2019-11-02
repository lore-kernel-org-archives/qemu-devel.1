Return-Path: <SRS0=rFyn=Y2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BA2CA9EC7
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 19:59:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA5B2080F
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 19:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA5B2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQzYW-0006EQ-I5
	for qemu-devel@archiver.kernel.org; Sat, 02 Nov 2019 15:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iQzXm-0005pn-U6
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 15:58:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iQzXl-0006Qe-PC
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 15:58:42 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:56393)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iQzXl-0006P2-FA
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 15:58:41 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MIMT4-1iChnE37g4-00EIyg; Sat, 02 Nov 2019 20:58:36 +0100
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191102171511.31881-1-laurent@vivier.eu>
 <20191102171511.31881-3-laurent@vivier.eu>
 <b9f724f7-1bd9-3283-ab20-0038ab278251@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 2/3] dp8393x: fix dp8393x_receive()
Message-ID: <ffcb2ea1-3adc-d65f-c707-6b75278d7fec@vivier.eu>
Date: Sat, 2 Nov 2019 20:58:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <b9f724f7-1bd9-3283-ab20-0038ab278251@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TKxSg8MKidv6pkX6FUqG8qyynbdMChkWG99FPWx75h/zzKdB0vs
 G/26kPDtJoZk073FqHdU6GCxFWQCPORER8HgtuHJXIcXUVc3Go40jp/R0oxmmiRukDKvft+
 VMk1PKjo+e4EnmFkaNjqOk7PIlXhK83Tj/YfH9lFRDEnT80J+maz3aCkNRCjsOTON2eiFS3
 X2NUK75FlTZ9SH6hjtveA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r5tNS9nvxR8=:tpmaVE3bHTF5HlRcr4t/8p
 qrgnOlWKzqcqWO+enVzU2DoItr5Mu5809S2GYgCdT1DRxBk3pjseuiCRZTBojRs0aRmLhtyFX
 sUANzyElVHlT+HB8UpJCMbzOwWMBj6V90kdg/pAw3nswDoEZFh57d3A+OA/WScKHIFWCfBSy3
 +Afn9XhttSSPfYXk/12eXccIXoWJG9b1cp5eQK22genEa18/0vSMN+Hq+Lu67KlQzrluWA3/H
 ByA3sXDslPTEjWPh6ej51Z55G0zdC4w4dKzJUD3eMluGHdNN0AheXliQKH626tyObAx6vpjun
 2ADaUse4uKSuieStwsYafctnopELv41sG6Pb1e/L5oiM8OVpUtH/iulrsC7opnKXcIOD8eSvF
 igaEb4UhXPeiiL8HW+4j3S4HxdbHVZpfPlnanMWY58xH3nFSW8tsbKSY2xkndb/Oc/xpgsGNZ
 DzkgPv1aXF3VmvleX/zhOqnqWSk4ySKi738KZE3NOFbXFF0wZTJpKJbCGT4L+5dzai8ee1Eef
 p72Klt0hf4YV+Qa08/W9MfPID0B5dq0Rns7hHsT+1/VpG5FTf1Xce9UTdJhJ9cWnlbOYjH5jX
 LtT7D+JeMLVDk/rEvVfi00nSJHRAYYjGFNxfIEhFaAqwBfwo9XmdpbnSSjiDbTcC0Mx/5lhVh
 oArdhWDt0I/3FvtWAz+tsggv9vOGfGem09+u7r1mL3M5x5pp66h8GGkXTwL1uU9O4v2upwivJ
 oUO0SnGU8OaeCMpuFp+yps3tfnwUhiwkSvyluzOCCrB9M6EV4nB5nrYYN3l8kUJoRSgm8J+dn
 J82rpyN6PsdfDJWczOuQxBLl97AXB/93ck9zggk/F7BsA+klrtBYEzquGOwLBC44N9ogZmbo7
 DgW+s0xn3y0vAHDsom+Zi1B3/m88YLobfxl1QwMzM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.73
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
Cc: Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 02/11/2019 à 20:41, Philippe Mathieu-Daudé a écrit :
> On 11/2/19 6:15 PM, Laurent Vivier wrote:
>> address_space_rw() access size must be multiplied by the width.
>>
>> This fixes DHCP for Q800 guest.
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>   hw/net/dp8393x.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
>> index 85d3f3788e..b8c4473f99 100644
>> --- a/hw/net/dp8393x.c
>> +++ b/hw/net/dp8393x.c
>> @@ -833,7 +833,7 @@ static ssize_t dp8393x_receive(NetClientState *nc,
>> const uint8_t * buf,
>>       } else {
>>           dp8393x_put(s, width, 0, 0); /* in_use */
>>           address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t)
>> * 6 * width,
>> -            MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data,
>> sizeof(uint16_t), 1);
>> +            MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 1);
> 
> Which is following:
> 
>     if (s->regs[SONIC_LLFA] & 0x1) {
>         size = sizeof(uint16_t) * 1 * width;

but we have "size = sizeof(uint16_t) * width;" later.

This file needs cleanup...

> So OK (you describe 'width' but use 'size').
>

I meant the access size "sizeof(uint16_t)" must be adjusted by the width
of the bus (defined by (s->regs[SONIC_DCR] & SONIC_DCR_DW). [1]

And this is exactly what contains "size".

> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 

Thanks,
Laurent

[1] DP83932C-20/25/33 MHz SONIC (tm) Systems-Oriented Network Interface
Controller

"1.3 DATA WIDTH AND BYTE ORDERING

The SONIC can be programmed to operate with either
32-bit or 16-bit wide memory. The data width is configured
during initialization by programming the DW bit in the Data
Configuration Register (DCR, Section 4.3.2). If the 16-bit
data path is selected, data is driven on pins D15– D0."

