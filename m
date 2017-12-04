Received: from eggs.gnu.org ([2001:4830:134:3::10]:34297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eLu6h-0003YI-9x
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 12:00:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eLu6d-0007ry-FN
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 12:00:39 -0500
References: <20171204125505.29203-1-david@redhat.com>
	<20171204175651.4acffb4e.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <748a102a-cc55-b4d7-e18d-f65a144f5d9f@redhat.com>
Date: Mon, 4 Dec 2017 18:00:31 +0100
MIME-Version: 1.0
In-Reply-To: <20171204175651.4acffb4e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 0/5] s390x/tcg: CCW hotplug
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>

On 04.12.2017 17:56, Cornelia Huck wrote:
> On Mon,  4 Dec 2017 13:55:00 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Hotplugging a ccw device currently fails due to different reasons.
>>
>> 1. The stored machine check information is partially wrong.
>> 2. The TOD programmable field cannot be restored.
>> 3. STCRW cannot get executed.
>>
>> With these patches, I am able to sucessfully hotplug e.g. virtio-rng by
>> issuing "device_add virtio-rng-ccw,id=rng0" to a Linux guest.
> 
> Thank you for taking care of my unpublished todo list ;)
> 
> Does device_del also work?

I did a very quick test and it seemed to work. (I remember seeing
notifications in dmesg)


-- 

Thanks,

David / dhildenb
