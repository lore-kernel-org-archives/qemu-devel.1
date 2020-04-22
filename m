Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78D9C55189
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:44:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B86D2073A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B86D2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRFgP-0006GQ-Lr
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 09:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jRFfS-0005UD-69
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jRFfM-0002MJ-5c
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:43:57 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:49523)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jRFfL-0001xL-I6; Wed, 22 Apr 2020 09:43:51 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id DE8FF746333;
 Wed, 22 Apr 2020 15:43:38 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A3469746324; Wed, 22 Apr 2020 15:43:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A1B87746331;
 Wed, 22 Apr 2020 15:43:38 +0200 (CEST)
Date: Wed, 22 Apr 2020 15:43:38 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 2/4] smbus: Fix spd_data_generate() error API violation
In-Reply-To: <87h7xd5rvs.fsf@dusky.pond.sub.org>
Message-ID: <alpine.BSF.2.22.395.2004221502090.19234@zero.eik.bme.hu>
References: <20200420132826.8879-1-armbru@redhat.com>
 <20200420132826.8879-3-armbru@redhat.com>
 <alpine.BSF.2.22.395.2004201613040.29873@zero.eik.bme.hu>
 <87h7xd5rvs.fsf@dusky.pond.sub.org>
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
>>> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
>>> pointer to a variable containing NULL.  Passing an argument of the
>>> latter kind twice without clearing it in between is wrong: if the
>>> first call sets an error, it no longer points to NULL for the second
>>> call.
>>>
>>> spd_data_generate() can pass @errp to error_setg() more than once when
>>> it adjusts both memory size and type.  Harmless, because no caller
>>> passes anything that needs adjusting.  Until the previous commit,
>>> sam460ex passed types that needed adjusting, but not sizes.
>>>
>>> spd_data_generate()'s contract is rather awkward:
>>>
>>>    If everything's fine, return non-null and don't set an error.
>>>
>>>    Else, if memory size or type need adjusting, return non-null and
>>>    set an error describing the adjustment.
>>>
>>>    Else, return null and set an error reporting why no data can be
>>>    generated.
>>>
>>> Its callers treat the error as a warning even when null is returned.
>>> They don't create the "smbus-eeprom" device then.  Suspicious.
>>
>> The idea here again is to make it work if there's a way it could work
>> rather than throw back an error to user and bail. This is for user
>> convenience in the likely case the user knows nothing about the board
>> or SPD data restrictions.
>
> We're in perfect agreement that the user of QEMU should not need to know
> anything about memory type and number of banks.  QEMU should pick a
> sensible configuration for any memory size it supports.

I though it could be useful to warn the users when QEMU had to fix up some 
values to notify them that what they get may not be what they expect and 
can then know why. If the message really annoys you you can remove it but 
I think it can be useful. I just think your real problem with it is that 
Error can't support it so it's easier to remove the warning than fixing 
Error or use warn_report instead.

>>                           You seem to disagree with this
>
> Here's what I actually disagree with:
>
> 1. QEMU warning the user about its choice of memory type, but only
> sometimes.  Why warn?  There is nothing wrong, and there is nothing the
> user can do to avoid the condition that triggers the warning.

The memory size that triggers the warning is specified by the user so the 
user can do someting about it.

> 2. QEMU changing the user's memory size.  Yes, I understand that's an
> attempt to be helpful, but I prefer my tools not to second-guess my
> intent.

I agree with that and also hate Windows's habit of trying to be more 
intelligent than the user and prefer the Unix way however the average 
users of QEMU (from my perpective, who wants to run Amiga like OSes 
typically on Windows and for the most part not knowing what they are 
doing) are already intimidated by the messy QEMU command line interface 
and will specify random values and complain or go away if it does not work 
so making their life a little easier is not useless. These users (or any 
CLI users) are apparently not relevant from your point of view but they do 
exist and I think should be supported better.

>>                                                          and want to
>> remove all such logic from everywhere. Despite the title of this patch
>> it's not just fixing error API usage but removing those fix ups.
>
> I'm removing unused code that is also broken.  If you want to keep it,
> please fix it, and provide a user and/or a unit test.  Without that, it
> is a trap for future callers.

What was broken in this patch? Isn't freeing the previous warning when 
adding a new one or combining them as you say below (although I don't 
really get what you mean) would fix it without removing fix ups? It's only 
unused now because in previous patches you've removed all usages: first 
broke memory fixup because of some internal QEMU API did not support 
fixing up memory size so instead of fixing that API removed what did not 
fit, then now removing type fix ups because it's not fitting Error API.

Originally it did work well and produced usable values for whatever number 
the user specified and it was convenient for users. (Especially the 
sam460ex is a problematic case because of SoC and firmware limits that the 
user should not need to know about.)

>> If Error cannot be used for this could you change error_setg to
>> warn_report and keep the fix ups untouched? That fixes the problem
>> with error (although leaves no chance to board code to handle
>> errors). Maybe fix Error to be usable for what it's intended for
>> rather than removing cases it can't handle.
>
> Error is designed for errors, not warnings.
>
> A function either succeeds (no error) or fails (one error).
>
> It can be pressed into service for warnings (you did, although in a
> buggy way).  You still can return at most one Error per Error **
> parameter.  If you need multiple warnings, use multiple parameters
> (ugh!).  You could also try to squash multiple warnings into one the
> hints mechanism.
>
> I'd advise against combining warn_report() and Error ** in one function.
> A function should either take care of talking to the user completely, or
> leave it to its caller completely.

I've tried to use error so the board code can decide what's an error and 
what's a warning but if this cannot be done with this QEMU facility I 
don't know a better way than using warn_report for warnings.

Regards,
BALATON Zoltan

