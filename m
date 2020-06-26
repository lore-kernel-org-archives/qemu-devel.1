Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E933AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 11:31:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF67D206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 11:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF67D206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jomaD-0006r5-13
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 07:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jomZ2-0005sc-9C; Fri, 26 Jun 2020 07:30:36 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:17144)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jomYz-0004b9-9H; Fri, 26 Jun 2020 07:30:35 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 9019B74633D;
 Fri, 26 Jun 2020 13:30:29 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 573E9745712; Fri, 26 Jun 2020 13:30:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 54CA77456F8;
 Fri, 26 Jun 2020 13:30:29 +0200 (CEST)
Date: Fri, 26 Jun 2020 13:30:29 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 2/4] smbus: Fix spd_data_generate() error API violation
In-Reply-To: <alpine.BSF.2.22.395.2004222053070.22480@zero.eik.bme.hu>
Message-ID: <alpine.BSF.2.22.395.2006261315070.94870@zero.eik.bme.hu>
References: <20200422134815.1584-1-armbru@redhat.com>
 <20200422134815.1584-3-armbru@redhat.com>
 <alpine.BSF.2.22.395.2004221622140.19234@zero.eik.bme.hu>
 <0af0e0f0-8127-da83-d9d2-89a3fe28f778@redhat.com>
 <alpine.BSF.2.22.395.2004222053070.22480@zero.eik.bme.hu>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-738138568-1593171029=:94870"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 06:21:50
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-738138568-1593171029=:94870
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 22 Apr 2020, BALATON Zoltan wrote:
> On Wed, 22 Apr 2020, Philippe Mathieu-Daudé wrote:
>> On 4/22/20 4:27 PM, BALATON Zoltan wrote:
>>> On Wed, 22 Apr 2020, Markus Armbruster wrote:
>>>> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
>>>> pointer to a variable containing NULL.  Passing an argument of the
>>>> latter kind twice without clearing it in between is wrong: if the
>>>> first call sets an error, it no longer points to NULL for the second
>>>> call.
>>>> 
>>>> spd_data_generate() can pass @errp to error_setg() more than once when
>>>> it adjusts both memory size and type.  Harmless, because no caller
>>>> passes anything that needs adjusting.  Until the previous commit,
>>>> sam460ex passed types that needed adjusting, but not sizes.
>>>> 
>>>> spd_data_generate()'s contract is rather awkward:
>>>> 
>>>>    If everything's fine, return non-null and don't set an error.
>>>> 
>>>>    Else, if memory size or type need adjusting, return non-null and
>>>>    set an error describing the adjustment.
>>>> 
>>>>    Else, return null and set an error reporting why no data can be
>>>>    generated.
>>>> 
>>>> Its callers treat the error as a warning even when null is returned.
>>>> They don't create the "smbus-eeprom" device then.  Suspicious.
>>>> 
>>>> Since the previous commit, only "everything's fine" can actually
>>>> happen.  Drop the unused code and simplify the callers.  This gets rid
>>>> of the error API violation.
>>> 
>>> This leaves board code no chance to recover from values given by user that 
>>> won't fit without duplicating checks that this function does. Also this 
>>> will abort without giving meaningful errors if an invalid value does get 
>>> through and result in a crash which is not used friendly. So I don't like 
>>> this but if others think this is acceptable maybe at least unit test 
>>> should be adjusted to make sure aborts cannot be triggered by user for 
>>> values that are not usually tested during development.
>> 
>> Agreed. Do you have an example (or more) to better show Markus this code 
>> use? So we can add tests.
>
> After Markus's patches probably nothing uses it any more but this comes with 
> the result that previously giving some random value such as -m 100 did 
> produce a working sam460ex machine after some warnings but now it just thows 
> back some errors to the user which may or may not be helpful to them.
>
>> Personally I'd use a script to generate a dumb static array of all possible 
>> sizes...
>
> Maybe testing with the biggest valid value such as -m 2048 (that's commonly 
> used probably) and an invalid value such as -m 100 might be enough. Testing 
> all possible values might take too long and would not test what happens with 
> invalid values. Ideally those invalud values should also work like before 
> a0258e4afa but should at least give a meaningful warning so the user can fix 
> the command line without too much head scratching. Actually that commit was 
> from Igor not from Marcus so sorry for attributing that to Marcus too, I 
> remembered wrong.
>
> By the way you could argue that on real machine you cannot plug certain 
> combinations of memory modules so it's enough to model that but I think QEMU 
> does not have to be that strict and also support configs that cannot happen 
> on real hadware but would work. This might be useful for example if you have 
> some ammount of memory to set aside for a VM on a host but that's not a size 
> that exists in memory modules on real hardware. This also works on pc machine 
> in qemu-system-i386 for example: it accepts -m 100 and does its best to 
> create a machine with such unrealistic size. The sam460ex did the same 
> (within SoC's limits) and before a0258e4afa -m 100 was fixed up to 96 MB 
> which is now not possible due to change in QEMU internal APIs. This probably 
> isn't important enough to worth the extra effort to support but would have 
> been nice to preserve.

Besides the above here's another use case of the fix ups that I wanted to 
keep:

https://patchew.org/QEMU/cover.1592315226.git.balaton@eik.bme.hu/b5f4598529a77f15f554c593e9be2d0ff9e5fab3.1592315226.git.balaton@eik.bme.hu/

This board normally uses OpenBIOS which gets RAM size from fw_cfg and so 
works with whatever amount of RAM (also Linux booted with -kernel probably 
does not care) so any -memory value is valid. However some may want to 
also use original firmware ROM for compatibility which detects RAM reading 
SPD eeproms (the i2c emulation needed for that is not working yet but once 
that's fixed this will be the case). I want to add smbus_eeproms for this 
but do not want to just abort for cases where -memory given by user cannot 
be covered with SPD data. Instead a warning and covering as much RAM as 
possible should be enough (the ROM will detect less RAM than given with -m 
but that's OK and better than just bailing out without a message tripping 
an assert). But I don't want to replicate in board code the calculation 
and checks the spd_data_generate() function does anyway (that would just 
puzzle reviewers for every use of this functions).

Previously this was possible with my original spd_data_generate() 
implementation. What's your suggestion to bring that functionality back 
without breaking Error API? Maybe adding new parameters to tell the 
spd_data_generate() which fixups are allowed?

Regards,
BALATON Zoltan
--3866299591-738138568-1593171029=:94870--

