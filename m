Received: from eggs.gnu.org ([209.51.188.92]:41896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1goZzA-0007P0-G8
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 15:27:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1goZz9-00024B-MV
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 15:27:56 -0500
References: <20190121134249.16615-1-david@redhat.com>
	<20190121134249.16615-2-david@redhat.com>
	<7f7d8582-b6d2-b120-c768-8cc8350b416c@linux.ibm.com>
	<86377327-ab6d-df3a-b914-688206273bd5@redhat.com>
	<14055713-cd8e-7fc5-d819-3724838662a3@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <376e6094-eacf-782a-ebfe-42838d235c78@redhat.com>
Date: Tue, 29 Jan 2019 21:27:51 +0100
MIME-Version: 1.0
In-Reply-To: <14055713-cd8e-7fc5-d819-3724838662a3@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/2] s390x/pci: Introduce unplug
 requests and split unplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pmorel@linux.ibm.com, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 29.01.19 17:54, Pierre Morel wrote:
> On 29/01/2019 16:14, David Hildenbrand wrote:
>> On 29.01.19 14:31, Pierre Morel wrote:
>>> On 21/01/2019 14:42, David Hildenbrand wrote:
>>>> PCI on s390x is really weird and how it was modeled in QEMU might no=
t have
>>>> been the right choice. Anyhow, right now it is the case that:
>>>> - Hotplugging a PCI device will silently create a zPCI device
>>>>     (if none is provided)
>>>> - Hotunplugging a zPCI device will unplug the PCI device (if any)
>>>> - Hotunplugging a PCI device will unplug also the zPCI device
>>>> As far as I can see, we can no longer change this behavior. But we
>>>> should fix it.
>=20
>=20
>>> So unplugging PCI first will deny the guest any possibility to smooth=
ly
>>> relinquish a device.
>>>
>>>
>>> Is it possible the other way around?
>>
>> Maybe, but it does not really matter. We unplug both devices
>> synchronously, without the guest recognizing the order. We always have
>> the unplug request first that notifies the guest. When we get an ACK
>> from the guest, we can unpplug both devices in any order.
>>
>> (and if we want to change the order, we should do it in a separate
>> patch, this patch does not change the order, just refactors the code)
>=20
>=20
> If it is done atomically, then I have no objection.

Yes, this is atomically. It is two separate steps, but only logically.
The guest cannot observe it.

Thanks!

>=20
> Regards,
> Pierre
>=20
>=20
>=20


--=20

Thanks,

David / dhildenb
