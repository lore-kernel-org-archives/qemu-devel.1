Received: from eggs.gnu.org ([2001:4830:134:3::10]:59032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fTlzX-0003zq-7T
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:30:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fTlzU-0000Pi-5h
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:30:03 -0400
References: <20180611121655.19616-1-david@redhat.com>
	<20180611121655.19616-8-david@redhat.com>
	<20180613150320.3d6d11ca@redhat.com>
	<430ef63d-0e9b-5925-5d5a-b6804ec7d988@redhat.com>
	<045b1a53-fdf2-36db-2898-cfee0849232a@redhat.com>
	<20180614170051.62104d16@redhat.com>
	<3ba714d3-2031-5ddd-d21a-afdaee97f685@redhat.com>
	<20180615115912.59bae274@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <7e671ffb-712c-4cf5-42ca-8bd4cf891edb@redhat.com>
Date: Fri, 15 Jun 2018 12:29:54 +0200
MIME-Version: 1.0
In-Reply-To: <20180615115912.59bae274@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 07/11] pc-dimm: get_memory_region() can
 never fail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>


>>> pre_plug isn't part of device, it's a separate part that might vary
>>> depending on machine and which might modify device properties along
>>> the way and then exaggerating we would need 'prepare2()' and after
>>> that 'pre_plug2()' and ...  
>>
>> That's how two parties (device vs hotplug handler) work together to get
>> results done ... Just like inititalize() -> realized() vs. pre_plug ->
>> plug(). There has to be some hand shaking.
> In general hotplug handler is optional, for example a board might
> create initial memory wit fixed layout as:
>   dev = object_new(dimm)
>   set memdev + set addr
>   qdev_init_no_fail()
> 
> generalized pc-dimm helpers for hotplug handler is just impl. detail,
> a board might have other ideas how to use pc-dimm and choose to
> implement wiring differently. So device model should do sanity checks
> independently from whomever uses it.

In general, I am not a fan of implementing things the "what if someday
..." way. It overcomplicates code and you can be sure that usually
something is missed either way (as there is no concrete use case, not
even in somebodys mind).

But I can see that for pc-dimms that can actually make sense (in
contrast to other, more specific devices).

-- 

Thanks,

David / dhildenb
