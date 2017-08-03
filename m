Received: from eggs.gnu.org ([2001:4830:134:3::10]:40223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ddLLm-0000ps-1E
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 15:00:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ddLLi-00062z-Kw
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 15:00:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ddLLi-0005z6-Aw
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 14:59:58 -0400
References: <1501285073-2215-1-git-send-email-zuban32s@gmail.com>
	<1501285073-2215-6-git-send-email-zuban32s@gmail.com>
	<491f77fc-974c-33dd-3974-08ab61d2c078@redhat.com>
	<CAKSfGUCTom8YBs8wOHMX_MpzDF1efB8_USb4tuW+hcAdoG2xvw@mail.gmail.com>
	<20170802003910-mutt-send-email-mst@kernel.org>
	<17a71bfc-1933-f707-2504-c9c699534cea@redhat.com>
	<20170802164551-mutt-send-email-mst@kernel.org>
	<9e36b7d6-bff3-b046-6053-162fb75ca0a0@redhat.com>
	<b0e1c72d-9c17-42e5-3135-5ebb1e53b4f1@redhat.com>
	<c4761b15-4525-247c-14da-510b20dbf90a@redhat.com>
	<20170802192446-mutt-send-email-mst@kernel.org>
	<597fd60c-d8ec-0334-10de-3ff4947055ea@redhat.com>
	<6b6e8efe-18d6-8d77-ad8c-54b8f7ba2ef8@redhat.com>
	<92801f02-1743-b604-8a07-fbf5db162386@redhat.com>
	<1ecc7424-2b82-6205-204f-8eb0f287dccd@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <ad4db3a8-0d0b-2913-21c0-88360dc74577@redhat.com>
Date: Thu, 3 Aug 2017 21:59:45 +0300
MIME-Version: 1.0
In-Reply-To: <1ecc7424-2b82-6205-204f-8eb0f287dccd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/5] docs: update documentation
 considering PCIE-PCI bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laine Stump <laine@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Alexander Bezzubikov <zuban32s@gmail.com>, ehabkost@redhat.com, seabios@seabios.org, Kevin OConnor <kevin@koconnor.net>, Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com, Igor Mammedov <imammedo@redhat.com>, rth@twiddle.net

