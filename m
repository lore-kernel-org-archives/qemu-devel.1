Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFB0C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 23:28:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B40924673
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 23:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B40924673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8uTz-0006uK-Qr
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 18:28:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j8uSj-0005yk-7x
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 18:27:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j8uSh-00023K-LC
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 18:27:01 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:25725)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1j8uSe-0001yU-2i; Mon, 02 Mar 2020 18:26:56 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 41AD4747DCF;
 Tue,  3 Mar 2020 00:26:54 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0FE2E7476D5; Tue,  3 Mar 2020 00:26:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0D7AC74637E;
 Tue,  3 Mar 2020 00:26:54 +0100 (CET)
Date: Tue, 3 Mar 2020 00:26:54 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 1/2] ide: Make room for flags in PCIIDEState and add one
 for legacy IRQ routing
In-Reply-To: <ff8e0d07-9237-b8b4-a117-88e86926bf28@ilande.co.uk>
Message-ID: <alpine.BSF.2.22.395.2003030017210.47473@zero.eik.bme.hu>
References: <cover.1583017348.git.balaton@eik.bme.hu>
 <775825dba26f6b36ab067f253e4ab5dc3a3d15dc.1583017348.git.balaton@eik.bme.hu>
 <d85cd8c6-99a3-8430-41cc-486aad1ad8de@ilande.co.uk>
 <alpine.BSF.2.22.395.2003011619100.95594@zero.eik.bme.hu>
 <87pndvch3t.fsf@dusky.pond.sub.org>
 <ff8e0d07-9237-b8b4-a117-88e86926bf28@ilande.co.uk>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: qemu-block@nongnu.org, philmd@redhat.com,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Mar 2020, Mark Cave-Ayland wrote:
> On 02/03/2020 08:10, Markus Armbruster wrote:
>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>> On Sun, 1 Mar 2020, Mark Cave-Ayland wrote:
>>>> On 29/02/2020 23:02, BALATON Zoltan wrote:
>>>>> We'll need a flag for implementing some device specific behaviour in
>>>>> via-ide but we already have a currently CMD646 specific field that can
>>>>> be repurposed for this and leave room for furhter flags if needed in
>>>>> the future. This patch changes the "secondary" field to "flags" and
>>>>> define the flags for CMD646 and via-ide and change CMD646 and its
>>>>> users accordingly.
>>>>>
>>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>>> ---
>>>>>  hw/alpha/dp264.c     |  2 +-
>>>>>  hw/ide/cmd646.c      | 12 ++++++------
>>>>>  hw/sparc64/sun4u.c   |  9 ++-------
>>>>>  include/hw/ide.h     |  4 ++--
>>>>>  include/hw/ide/pci.h |  7 ++++++-
>>>>>  5 files changed, 17 insertions(+), 17 deletions(-)
>>>>>
>>>>> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
>> [...]
>>>>> @@ -317,20 +317,20 @@ static void pci_cmd646_ide_exitfn(PCIDevice *dev)
>>>>>      }
>>>>>  }
>>>>>
>>>>> -void pci_cmd646_ide_init(PCIBus *bus, DriveInfo **hd_table,
>>>>> -                         int secondary_ide_enabled)
>>>>> +void pci_cmd646_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn,
>>>>> +                         bool secondary_ide_enabled)
>>>>>  {
>>>>>      PCIDevice *dev;
>>>>>
>>>>> -    dev = pci_create(bus, -1, "cmd646-ide");
>>>>> -    qdev_prop_set_uint32(&dev->qdev, "secondary", secondary_ide_enabled);
>>>>> +    dev = pci_create(bus, devfn, "cmd646-ide");
>>>>> +    qdev_prop_set_bit(&dev->qdev, "secondary", secondary_ide_enabled);
>>>>>      qdev_init_nofail(&dev->qdev);
>>>>>
>>>>>      pci_ide_create_devs(dev, hd_table);
>>>>>  }
>>>>
>>>> Note that legacy init functions such as pci_cmd646_ide_init() should be removed where
>>>> possible, and in fact I posted a patch last week to completely remove it. This is
>>>> because using qdev directly allows each board to wire up the device as required,
>>>> rather than pushing it down into a set of init functions with different defaults.
>>>>
>>>> Given that you're working in this area, I'd highly recommend doing the same for
>>>> via_ide_init() too.
>>>
>>> I could do that, however these ide init functions seem to exist for
>>> piix, cmd646 and via-ide so that pci_ide_create_devs function is kept
>>> local to hw/ide. Nothing else called that func apart from sun4u so
>>> I've chosen this way to keep consistency (also keeps property type at
>>> one place instead of needing to change each board that sets
>>> property). If the consensus is that getting rid of these init funcs
>>> even if that means pci_ide_create_devs will not be local to ide any
>>> more I can go that way but would like to hear opinion of ide
>>> maintainer as well.
>>
>> I think Mark's point is that modelling a device and wiring up a device
>> model are separate things, and the latter belongs to the board.
>>
>> pci_cmd646_ide_init() is a helper for boards.  Similar helpers exist
>> elsewhere.
>>
>> In the oldest stratum of qdev code, such helpers were static inline
>> functions in the device model's .h.  That way, they're kind of separate
>> from the device model proper, in the .c, and kind of in the board code
>> where they belong, via inlining.  I've always considered that a terrible
>> idea; it's "kind of" as in "not really".  Over time, practice moved
>> first to putting the helpers into .c, then to open-coding the wiring
>> where it belongs: in the boards.
>>
>> A few helper functions have survived, e.g. in hw/lm32/milkymist-hw.h,
>> and the IDE helpers we're discussing here.
>>
>> Of course, when the code to wire up certain devices gets overly
>> repetitive, factoring out common code into helpers can make sense.  But
>> where to put them?  I can't see an obvious home for common board
>> helpers.  We tend to put these wiring helpers into a device model's .c
>> code for want of a better place.  Tolerable, I think.
>
> Right, thanks for the more detailed explanation of what I was trying to say above.
>
> As you say having helpers can definitely help avoid repetitive code, however there
> was a case a few releases back when someone flipped a qdev property in a device
> _init() helper function used to initialise one of the more common devices and it
> broke several of the older machines.
>
> So now I'm mainly of the opinion that if the helper is just instantiating a device,
> setting qdev properties and then returning the device then you're better off moving
> the initialisation into the board code to prevent problems like this occurring again
> (and certainly this nudges us towards building machines from config files since all
> the configuration/wiring is now done at board level).

The conflicting interests here seem to be

1. Keeping pci_ide_create_devs() local to hw/ide
2. keeping things related to the board in board code and getting rid of 
init functions

I can't decide which of the above is more important or nicer but the patch 
I've proposed at least kept consistency with existing practice. If it's 
decided that board code should use pci_ide_create_devs directly instead we 
could either address that in a separate clean up series also getting rid 
of the piix init functions at the same time later or if Mark's series gets 
merged first I can rebase on that.

Regards,
BALATON Zoltan

