Received: from eggs.gnu.org ([209.51.188.92]:58615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gpbL1-0007RX-UQ
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:06:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gpbKz-0003A3-UZ
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:06:43 -0500
References: <20190201124543.5945-1-cohuck@redhat.com>
	<6239c630-24d1-f68f-ec16-023e1f37148d@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3f4345e4-611a-b231-e7c7-73a34d4f2433@redhat.com>
Date: Fri, 1 Feb 2019 17:06:26 +0100
MIME-Version: 1.0
In-Reply-To: <6239c630-24d1-f68f-ec16-023e1f37148d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x/pci: mark zpci devices as
 unmigratable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 01.02.19 16:41, Collin Walling wrote:
> On 2/1/19 7:45 AM, Cornelia Huck wrote:
>> We currently don't migrate any state for zpci devices, which are
>> coupled with standard pci devices. This means funny things happen
>> when we e.g. try to migrate with a virtio-pci device but the s390x-
>> specific zpci state is not migrated (vfio-pci is not affected, as
>> it is not migratable anyway.)
>>
>> Until this is fixed, mark zpci devices as unmigratable.
>>
>> Reported-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>
>> This is just a stop-gap measure to give us time to implement the
>> needed migration code properly.
> 
> I imagine this means we'll want a single migration handler that will
> take care of PCI and zPCI in one go, that way the data stays coupled?
> 
> Just throwing thoughts out there.

Guess this won't really be possible. Each device is to migrate "itself".
We'll then also have to see which parts of the host bridge requires
migration. Most probably not that easy. Migrating timers and such.
Taking care of resets...

As I am planning to end my journey to wondeful zpci land for now (but I
might eventually look into it again in the future), I won't be looking
into migration.

If IBM has some resources for that, very much appreciated.

-- 

Thanks,

David / dhildenb