On 03/08/2017 16:58, Laine Stump wrote:
> On 08/03/2017 06:29 AM, Marcel Apfelbaum wrote:
>> On 03/08/2017 5:41, Laine Stump wrote:
>>> On 08/02/2017 01:58 PM, Marcel Apfelbaum wrote:
>>>> On 02/08/2017 19:26, Michael S. Tsirkin wrote:
>>>>> On Wed, Aug 02, 2017 at 06:36:29PM +0300, Marcel Apfelbaum wrote:
>>>>>>>>>>> Can dmi-pci support shpc? why doesn't it? For compatibility?
>>>>>>>>>>
>>>>>>>>>> I don't know why, but the fact that it doesn't is the reason
>>>>>>>>>> libvirt
>>>>>>>>>> settled on auto-creating a dmi-pci bridge and a pci-pci bridge
>>>>>>>>>> under
>>>>>>>>>> that for Q35. The reasoning was (IIRC Laine's words correctly)
>>>>>>>>>> that the
>>>>>>>>>> dmi-pci bridge cannot receive hotplugged devices, while the
>>>>>>>>>> pci-pci
>>>>>>>>>> bridge cannot be connected to the root complex. So both were
>>>>>>>>>> needed.
>>>
>>
>> Hi Laine,
>>
>>>
>>> At least that's what I was told :-) (seriously, 50% of the convoluted
>>> rules encoded into libvirt's PCI bus topology construction and
>>> connection rules come from trial and error, and the other 50% come from
>>> advice and recommendations from others who (unlike me) actually know
>>> something about PCI.)
>>>
>>> Of course the whole setup of plugging a pci-bridge into a
>>> dmi-to-pci-bridge was (at the time at least) an exercise in futility,
>>> since hotplug didn't work properly on pci-bridge+Q35 anyway (that
>>> initially wasn't explained to me; it was only after I had constructed
>>> the odd bus topology and it was in released code that someone told me
>>> "Oh, by the way, hotplug to pci-bridge doesn't work on Q35". At first it
>>> was described as a bug, then later reclassified as a future feature.)
>>>
>>> (I guess the upside is that all of the horrible complex/confusing code
>>> needed to automatically add two controllers just to plug in a single
>>> endpoint is now already in the code, and will "just work" if/when
>>> needed).
>>>
>>> Now that I go back to look at this thread (qemu-devel is just too much
>>> for me to try and read unless something has been Cc'ed to me - I really
>>> don't know how you guys manage it!), I see that pcie-pci-bridge has been
>>> implemented, and we (libvirt) will want to use that instead of
>>> dmi-to-pci-bridge when available. And pcie-pci-bridge itself can have
>>> endpoints hotplugged into it, correct?
>>
>> Yes.
>>
>>> This means there will need to be
>>> patches for libvirt that check for the presence of pcie-pci-bridge, and
>>> if it's found they will replace any auto-added
>>> dmi-to-pci-bridge+pci-bridge with a long pcie-pci-bridge.
>>>
>>
>> The PCIe-PCI bridge is to be plugged into a PCIe Root Port and then
>> you can add PCI devices to it. The devices can be hot-plugged
>> into it (see below the limitations) and even the bridge itself
>> can be hot-plugged (old OSes might not support it).
>>
>> So the device will replace the dmi-pci-bridge + pci-pci
>> bridge completely.
>>
>> libvirt will have 2 options:
>> 1. Start with a pcie-pci bridge attached to a PCIe Root Port
>>     and all legacy PCI devices should land there (or on bus 0)
>>     (You can use the "auto" device addressing, add PCI devices
>>      automatically to this device until the bridge is full,
>>      then use the last slot to add a pci brigde or use another
>>      pcie-pci bridge)
>> 2. Leave a PCIe Root Port empty and configure with hints for
>>     the fw that we might want to hotplug a pcie-pci bridge into it.
>>     If a PCI device is needed, hotplug the pcie-pci bridge first,
>>     then the device.
>>
>> The above model gives you enough elasticity so if you:
>>    1. don't need PCI devices -> create the machine with
>>       no pci controllers
>>    2. need PCI devices -> add a pcie-pci bridge and you
>>       get a legacy PCI bus supporting hotplug.
>>    3. might need PCI devices -> leave a PCIe Root Port
>>       empty (+ hints)
> 
> I'm not sure what to do in libvirt about (3). Right now if an unused
> root port is found in the config when adding a new endpoint device with
> no PCI address, the new endpoint will be attached to that existing root
> port. In order for one of the "save it for later" root ports to work, I
> guess we will need to count that root port as unavailable when setting
> PCI addresses on an inactive guest, but then allow hotplugging into it.

For Q35 you need such policy anyway. The only way to allow PCI Express
Hotplug (I am not referring now to our legacy PCI hotplug) you
need to leave a few PCIe Root Ports empty. How many is an interesting
question. Maybe a domain property (free-slots=x) ?
For our scenario the only difference is the empty Root Port has
a hint/a few hints for the firmware. Maybe all free Root Ports
should behave the same.

> But what if someone wants to hotplug a PCI Express endpoint, and the
> only root-port that's available is this one that's marked to allow
> plugging in a pcie-pci-bridge? Do we fail the endpoint hotplug (even
> though it could have succeeded)? 

First come, first served.

>Or do we allow it, and then later
> potentially fail an attempt to hotplug a pcie-pci-bridge? (To be clear -
> I don't think there's really anything better that qemu could do to help
> this situation; I'm just thinking out loud about how libvirt can best
> deal with it)

I think it would be very difficult to differentiate between the free
Root Ports. The user should leave enough empty Root Ports, all of them
should have the hint for the firmware to allow the pcie-pci bridge.

> 
> 
>>
>>
>>
>>>>>>>>>>
>>>>>>>>>> Thanks
>>>>>>>>>> Laszlo
>>>>>>>>>
>>>>>>>>> OK. Is it true that dmi-pci + pci-pci under it will allow hotplug
>>>>>>>>> on Q35 if we just flip the bit in _OSC?
>>>>>>>>
>>>>>>>> Marcel, what say you?... :)
>>>>>>
>>>>>> Good news, works with:
>>>>>>       -device i82801b11-bridge,id=b1
>>>>>>       -device pci-bridge,id=b2,bus=b1,chassis_nr=1,msi=off
>>>>>
>>>>> And presumably it works for modern windows?
>>>>> OK, so it looks like patch 1 is merely a bugfix, I'll merge it for
>>>>> 2.10.
>>>>>
>>>>
>>>> Tested with Win10, I think is OK to merge if for 2.10.
>>>>
>>>>>> Notice bridge's msi=off until the following kernel bug will be merged:
>>>>>>      https://www.spinics.net/lists/linux-pci/msg63052.html
>>>>>
>>>>> Does libvirt support msi=off as a work-around?
>>>
>>> We have no explicit setting for msi on pci controllers. The only place
>>> we explicitly set that is on the ivshmem device.
>>>
>>
>> We need msi=off because of a bug in Linux Kernel. Even if the bug
>> is fixed (there is already a patch upstream), we don't know when
>> will get in (actually 4.14) and what versions will include it.
>>
>>> That doesn't mean that we couldn't add it. However, if we were going to
>>> do it manually, that would mean adding another knob that we have to
>>> support forever. And even if we wanted to do it automatically, we would
>>> not only need to find something in qemu to key off of when deciding
>>> whether or not to set it, but we would *still* have to explicitly store
>>> the setting in the config so that migrations between hosts using
>>> differing versions of qemu would preserve guest ABI.
>>
>> It is not even something QEMU can be queried about. It depends on
>> the guest OS.
> 
> Right, so libvirt has no way of detecting whether of not it's needed.
> And if we provide the setting and publish documentation telling people
> that they need to set it off to support hotplug, then we'll get people
> still setting msi=off years from now, even if they aren't doing any
> legacy PCI hotplug ("cargo cult" sysadminning).
>  >
>>
>>> Are there really
>>> enough people demanding (with actual concrete plans of *using*) hotplug
>>> of legacy PCI devices on Q35 guests *immediately* that we want to
>>> permanently pollute libvirt's code in this manner just for an interim
>>> workaround?
>>>
>>
>> If/when Q35 would become the default machine, we want feature parity,
>> so the users can keep the exact (almost) setup on q35. PCI
>> hotplug is part of it.
> 
> Sure. But proper operation is coming in the kernel. And Q35 isn't the
> default yet. The world has already waited several years for all of this.
> If it's just going to be a matter of a couple months more before the
> final piece is in place, why add code to support a workaround that will
> only be needed by a very small number of people (early adopters and
> testers who will anyway be testing the workaround rather than the
> completed feature in the full stack) for a very short time?
> 

