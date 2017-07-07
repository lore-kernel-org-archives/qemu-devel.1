Received: from eggs.gnu.org ([2001:4830:134:3::10]:59366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dTNk3-0004Nl-G2
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:31:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dTNjy-0001dI-JF
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:31:55 -0400
Received: from chuckie.co.uk ([82.165.15.123]:54653
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dTNjy-0001Yt-BZ
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:31:50 -0400
References: <74424b67-f20b-27c1-6c96-e2ee54bf5bd6@ilande.co.uk>
	<8760f7fnot.fsf@dusky.pond.sub.org>
	<54df7dce-5108-40d4-e765-03137af3ad73@ilande.co.uk>
	<87fueanaxt.fsf@dusky.pond.sub.org>
	<70968a58-f3be-4fa1-aa4e-bbfd39520e09@ilande.co.uk>
	<87lgo2hi7u.fsf@dusky.pond.sub.org>
	<7c78b873-1d97-f7ef-395b-21d6f7e8634a@redhat.com>
	<87podd4xjc.fsf@dusky.pond.sub.org>
	<b54c8d3c-bfb5-1a85-ef35-8a33e4893464@redhat.com>
	<87d19diqd1.fsf@dusky.pond.sub.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <03541a3c-d1b5-39b7-67cf-3ba6936ce64a@ilande.co.uk>
Date: Fri, 7 Jul 2017 08:31:27 +0100
MIME-Version: 1.0
In-Reply-To: <87d19diqd1.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Managing architectural restrictions with -device
 and libvirt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 06/07/17 15:36, Markus Armbruster wrote:

>>>> I see two ways to continue:
>>>>   1. A new kind of pci-bridge should be created with a "special"
>>>>      secondary bus that has less slots. (harder to implement)
>>>>   2. Add the limitation of the number of slots to the PCIBus class,
>>>>      (simpler to implement, but since is not a widely used case maybe
>>>>      is not the best way to go.
>>>
>>> I suspect (2) would be trivial.  I like trivial.
>>
>> I also like trivial, what might not be trivial is to convince Michael
>> a base PCIBus class needs a property that limits the number of slots.
>> But since the device registration code is generic, we may need that
>> property anyway.
>>
>> Taking the idea a little farther, instead of limiting the slots number,
>> we can have a slot-available flag for each slot. In this way we can
>> cover more future requirements like "slot #5 is not never used".
> 
> That's strictly more general, and should still be trivial.

Indeed, having a bitmask is exactly what I suggested at the end of my
last email. I've quickly put something together which I'll send along
shortly...


ATB,

Mark.
