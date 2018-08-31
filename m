Received: from eggs.gnu.org ([2001:4830:134:3::10]:34058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fvi1y-0002fR-0U
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 07:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fvi1t-00039y-Pl
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 07:56:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43172 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fvi1t-00039f-K1
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 07:55:57 -0400
References: <20180829153624.12299-1-david@redhat.com>
	<20180829153624.12299-15-david@redhat.com>
	<20180831112316.GW8359@habkost.net>
	<18b94f86-baac-45ac-75da-e80f0766d7a3@redhat.com>
	<20180831114108.GX8359@habkost.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f21a2dfa-4d1b-9e3c-e30d-83b174cf788a@redhat.com>
Date: Fri, 31 Aug 2018 13:55:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180831114108.GX8359@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 14/20] memory-device: ids of virtio
 based devices are special
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, Richard Henderson <rth@twiddle.net>

>>> I don't like having virtio-specific code on memory-device.c.
>>> What about making it generic?  Let device 2 register a read-only
>>> property for the user-visible ID, and make memory_device_id() use
>>> that property if it's present.
>>
>> Valid point. Or avoid properties and add a function to the memory-device
>> class?
> 
> That works too, and it was my first thought.  But if you want a
> method whose only purpose is to return a single value without
> affecting object state, a QOM property seems like a perfect fit.
> 
> Either of those options would be good enough for me, though.
> 

The function would only have to be defined for those overwriting it.
Will have a look. Thanks!

-- 

Thanks,

David / dhildenb
