Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F487C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 06:10:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECC9720759
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 06:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQa8H8D8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC9720759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq9Sx-0001HJ-8M
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 02:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jq9SI-0000dX-F5; Tue, 30 Jun 2020 02:09:18 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:39204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jq9SF-0001dB-IO; Tue, 30 Jun 2020 02:09:18 -0400
Received: by mail-ed1-x542.google.com with SMTP id d18so9369595edv.6;
 Mon, 29 Jun 2020 23:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+rqAn9bZERyTmJIAkzShlhMBITZODVUYmEfXR/+weT4=;
 b=MQa8H8D8T3hiZhMvUP5pkgGkKwVZ1UKEIXHWE9hALod96U82vJR7r2K+KNA8BGMAbp
 ayUjCcTBa71YJNjNim9mnHx1jQUtLVZobNF7RddO7ogD34vOsTjZPFMWQG+kC1U8/047
 rZqbdayaaZJres8Jve1LVrWNVStrBiycNgj1reUhyL8upQP7r+Q8y5lnT3NDbSgMXBQ9
 D9chj2+MGT0AMnbLsgdMz/4kHuDOcXj1q+dy8PbCtgHmd8F6IOLBrMbDrix79tHw2y3b
 eaTbUM3wVh8r2u/icgwDiD5PBvs7W7XIXfFXOPItF4+rHL4zgyx8Pb/tPq+FNPvXtIep
 gTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+rqAn9bZERyTmJIAkzShlhMBITZODVUYmEfXR/+weT4=;
 b=G7xokgyHs95Xz6dg1ysL5lPJK32L2WNWuuIpER2R7coJ/ILUHMrPHbjIpthbpN9lv5
 KX9werb+1jiR4o9enA9EwA7OWlBBF+W7y34X8AV+hR4xm7mhsETK+jlr40Fgify1yykV
 PpkXWbq+sADIjU1RGJXabnHuQqfbbvZw1aW4DGcHpu6NJMzqUT5FwJVlwsyiTl+fyMg2
 2oPVj1DuEGmIbTV5M5/W/nL7V8W2MSGr9dzzlqWpHZ/JlfhXE0SQpG+XNRZ0wA0rGAHN
 BWifS7SFPHnKY3VT2RZtPaYAp2kPA9zDlJjqcRJPcrI7fpIDcSpuqSKRKOJsNkH9ZXnX
 Juig==
X-Gm-Message-State: AOAM533HqiHk8Et1/GiNEpo3AXYsFee9n65JL3SD0IPcb9TKLYiskv7z
 D5ApjpyIhAG57+lXyd3AvHhrnslScjQ=
X-Google-Smtp-Source: ABdhPJwoLb8yz3vmSDMfvztd0DcjL78HpKv4K1hR1KLN3a6QkHCfyJalawbx0QF4Ru2qWQnYSr4kAw==
X-Received: by 2002:a50:bec2:: with SMTP id e2mr22143376edk.3.1593497352760;
 Mon, 29 Jun 2020 23:09:12 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id y7sm1686288edq.25.2020.06.29.23.09.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 23:09:12 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] smbus: Fix spd_data_generate() error API violation
To: BALATON Zoltan <balaton@eik.bme.hu>
References: <20200422134815.1584-1-armbru@redhat.com>
 <20200422134815.1584-3-armbru@redhat.com>
 <alpine.BSF.2.22.395.2004221622140.19234@zero.eik.bme.hu>
 <0af0e0f0-8127-da83-d9d2-89a3fe28f778@redhat.com>
 <alpine.BSF.2.22.395.2004222053070.22480@zero.eik.bme.hu>
 <alpine.BSF.2.22.395.2006261315070.94870@zero.eik.bme.hu>
 <87k0ztrn9m.fsf@dusky.pond.sub.org>
 <731e8765-4886-3bfe-b877-06078d0e977d@amsat.org>
 <alpine.BSF.2.22.395.2006292127520.63145@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <20bcd5be-7664-4555-38bc-c8c68b603127@amsat.org>
