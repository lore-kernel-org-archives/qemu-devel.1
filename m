Received: from eggs.gnu.org ([2001:4830:134:3::10]:56393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f94de-0005nc-IK
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 04:09:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f94dY-0005K4-N7
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 04:09:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54702 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1f94dY-0005GI-IB
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 04:09:48 -0400
References: <20180417224054.26363-1-lersek@redhat.com>
	<20180418060243.iafg4wj5gwsruop5@sirius.home.kraxel.org>
	<b9c7d767-39c4-065f-f487-34c0c682bd85@redhat.com>
	<20180419100900.7b66fde0@umbus.fritz.box>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <d032dfe2-bfab-5a12-c867-a5229f303f5f@redhat.com>
Date: Thu, 19 Apr 2018 10:09:30 +0200
MIME-Version: 1.0
In-Reply-To: <20180419100900.7b66fde0@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu RFC v2] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <dgibson@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

On 04/19/18 02:09, David Gibson wrote:
> On Wed, 18 Apr 2018 10:32:06 +0200
> Laszlo Ersek <lersek@redhat.com> wrote:
> 
>> On 04/18/18 08:02, Gerd Hoffmann wrote:
>>  [...]  
>>  [...]  
>>>
>>> Looks good to me overall.
>>>  
>>>> +{ 'enum' : 'FirmwareType',
>>>> +  'data' : [ 'bios', 'slof', 'uboot', 'uefi' ] }  
>>>
>>> openbios missing.
>>>  
>>>> +{ 'enum' : 'FirmwareArchitecture',
>>>> +  'data' : [ 'aarch64', 'arm', 'i386', 'x86_64' ] }  
>>>
>>> ppc(64) missing (but you have slof above ;) ...
>>> s390 too.  
>>
>> I figured those would be contributed by people that actually use them,
>> as separate patches :) In fact I would rather prefer removing "slof" and
>> "uboot" from this initial version, because I have zero clue about them.
> 
> I've only been able to skim this discussion, so apologies if I've
> missed things.  I'm pretty unclear on the overall purpose of this, but
> in particular this FirmwareType field seems pretty weird.
> 
> Specifically the things in the list don't really seem comparable to
> each other: UEFI is a specified interface, BIOS is a de-facto
> interface.  So far so good.  But SLOF is a specific implementation of
> Open Firmware (of which we have a couple of other partial
> implementations used for other qemu platforms).

Thank you -- I will replace SLOF with "openfirmware".

This also implies I shouldn't add "openbios" separately, which was
suggested earlier by Gerd -- according to
<https://en.wikipedia.org/wiki/OpenBIOS>, OpenBIOS is another
implementation of OFW.

> U-Boot is somewhere in
> between the two, a specific implementation that defines a fair bunch of
> its own interfaces.

Right, this is about interfaces, so I'll keep "uboot".

Thank you!
Laszlo
