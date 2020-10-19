Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45E2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D9F1222EA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9F1222EA
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUXwD-0003JV-BK
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 12:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kUXr9-00078E-EQ; Mon, 19 Oct 2020 12:17:59 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:23887)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kUXr4-0003QN-9t; Mon, 19 Oct 2020 12:17:54 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 672EF746333;
 Mon, 19 Oct 2020 18:17:34 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 09F8F745953; Mon, 19 Oct 2020 18:17:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 082DB74594E;
 Mon, 19 Oct 2020 18:17:34 +0200 (CEST)
Date: Mon, 19 Oct 2020 18:17:34 +0200 (CEST)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH] hw/pci-host/grackle: Verify PIC link is properly set
In-Reply-To: <9968e60e-99fd-3777-62ca-57decb716886@ilande.co.uk>
Message-ID: <4d2ab53b-879-a58d-b4b4-1b36f037765f@eik.bme.hu>
References: <20201011190332.3189611-1-f4bug@amsat.org>
 <20201011223446.GA4787@yekko.fritz.box>
 <369509c1-2e90-13cf-8845-892e754516d1@amsat.org>
 <20201012065436.GB71119@yekko.fritz.box>
 <9f7e4847-801d-dcd3-b876-bf2d276251@eik.bme.hu>
 <6e587154-4bc5-c44c-0c85-b46e0dddd3aa@amsat.org>
 <87k0vm1wny.fsf@dusky.pond.sub.org>
 <24bcd4-fde2-22a2-d3f4-cd42d9ee13c6@eik.bme.hu>
 <87d01e48pa.fsf@dusky.pond.sub.org>
 <9968e60e-99fd-3777-62ca-57decb716886@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-936919194-1603124254=:64611"
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 BALATON Zoltan via <qemu-devel@nongnu.org>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: BALATON Zoltan <balaton@eik.bme.hu>
From: BALATON Zoltan via <qemu-devel@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-936919194-1603124254=:64611
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 19 Oct 2020, Mark Cave-Ayland wrote:
> On 19/10/2020 15:00, Markus Armbruster wrote:
>> BALATON Zoltan via <qemu-devel@nongnu.org> writes:
>>> On Mon, 19 Oct 2020, Markus Armbruster wrote:
>>>> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>>>>> On 10/12/20 1:50 PM, BALATON Zoltan via wrote:
>>>>>> On Mon, 12 Oct 2020, David Gibson wrote:
>>>>>>> On Mon, Oct 12, 2020 at 08:21:41AM +0200, Philippe
>>>>>>> Mathieu-DaudÃƒÆ’Ã‚Â© wrote:
>>>>>>>> On 10/12/20 12:34 AM, David Gibson wrote:
>>>>>>>>> On Sun, Oct 11, 2020 at 09:03:32PM +0200, Philippe
>>>>>>>>> Mathieu-DaudÃƒÆ’Ã‚Â© wrote:
>>>>>>>>>> The Grackle PCI host model expects the interrupt controller
>>>>>>>>>> being set, but does not verify it is present. Add a check to
>>>>>>>>>> help developers using this model.
>>>>>>>>> 
>>>>>>>>> I don't think thaqt's very likely, but, sure, applied to ppc-for-5.2
>>>>>>>> 
>>>>>>>> Do you want I correct the description as:
>>>>>>>> "The Grackle PCI host model expects the interrupt controller
>>>>>>>> being set, but does not verify it is present.
>>>>>>>> A developer basing its implementation on the Grackle model
>>>>>>>> might hit this problem. Add a check to help future developers
>>>>>>>> using this model as reference."?
>>>>>>> 
>>>>>>> No, it's fine.Â  All I was saying is that the chances of anyone using
>>>>>>> Grackle in future seem very low to me.
>>>>>> So maybe an assert instead of a user visible error would be enough?
>>>>> 
>>>>> My understanding is realize() shouldn't abort()
>>>>> (the caller might choose to by using &error_abort).
>>>> 
>>>> assert() is for checking invariants.  A violated invariant is a
>>>> programming error: developers screwed up, safe recovery is impossible.
>>>> 
>>>> Abusing assert() to catch errors that are not programming errors is
>>>> wrong.
>>>> 
>>>> You may check invariants with assert() anywhere in the code.
>>>> 
>>>> You should not misuse assert() anywhere in the code.
>>>> 
>>>> Sometimes, an error condition that is *not* a programming error in the
>>>> function where it is detected *is* a programming error for certain
>>>> calls.  Having these calls pass &error_abort is a common solution for
>>>> this problem.
>>>> 
>>>> Hope this helps.
>>> 
>>> Helps just a bit but after reading this I'm still confused if this
>>> particular case should be assert or ser error.
>>> 
>>> I was suggesting assert and I think it's a programming error to use
>>> the grackle model without setting PIC link but not sure if users can
>>> also create this instance via command line (even if it does not make
>>> much sense) in which case it's probably better to return error.
>> 
>> They can't: "info qdm" shows
>>
>>      name "grackle-pcihost", bus System, no-user
>>                                          ~~~~~~~
>>
>>>                                                                  Having
>>> all devices user creatable via -device without a way to describe their
>>> dependencies is a nice way to make all sorts of errors possible. But
>>> maybe aborting with assert during creation of the machine is still
>>> OK. If people device_add a model later and that crashes then it's
>>> their problem. Unless we want to avoid that being used as DoS in
>>> enterprise setting. So maybe we should never abort then if there's a
>>> way to fail with an error instead.
>>> 
>>> I can look at this problem from different angles and all seem to be
>>> plausible resulting in different solutions.
>> 
>> As long as the device is no-user, asserting that properties have sane
>> values feels reasonable enough to me.
>> 
>> Setting an error instead is not wrong, of course.
>
> One thing I have thought about is being able to mark a link property as 
> mandatory so if a value hasn't been set before realize then you receive a 
> fatal error. This would be for cases like this where 2 internal devices are 
> connected together without any formal interface, i.e. in cases where -device 
> wouldn't work anyway.

In that case we should have no-user anyway and the device has to be 
instantiated by board code so then assert is enough to avoid error in 
board code. More complex way to describe dependencies may only be needed 
if we want to allow dynamic creation of new boards via the command line 
which was the original idea but that's quite a long way away if possible 
at all so I would not worry about that at this point.

Regards,
BALATON Zoltan
--3866299591-936919194-1603124254=:64611--

