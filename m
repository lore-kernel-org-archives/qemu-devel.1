Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D56C4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:57:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4485C20731
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4485C20731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUCUd-0001nV-Aw
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:56:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1jUCTq-0001ND-J3
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1jUCTp-0006pl-IA
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:56:10 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:59186
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jUCTp-0006lW-5D
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:56:09 -0400
Received: from host86-140-11-65.range86-140.btcentralplus.com ([86.140.11.65]
 helo=[192.168.1.65]) by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jUCTo-0001ZJ-ET; Thu, 30 Apr 2020 17:56:09 +0100
To: Markus Armbruster <armbru@redhat.com>
References: <87mu6uia5i.fsf@dusky.pond.sub.org>
 <20200429155719.GL1495129@redhat.com> <87k11xh2kq.fsf@dusky.pond.sub.org>
 <CAFEAcA9-oxkMD-kJ1z12d4K1S_Jaz7Wj6_38Ah7ChSaBfQNkkA@mail.gmail.com>
 <87tv11e1en.fsf_-_@dusky.pond.sub.org>
 <51a4e9ea-eca3-6c1d-a753-86c5810ac094@ilande.co.uk>
 <874kt1dpw7.fsf@dusky.pond.sub.org>
 <c1fa0770-a07f-e5bc-9db8-6af0576c365f@ilande.co.uk>
 <877dxxc862.fsf@dusky.pond.sub.org>
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
Message-ID: <0b745eed-841e-8879-c320-3166e2a46953@ilande.co.uk>
Date: Thu, 30 Apr 2020 17:56:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <877dxxc862.fsf@dusky.pond.sub.org>
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

On 30/04/2020 16:20, Markus Armbruster wrote:

>> Ah I see now, these aliases are for individual properties rather than objects. What I
>> was trying to ask was if it were possible to have something like this:
>>
>> /machine (SS-5-machine)
>>   /builtin
>>     /nic0 -> link to "lance" device
>>
>> Here nic0 is an alias "published" by the maintainer of the SS-5 machine which is
>> configured in the machine init() function using object_property_add_link() or a
>> suitable wrapper. Users can then configure these builtin devices from the command
>> line using your -machine nic0.netdev=my-netdev-id syntax or similar.
> 
> Got it now, thanks!
> 
>> Having the default devices under /builtin or other known QOM path would enable
>> builtin devices to be easily enumerated programatically and/or from the command line
>> as required.
> 
> There are three standard containers under /machine/:
> 
> * /machine/peripheral/
> 
>   Devices with a user-specified ID go here, as /machine/peripheral/ID.
>   User-specified means -device or device_add.
> 
>   /machine/peripheral/ID is effectively a stable interface.  It's just
>   underdocumented (undocumented?).
> 
>   To be useful, the stuff below ID/ needed to be stable and documented,
>   too.
> 
> * /machine/peripheral-anon/
> 
>   Same, but user elected not to give an ID.
>   /machine/peripheral-anon/device[N], where N counts up from zero in
>   creation order.
> 
>   N is obviously not stable, but this is a problem of the user's making.
>   If you want to refer to a device, give it an ID.
> 
> * /machine/unattached/
> 
>   The orphanage.  When a device has no parent when its realized, it gets
>   put here, as /machine/unattached/device[N], where N counts up from
>   zero in realization order.
> 
>   N is obviously not stable, and this time we can't blame the
>   victim^Wuser.  You can search for devices of a certain type.
>   Sometimes that's good enough.
> 
>   All the onboard devices are here, and much more.  We've fathered a lot
>   of unloved red-headed children, it seems...
> 
>   Some of the "much more" is due to sloppy modelling, i.e. neglecting to
>   set the proper parent.
> 
>   I figure we could put onboard devices in a nicer place, with nicer
>   names.  Need a convention for the place and the names, then make board
>   code conform to it.

That's good, it seems that this is already fairly close to how it works for -device
at the moment.

I don't think that it is possible to come up a single place for on-board devices to
live directly though. Going back to one of my first examples: wiring up a chardev to
a serial port on the macio device. To me it makes sense for that to exist in QOM
under /machine/pci-bus/mac-io/escc. In contrast an in-built NIC could live under
/machine/pci-bus/in-built/nic, and placing one or both of these devices directly
under /machine/foo doesn't feel intuitive.

AFAIK as per your ARM virt example I believe it is only possible to register an alias
for a property rather than for an Object? The ultimate aim would be for
object_resolve_path("/machine/builtin/nic0") and
object_resolve_path("/machine/pci-bus/in-built/nic") to return the same Object, and
for the aliases on built-in devices to be children of /machine/builtin to allow easy
iteration and introspection.


ATB,

Mark.

