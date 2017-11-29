Received: from eggs.gnu.org ([2001:4830:134:3::10]:39957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eK3ao-0002o5-2Q
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:44:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eK3al-0002q6-2b
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:44:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eK3ak-0002pg-Sn
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:44:03 -0500
References: <20171129084628.12336-1-david@gibson.dropbear.id.au>
	<20171129084628.12336-7-david@gibson.dropbear.id.au>
	<9b0e9672-e0d7-53c3-9a42-ab3f6011b59b@redhat.com>
	<20171129114109.GZ3037@localhost.localdomain>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <970587d3-6aa9-af31-0c07-b2004fbfb5a5@redhat.com>
Date: Wed, 29 Nov 2017 16:43:56 +0200
MIME-Version: 1.0
In-Reply-To: <20171129114109.GZ3037@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [for-2.12 6/7] pci: Eliminate redundant
 PCIDevice::bus pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org

On 29/11/2017 13:41, Eduardo Habkost wrote:
> On Wed, Nov 29, 2017 at 12:54:04PM +0200, Marcel Apfelbaum wrote:
>> On 29/11/2017 10:46, David Gibson wrote:
>>> The bus pointer in PCIDevice is basically redundant with QOM information.
>>> It's always initialized to the qdev_get_parent_bus(), the only difference
>>> is the type.
>>>
>>> Therefore this patch eliminates the field, instead creating a pci_get_bus()
>>> helper to do the type mangling to derive it conveniently from the QOM
>>> Device object underneath.
>>>
>>
>>
>> Hi David,
>>
>> I personally don't see why the caching of the bus bothers you.
>> It makes the code a little easier to read, but indeed is a duplication
>> of data; let's see what Michael has to say, is a matter of
>> taste I suppose.
> 
> I'm all for removing duplication of data because it makes the
> code less fragile.  We don't even take care of clearing
> pci_dev->bus when the device is removed from the bus, so there's
> a window between unplugging a device and actually freeing the
> object where pci_dev->bus can become a dangling pointer.
> 

This is a good point.

Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel

> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> 
