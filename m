Received: from eggs.gnu.org ([2001:4830:134:3::10]:36117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e5Z8n-0000Tv-J3
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:23:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e5Z8m-00023g-NW
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:23:17 -0400
References: <20171020115803.14093-1-david@redhat.com>
	<d5ac6186-7b57-b905-21da-e78119dbe67e@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3f82b54d-6930-252e-7f63-1c22ad3d50e6@redhat.com>
Date: Fri, 20 Oct 2017 17:23:12 +0200
MIME-Version: 1.0
In-Reply-To: <d5ac6186-7b57-b905-21da-e78119dbe67e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] target/s390x: change CPU type name to
 "s390x-cpu"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, cohuck@redhat.com, borntraeger@de.ibm.com, Igor Mammedov <imammedo@redhat.com>

On 20.10.2017 14:44, Thomas Huth wrote:
> On 20.10.2017 13:58, David Hildenbrand wrote:
>> For now, e.g. host-s390-cpu wasn't exposed to the user. cpu-add, -cpu
>> and the CPU model qmp interfaces didn't care about the actual type,
>> as that information was hidden.
>>
>> This changed with CPU hotplug via device_add. Now the type is visible to
>> the user. Before we get that supported in a stable version, this is our
>> last chance to change it.
>>
>> So change it form "s390-cpu" to "s390x-cpu", to match the architecture
>> name. Example names are then e.g. z14-s390x-cpu or qemu-s390x-cpu.
> 
> Basically fine for me ... but just to be sure: Did you test whether
> migration still works fine from older versions to a version that
> contains this patch?
> 
>  Thomas
> 

Very basic migration testing (initrd guest with 4 cpus). That name
should not pup up in the migration stream.

-- 

Thanks,

David
