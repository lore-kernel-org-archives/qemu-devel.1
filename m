Received: from eggs.gnu.org ([209.51.188.92]:37612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1go7Us-0003FQ-Tv
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:02:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1go7Un-0000r5-Dw
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:02:46 -0500
References: <20190123195527.29575-1-david@redhat.com>
	<20190123195527.29575-4-david@redhat.com>
	<20190128150141.2a4f8fca@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a9ed2520-8c2b-b06b-54e2-68af17b5fc61@redhat.com>
Date: Mon, 28 Jan 2019 15:02:21 +0100
MIME-Version: 1.0
In-Reply-To: <20190128150141.2a4f8fca@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFCv2 3/9] qdev: Provide
 qdev_get_bus_hotplug_handler()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On 28.01.19 15:01, Igor Mammedov wrote:
> On Wed, 23 Jan 2019 20:55:21 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Let's use a wrapper instead of looking it up manually. This function can
>> than be reused when we explicitly want to have the bus hotplug handler
>> (e.g. when the bus hotplug handler was overwritten by the machine
>> hotplug handler).
>>
>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> maybe drop the 2nd one?

Whoops, indeed! Thanks!

-- 

Thanks,

David / dhildenb
