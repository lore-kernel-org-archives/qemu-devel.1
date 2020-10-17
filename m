Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B580EC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 16:40:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3002B2074A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 16:40:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3002B2074A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTpGI-0001HQ-BX
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 12:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kTpEw-0000bc-DO; Sat, 17 Oct 2020 12:39:30 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:12566)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kTpEs-0003ub-Ne; Sat, 17 Oct 2020 12:39:28 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 7ED22747620;
 Sat, 17 Oct 2020 18:39:21 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 47B12746383; Sat, 17 Oct 2020 18:39:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 460E4746331;
 Sat, 17 Oct 2020 18:39:21 +0200 (CEST)
Date: Sat, 17 Oct 2020 18:39:21 +0200 (CEST)
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH v8 0/5] Mac Old World ROM experiment (ppc/mac_* clean
 ups and loading binary ROM)
In-Reply-To: <7c34f053-268e-6dbf-205f-48792328ebe8@amsat.org>
Message-ID: <edb86311-6093-9776-a81-17ee8205a6c@eik.bme.hu>
References: <cover.1602805637.git.balaton@eik.bme.hu>
 <005ed95d-65ee-ab36-c068-e96a773ef8ed@ilande.co.uk>
 <7c34f053-268e-6dbf-205f-48792328ebe8@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-1657179590-1602952422=:25114"
Content-ID: <22851748-2598-35dd-fb46-3d8eddb336df@eik.bme.hu>
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: BALATON Zoltan <balaton@eik.bme.hu>
From: BALATON Zoltan via <qemu-devel@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1657179590-1602952422=:25114
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <cb2561cb-7fcd-c7b4-58e-588427fe5149@eik.bme.hu>

On Fri, 16 Oct 2020, Philippe Mathieu-Daudé wrote:
> On 10/16/20 11:58 AM, Mark Cave-Ayland wrote:
>> On 16/10/2020 00:47, BALATON Zoltan via wrote:
>> 
>>> This is the cut down version of the earlier series omitting unfinished
>>> patches that I plan to rework later and rebased to Mark's qemu-macppc
>>> branch. Compared to v7 the only change is the cast to (target_ulong)
>>> from (uint32_t) as requested by Mark in patch 1.
>> 
>> FWIW the reason for suggesting the cast to target_ulong is so that the same 
>> code works for both qemu-system-ppc and qemu-system-ppc64. For 
>> qemu-system-ppc that should correctly drop the sign extension from 32-bit, 
>> whilst still allowing someone to load a 64-bit ELF into qemu-system-ppc64 
>> if requested.
>
> IMO this is part of a bigger design problem. Not all
> machines main bus is 64-bit. I did some experiments
> but changing that involves a lot of work.

Did not want to reply to this to not bring it to your attention before 
patch gets in finally but it's too late...

Not sure what you refer to but in this particular case the problem only 
seems to be load_elf loading 32 bit ELF files returning sign extended 64 
bit address which looks bogus but since this function is widely used I did 
not feel confident enough to propose a patch to load_elf.

By the way, also the parameters of load_elf could take a clean up to 
remove all the mostly NULL values as I've pointed out before:

https://lists.nongnu.org/archive/html/qemu-devel/2019-01/msg03427.html

but all this could wait until later, these don't seem to be urgent 
problems to prevent moving mac machines forward now and could all be 
addressen in separate elf loading series. So just note the problem and 
move on for now please.

Reagards.
BALATON Zoltan
--3866299591-1657179590-1602952422=:25114--

