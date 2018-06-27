Received: from eggs.gnu.org ([2001:4830:134:3::10]:47308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYGXr-0005hR-1N
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 15:56:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYGXn-000525-Ve
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 15:56:03 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:33321)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fYGXn-00051X-La
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 15:55:59 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue005 [212.227.15.167]) with ESMTPSA (Nemesis) id
	0Mczwc-1fpFAF3guY-00IEKN for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018
	21:55:58 +0200
References: <20180625131253.11218-2-kraxel@redhat.com>
	<6ad67e44-b002-1cd7-cfd1-2d98ebde1a7e@redhat.com>
	<20180627065126.mwzdxshr3njzok7n@sirius.home.kraxel.org>
	<0df8a05c-43fc-6e85-b13c-d3f5c4691964@redhat.com>
	<87fu18ach6.fsf_-_@dusky.pond.sub.org>
	<alpine.BSF.2.21.1806271010080.90116@zero.eik.bme.hu>
	<20180627085217.blrsx5lmu4sau4fd@sirius.home.kraxel.org>
	<5d591d6c-ccc4-cc86-ebbc-3c66a6817c70@redhat.com>
	<db5529c6-7002-4b96-9d94-ca719e3845f8@amsat.org>
	<4c86fb26-f7c3-e66e-33a2-dbbfe2e70960@vivier.eu>
	<20180627184453.GC2424@work-vm>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e183c7e9-b8d4-2f61-327c-0ad29ad36b75@vivier.eu>
Date: Wed, 27 Jun 2018 21:55:56 +0200
MIME-Version: 1.0
In-Reply-To: <20180627184453.GC2424@work-vm>
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
To: qemu-devel@nongnu.org

Le 27/06/2018 à 20:44, Dr. David Alan Gilbert a écrit :
> * Laurent Vivier (laurent@vivier.eu) wrote:
>> Le 27/06/2018 à 15:33, Philippe Mathieu-Daudé a écrit :
>>> On 06/27/2018 06:09 AM, Thomas Huth wrote:
>>>> On 27.06.2018 10:52, Gerd Hoffmann wrote:
>>>>>   Hi,
>>>>>
>>>>>>> Is QEMU still useful on 32-bit hosts?  Honest question!
>>>>>>
>>>>>> I guess it depends on what 32-bit hosts you consider. If you look at only
>>>>>> x86 vs. x86_64 then probably x86 is not that important any more but for some
>>>>>> embedded systems/SoCs 32bit might still be common and QEMU useful for those
>>>>>> (also as host not only emulated).
>>>>>
>>>>> Well.  I've used kvm with an 32bit arm soc (cubietruck).  It's very
>>>>> slow.  And all the arm architecture improvements to support kvm better
>>>>> are for aarch64 only.
>>>>>
>>>>>> Another option might be to not support audio/hda on 32bit hosts. It's not
>>>>>> nice either but a lot nicer than dropping support for 32bit hosts
>>>>>> alltogether to fix a problem in device emulation.
>>>>>
>>>>> But it also is not useful and a waste of resources to maintain 32bit
>>>>> host compatibility if nobody actually uses that ...
>>>>>
>>>>> For me testbuilds are the only reason to compile qemu for 32bit hosts.
>>>>> Since years.
>>>>
>>>> Well, while that's true for you, me and likely most of us developers,
>>>> you can not know whether this is also true for all users of qemu. Thus
>>>> this needs to be announced first for a couple of releases so that people
>>>> have a chance to speak up whether they still need this or not. As
>>>> mentioned earlier, embedded devices are often still 32-bit and I know
>>>> that there really are people who use QEMU on embedded devices.
>>>>
>>>> But I think we could at least announce now already that we intend to
>>>> drop support for 32-bit hosts in the future (maybe not in 2 releases
>>>> already, but, let's say in 2020? 2020 is already the EOL of Python 2, so
>>>> that will rule out a bunch of other legacy hosts, too).
>>>
>>> linux-user is certainly widely used on ARMv6 / ARMv7.
>>>
>>> Known user cases:
>>>
>>> - run ARMv7 binaries on ARMv6
>>> - run armhf binaries on armel
>>> - run x86-64 binaries on ARMv7
>>>
>>
>> I run i386 binaries on ARMv6.
> 
> Do you know if that model has the 64bit atomics (ldrexd/strexd)?

http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0489e/Cihbghef.html

"ARM LDREXB, LDREXH, LDREXD, STREXB, STREXD, and STREXH are available in
ARMv6K and above."

Laurent
