Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE78C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 19:02:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0FF9206A1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 19:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qix4caMp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0FF9206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpz2x-0001Ub-Uv
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 15:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jpz16-0000L3-V3; Mon, 29 Jun 2020 15:00:32 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:44077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jpz14-0006dH-SZ; Mon, 29 Jun 2020 15:00:32 -0400
Received: by mail-ed1-x541.google.com with SMTP id by13so3970862edb.11;
 Mon, 29 Jun 2020 12:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Jjz32VtqdI2FyMsCKUm+glvM/S+eY4AelhubjqzeXH0=;
 b=Qix4caMpPG7pU/cT3wpys8K+yTCRl/3TtFEThIdoQ3JB/GyMmQjLdjWM4OTzTTpTka
 +PhZGws7xC7UHyBemPd4UUv+yX+IlHWtFPbrWtYURjO5ngiQKg2WwrK9pie4yTtMIaNV
 GRv8LFkH8AGMtLEHLqbHGkg0t2CXigrm9i5LaGDdT6OGM7YSczBSLHZvRRNU/1jcj9QI
 8AU2KXq0er+X+RIZfgbkLL9GKqLoA46mMGACxcSbTI+9Kq5eiF3mJYBZP49Kl/+JJmGT
 FEvcATuHaWOR5tOdeCihPNwiPRuDFngleWcFLlyr10B3yXU37JSKcfc7G298sHMvhKI7
 d/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Jjz32VtqdI2FyMsCKUm+glvM/S+eY4AelhubjqzeXH0=;
 b=QEygEthgL/vRuUfZcCv1dntcBiRcX7anWmRcU9306sLbGf8rtCQVI79TsZQX7M79KY
 MypQZtH7AiQ6nV+NzhG5uuemqLk9h6b99f5kgbH5+hOXQgHxVh9/wIgJrKuYJdbxxJI3
 crP09onO6BNBBY+TCQebFX140qjJUV2TQz5sJFtxrpteydTEp6kBdY7RnWBAMm+CYR41
 rTOltD8bQz5YRGtSh9rFJ1Q0hjGueGmKsdGr+Z9Nf8MWXV5L4ExWgIGglpxFe9ngiaw6
 0cBRRsR5DX/C+1pC7BYP8FZHfj/cNVn5MkEBOocVEUg/pg1uNZB3SWyVjN8qa6/pk+gc
 uakg==
X-Gm-Message-State: AOAM532nMqNDoE3XNdrs9DDrHTYNtxUB/YyzZj4Y/W0fxnfyqiLaiQSc
 G9tbSbwzV/rAXI6UUZlXp7o=
X-Google-Smtp-Source: ABdhPJzV8FzBWRYzbDYhP7aQcybWSbJEtdIgOdggDipM2PTogmaIiPnJFC/Ks688OlhcpHl49PV0/A==
X-Received: by 2002:aa7:c98d:: with SMTP id c13mr10823705edt.188.1593457228727; 
 Mon, 29 Jun 2020 12:00:28 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id s14sm540862edq.36.2020.06.29.12.00.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 12:00:27 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] smbus: Fix spd_data_generate() error API violation
To: Markus Armbruster <armbru@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
References: <20200422134815.1584-1-armbru@redhat.com>
 <20200422134815.1584-3-armbru@redhat.com>
 <alpine.BSF.2.22.395.2004221622140.19234@zero.eik.bme.hu>
 <0af0e0f0-8127-da83-d9d2-89a3fe28f778@redhat.com>
 <alpine.BSF.2.22.395.2004222053070.22480@zero.eik.bme.hu>
 <alpine.BSF.2.22.395.2006261315070.94870@zero.eik.bme.hu>
 <87k0ztrn9m.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <731e8765-4886-3bfe-b877-06078d0e977d@amsat.org>
