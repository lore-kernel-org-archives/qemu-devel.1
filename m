Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3611C3F2C6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 18:45:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 790D021775
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 18:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 790D021775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAHyf-0001yH-M8
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 13:45:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1jAHxi-0000hI-IH
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 13:44:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1jAHxg-0008Nk-MS
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 13:44:42 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:36772
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jAHxg-0008Iy-8n; Fri, 06 Mar 2020 13:44:40 -0500
Received: from host86-162-6-80.range86-162.btcentralplus.com ([86.162.6.80]
 helo=[192.168.1.65]) by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jAHxt-0003Hf-Q5; Fri, 06 Mar 2020 18:44:54 +0000
To: BALATON Zoltan <balaton@eik.bme.hu>
References: <cover.1583017348.git.balaton@eik.bme.hu>
 <alpine.BSF.2.22.395.2003011731130.95594@zero.eik.bme.hu>
 <57ff6676-5054-d3f6-f4fc-6ff02b09019f@ilande.co.uk>
 <alpine.BSF.2.22.395.2003011902490.28669@zero.eik.bme.hu>
 <alpine.BSF.2.22.395.2003011951370.28669@zero.eik.bme.hu>
 <38cb0f83-79fc-7021-38fc-c1e28c3c0fa0@ilande.co.uk>
 <alpine.BSF.2.22.395.2003012202330.79908@zero.eik.bme.hu>
 <9ce6d135-4169-96ae-c457-1131b4510c49@ilande.co.uk>
 <alpine.BSF.2.22.395.2003022145430.47473@zero.eik.bme.hu>
 <2a39ccab-e4d4-8172-9a1d-0bc089e0104c@ilande.co.uk>
 <alpine.BSF.2.22.395.2003032356230.41934@zero.eik.bme.hu>
 <a579c016-fd6c-ad4f-c091-2286265c9a57@ilande.co.uk>
 <alpine.BSF.2.22.395.2003042227190.70853@zero.eik.bme.hu>
 <b3bce0d3-3ab3-7fb3-ed3c-60f1f19159d6@ilande.co.uk>
 <alpine.BSF.2.22.395.2003060007040.48868@zero.eik.bme.hu>
 <alpine.BSF.2.22.395.2003060115170.85813@zero.eik.bme.hu>
 <e8f3fe10-7a44-5552-bb80-7bc24fe68cc6@ilande.co.uk>
 <alpine.BSF.2.22.395.2003061306500.10004@zero.eik.bme.hu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <19993bf1-a695-2a5d-dce8-f1b2b6677bf5@ilande.co.uk>
Date: Fri, 6 Mar 2020 18:44:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2003061306500.10004@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 86.162.6.80
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 2/2] via-ide: Also emulate non 100% native mode
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:41c9:1:41f::167
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
Cc: qemu-block@nongnu.org, philmd@redhat.com, qemu-devel@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/03/2020 12:40, BALATON Zoltan wrote:

