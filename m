Received: from eggs.gnu.org ([2001:4830:134:3::10]:42618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gL69T-0003Sa-Ol
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 07:44:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gL69R-0001pl-IG
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 07:44:43 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gL69P-0001V4-7r
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 07:44:41 -0500
Received: by mail-oi1-x244.google.com with SMTP id p144-v6so1310163oic.12
	for <qemu-devel@nongnu.org>; Fri, 09 Nov 2018 04:44:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1724064a-acdc-5571-4f54-f0ac021027d0@redhat.com>
References: <CAFEAcA9pvsNML+=2jwygO4ciJWr0GmWHznJ-Lb1bcOsWhYjo4A@mail.gmail.com>
	<20181109111731.vxdmqmkorblcnntx@sirius.home.kraxel.org>
	<20181109112953.w4wtltwxpl4z2lpj@sirius.home.kraxel.org>
	<1724064a-acdc-5571-4f54-f0ac021027d0@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Nov 2018 12:44:08 +0000
Message-ID: <CAFEAcA9uV1VEfuaJEhYwfjyP72kWLiHCF0J_52prudGULRqFug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] List of files containing devices which have not
 been QOMified
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 9 November 2018 at 12:39, Thomas Huth <thuth@redhat.com> wrote:
> On 2018-11-09 12:29, Gerd Hoffmann wrote:
>> On Fri, Nov 09, 2018 at 12:17:31PM +0100, Gerd Hoffmann wrote:
>>>   Hi,
>>>
>>>> I am also suspicious about hw/bt/ but don't know enough
>>>> about that subsystem to say if it could benefit from
>>>> using QOM objects more.
>>>
>>> I'm wondering whenever anyone would even notice if we just rm -rf hw/bt
>>>
>>> Looking through the changelog for the last five years (after hw/ split)
>>> the only thing I see is fixing warnings from compiler or coverity,
>>> adapting to changes in other systems (chardev for example) and treewide
>>> changes.  Not a *single* patch specific to bluetooth ...
>>
>> Tried this after studying docs:
>>
>>   qemu -usb -device usb-bt-dongle -bt hci,vlan=0 -bt device:keyboard
>>
>> Segfaults right anway on first keypress.
>> I guess that qualifies as "broken and obviously unused".
>
> Thanks for checking! I guess that means we could even get rid of it
> without deprecating it first if it is broken already for more than two
> releases...?

Maybe; but it's potentially a big feature and that's just
a test of one use case. I would be happier if we stuck
to our standard deprecation strategy. (We're not dumping
it in 3.1 so we have the easy opportunity to let our
users have at least one release of notice by putting in
a deprecation notice in for 3.1.)

thanks
-- PMM
