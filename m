Received: from eggs.gnu.org ([2001:4830:134:3::10]:36509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fPuP4-0005la-Cw
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 14:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fPuOz-0000UN-GJ
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 14:40:26 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:40793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fPuOz-0000Si-8A
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 14:40:21 -0400
Received: by mail-wr0-x241.google.com with SMTP id l41-v6so45246655wre.7
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 11:40:21 -0700 (PDT)
References: <20180603092749.107476-1-marcel.apfelbaum@gmail.com>
	<20180604042928-mutt-send-email-mst@kernel.org>
	<20180604125415.GN7451@localhost.localdomain>
	<20180604130129.GG19749@redhat.com>
	<20180604194500-mutt-send-email-mst@kernel.org>
	<20180604165637.GP19749@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <a339771a-0ad8-c1de-c59d-2b6f0eea92ec@gmail.com>
Date: Mon, 4 Jun 2018 21:40:15 +0300
MIME-Version: 1.0
In-Reply-To: <20180604165637.GP19749@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH RFC] hw/pc: set q35 as the default x86
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: pbonzini@redhat.com, rth@twiddle.net, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org



On 06/04/2018 07:56 PM, Daniel P. Berrangé wrote:
> On Mon, Jun 04, 2018 at 07:48:51PM +0300, Michael S. Tsirkin wrote:
>> On Mon, Jun 04, 2018 at 02:01:29PM +0100, Daniel P. Berrangé wrote:
>>> On Mon, Jun 04, 2018 at 09:54:15AM -0300, Eduardo Habkost wrote:
>>>> On Mon, Jun 04, 2018 at 04:38:22AM +0300, Michael S. Tsirkin wrote:
>>>>> On Sun, Jun 03, 2018 at 12:27:49PM +0300, Marcel Apfelbaum wrote:
>>>>>> Moving to QEMU 3.0 seems like a good opportunity for such a change.
>>>>>>
>>>>>> I440FX is really old and does not support modern features like IOMMU.
>>>>>> Q35's SATA emulation is faster than pc's IDE, native PCI express hotplug
>>>>>> is cleaner than ACPI based one and so on...
>>>>>>
>>>>>> Also the libvirt guys added very good support for the Q35 machine (thanks!).
>>>>>>
>>>>>> Management software should always specify the machine type and for the
>>>>>> current setups, adding '-machine pc' to the command line is not such a
>>>>>> big deal.
>>>>>>
>>>>>> In time the pc machine will fade out and we will probably stop adding
>>>>>> new versions at some point.
>>>>>>
>>>>>> Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>>>>> For command line users, I think changing the default isn't nice.
>>>>>
>>>>> Yes it's easy to add -machine pc but there's no documentation
>>>>> that tells you to do so. Add to that shortcuts like -cdrom
>>>>> stop working, hotplug needs extra bridges to work, and one
>>>>> can see that while management tool users benefit from q35,
>>>>> command line users will suffer.
>>>>>
>>>>> Can't we add a tag for management without changing the command line
>>>>> default? How about "management-default"? "recommended"? "latest"?
>>>> We could add new aliases if they are useful for management
>>>> software, but we would need a well-defined use case and set of
>>>> requirements+expectations for the new alias.
>>> I'm not convinced by the idea of adding a distinct default "for mgmt". All
>>> the problems described wrt 'q35' vs 'pc' apply equally to management apps
>>> as they do to humans. It just happens that one common mgmt layer (libvirt)
>>> knows how to handle some of the complexity of q35. Other mgmt apps though
>>> are just as likely to be hurt by the change as humans are. So effectively
>>> the proposed "for mgmt" is actually  "for libvirt >= some version", which
>>> feels like a layering violation to me.
>> Is libvirt happy to just hard-code q35 for now then?
> I'm pretty wary of doing that, as I feel 'pc' has broader OS compatibility
> than 'q35', so we'd be likely to cause breakage for users.
>
> IMHO, defaults are something better expressed in libosinfo, so if there's
> guests where we think q35 is a better choice, we can record it there and
> leave everything else on pc to avoid risk of breakage.

The only info we need to pass properly to management systems is:
"Use q35 unless your guests are really old".

I agree the exiting systems should not be touched.

Thanks,
Marcel

> Regards,
> Daniel
