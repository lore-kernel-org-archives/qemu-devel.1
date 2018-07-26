Received: from eggs.gnu.org ([2001:4830:134:3::10]:33112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fih8E-0000vk-AG
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 10:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fih8B-0004BZ-9M
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 10:20:42 -0400
References: <20180725142758.9980-1-lbloch@janustech.com>
	<20180725142758.9980-3-lbloch@janustech.com>
	<20180726100242.GD4215@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3373f5e8-e613-c5eb-81d3-77a2b9dc73fb@redhat.com>
Date: Thu, 26 Jul 2018 09:20:31 -0500
MIME-Version: 1.0
In-Reply-To: <20180726100242.GD4215@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 2/4 for-3.0] qcow2: Options'
 documentation fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Leonid Bloch <lbloch@janustech.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 07/26/2018 05:02 AM, Kevin Wolf wrote:
> Am 25.07.2018 um 16:27 hat Leonid Bloch geschrieben:
>> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
>> ---
>>   docs/qcow2-cache.txt |  3 +++
>>   qemu-options.hx      | 10 ++++++----
>>   2 files changed, 9 insertions(+), 4 deletions(-)
>>

>> +++ b/qemu-options.hx
>> @@ -752,15 +752,17 @@ image file)
>>   
>>   @item cache-size
>>   The maximum total size of the L2 table and refcount block caches in bytes
>> -(default: 1048576 bytes or 8 clusters, whichever is larger)
> 
> I think it would be good to still say something about the default.
> Maybe something like "default: the sum of l2-cache-size and
> refcount-cache-size"?

Except what happens if you specify only one of l2-cache-size or 
refcount-cache-size? Is the defaulted cache-size then just that one size 
you specified (and the other cache ignored), or is the total cache size 
still defaulted to the 1M/8-cluster size (assuming its larger than the 
other size specified)?

> 
>>   @item l2-cache-size
>> -The maximum size of the L2 table cache in bytes
>> -(default: 4/5 of the total cache size)
>> +The maximum size of the L2 table cache.
> 
> Why did you remove "in bytes" and add a period which the other options
> don't have? I prefer the old version of this line.
> 
>> +(default: if cache-size is not defined - 1048576 bytes or 8 clusters, whichever
>> +is larger; otherwise, as large as possible or needed within the cache-size,
>> +while permitting the requested or the minimal refcount cache size)
>>   
>>   @item refcount-cache-size
>>   The maximum size of the refcount block cache in bytes
>> -(default: 1/5 of the total cache size)
>> +(default: 4 times the cluster size, or any portion of the cache-size, if it is
>> +specified and large enough, left over after allocating the full L2 cache)
> 
> I found the second part hard to understand. Maybe "4 times the cluster
> size; or if both cache-size and l2-cache-size are given, the part of
> the cache-size that is not used for the L2 cache yet."?
> 
> Kevin
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
