Received: from eggs.gnu.org ([2001:4830:134:3::10]:39496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fTmS0-0006CY-2S
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:59:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fTmRw-0001SY-0c
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:59:28 -0400
From: David Hildenbrand <david@redhat.com>
References: <20180611121655.19616-1-david@redhat.com>
	<20180613153454.3e0a07a3@redhat.com>
	<11ae5790-03c8-d81c-1074-dcc1e054fedc@redhat.com>
Message-ID: <2d90f07a-cdaa-a0da-1efc-8e24f6d0f539@redhat.com>
Date: Fri, 15 Jun 2018 12:59:19 +0200
MIME-Version: 1.0
In-Reply-To: <11ae5790-03c8-d81c-1074-dcc1e054fedc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 00/11] pc-dimm: next bunch of cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On 13.06.2018 16:11, David Hildenbrand wrote:
> On 13.06.2018 15:34, Igor Mammedov wrote:
>> On Mon, 11 Jun 2018 14:16:44 +0200
>> David Hildenbrand <david@redhat.com> wrote:
>>
>>> This is another set of cleanups as the result from
>>>     [PATCH v4 00/14] MemoryDevice: use multi stage hotplug handlers
>>> And is based on the two series
>>>     [PATCH v1 0/2] memory: fix alignment checks/asserts
>>>     [PATCH v2 0/6] spapr: machine hotplug handler cleanups
>>>
>>> These cleanup are the last step before factoring out the
>>> pre_plug, plug and unplug logic of memory devices completely, to make it
>>> more independent from pc-dimm.
>> patches 1-4 are fine,
>> the rest starting from 5/11 is based on wrong assumptions so should
>> be reworked or dropped.
> 
> @Paolo can you pick up patch 1-4, so we have them out of the way (while
> I potentially create new and more patches?)

I'll drag these 4 along and perform some renaming in patch nr 3.


-- 

Thanks,

David / dhildenb
