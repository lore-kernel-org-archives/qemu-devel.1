Received: from eggs.gnu.org ([2001:4830:134:3::10]:54426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dcxvC-0000Xf-5k
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 13:59:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dcxv7-0006qO-KJ
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 13:59:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dcxv7-0006q6-Ds
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 13:58:57 -0400
References: <1501285073-2215-1-git-send-email-zuban32s@gmail.com>
	<1501285073-2215-6-git-send-email-zuban32s@gmail.com>
	<491f77fc-974c-33dd-3974-08ab61d2c078@redhat.com>
	<CAKSfGUCTom8YBs8wOHMX_MpzDF1efB8_USb4tuW+hcAdoG2xvw@mail.gmail.com>
	<20170802003910-mutt-send-email-mst@kernel.org>
	<17a71bfc-1933-f707-2504-c9c699534cea@redhat.com>
	<20170802164551-mutt-send-email-mst@kernel.org>
	<9e36b7d6-bff3-b046-6053-162fb75ca0a0@redhat.com>
	<b0e1c72d-9c17-42e5-3135-5ebb1e53b4f1@redhat.com>
	<c4761b15-4525-247c-14da-510b20dbf90a@redhat.com>
	<20170802192446-mutt-send-email-mst@kernel.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <597fd60c-d8ec-0334-10de-3ff4947055ea@redhat.com>
Date: Wed, 2 Aug 2017 20:58:41 +0300
MIME-Version: 1.0
In-Reply-To: <20170802192446-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/5] docs: update documentation
 considering PCIE-PCI bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Alexander Bezzubikov <zuban32s@gmail.com>, qemu-devel@nongnu.org, ehabkost@redhat.com, seabios@seabios.org, Kevin OConnor <kevin@koconnor.net>, Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com, Igor Mammedov <imammedo@redhat.com>, rth@twiddle.net, laine@redhat.com

On 02/08/2017 19:26, Michael S. Tsirkin wrote:
> On Wed, Aug 02, 2017 at 06:36:29PM +0300, Marcel Apfelbaum wrote:
>>>>>>> Can dmi-pci support shpc? why doesn't it? For compatibility?
>>>>>>
>>>>>> I don't know why, but the fact that it doesn't is the reason libvirt
>>>>>> settled on auto-creating a dmi-pci bridge and a pci-pci bridge under
>>>>>> that for Q35. The reasoning was (IIRC Laine's words correctly) that the
>>>>>> dmi-pci bridge cannot receive hotplugged devices, while the pci-pci
>>>>>> bridge cannot be connected to the root complex. So both were needed.
>>>>>>
>>>>>> Thanks
>>>>>> Laszlo
>>>>>
>>>>> OK. Is it true that dmi-pci + pci-pci under it will allow hotplug
>>>>> on Q35 if we just flip the bit in _OSC?
>>>>
>>>> Marcel, what say you?... :)
>>
>> Good news, works with:
>>     -device i82801b11-bridge,id=b1
>>     -device pci-bridge,id=b2,bus=b1,chassis_nr=1,msi=off
> 
> And presumably it works for modern windows?
> OK, so it looks like patch 1 is merely a bugfix, I'll merge it for 2.10.
> 

Tested with Win10, I think is OK to merge if for 2.10.

>> Notice bridge's msi=off until the following kernel bug will be merged:
>>    https://www.spinics.net/lists/linux-pci/msg63052.html
> 
> Does libvirt support msi=off as a work-around?
> 

Adding Laine, maybe he has the answer.

Thanks,
Marcel



>>
>> Thanks,
>> Marcel
> 
