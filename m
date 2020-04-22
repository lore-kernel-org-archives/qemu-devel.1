Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01E5C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 19:34:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BC0820767
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 19:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC0820767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRL8D-0005BJ-Gd
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 15:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jRL6Q-0003XL-Dc
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 15:32:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jRL6O-0006Bz-Jz
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 15:32:09 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:39036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jRL6N-000664-Vc; Wed, 22 Apr 2020 15:32:08 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 2DD1074633E;
 Wed, 22 Apr 2020 21:32:04 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id F2F58746335; Wed, 22 Apr 2020 21:32:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id F1789746333;
 Wed, 22 Apr 2020 21:32:03 +0200 (CEST)
Date: Wed, 22 Apr 2020 21:32:03 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 2/4] smbus: Fix spd_data_generate() error API violation
In-Reply-To: <0af0e0f0-8127-da83-d9d2-89a3fe28f778@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2004222053070.22480@zero.eik.bme.hu>
References: <20200422134815.1584-1-armbru@redhat.com>
 <20200422134815.1584-3-armbru@redhat.com>
 <alpine.BSF.2.22.395.2004221622140.19234@zero.eik.bme.hu>
 <0af0e0f0-8127-da83-d9d2-89a3fe28f778@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1537099632-1587583923=:22480"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 15:32:04
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1537099632-1587583923=:22480
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 22 Apr 2020, Philippe Mathieu-Daudé wrote:
> On 4/22/20 4:27 PM, BALATON Zoltan wrote:
>> On Wed, 22 Apr 2020, Markus Armbruster wrote:
>>> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
>>> pointer to a variable containing NULL.  Passing an argument of the
>>> latter kind twice without clearing it in between is wrong: if the
>>> first call sets an error, it no longer points to NULL for the second
>>> call.
>>> 
>>> spd_data_generate() can pass @errp to error_setg() more than once when
>>> it adjusts both memory size and type.  Harmless, because no caller
>>> passes anything that needs adjusting.  Until the previous commit,
>>> sam460ex passed types that needed adjusting, but not sizes.
>>> 
>>> spd_data_generate()'s contract is rather awkward:
>>> 
>>>    If everything's fine, return non-null and don't set an error.
>>> 
>>>    Else, if memory size or type need adjusting, return non-null and
>>>    set an error describing the adjustment.
>>> 
>>>    Else, return null and set an error reporting why no data can be
>>>    generated.
>>> 
>>> Its callers treat the error as a warning even when null is returned.
>>> They don't create the "smbus-eeprom" device then.  Suspicious.
>>> 
>>> Since the previous commit, only "everything's fine" can actually
>>> happen.  Drop the unused code and simplify the callers.  This gets rid
>>> of the error API violation.
>> 
>> This leaves board code no chance to recover from values given by user that 
>> won't fit without duplicating checks that this function does. Also this 
>> will abort without giving meaningful errors if an invalid value does get 
>> through and result in a crash which is not used friendly. So I don't like 
>> this but if others think this is acceptable maybe at least unit test should 
>> be adjusted to make sure aborts cannot be triggered by user for values that 
>> are not usually tested during development.
>
> Agreed. Do you have an example (or more) to better show Markus this code use? 
> So we can add tests.

After Markus's patches probably nothing uses it any more but this comes 
with the result that previously giving some random value such as -m 100 
did produce a working sam460ex machine after some warnings but now it just 
thows back some errors to the user which may or may not be helpful to 
them.

> Personally I'd use a script to generate a dumb static array of all possible 
> sizes...

Maybe testing with the biggest valid value such as -m 2048 (that's 
commonly used probably) and an invalid value such as -m 100 might be 
enough. Testing all possible values might take too long and would not test 
what happens with invalid values. Ideally those invalud values should also 
work like before a0258e4afa but should at least give a meaningful warning 
so the user can fix the command line without too much head scratching. 
Actually that commit was from Igor not from Marcus so sorry for 
attributing that to Marcus too, I remembered wrong.

By the way you could argue that on real machine you cannot plug certain 
combinations of memory modules so it's enough to model that but I think 
QEMU does not have to be that strict and also support configs that cannot 
happen on real hadware but would work. This might be useful for example if 
you have some ammount of memory to set aside for a VM on a host but that's 
not a size that exists in memory modules on real hardware. This also works 
on pc machine in qemu-system-i386 for example: it accepts -m 100 and does 
its best to create a machine with such unrealistic size. The sam460ex did 
the same (within SoC's limits) and before a0258e4afa -m 100 was fixed up 
to 96 MB which is now not possible due to change in QEMU internal APIs. 
This probably isn't important enough to worth the extra effort to support 
but would have been nice to preserve.

Regards,
BALATON Zoltan
--3866299591-1537099632-1587583923=:22480--