> On Fri, 6 Mar 2020, Mark Cave-Ayland wrote:
>> On 06/03/2020 00:21, BALATON Zoltan wrote:
>>> On Fri, 6 Mar 2020, BALATON Zoltan wrote:
>>>> On Thu, 5 Mar 2020, Mark Cave-Ayland wrote:
>>>>> On 04/03/2020 22:33, BALATON Zoltan wrote:
>>>>> another possibility: PCI configuration space register 0x3d (Interrupt pin) is
>>>>> documented as having value 0 == Legacy IRQ routing which should be the initial
>>>>> value
>>>>> on reset, but QEMU incorrectly sets it to 1 which indicates PCI IRQ routing.
>>>>
>>>> The VT8231 docs say this should always read 1 but may be this is somehow set to 0
>>>> on the Pegasos2. What does that mean? Should we use this value instead of the
>>>> feature bit to force using legacy interrupts? We'd still need a property in via-ide
>>>> to set this reg or is it possible to set it from board code overriding the default
>>>> after device is created? That would allow to drop patch 1. I can try this.
>>>
>>> This seemed like it could simplify patches a bit but it does not work. Setting this
>>> reg to 0 breaks Linux and MorphOS which then think the device does not have an
>>> interrupt at all and fail as before waiting for the irq. So we still need the feature
>>> bit, cant use this reg to force legacy interrupts. I've spent considerable time
>>> testing different OSes before I've ended up with this patch series I've submitted and
>>> I could not find a simpler way that works with everything.
>>
>> I appreciate that testing these things can take a lot of time, but what is important
>> thing to ask here is whether these hacks are attempting to work around something in
>> QEMU that doesn't match the hardware specification, and to me it feels that this is
>> what is happening here.
> 
> It may be we need to work around some incomplete modelling of devices in QEMU, e.g.
> we only model the native mode of these IDE interfaces so anything involving legacy
> mode is out of scope. To also emulate legacy mode we'd need changing common ISA code
> and maybe PIC code as well. As those parts are also used by other more commonly used
> machine models I'd avoid breaking those and rather implement it confined to these
> machines that are not yet finished or complete anyway than try to change all
> dependent devices that would need even more testing. These "hacks" could be cleaned
> up later and this would not be the only hack in QEMU, I don't have time to fix
> everything and it's unreasonable to demand it I think. I'd suggest to take this patch
> as it is now and if you don't like it you can submit patches that clean it up the way
> you think is correct or submit an alternative patch now that shows how do you think
> it can be done in a cleaner way because I don't see it and don't have more time for
> it now.
> 
>> Obviously this thread has become quite long (and even I'm struggling to find previous
>> discussions) but here is my summary below:
>>
>> - I don't think the patch in its current form is the right way to do this. Instead of
>> adding a feature bit to fudge the existing IRQ routing when the existing IRQ routing
>> is wrong, let's fix the existing IRQ routing instead.
> 
> I think that would involve changing parts which could break other machines so I'd
> rather go with a featute bit only affecting pegasos2 and fulonge2 than touch i8259 or
> ISA emulation basing that on some guess how the real chip may be implemented. Is it
> possible to implement what you propose without changing common IDE, ISA and PIC
> emulation only in via-ide and fulong2e code?
> 
>> - There is no mention of "non-100%" native mode in the 8231 or 686B datasheet: this
>> is simply a term used within the Linux patches. The controller is either in native
>> mode, or legacy mode. It may be that guests are making use of some undefined
>> behaviour here.
> 
> Yes, this is a Linux term and Linux also uses a feature bit to enable this
> workaround. If that's good enough for Linux why isn't it good enough for you?
> 
>> - The code that uses the value of PCI_INTERRUPT_LINE in via-ide is incorrect (as your
>> patch comment points out, some guests ignore it anyway).
> 
> You're misunderstanding the comment. The via_ide_config_read function is needed to
> restore value in interrupt line that common PCI reset code deletes. Linux depends on
> this value to be the same as on real hardware so this is needed to work around QEMU
> and Linux pecularities.
> 
> I've tried using PCI_INTERRUPT_PIN in place of the feature bit but setting that to 0
> breaks Linux and MorphOS on pegasos2 because these apparently expect this to be set
> to 1 corresponding to native mode. (Firmware only sets native mode enable bits in
> prog-if but datasheet says this reg should be 1 by default and other PCI docs say 0
> here means no interrupt used so maybe that's why Linux and MorphOS don't like it.)
> 
>> - There is different behaviour here between the 8231 and 686B in this area, despite
>> having the same vendor/device id.
>>
>>
>> The first thing you need to fix is the PCI_INTERRUPT_LINE part; I would start by
>> removing the existing code and instead expose a qdev named gpio "legacy-irq" and
>> wiring that up to your interrupt controller. Note you'd have to do the same for
>> fulong2e, but that is reasonably trivial.
> 
> Please go ahead and do it but if you don't submit an alternative patch before the
> freeze I'd ask John and Peter to make a judgement here and tell if my series is
> acceptable or not in its current form and if it is then please merge it and leave
> clean ups for subsequent patches. This is blocking my further patches to implement
> pegasos2 emulation.

I believe I've answered this in detail in my previous email, so I suggest we keep the
discussion there so it's all in one place.


ATB,

Mark.

