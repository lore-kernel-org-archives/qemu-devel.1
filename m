Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAF1C47256
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 01:39:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA2362072E
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 01:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2362072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUh7j-0005QX-0v
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 21:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jUh73-0004sZ-Sh
 for qemu-devel@nongnu.org; Fri, 01 May 2020 21:38:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jUh71-0005Jh-My
 for qemu-devel@nongnu.org; Fri, 01 May 2020 21:38:40 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:44700)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jUh71-0005Hy-7Y
 for qemu-devel@nongnu.org; Fri, 01 May 2020 21:38:39 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 2272974632C;
 Sat,  2 May 2020 03:38:26 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E54EE746344; Sat,  2 May 2020 03:38:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E3BCF746340;
 Sat,  2 May 2020 03:38:25 +0200 (CEST)
Date: Sat, 2 May 2020 03:38:25 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] target/m68k: Allow movec only on 68010+
In-Reply-To: <36b52da5-52f3-cc6e-8e76-36646e74c0e0@vivier.eu>
Message-ID: <alpine.BSF.2.22.395.2005020318440.35789@zero.eik.bme.hu>
References: <20200114202226.E859E745702@zero.eik.bme.hu>
 <alpine.BSF.2.22.395.2005011511210.62443@zero.eik.bme.hu>
 <36b52da5-52f3-cc6e-8e76-36646e74c0e0@vivier.eu>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1819840939-1588383505=:35789"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2001:738:2001:2001::2001
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1819840939-1588383505=:35789
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 1 May 2020, Laurent Vivier wrote:
> Le 01/05/2020 à 15:11, BALATON Zoltan a écrit :
>> Ping?
>
> I sent a comment:
>
> https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg02840.html

Thanks, I've somehow missed that, did not show up in my inbox for some 
reason. I wasn't sure about the FPU flag but did not find a better one 
without adding new flag for 68010. Lucien's patch is indeed more complete 
and should fix the same problem. So will that be merged then?

Regards,
BALATON Zoltan

> Thanks,
> Laurent
>
>>
>> On Tue, 14 Jan 2020, BALATON Zoltan wrote:
>>> The movec opcode does not exist on 68000 and should raise an
>>> exception. Fix the feature mask to only allow movec on newer 68k CPUs.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>> target/m68k/translate.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
>>> index fcdb7bc8e4..f19da064c8 100644
>>> --- a/target/m68k/translate.c
>>> +++ b/target/m68k/translate.c
>>> @@ -5988,7 +5988,7 @@ void register_m68k_insns (CPUM68KState *env)
>>>     BASE(stop,      4e72, ffff);
>>>     BASE(rte,       4e73, ffff);
>>>     INSN(cf_movec,  4e7b, ffff, CF_ISA_A);
>>> -    INSN(m68k_movec, 4e7a, fffe, M68000);
>>> +    INSN(m68k_movec, 4e7a, fffe, FPU);
>>> #endif
>>>     BASE(nop,       4e71, ffff);
>>>     INSN(rtd,       4e74, ffff, RTD);
>>>
>
>
--3866299591-1819840939-1588383505=:35789--