Date: Mon, 29 Jun 2020 21:00:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87k0ztrn9m.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/27/20 9:17 AM, Markus Armbruster wrote:
> BALATON Zoltan <balaton@eik.bme.hu> writes:
> 
>> On Wed, 22 Apr 2020, BALATON Zoltan wrote:
>>> On Wed, 22 Apr 2020, Philippe Mathieu-DaudÃ© wrote:
>>>> On 4/22/20 4:27 PM, BALATON Zoltan wrote:
>>>>> On Wed, 22 Apr 2020, Markus Armbruster wrote:
>>>>>> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
>>>>>> pointer to a variable containing NULL.Â  Passing an argument of the
>>>>>> latter kind twice without clearing it in between is wrong: if the
>>>>>> first call sets an error, it no longer points to NULL for the second
>>>>>> call.
>>>>>>
>>>>>> spd_data_generate() can pass @errp to error_setg() more than once when
>>>>>> it adjusts both memory size and type.Â  Harmless, because no caller
>>>>>> passes anything that needs adjusting.Â  Until the previous commit,
>>>>>> sam460ex passed types that needed adjusting, but not sizes.
>>>>>>
>>>>>> spd_data_generate()'s contract is rather awkward:
>>>>>>
>>>>>> Â Â  If everything's fine, return non-null and don't set an error.
>>>>>>
>>>>>> Â Â  Else, if memory size or type need adjusting, return non-null and
>>>>>> Â Â  set an error describing the adjustment.
>>>>>>
>>>>>> Â Â  Else, return null and set an error reporting why no data can be
>>>>>> Â Â  generated.
>>>>>>
>>>>>> Its callers treat the error as a warning even when null is returned.
>>>>>> They don't create the "smbus-eeprom" device then.Â  Suspicious.
>>>>>>
>>>>>> Since the previous commit, only "everything's fine" can actually
>>>>>> happen.Â  Drop the unused code and simplify the callers.Â  This gets rid
>>>>>> of the error API violation.
>>>>>
>>>>> This leaves board code no chance to recover from values given by
>>>>> user that won't fit without duplicating checks that this function
>>>>> does. Also this will abort without giving meaningful errors if an
>>>>> invalid value does get through and result in a crash which is not
>>>>> used friendly. So I don't like this but if others think this is
>>>>> acceptable maybe at least unit test should be adjusted to make
>>>>> sure aborts cannot be triggered by user for values that are not
>>>>> usually tested during development.
>>>>
>>>> Agreed. Do you have an example (or more) to better show Markus this
>>>> code use? So we can add tests.
>>>
>>> After Markus's patches probably nothing uses it any more but this
>>> comes with the result that previously giving some random value such
>>> as -m 100 did produce a working sam460ex machine after some warnings
>>> but now it just thows back some errors to the user which may or may
>>> not be helpful to them.
>>>
>>>> Personally I'd use a script to generate a dumb static array of all
>>>> possible sizes...
>>>
>>> Maybe testing with the biggest valid value such as -m 2048 (that's
>>> commonly used probably) and an invalid value such as -m 100 might be
>>> enough. Testing all possible values might take too long and would
>>> not test what happens with invalid values. Ideally those invalud
>>> values should also work like before a0258e4afa but should at least
>>> give a meaningful warning so the user can fix the command line
>>> without too much head scratching. Actually that commit was from Igor
>>> not from Marcus so sorry for attributing that to Marcus too, I
>>> remembered wrong.
>>>
>>> By the way you could argue that on real machine you cannot plug
>>> certain combinations of memory modules so it's enough to model that
>>> but I think QEMU does not have to be that strict and also support
>>> configs that cannot happen on real hadware but would work. This
>>> might be useful for example if you have some ammount of memory to
>>> set aside for a VM on a host but that's not a size that exists in
>>> memory modules on real hardware. This also works on pc machine in
>>> qemu-system-i386 for example: it accepts -m 100 and does its best to
>>> create a machine with such unrealistic size. The sam460ex did the
>>> same (within SoC's limits) and before a0258e4afa -m 100 was fixed up
>>> to 96 MB which is now not possible due to change in QEMU internal
>>> APIs. This probably isn't important enough to worth the extra effort
>>> to support but would have been nice to preserve.
>>
>> Besides the above here's another use case of the fix ups that I wanted
>> to keep:
>>
>> https://patchew.org/QEMU/cover.1592315226.git.balaton@eik.bme.hu/b5f4598529a77f15f554c593e9be2d0ff9e5fab3.1592315226.git.balaton@eik.bme.hu/
>>
>> This board normally uses OpenBIOS which gets RAM size from fw_cfg and
>> so works with whatever amount of RAM (also Linux booted with -kernel
>> probably does not care) so any -memory value is valid. However some
>> may want to also use original firmware ROM for compatibility which
>> detects RAM reading SPD eeproms (the i2c emulation needed for that is
>> not working yet but once that's fixed this will be the case). I want
>> to add smbus_eeproms for this but do not want to just abort for cases
>> where -memory given by user cannot be covered with SPD data. Instead a
>> warning and covering as much RAM as possible should be enough (the ROM
>> will detect less RAM than given with -m 
>> but that's OK and better than just bailing out without a message
>> tripping an assert). But I don't want to replicate in board code the
>> calculation and checks the spd_data_generate() function does anyway
>> (that would just puzzle reviewers for every use of this functions).
>>
>> Previously this was possible with my original spd_data_generate()
>> implementation. What's your suggestion to bring that functionality
>> back without breaking Error API? Maybe adding new parameters to tell
>> the spd_data_generate() which fixups are allowed?
> 
> Quick reply without having thought through the issues at all: I'm not
> opposed to you doing work to enable additional or even arbitrary memory
> sizes where these actually work.  I'm first and foremost opposed to me
> wasting time on "improving" code that is not used for anything.  That's
> why I dumbed down spd_data_generate().

I'm starting to understand Zoltan point. What I'm seeing is Zoltan using
a hobbyist code, that just happens to work for hobbyists, but get in the
way of enterprise quality standards.

Zoltan doesn't have the skills/time/motivation to rework its working
code to meet the enterprise quality level. Enterprise developers tried
to understand twice (first Igor, then Markus) the hobbyist use to get
it done safer, so it can stay maintained.

Zoltan, I guess I understood your use and have an idea to rework it in
a way that everybody is happy, but as Markus said, since the freeze is
next week, I won't have time to get it done in this short amount of
time.

From the PPC460EX-NUB800T-AMCC-datasheet-11553412.pdf datasheet I
understand the 460EX can support "Up to 8 GB in four external banks",
but the SAM 460ex board only wires a single bank (to the SODIMM
connector). You want to use a virtual board with up-to 4 banks in
use, right?

> Secondly, I'm opposed to QEMU "correcting" user configuration.  I want
> QEMU do exactly what it's told, and fail with a clear error message when
> that is not possible.  The error message may include hints for the user
> on how to correct the configuration.
> 


