Received: from eggs.gnu.org ([2001:4830:134:3::10]:60219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYAeX-0001ej-Jh
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYAeS-0007WR-QH
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:38:33 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:42020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYAeS-0007Vm-Lm
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:38:28 -0400
Received: by mail-qk0-x243.google.com with SMTP id u62-v6so1014379qkf.9
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 06:38:28 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180625131253.11218-1-kraxel@redhat.com>
	<20180625131253.11218-2-kraxel@redhat.com>
	<6ad67e44-b002-1cd7-cfd1-2d98ebde1a7e@redhat.com>
	<20180627065126.mwzdxshr3njzok7n@sirius.home.kraxel.org>
	<0df8a05c-43fc-6e85-b13c-d3f5c4691964@redhat.com>
	<87fu18ach6.fsf_-_@dusky.pond.sub.org>
	<20180627110923.GG30628@redhat.com> <87d0wcwfdv.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f4063e3e-408a-d5c2-6b7b-1ae152dbd54a@amsat.org>
Date: Wed, 27 Jun 2018 10:38:24 -0300
MIME-Version: 1.0
In-Reply-To: <87d0wcwfdv.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Drop support for 32bit hosts in qemu? (was: [PULL
 1/6] audio/hda: create millisecond timers that handle IO)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Martin Schrodt <martin@schrodt.org>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Max Reitz <mreitz@redhat.com>

On 06/27/2018 10:03 AM, Alex Bennée wrote:
> 
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
>> On Wed, Jun 27, 2018 at 09:57:09AM +0200, Markus Armbruster wrote:
>>> Thomas Huth <thuth@redhat.com> writes:
>>>
>>>> On 27.06.2018 08:51, Gerd Hoffmann wrote:
>>> [...]
>>>>> Drop support for 32bit hosts in qemu?
>>>>
>>>> I guess the only way to answer that question reliably is to send a patch
>>>> to mark 32-bit hosts as deprecated...
>>>>
>>>> Anyway, you still have got to fix that problem with -m32 now somehow
>>>> since we certainly can not drop 32-bit immediately.
>>>
>>> We certainly can if we want to.
>>>
>>> Our formal deprecation policy codifies our compromise between the need
>>> to evolve QEMU and the need of its users for stable external interfaces.
>>>
>>> "Compiles on host X" is also a need, but it's a different one.
>>> Evidence: "Supported build platforms" has its own appendix, separate
>>> from "Deprecated features".  It's mum on 32-bit hosts.
>>
>> It is silent on host architecture coverage in general in fact. It was
>> only really focusing on operating systems and so any arch coverage is
>> at best inferred from what those OS target. Fedora covers 32-bit & 64-bit
>> arches for example, so you could take that to imply we need to support
>> both in QEMU.
>>
>> It is fuzzier though because while Peter has good OS coverage for his
>> merge testing, I don't think he has full host arch coverage for everything
>> that downstreams expect QEMU to build on ?
> 
> We do however have cross build infrastructure for all tcg/foo backends.
> They are run by the shippable CI framework (which is how I noticed):
> 
>   https://app.shippable.com/github/qemu/qemu/runs?branchName=master

FWIW we can also build ppc32 again (with the apt-fake kludge although).

> 
> Once we have the changes made to the wiki I'd like to use:
> 
>   https://wiki.qemu.org/Template:CIStatus
> 
> In a few choice places on the wiki, including the front page, for better
> visibility.
> 
>>> I'm not saying we *should* drop 32-bit hosts immediately.  Only that the
>>> feature deprecation policy does not apply.
>>>
>>> Is QEMU still useful on 32-bit hosts?  Honest question!
>>
>> That answer varies depending on what you're using QEMU for I think. It
>> could be that people see tools like qemu-img/qemu-nbd as useful even
>> if they don't use system emulators. And of course userspace emulators
>> are enough distinct use case.
>>
>> IMHO as long as distros are shipping 32-bit support, it is reasonable
>> to assume there will be people who find QEMU useful to some degree.
>>
>> Personally I don't have any need for 32-bit hosts, but clearly some
>> people do since otherwise distros would  have killed their 32-bit
>> arches already.
> 
> I know of at least one kernel developer who uses qemu-system-aarch64 on
> their 32 bit ARM Chromebook to test their 64 bit code. Next time I see
> them I'll see if they are still using it.
> 
> My feeling is although probably not widespread it certainly can be handy.
> 
>>
>> Regards,
>> Daniel
> 
> 
> --
> Alex Bennée
> 