I see your point.

> If the kernel fix is something that can't be backported into stable
> kernels being used on downstream distros that *will* get the qemu and
> libvirt features backported/rebased in, then maybe we should think about
> supporting a workaround. Otherwise, I think we should just let it all
> settle and it will work itself out.
> 

We've just got confirmation the fix will be in all stable versions:
     https://patchwork.kernel.org/patch/9848431/

>>
>>>
>>> I didn't have enough time/energy to fully parse all the rest of this
>>> thread - is msi=off currently required for pcie-pci-bridge hotplug as
>>> well?
>>
>> Yes.
>>
>> (not that it changes my opinion - just as we can tell people
>>> "upgrade to a new qemu and libvirt if you want to hotplug legacy PCI
>>> devices on Q35 guests", we can also tell them "Oh, and wait X weeks and
>>> upgrade to a new kernel too".
>>>
>>
>> I agree it will be hard to manage such a flag on libvirt automatically,
>> but exposing an msi property to the pcie-pci-bridge and adding a
>> comment: "switch to off if pci-hotplug doesn't work" would be ok?
>>
>> An alternative is to not expose "msi" to libvirt and default it to off.
>> In the future, if the feature proves valuable, we can ask libvirt
>> to help for transition to "on".
> 
> msi=off vs. msi=on is a guest abi difference, right?

I am not sure about it, a hw vendor can sell 2 identical
cards, one without msi support, the other with.
We should be able to interchange the cards.
Of course changing the card because of the kernel sounds
crazy enough.

  If that's the case,
> then the only way we could "transition to 'on'" in the future would be
> if we keep track of the msi setting in the config from the beginning (or
> alternately. we default to setting msi=off *only for pcie-pci-bridge*
> when building the qemu commandline, and then at some later time we add
> support to the config for msi=on, then figure out some way that libvirt
> can decide to add that to the config *in new definitions only*).

This is what I meant.

> This
> latter is a bad plan,

My bad :)

> because we would know from the outset that we'll
> need to add the msi attribute to the config at some time in the future,
> and by not adding it immediately we create the need for more complex
> code in the future (to deal with making sure that "msi=off" is the same
> as "no msi specified" for existing configs, but that "no msi specified"
> can mean "set msi to whatever is appropriate" for new configs. There's
> already code like that in libvirt, and it's a pain to keep it straight
> and explain it to other people - it's just a regression trap waiting for
> someone unfamiliar with the code to come in and accidentally break it
> when they think they're just "cleaning up ugly code".
> 

Understood

> So if we do it at all, we should just add the msi attribute right away
> and allow people to manually set it off (your first suggestion). But
> again, what is the time window and number of users this will actually be
> helping? It sounds like it's working itself out anyway.
> 

It will work itself out, since the patch will be merged in
stable versions. My *only* concern is we are going to announce
PCI hotplug legacy support and some early adapter will ask
how can he do that with libvirt.
It will be reasonable to ask him to update/patch the guest kernel?

> (Is there any other use for being able to set msi=off?)
> 

Not from what I know.
Thanks,
Marcel
