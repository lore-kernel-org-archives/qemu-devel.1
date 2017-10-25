Received: from eggs.gnu.org ([2001:4830:134:3::10]:48083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e7IA9-0003CY-Jo
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:39:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e7IA5-0003UJ-N0
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:39:49 -0400
References: <20171020115803.14093-1-david@redhat.com>
	<a889832b-ade3-f924-e49d-386052ae6ff0@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2228fd2c-eda0-ab81-50e6-cb3570d1fc30@redhat.com>
Date: Wed, 25 Oct 2017 11:39:39 +0200
MIME-Version: 1.0
In-Reply-To: <a889832b-ade3-f924-e49d-386052ae6ff0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1] target/s390x: change CPU
 type name to "s390x-cpu"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, borntraeger@de.ibm.com
Cc: Thomas Huth <thuth@redhat.com>, cohuck@redhat.com, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On 20.10.2017 17:26, Eric Blake wrote:
> On 10/20/2017 06:58 AM, David Hildenbrand wrote:
>> For now, e.g. host-s390-cpu wasn't exposed to the user. cpu-add, -cpu
>> and the CPU model qmp interfaces didn't care about the actual type,
>> as that information was hidden.
>>
>> This changed with CPU hotplug via device_add. Now the type is visible to
>> the user. Before we get that supported in a stable version, this is our
>> last chance to change it.
>>
>> So change it form "s390-cpu" to "s390x-cpu", to match the architecture
> 
> s/form/from/
> 
>> name. Example names are then e.g. z14-s390x-cpu or qemu-s390x-cpu.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
> 
> 

If there are no objections, Christian can you pick this up (fixing the
typo) so we get this into 2.11?

-- 

Thanks,

David
