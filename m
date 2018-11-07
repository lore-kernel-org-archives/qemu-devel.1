Received: from eggs.gnu.org ([2001:4830:134:3::10]:35254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gKPfZ-0003Dp-R3
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 10:23:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gKPfW-0002pP-Ld
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 10:23:01 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gKPfV-0002gR-U5
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 10:22:58 -0500
Received: by mail-ed1-f66.google.com with SMTP id w25so7824306edx.6
	for <qemu-devel@nongnu.org>; Wed, 07 Nov 2018 07:22:51 -0800 (PST)
References: <CAFEAcA9pvsNML+=2jwygO4ciJWr0GmWHznJ-Lb1bcOsWhYjo4A@mail.gmail.com>
	<30bb371d-4183-dd25-3413-08fd60a9eeea@redhat.com>
	<CAFEAcA_2MqRX2j1pabqbfNdrexpCfNS=xJn=TCaPrkpnD2Bvcw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <500cfa7d-7cae-a7e7-7a9e-741648806f69@redhat.com>
Date: Wed, 7 Nov 2018 16:22:44 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_2MqRX2j1pabqbfNdrexpCfNS=xJn=TCaPrkpnD2Bvcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 7/11/18 0:06, Peter Maydell wrote:
> On 6 November 2018 at 19:16, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>> On 6/11/18 19:43, Peter Maydell wrote:
>>>
>>> I had an idea for how to get a rough list of source files
>>> containing devices that haven't been QOMified. The theory
>>> is that a pre-QOM device generally has an "init" function
>>> which allocates memory for the device struct. So looking in
>>> hw/ for files which call g_new*() or g_malloc*() should get
>>> us all the non-QOM devices (as well as a pile of false
>>> positives, of course). The following link is the result of
>>> doing that and then eyeballing the results for false positives
>>> and throwing those out. It might have missed one or two
>>> files or included one or two by mistake. But I think it's
>>> pretty close, and it seems to have caught all the obvious
>>> ones I knew about. There are 61 files on this list.
>>>
>>> I am also suspicious about hw/bt/ but don't know enough
>>> about that subsystem to say if it could benefit from
>>> using QOM objects more.
>>>
>>
>>> hw/arm/exynos4210.c
>>
>> I already did this one.
>>
>>> hw/sd/omap_mmc.c
>> I will do this one.
> 
> I have some out-of-tree stuff that deals with this device
> (part of the omap3 patchset tries to do some QOMification,
> but it was a bit tangled with adding omap3 features),
> so if you could hold off on working on the various omap
> devices in this set that might be better, til I see
> whether any of the out-of-tree code is usefully salvageable.

Sure, go ahead with OMAP, this is the last thing I want to touch.

I wondered if there is sens to work on the OMAP devices then read your 
thought "I'm not sure what exactly (other than tidiness) we gain from 
converting remaining non-QOM devices."
