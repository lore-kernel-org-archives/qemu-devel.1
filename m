Received: from eggs.gnu.org ([209.51.188.92]:34422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gp8r7-0000hR-V2
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 04:41:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gp8r6-0002E4-6x
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 04:41:57 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87y378n5iy.fsf@dusky.pond.sub.org>
	<CAFEAcA9b+7m1hL9atdm2_0fq66HPGWDhpAfZCRfPbegr2hKyGg@mail.gmail.com>
	<87o97yi67d.fsf@dusky.pond.sub.org>
	<300bdcd7-fbde-d7a3-12a0-eafdc0aa58f6@redhat.com>
	<87d0oddxu2.fsf@dusky.pond.sub.org>
	<f4528a7d-4bb5-f607-760e-72db3eaa34ad@redhat.com>
Date: Thu, 31 Jan 2019 10:41:46 +0100
In-Reply-To: <f4528a7d-4bb5-f607-760e-72db3eaa34ad@redhat.com> (Paolo
	Bonzini's message of "Thu, 31 Jan 2019 10:19:52 +0100")
Message-ID: <877eelcgf9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Configuring pflash devices for OVMF firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Krempa <pkrempa@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?utf-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 31/01/19 09:40, Markus Armbruster wrote:
>>> Maybe we should just add pflash block properties to the machine?  And
>>> then it can create the devices if the properties are set to a non-empty
>>> value.
>> What exactly do you have in mind?  Something like
>> 
>>     -machine q35,ovmf-code=OVMF-CODE-NODE,ovmf-data=OVMF-DATA-NODE
>> 
>> where OVMF-CODE-NODE and OVMF-DATA-NODE are block backend node names,
>> i.e.
>> 
>>     -blockdev file,node-name=OVMF-CODE-NODE,read-only=on,filename=/usr/share/edk2/ovmf/OVMF_CODE.fd
>>     -blockdev file,node-name=OVMF-DATA-NODE,read-only=on,filename=...
>
> Yes, though I would call it pflash0 and pflash1.

Digression... should we put traditional BIOS in flash as well?  Only for
new machine types, obviously.