Date: Tue, 30 Jun 2020 08:09:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2006292127520.63145@zero.eik.bme.hu>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x542.google.com
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/29/20 11:31 PM, BALATON Zoltan wrote:
> On Mon, 29 Jun 2020, Philippe Mathieu-DaudÃ© wrote:
>> On 6/27/20 9:17 AM, Markus Armbruster wrote:
>>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>>> On Wed, 22 Apr 2020, BALATON Zoltan wrote:
>>>>> On Wed, 22 Apr 2020, Philippe Mathieu-DaudÃÂ© wrote:
>>>>>> On 4/22/20 4:27 PM, BALATON Zoltan wrote:
>>>>>>> On Wed, 22 Apr 2020, Markus Armbruster wrote:
>>>>>>>> The Error ** argument must be NULL, &error_abort, &error_fatal,
>>>>>>>> or a
>>>>>>>> pointer to a variable containing NULL.ÃÂ  Passing an
>>>>>>>> argument of the
>>>>>>>> latter kind twice without clearing it in between is wrong: if the
>>>>>>>> first call sets an error, it no longer points to NULL for the
>>>>>>>> second
>>>>>>>> call.
>>>>>>>>
>>>>>>>> spd_data_generate() can pass @errp to error_setg() more than
>>>>>>>> once when
>>>>>>>> it adjusts both memory size and type.ÃÂ  Harmless, because
>>>>>>>> no caller
>>>>>>>> passes anything that needs adjusting.ÃÂ  Until the previous
>>>>>>>> commit,
>>>>>>>> sam460ex passed types that needed adjusting, but not sizes.
>>>>>>>>
>>>>>>>> spd_data_generate()'s contract is rather awkward:
>>>>>>>>
>>>>>>>> ÃÂ ÃÂ  If everything's fine, return non-null and don't
>>>>>>>> set an error.
>>>>>>>>
>>>>>>>> ÃÂ ÃÂ  Else, if memory size or type need adjusting,
>>>>>>>> return non-null and
>>>>>>>> ÃÂ ÃÂ  set an error describing the adjustment.
>>>>>>>>
>>>>>>>> ÃÂ ÃÂ  Else, return null and set an error reporting
>>>>>>>> why no data can be
>>>>>>>> ÃÂ ÃÂ  generated.
>>>>>>>>
>>>>>>>> Its callers treat the error as a warning even when null is
>>>>>>>> returned.
>>>>>>>> They don't create the "smbus-eeprom" device then.ÃÂ 
>>>>>>>> Suspicious.
>>>>>>>>
>>>>>>>> Since the previous commit, only "everything's fine" can actually
>>>>>>>> happen.ÃÂ  Drop the unused code and simplify the
>>>>>>>> callers.ÃÂ  This gets rid
>>>>>>>> of the error API violation.
>>>>>>>
>>>>>>> This leaves board code no chance to recover from values given by
>>>>>>> user that won't fit without duplicating checks that this function
>>>>>>> does. Also this will abort without giving meaningful errors if an
>>>>>>> invalid value does get through and result in a crash which is not
>>>>>>> used friendly. So I don't like this but if others think this is
>>>>>>> acceptable maybe at least unit test should be adjusted to make
>>>>>>> sure aborts cannot be triggered by user for values that are not
>>>>>>> usually tested during development.
>>>>>>
>>>>>> Agreed. Do you have an example (or more) to better show Markus this
>>>>>> code use? So we can add tests.
>>>>>
>>>>> After Markus's patches probably nothing uses it any more but this
>>>>> comes with the result that previously giving some random value such
>>>>> as -m 100 did produce a working sam460ex machine after some warnings
>>>>> but now it just thows back some errors to the user which may or may
>>>>> not be helpful to them.
>>>>>
>>>>>> Personally I'd use a script to generate a dumb static array of all
>>>>>> possible sizes...
>>>>>
>>>>> Maybe testing with the biggest valid value such as -m 2048 (that's
>>>>> commonly used probably) and an invalid value such as -m 100 might be
>>>>> enough. Testing all possible values might take too long and would
>>>>> not test what happens with invalid values. Ideally those invalud
>>>>> values should also work like before a0258e4afa but should at least
>>>>> give a meaningful warning so the user can fix the command line
>>>>> without too much head scratching. Actually that commit was from Igor
>>>>> not from Marcus so sorry for attributing that to Marcus too, I
>>>>> remembered wrong.
>>>>>
>>>>> By the way you could argue that on real machine you cannot plug
>>>>> certain combinations of memory modules so it's enough to model that
>>>>> but I think QEMU does not have to be that strict and also support
>>>>> configs that cannot happen on real hadware but would work. This
>>>>> might be useful for example if you have some ammount of memory to
>>>>> set aside for a VM on a host but that's not a size that exists in
>>>>> memory modules on real hardware. This also works on pc machine in
>>>>> qemu-system-i386 for example: it accepts -m 100 and does its best to
>>>>> create a machine with such unrealistic size. The sam460ex did the
>>>>> same (within SoC's limits) and before a0258e4afa -m 100 was fixed up
>>>>> to 96 MB which is now not possible due to change in QEMU internal
>>>>> APIs. This probably isn't important enough to worth the extra effort
>>>>> to support but would have been nice to preserve.
>>>>
>>>> Besides the above here's another use case of the fix ups that I wanted
>>>> to keep:
>>>>
>>>> https://patchew.org/QEMU/cover.1592315226.git.balaton@eik.bme.hu/b5f4598529a77f15f554c593e9be2d0ff9e5fab3.1592315226.git.balaton@eik.bme.hu/
>>>>
>>>>
>>>> This board normally uses OpenBIOS which gets RAM size from fw_cfg and
>>>> so works with whatever amount of RAM (also Linux booted with -kernel
>>>> probably does not care) so any -memory value is valid. However some
>>>> may want to also use original firmware ROM for compatibility which
>>>> detects RAM reading SPD eeproms (the i2c emulation needed for that is
>>>> not working yet but once that's fixed this will be the case). I want
>>>> to add smbus_eeproms for this but do not want to just abort for cases
>>>> where -memory given by user cannot be covered with SPD data. Instead a
>>>> warning and covering as much RAM as possible should be enough (the ROM
>>>> will detect less RAM than given with -m
>>>> but that's OK and better than just bailing out without a message
>>>> tripping an assert). But I don't want to replicate in board code the
>>>> calculation and checks the spd_data_generate() function does anyway
>>>> (that would just puzzle reviewers for every use of this functions).
>>>>
>>>> Previously this was possible with my original spd_data_generate()
>>>> implementation. What's your suggestion to bring that functionality
>>>> back without breaking Error API? Maybe adding new parameters to tell
>>>> the spd_data_generate() which fixups are allowed?
>>>
>>> Quick reply without having thought through the issues at all: I'm not
>>> opposed to you doing work to enable additional or even arbitrary memory
>>> sizes where these actually work.� I'm first and foremost opposed to me
>>> wasting time on "improving" code that is not used for anything.� That's
>>> why I dumbed down spd_data_generate().
>>
>> I'm starting to understand Zoltan point. What I'm seeing is Zoltan using
>> a hobbyist code, that just happens to work for hobbyists, but get in the
>> way of enterprise quality standards.
> 
> This is not necessarily a conflict between hobbyist vs enterprise but
> more like different view on what the qemu-system-* CLI should be. I
> think the CLI is the main human interface of QEMU as it does not really
> provide a GUI for configuring or running VMs (as for example VirtualBox
> does, QEMU only has minimal GUI to view and control running VMs) so
> users are forced to use either the command line or maybe an external
> management frontend, but for simple things (like hobbyist use) that's an
> overkill and also not a good match as those are designed for enterprise
> use. (Also these hobbyist are on Windows or macOS where these management
> apps are not available and getting a working QEMU binary is already a
> challenge.)
> 
> The problem is that these management frontends don't have a proper API
> to control QEMU but abuse the CLI and QEMU monitor for this which are
> supposed to be human interfaces at the first place but changing the
> commands for the needs of management apps result in arcane command
> lines. Note that humans and management apps likely have different
> requirements so if you mean hobbyist = human and enterprise = management
> frontend then that's about what my problem is. I think humans and
> management apps could coexist using the same interfaces if these cannot
> be cleanly separated (as that would need either changing management apps
> to use something else than the main human interface or providing proper
> GUI or CLI frontend for humans) but if they use the same CLI then
> allowing some convenience commands to make the life of humans easier
> should not be forbidden. Running a VM should be simple and not require
> typing multiple lines of options just to result in an error that
> something is not what QEMU thinks is acceptable even though it could
> work and could be fixed. That's really annoying for a human but may be
> desirable for a management app so it does not need to check it got what
> it think it specified.
> 
>> Zoltan doesn't have the skills/time/motivation to rework its working
>> code to meet the enterprise quality level. Enterprise developers tried
>> to understand twice (first Igor, then Markus) the hobbyist use to get
>> it done safer, so it can stay maintained.
> 
> Of course I don't have time or motivation to make it enterprise quality
> when I work unpayed on this in my free time and for fun. I already spend
> too much time with this so while I try to make it good enough to be
> included upstream the direction is clearly different than what
> enterprise users need. But that's OK as the machines I work with are not
> really used in an enterprise setting and mostly used by hobbyists, but
> if some of the components or machines could be useful to enterprise
> people I expect them to put in the effort to get them to enterprise level.
> 
> But this probably does not apply to the very problem discussed here.
> When I've added new machines (apart from sam460ex also pegasos2 which is
> not upstream yet and now hopefully Mac machines soon too) these needed
> SPD eeproms because their firmwares detected RAM based on it. There were
> some already existing boards which emulated SPD but these were ad-hoc
> implementations without any commonality. To avoid increasing the mess by
> adding a few more independent SPD emulations that would get out of sync
> I've spent some time to come up with a common function that could be
> used by all these boards and the new ones I wanted to add. The goal of
> this function was to put SPD emulation in a single place and make it
> easy for board code to use it without needing to duplicate code.
> 
> Also Marcus mentioned uniformity between machines: Most machines, like
> pc ones accept any memory size such as -m 100 even though on real
> hardware it's not possible but can work with the firmware in QEMU that
> usually take this info from FW_CFG or something else and not resticted
> by SPD data. I wanted to do the same in sam460ex and allow it to use any
> memory size exactly for uniformity besides used convenience, even though
> that machine has some constraints so it required to fix up RAM size to
> meet those constraints. So -m 100 would result in 96 MB of RAM that the
> SoC and firmware can handle and is closest to what the user intended.
> This worked well until Igor changed memory allocation to memdev (which I
> don't even know what it is: some enterprise stuff not really needed for
> hobbyists but maybe could be useful e.g. to save guest memory image so
> why not) but this required getting rid of fix ups of memory size in
> boards (sam460ex wasn't the only one) beacuse memdev could not support
> this for some reason and Igor did not want to add that (even though I've
> proposed some designs, you can look up in patch review). So this broke
> fix ups, then Marcus noticed that errors reporting via err object cannot
> be used for warnings as I've tried to use so to fix it he just removed
> all the reamaining traces of it thereby making it more difficult to add
> SPD eeproms to mac_oldworld without duplicating the removed checks in
> board code which I wanted to avoid because:
> 
> 1. This is knowledge about SPD eeproms that should be in that func
> 2. Would duplicate non-trivial code in boards that would puzzle
> reviewers and is error prone too.
> 
>> Zoltan, I guess I understood your use and have an idea to rework it in
>> a way that everybody is happy, but as Markus said, since the freeze is
>> next week, I won't have time to get it done in this short amount of
>> time.
> 
> It's not urgent but if we can agree on something that's acceptable for
> everyone I may be able to submit a patch but don't want to put in effort
> if it will be turned down anyway due to nothing else than the current
> solution being acceptable based on principles over convenience. Arguing
> with Markus about it before got me that impression so I'd rather ask
> before wasting time with it.
> 
>> From the PPC460EX-NUB800T-AMCC-datasheet-11553412.pdf datasheet I
>> understand the 460EX can support "Up to 8 GB in four external banks",
>> but the SAM 460ex board only wires a single bank (to the SODIMM
>> connector). You want to use a virtual board with up-to 4 banks in
>> use, right?
> 
> No, the firmware won't check additional banks because it only checks the
> one wired. So what we need is to put as much RAM as possible on that
> SODIMM (and we can use that SoC can handle both DDR and DDR2) but since
> it's already broken and limited to valid SODIMM sizes due to memdev not
> supporting memory size fix ups fixing this again is not high priority.
> 
> What I'd like is reverting f26740c61a57f and fix that some other way so
> I don't have to duplicate size check in board code as can be seen in the
> patchew link above but could just call spd_data_generate() to do its
> job. This was discussed at the time that patch was in review you can
> read it here:
> 
> http://patchwork.ozlabs.org/project/qemu-devel/patch/20200420132826.8879-3-armbru@redhat.com/
> 
> 
> My points were not really considered then, now that I have another use
> case maybe it could be revisited and fixed. What I want is to be able to
> call spd_data_generate() from board code with whatever sizÃ© (the
> board does not need to know about SPD limits and so cannot pre-check the
> size) and the function should return the largest possible size SPD and
> some indication if the size was not used completely. If Error cannot be
> used for this, return the message or error some other way but let the
> board code decide if it wants to abort or it can use the smaller SPD. Do
> not assert in the helper function. Maybe the DIMM type fix up can be
> dropped and only keep the size fix up so then we don't need to use error
> twice, the board could call the function again if a different type is
> also acceptable, since only sam460ex would need this I can do that there
> for type fixup and call spd_data_generate() again with DDR2 if first one
> with DDR could not fit all ram. But at least the asserts should be
> dropped for this and the size check brought back. Then adding SPD to
> mac_oldworld could also be done by calling spd_data_generate() instead
> of duplicating the checks this function does anyway. This board has
> three slots so if user says -m 1400 it would call spd_data_generate()
> with 1400 first, get back 512 SPD that it adds to first slot then calls
> spd_data_generate() again with 888, gets 512 again that it adds to 2nd
> slot and calls spd_data_generate() for last slot with 376 which would
> give 256 and 120 remaining that it may warn the user about but still
> continue because the SPD data is only used by a ROM from real hardware
> (that may be used for compatibility with some software) but the default
> OpenBIOS disregards SPD data and would still use 1400 so it's not an
> error to abort on. Simply if using a firmare ROM then only 1280 MB of
> the 1400 will be available due to its limitations but that's not a
> reason to force users to change their command line. Printing a warning
> is enough to hint they may use different value but aborting without an
> error message on an assert which is the current situation is not really
> a user friendly way.

I just noticed we have a MachineClass::fixup_ram_size() handler. There
is only one implementation (on s390x) which does a bit the opposite:
If the user asks for -m 1400, it will pad to a valid physical size,
so in your example to 1472 MiB. Then the guest can use only 1400 if it
is happy with it. 72 MiB are wasted, but this is still better than the
576 MiB wasted if we were using 2 GiB instead ;)

See commit 5c30ef937f5:

static ram_addr_t s390_fixup_ram_size(ram_addr_t sz)
{
    /* same logic as in sclp.c */
    int increment_size = 20;
    ram_addr_t newsz;

    while ((sz >> increment_size) > MAX_STORAGE_INCREMENTS) {
        increment_size++;
    }
    newsz = sz >> increment_size << increment_size;

    if (sz != newsz) {
        qemu_printf("Ram size %" PRIu64 "MB was fixed up to %" PRIu64
                    "MB to match machine restrictions. "
                    "Consider updating "
                    "the guest definition.\n", (uint64_t) (sz / MiB),
                    (uint64_t) (newsz / MiB));
    }
    return newsz;
}

> 
> Hopefully at least somebody will read it up to this point, sorry for
> writing that much but hopefully this explains my point of view.

Someone did ;) I know it is not always easy, English is not the default
language for various developers.

> 
> Regards,
> BALATON Zoltan

