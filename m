Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABECC54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:58:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CF2A20787
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CF2A20787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRFt1-0001Tq-FT
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 09:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jRFrz-0000oW-15
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:56:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jRFrx-0000Xl-2B
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:56:54 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:42282)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jRFrw-0008WE-FJ; Wed, 22 Apr 2020 09:56:52 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 26A97746334;
 Wed, 22 Apr 2020 15:56:47 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D4405746331; Wed, 22 Apr 2020 15:56:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D2F9174632F;
 Wed, 22 Apr 2020 15:56:46 +0200 (CEST)
Date: Wed, 22 Apr 2020 15:56:46 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 1/4] sam460ex: Revert change to SPD memory type for <=
 128 MiB
In-Reply-To: <87imht5rw1.fsf@dusky.pond.sub.org>
Message-ID: <alpine.BSF.2.22.395.2004221543560.19234@zero.eik.bme.hu>
References: <20200420132826.8879-1-armbru@redhat.com>
 <20200420132826.8879-2-armbru@redhat.com>
 <alpine.BSF.2.22.395.2004201604130.29873@zero.eik.bme.hu>
 <87imht5rw1.fsf@dusky.pond.sub.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Apr 2020, Markus Armbruster wrote:
> BALATON Zoltan <balaton@eik.bme.hu> writes:
>> On Mon, 20 Apr 2020, Markus Armbruster wrote:
>>> Requesting 32 or 64 MiB of RAM with the sam460ex machine type produces
>>> a useless warning:
>>>
>>>    qemu-system-ppc: warning: Memory size is too small for SDRAM type, adjusting type
>>
>> Why is it useless? It lets user know there was a change so it could
>> help debugging for example.
>
> The memory type is chosen by QEMU, not the user.  Why should QEMU warn
> the user when it chooses DDR, but not when it chooses DDR2?
>
>>> This is because sam460ex_init() asks spd_data_generate() for DDR2,
>>> which is impossible, so spd_data_generate() corrects it to DDR.
>>
>> This is correct and intended. The idea is that the board code should
>> not need to know about SPD data, all knowledge about that should be in
>> spd_data_genereate().
>
> I challenge this idea.
>
> The kind of RAM module a board accepts is a property of the board.
> Modelling that in board code is sensible and easy.  Attempting to model
> it in a one size fits all helper function is unlikely to work for all
> boards.
>
> Apparently some boards (including malta) need two banks, so your helper
> increases the number of banks from one to two, but only when that's
> possible without changing the type.
>
> What if another board needs one bank?  Four?  Two even if that requires
> changing the type?  You'll end up with a bunch of flags to drive the
> helper's magic.  Not yet because the helper has a grand total of *two*
> users, and much of its magic is used by neither, as demonstrated by
> PATCH 2.
>
> If you want magic, have a non-magic function that does exactly what it's
> told, and a magic one to tell it what to do.  The non-magic one will be
> truly reusable.  You can have any number of magic ones.  Boards with
> sufficiently similar requirements can share a magic one.

So far we have only sufficiently similar boards that can share the only 
magic function. Not many boards use SPD data (these are mostly needed for 
real board firmware so anything purely virtual don't model it usually). 
The refactoring you propose could be needed if we had more dissimilar 
boards but I think we could do that at that time. Until then I've tried to 
make it simple for board code and put all magic in one place instead of 
having separate implementation of this in several boards. Maybe someone 
should try to convert the remaining boards (MIPS Malta and ARM 
integratorcp) to see if any refactoring is needed before doing those 
refactoring without checking first what's needed. I did not try to convert 
those boards because I cannot test them.

>>> The warning goes back to commit 08fd99179a "sam460ex: Clean up SPD
>>> EEPROM creation".  Turns out that commit changed memory type and
>>> number of banks to
>>>
>>>    RAM size    #banks  type    bank size
>>>     128 MiB         1   DDR2     128 MiB
>>>      64 MiB         2   DDR       32 MiB
>>>      32 MiB         1   DDR       32 MiB
>>>
>>> from
>>>
>>>    RAM size    #banks  type    bank size
>>>     128 MiB         2   SDR       64 MiB
>>>      64 MiB         2   SDR       32 MiB
>>>      32 MiB         2   SDR       16 MiB
>>>
>>> Reverting that change also gets rid of the warning.
>>>
>>> I doubt physical Sam460ex boards can take SDR or DDR modules, though.
>>
>> It can't but it can use both DDR and DDR2 (the board can't but the SoC
>> can and the firmware is OK with that too). This is what the commit
>> fixed, please don't break it.
>
> When a commit fixes something, it should say so.  This one does not:
>
>    commit 08fd99179a8c5d34c7065e2ad76c7f8b6afe239e
>    Author: BALATON Zoltan <balaton@eik.bme.hu>
>    Date:   Thu Jan 3 17:27:24 2019 +0100
>
>        sam460ex: Clean up SPD EEPROM creation
>
>        Get rid of code from MIPS Malta board used to create SPD EEPROM data
>        (parts of which was not even needed for sam460ex) and use the generic
>        spd_data_generate() function to simplify this.
>
>        Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>        Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>
> This commit message certainly suggests it was a refactoring that did not
> change SPD data at all.  Not the case, but you have to look at the patch
> closely to see.  Water under the bridge, of course.
>
> It misled me to assume the change was unintentional.

Sorry, I may have forgotten it by the time I was refactorig commits for 
submission.

Regards,
BALATON Zoltan

