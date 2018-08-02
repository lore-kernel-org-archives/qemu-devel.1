Received: from eggs.gnu.org ([2001:4830:134:3::10]:60985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1flAsd-0000ho-6K
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 06:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1flAsZ-0007me-Uj
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 06:30:51 -0400
References: <20180801133444.11269-1-david@redhat.com>
	<20180802121704.21fc4357@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <def8395b-ba15-b49c-1e89-1b3ba4e8a526@redhat.com>
Date: Thu, 2 Aug 2018 12:30:37 +0200
MIME-Version: 1.0
In-Reply-To: <20180802121704.21fc4357@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/4] pc-dimm: pre_plug "slot" and "addr"
 assignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, Eric Auger <eric.auger@redhat.com>

On 02.08.2018 12:17, Igor Mammedov wrote:
> On Wed,  1 Aug 2018 15:34:40 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> This is basically a resend of v3 with commit message changes.
>>
>> Paolo, if there are no further comments, can you please pick this up for
>> 3.1? Thanks!
>>
>> ---
>>
>> As requested by Igor, assign and verify "slot" and "addr" in the
>> pre_plug handler. Factor out the compatibility handling/configuration
>> for detecting the alignment to be used when searching for an address
>> in guest physical memory for a memory device.
>>
>> This is another part of the original series
>>     [PATCH v4 00/14] MemoryDevice: use multi stage hotplug handlers
> does it depend on
>    [PATCH v1 00/11] memory-device: complete refactoring
> that's still on my review queue?
> or it's other way around?

The other way around, "[PATCH v1 00/11] memory-device: complete
refactoring" is based on this series.


-- 

Thanks,

David / dhildenb
