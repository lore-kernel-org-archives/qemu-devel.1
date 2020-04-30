Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831AFC83000
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:34:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56C0F2072A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C0F2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUAGL-0005we-Eb
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 10:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33256)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1jUAF0-0004aM-PQ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:32:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1jUAEz-0005fm-Ja
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:32:42 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:58894
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jUAEz-0005bx-65
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:32:41 -0400
Received: from host86-140-11-65.range86-140.btcentralplus.com ([86.140.11.65]
 helo=[192.168.1.65]) by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jUAEt-0000l1-2g; Thu, 30 Apr 2020 15:32:41 +0100
To: Markus Armbruster <armbru@redhat.com>
References: <87mu6uia5i.fsf@dusky.pond.sub.org>
 <20200429155719.GL1495129@redhat.com> <87k11xh2kq.fsf@dusky.pond.sub.org>
 <CAFEAcA9-oxkMD-kJ1z12d4K1S_Jaz7Wj6_38Ah7ChSaBfQNkkA@mail.gmail.com>
 <87tv11e1en.fsf_-_@dusky.pond.sub.org>
 <51a4e9ea-eca3-6c1d-a753-86c5810ac094@ilande.co.uk>
 <874kt1dpw7.fsf@dusky.pond.sub.org>
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
Message-ID: <c1fa0770-a07f-e5bc-9db8-6af0576c365f@ilande.co.uk>
Date: Thu, 30 Apr 2020 15:32:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <874kt1dpw7.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.140.11.65
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: Configuring onboard devices
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/04/2020 15:11, Markus Armbruster wrote:

> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:
> 
>> On 30/04/2020 11:03, Markus Armbruster wrote:
>>> Peter Maydell <peter.maydell@linaro.org> writes:
>>>
>>>> On Thu, 30 Apr 2020 at 08:09, Markus Armbruster <armbru@redhat.com> wrote:
>>>>> Our means to configure onboard devices are weak.  We sidestepped this
>>>>> for isa-fdc by taking it off the board, and thus make -device work.
>>>>
>>>> This seems to be a general dynamic: the x86 pc machine works
>>>> via -device options (or is changed so it can work that way);
>>>> and then people propose dropping/deprecating/etc the config
>>>> options that work with onboard devices, without providing
>>>> clear solutions/instructions on how the command line needs
>>>> to change/etc for the mass of boards which are not the x86
>>>> pc machine and which do have a lot of onboard devices which
>>>> can't be handled via -device.
>>>>
>>>> So my gut reaction to the "we should deprecate -global"
>>>> suggestions in this thread was a bit "here we go again"...
>>>> What works for x86 or even "what is sufficient for libvirt"
>>>> doesn't necessarily cover all the cases.
>>>
>>> Such shortsighted proposals have been made, but don't think it's what
>>> we're doing here.
>>>
>>> You're 100% right in that we do need to configure onboard devices.
>>> -global is a terrible way to do it, though: it applies to *all* devices
>>> of a kind.  What if the board has more than one?  What if the can add
>>> more?
>>>
>>> Taking onboard devices off the board can occasionally sidestep the
>>> issue.  For isa-fdc, we genuinely *wanted* to take the damn thing off,
>>> because all it did for most users was provide them with VENOM.  Not
>>> needing -global for it anymore was just a nice bonus.
>>>
>>> Taking onboard devices off just to reduce the device configuration
>>> problem to a solved one, namely -device, may be tempting (it was to me),
>>> but it's too intrusive to be practical at scale.
>>>
>>> Adding machine properties that alias onboard device properties is less
>>> intrusive.  The ones I added were still a lot of work.
>>>
>>> Configuring onboard devices via machine properties restricts property
>>> access to the ones we added to the machine.  This differs from pluggable
>>> devices, where users can access all properties.
>>>
>>> Any better ideas for letting users configure onboard devices?
>>
>> Is it possible to let machine owners add alias properties to the machine object
>> referencing in-built devices? I could then instantiate my on-board nic in the machine
>> init() function, and then use object_property_add_alias() to add a "nic0" alias on
>> the machine that can be used to wire it up to a netdev using the command line.
> 
> Have a look at hw/arm/virt.c's virt_flash_create(), from commit
> e0561e60f1 "hw/arm/virt: Support firmware configuration with -blockdev".
> It adds machine properties "pflash0" and "pflash1" as aliases for the
> onboard flash memory devices' property "drive".
> 
> Does this answer your question?

Ah I see now, these aliases are for individual properties rather than objects. What I
was trying to ask was if it were possible to have something like this:

/machine (SS-5-machine)
  /builtin
    /nic0 -> link to "lance" device

Here nic0 is an alias "published" by the maintainer of the SS-5 machine which is
configured in the machine init() function using object_property_add_link() or a
suitable wrapper. Users can then configure these builtin devices from the command
line using your -machine nic0.netdev=my-netdev-id syntax or similar.

Having the default devices under /builtin or other known QOM path would enable
builtin devices to be easily enumerated programatically and/or from the command line
as required.


ATB,

Mark.

