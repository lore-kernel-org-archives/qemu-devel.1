Received: from eggs.gnu.org ([2001:4830:134:3::10]:53488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdeMa-0007v7-LV
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 12:22:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdeMZ-00022x-JN
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 12:22:40 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:39893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fdeMZ-00022j-DJ
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 12:22:39 -0400
Received: by mail-oi0-x241.google.com with SMTP id d189-v6so56838713oib.6
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 09:22:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87muuwo2dz.fsf@dusky.pond.sub.org>
References: <1531170180-21199-1-git-send-email-thuth@redhat.com>
	<CAFEAcA-T_d2kEU+Pb72=pJQhpvqvN1owgi4RLNtNY=L4t_1Z2g@mail.gmail.com>
	<5d0c7195-ffbf-1618-6106-ef6c82df3bd7@redhat.com>
	<CAFEAcA9GspXJg2ioLrCknBgYHJ9f6qvM=n=y0dLeU12yv_5ETA@mail.gmail.com>
	<931c0545-e3d8-fc84-9b69-59fab040265c@redhat.com>
	<20180711161216.GV7451@localhost.localdomain>
	<CAFEAcA-3aBQPwiwDfZSjspiwv4L-U0LXBKaOQ2m+=OzhqRq3OQ@mail.gmail.com>
	<87y3egmzem.fsf@dusky.pond.sub.org>
	<6cc1c007-4bdf-2b8c-b0b0-d32979a56ecd@redhat.com>
	<87muuwo2dz.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jul 2018 17:22:18 +0100
Message-ID: <CAFEAcA9g0Vu-cF50maC2cVrSffZA5F6AsoM5pz2XT09YKG4WHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm/bcm283x: Fix crash with device_add
 bcm2837 on unsupported machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 12 July 2018 at 17:16, Markus Armbruster <armbru@redhat.com> wrote:
> Thomas Huth <thuth@redhat.com> writes:
>
>> On 12.07.2018 14:06, Markus Armbruster wrote:
>>> Peter Maydell <peter.maydell@linaro.org> writes:
>>>
>>>> On 11 July 2018 at 17:12, Eduardo Habkost <ehabkost@redhat.com> wrote:
>>>>> On Wed, Jul 11, 2018 at 09:21:48AM +0200, Thomas Huth wrote:
>>>>>> Hm, ok, so how to continue here now? Shall we at least mark the
>>>>>> bcm2836/7 devices with user_creatable=false, so that users can not crash
>>>>>> their QEMU so easily with device_add? The problem with introspection via
>>>>>> device-list-properties would still continue to exist, but I think that's
>>>>>> less likely used in practice... otherwise we could still move the
>>>>>> qdev_set_parent_bus() calls to the realize() function instead, and just
>>>>>> add a big fat FIXME comment in front of the code block, so that we
>>>>>> remember to clean that up one day...
>>>>>
>>>>> Crashing device-list-properties should be a blocker bug, IMO.
>>>
>>> Seconded.
>>
>> Well, maybe I should then not suggest to add a hmp("info qtree") below
>> the hmp("info qom-tree") in test_one_device() of
>> tests/device-introspect-test.c ... otherwise we'll be quite busy in the
>> next weeks...
>
> If we can't fix these bugs in time, we can bring back
> cannot_destroy_with_object_finalize_yet, as Eduardo mentioned upthread.
> Would be sad, but sad beats crash.

...but are they actually interesting crashes? Nobody is ever
going to actually start emulation of an integratorcp machine and
then try to add a bcm2837 device via the QMP interface, except
if they're deliberately doing exhaustive testing. They're bugs,
sure, but they're not bugs I can ever see any real user possibly
tripping over, so we don't necessarily need to go to any
particular lengths to fix them for 3.0 if that's painful.

thanks
-- PMM
