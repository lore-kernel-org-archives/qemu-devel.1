Received: from eggs.gnu.org ([209.51.188.92]:34319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gpAyD-0004ms-BJ
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:57:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gpAyC-0002bv-Is
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:57:25 -0500
References: <87y378n5iy.fsf@dusky.pond.sub.org>
	<CAFEAcA9b+7m1hL9atdm2_0fq66HPGWDhpAfZCRfPbegr2hKyGg@mail.gmail.com>
	<87o97yi67d.fsf@dusky.pond.sub.org>
	<300bdcd7-fbde-d7a3-12a0-eafdc0aa58f6@redhat.com>
	<87d0oddxu2.fsf@dusky.pond.sub.org>
	<f4528a7d-4bb5-f607-760e-72db3eaa34ad@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a8168870-edc0-981e-3ee8-b41670629628@redhat.com>
Date: Thu, 31 Jan 2019 12:57:15 +0100
MIME-Version: 1.0
In-Reply-To: <f4528a7d-4bb5-f607-760e-72db3eaa34ad@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Configuring pflash devices for OVMF firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Libvirt <libvir-list@redhat.com>, Peter Krempa <pkrempa@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

On 01/31/19 10:19, Paolo Bonzini wrote:
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

(side-comment: read-only isn't correct for the varstore pflash)
